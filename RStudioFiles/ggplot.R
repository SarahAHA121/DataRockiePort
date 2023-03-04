install.packages(patchwork)
library(tidyverse)
library(patchwork)
library(lubridate)

ggplot(data = mtcars, mapping = aes(x = wt, y =mpg)) + geom_point()

d <- "2022-10-01"
d <- as.Date(d)

## create dataframe
df <- tribble(
  ~id, ~date,
  1, "2022/09/09",
  2, "2021/05/31",
  3, "2020/01/01"
)


## ggplot => 2D grammar of graphic
## data mapping geom

ggplot(data = mtcars,
       mapping = aes(x = mpg)) +
  geom_histogram()

ggplot(data = mtcars,
       mapping = aes(x = mpg)) +
  geom_density()

base <- ggplot(data = mtcars,
               mapping = aes(x = mpg))
base + geom_histogram(bins = 5)
base + geom_dotplot()
base + geom_density()

ggplot(data = mtcars, mapping = ) + geom_boxplot()

m <- mtcars %>%
  tibble() %>%
  mutate(am = factor(if_else(am==0, "Auto", "Manual")))

ggplot(m, aes(am)) +
  geom_bar()

m %>%
  count(am) %>%
  mutate(pct = n/sum(n))

## EDA => Exploratory Data Analysis
### 1. numericaal vs 2. visualization

## Two variables
## scatter plot

ggplot(m, aes(wt, mpg)) +
  geom_smooth(method = "lm")

## change setting in ggplot  
ggplot(m, aes(wt, mpg)) +
  geom_point(color = "red",
             size = 5,
             alpha = 0.8,
             shape = "+") +
  geom_smooth(method = "lm", 
              color = "black", 
              fill = "gold",
              se = F) +
  geom_rug()

## setting vs mapping

ggplot(m, aes(wt, mpg)) +
  geom_point(size=5, 
             alpha=0.7, 
             aes(color = cyl))

m <- m %>%
  mutate(cyl = factor(cyl))


## prep data
m %>%
  select(wt, mpg, hp) %>%
  mutate(hp_segment = case_when(
    hp < 100 ~ "low",
    hp < 200 ~ "medium",
    TRUE ~ "high"
  )) %>%
  mutate(hp_segment = factor(hp_segment,
                             labels = c("low","medium","high"),
                             levels = c("low","medium","high"),
                             ordered = TRUE)) %>%
  ggplot( aes(wt, mpg, color=hp_segment)) +
    geom_point(size=4, alpha=0.8) +
    scale_color_manual(
      values =c("red",
                "gold",
                "blue")
    )

ggplot(m, aes(wt, mpg, 
              color=am)) +
  geom_point()

ggplot(m, aes(x=am, y=mpg)) +
  geom_boxplot()

ggplot(m, aes(x=am, y=mpg)) +
  geom_violin() +
  geom_jitter(height = 0.05)

## base layer

ggplot(diamonds, aes(cut,
                     fill=color)) +
  geom_bar() +
  theme_minimal()

set.seed(42)
ggplot(sample_n(diamonds, 1000),
       aes(carat, price, color=cut)) +
  geom_point(alpha=0.05) +
  geom_smooth(method = "lm", se=F) +
  labs(
    title = "Relationship between carat and price of African diamonds",
    x = "Carat",
    y = "Price (USD)",
    subtitle = "Using ggplot to create this virtualization",
    caption = "Source: ggplot package"
  ) +
  theme_minimal()

##facet
ggplot(sample_n(diamonds, 1000),
       aes(carat, price, color=cut)) +
  geom_point(alpha=0.05) +
  geom_smooth(method = "lm", se=F) +
  theme_minimal() +
  facet_wrap(~ cut, ncol=5)


diamonds %>%
  sample_n(1000) %>%
  ggplot( aes(carat, price)) +
  geom_point(alpha=0.4) +
  geom_smooth() +
  theme_minimal() +
  facet_grid(cut ~ color)

## color
colors()
ggplot(diamonds, aes(price)) +
  geom_histogram(fill = "#14e38d",
                 bins=100) +
  theme_minimal()

ggplot(sample_n(diamonds, 1000), aes(carat, price, color=cut)) +
  geom_point() +
  theme_minimal() +
  #scale_color_manual(values = c("red","green","blue","salmon","cadetblue"))
  scale_color_brewer(palette = 3, type = "qual")

## available themes that can be used for free
install.packages("ggthemes")
library(ggthemes)

ggplot(sample_n(diamonds, 1000), aes(carat, price, color=cut)) +
  geom_point() +
  theme_economist()

p1 <- ggplot(mtcars, aes(hp)) + geom_histogram(bins=10)
p2 <- ggplot(mtcars, aes(mpg)) + geom_density()
p3 <- ggplot(diamonds, aes(cut, fill=cut)) + geom_bar()

library(patchwork)
p1 / (p2 + p3)

## ggplot shortcut
## qplot()

ggplot(mtcars, aes(wt, hp)) +
  geom_point()
    
qplot(wt, hp, data=mtcars)
qplot(hp, data=mtcars, bins=10)
qplot(hp, data=mtcars, geom="density")
qplot(hp, data=mtcars, geom="boxplot")
qplot(factor(am), mpg, data=mtcars, geom="boxplot")

qplot(wt, hp, data=mtcars) +
  qplot(wt, hp, data=mtcars, geom="smooth")

