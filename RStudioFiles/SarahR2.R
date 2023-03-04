install.packages(c('tidyverse',
                   'glue',
                   'sqldf',
                   'jsonlite',
                   'RSQLte',
                   'rvest'))

library(tidyverse)
library(glue)

y <- "beauty"
x <- glue("Sarah is {y}")

print(x)

df <- mtcars %>%
  rownames_to_column() %>%
  tibble()

df %>%
  select(1:3, 5, am)
df %>%
  select(milePerGallon = mpg, 
         horsePower = hp, 
         weight = wt)

df %>%
  rename(horsePower = hp)

df %>%
  select(am, horsePower = hp, wt)
df <- df %>%
  rename(model = rowname)


df %>%
  select(starts_with("a"), 1:3)

df %>%
  select(ends_with("p"))

df %>%
  select(contains("a"))

# filter row
## WHERE clause SQL
result <- df %>%
  select(model, mpg, wt, hp, am) %>%
  filter(mpg > 30)

write.csv(result, "result.csv")

#Filter using and
df %>%
  select(model, mpg, wt, hp, am) %>%
  filter(mpg < 30 & hp > 150)

#filter using or
df %>%
  select(model, mpg, wt, hp, am) %>%
  filter(mpg < 30 | hp > 150)

#Filter between
df %>%
  select(model, mpg, wt, hp, am) %>%
  filter(between(mpg, 20, 30))

## in operator
# "SELECT country FROM customers WHERE country IN ('USA', 'UK', 'TH');
# %in%
df %>%
  select(model, gear)

df %>%
  distinct(gear)

#SELECT distinct gear FROM mtcars;

df %>%
  select(model, gear) %>%
  filter(gear %in% c(3,5))
