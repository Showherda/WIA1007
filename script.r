library(rvest)
library(dplyr)
library(stringr)

sitemap <- "https://www.coursera.org/sitemap~www~courses.xml"
page <- read_html(sitemap)

course_links <- str_split(str_extract_all(page, "(?<=<loc>).*?(?=</loc>)")[[1]], " ")
print((course_links[[6064]]))
