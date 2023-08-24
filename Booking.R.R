
# loading pacakges 
library(robotstxt)
library(rvest)
library(XML)
library(plotly)
library(stringr)
library(dplyr)
library(ggplot2)
library(data.table)


#url <- "https://www.booking.com/searchresults.en-gb.html?ss=London&ssne=London&ssne_untouched=London&label=gog235jc-1DCAEoggI46AdICVgDaFCIAQGYAQm4ARfIAQzYAQPoAQH4AQKIAgGoAgO4ArDuuaEGwAIB0gIkZmJhYjE4YzAtNDdhMy00MmY1LTk2NWItN2UzOTgyNTk1OWEx2AIE4AIB&aid=397594&lang=en-gb&sb=1&src_elem=sb&src=searchresults&dest_id=-2601889&dest_type=city&checkin=2023-08-04&checkout=2023-08-06&ltfd=6%3A1%3A%3A&group_adults=2&no_rooms=1&group_children=0"

url <- "https://www.booking.com/searchresults.es.html?label=es-es-booking-desktop-onknyt5TBrS8m9RnGd*6fgS652829001115%3Apl%3Ata%3Ap1%3Ap2%3Aac%3Aap%3Aneg%3Afi%3Atikwd-65526620%3Alp1005424%3Ali%3Adec%3Adm&aid=2311236&ss=Barcelona&ssne=Londres&ssne_untouched=Londres&lang=es&sb=1&src_elem=sb&src=searchresults&dest_id=-372490&dest_type=city&ac_position=0&ac_click_type=b&ac_langcode=es&ac_suggestion_list_length=5&search_selected=true&search_pageview_id=ff4844360ec70177&ac_meta=GhBmZjQ4NDQzNjBlYzcwMTc3IAAoATICZXM6CUJhcmNlbG9uYUAASgBQAA%3D%3D&checkin=2023-08-04&checkout=2023-08-06&group_adults=2&no_rooms=1&group_children=1&offset=0"

HTMLContent <- read_html(url)


titles_page <- HTMLContent %>% html_elements("div[data-testid='title'][class='fcab3ed991 a23c043802']") %>% html_text()
prices_page <- HTMLContent %>% html_elements("span[data-testid='price-and-discounted-price'][class='fcab3ed991 fbd1d3018c e729ed5ab6']") %>% html_text()
ratings_page <- HTMLContent %>% html_elements("div[aria-label^='Puntuación:']") %>% html_text()

#details_page <- HTMLContent %>% html_elements("div[data-testid='property-card-unit-configuration'][class='d8eab2cf7f eb762c0360']") %>% html_text()

details_page <- HTMLContent %>% html_elements("div[data-testid='recommended-units'][class='b762360cf2']") %>% html_text()

booking_data <- data.frame(titles_page,prices_page,ratings_page,details_page)





#read the page
url <-"https://www.booking.com/searchresults.it.html?ss=Firenze%2C+Toscana%2C+Italia&efdco=1&label=booking-name-L*Xf2U1sq4*GEkIwcLOALQS267777916051%3Apl%3Ata%3Ap1%3Ap22%2C563%2C000%3Aac%3Aap%3Aneg%3Afi%3Atikwd-65526620%3Alp9069992%3Ali%3Adec%3Adm%3Appccp&aid=376363&lang=it&sb=1&src_elem=sb&src=index&dest_id=-117543&dest_type=city&ac_position=0&ac_click_type=b&ac_langcode=it&ac_suggestion_list_length=5&search_selected=true&search_pageview_id=2e375b14ad810329&ac_meta=GhAyZTM3NWIxNGFkODEwMzI5IAAoATICaXQ6BGZpcmVAAEoAUAA%3D&checkin=2023-06-11&checkout=2023-06-18&group_adults=2&no_rooms=1&group_children=0&sb_travel_purpose=leisure&fbclid=IwAR1BGskP8uicO9nlm5aW7U1A9eABbSwhMNNeQ0gQ-PNoRkHP859L7u0fIsE"
page <- read_html(url)

#parse out the parent node for each parent 
properties <- html_elements(page, xpath=".//div[@data-testid='property-card']")

#now find the information from each parent
#notice html_element - no "s"
title <- properties %>% html_element("div[data-testid='title']") %>% html_text()
prices <- properties %>% html_element("span[data-testid='price-and-discounted-price']") %>% html_text()    
ratings <- properties %>% html_element(xpath=".//div[@aria-label]") %>% html_text()

data.frame(title, prices, ratings)
