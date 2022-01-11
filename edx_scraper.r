library(rvest)
library(dplyr)
library(stringr)

sitemap <- "https://www.edx.org/sitemap-0.xml"
page <- read_html(sitemap)

course_links <- str_split(str_extract_all(page, "https://www.edx.org/course/(?!subject/).*?(?=</loc>)")[[1]], " ")

for (link in course_links){
  html <- read_html(link)
  name <- html_element(html, css = ".pr-4 h1") %>% html_text()
  level <- html_element(html, css = ".ml-1 > li:nth-child(3)") %>% html_text() %>% substr(9, 10000)
  # ratings <- html_element(html, css = "div.rc-ReviewsOverview__totals__rating") %>% html_text()
  free_enrol <- if (is.na(html_element(html, css = ".track-headers-row+ .tr .td+ .td .comparison-item") %>% html_text())) F else T
  fin_aid <- T
  x = paste(name, level, free_enrol, fin_aid, sep=",")
  cat(x, file="data.csv")
  print(link)
  print(x)
}
