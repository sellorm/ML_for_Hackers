library(readr)
library(dplyr)

options(tz="Europe/London")

column_headers <- c("DateOcurred", "DateReported", "Location", "ShortDescription", "Duration", "LongDescription")

ufocols <- cols(
  X1 = col_character(),
  X2 = col_character(),
  X3 = col_character(),
  X4 = col_character(),
  X5 = col_character(),
  X6 = col_character()
)

ufodata <- readr::read_tsv("01-Introduction/data/ufo/ufo_awesome.tsv",col_names = FALSE, col_types = ufocols)

colnames(ufodata) <- column_headers

head(ufodata)
summary(ufodata)

ufodata <- ufodata %>% 
  mutate(citystate = strsplit(Location,','),
         DateOcurred = as.Date(DateOcurred, format="%Y%m%d"),
         DateReported = as.Date(DateReported, format="%Y%m%d")) %>% 
  rowwise() %>% 
  mutate(city = citystate[1], state = tolower(citystate[2]), citystate = NULL)

summary(ufodata)
  
  
ufodata <- ufodata %>% 
    filter(!is.na(DateOcurred))


nrow(ufodata)
head(ufodata)
summary(ufodata)

