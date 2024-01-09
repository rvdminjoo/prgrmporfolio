install.packages("rvest")
install.packages("R6")
install.packages("httr")
library("rvest")
library("R6")
library("httr")
library("dplyr")

# http://httpbin.org/user-agent
ua <- "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/113.0.0.0 Safari/537.36"
url <- 'http://finance.naver.com/item/sise_day.nhn?code=005930&page=1'
url %>%
  read_html() %>%
  html_nodes('.type2')

price <- GET(url, user_agent(ua)) %>% 
  read_html() %>%
  html_nodes('.type2') %>% 
  html_table

stock_price <- data.frame(price)
stock_price <- na.omit(stock_price)
stock_price

stock_price <- stock_price[-c(1, 7,8,9, 15), ]

for (i in 1:10) {
  url <- paste0('http://finance.naver.com/item/sise_day.nhn?code=005930&page=', i)
  url %>%
    read_html() %>%
    html_nodes('.type2')
  
  price <- GET(url, user_agent(ua)) %>% 
    read_html() %>%
    html_nodes('.type2') %>% 
    html_table
  
  stock <- data.frame(price)
  stock <- stock[-c(1, 7,8,9, 15), ]
  stock_price <- rbind(stock_price, stock)
}

rownames(stock_price) <- NULL
stock_price



library(ggplot2)
ggplot(stock_price, aes(x=종가)) +
  geom_line(aes(날짜, 종가), color = "black") +
  theme_minimal()

install.packages("tidyquant")
library(tidyquant)
library(tidyverse)

tq_get("005930.KS",
       get = "stock.prices",
       from = "2000-01-01",
       to = "2023-05-28")

library(scales)

SE_prices <- tq_get("005930.KS",
                    get = "stock.prices",
                    from = "2000-01-01",
                    to = "2023-05-28")

ggplot(SE_prices) +
  geom_line(aes(date, adjusted), color = "black") +
  geom_point(data = subset(SE_prices, adjusted == max(adjusted)), 
             aes(date, adjusted), color = "red") +
  geom_text(data = subset(SE_prices, adjusted == max(adjusted)),
            aes(date - 500, adjusted, label = scales::comma(adjusted)))+
  scale_y_continuous(labels = comma) +
  theme_minimal()
