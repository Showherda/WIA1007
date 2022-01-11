library(rvest)
library(dplyr)
library(stringr)

sitemap <- "https://www.coursera.org/sitemap~www~courses.xml"
page <- read_html(sitemap)

course_links <- str_split(str_extract_all(page, "(?<=<loc>).*?(?=</loc>)")[[1]], " ")

for (link in course_links){
  html <- read_html(link)
  name <- html_element(html, css = ".banner-title-without--subtitle") %>% html_text()
  level <- str_extract(html, "(?<=Approx. ).*?(?= hours to complete)")
  ratings <- html_element(html, css = "div.rc-ReviewsOverview__totals__rating") %>% html_text()
  free_enrol <- grepl("Enroll for Free", html)
  fin_aid <- grepl("Financial aid available", html)
  x = paste(name, level, free_enrol, fin_aid, sep=",")
  cat(x, file="data.csv")
  print(link)
  print(x)
}
