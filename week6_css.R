
# IMDb Top 250 Movies: 평점 상위 250개 영화 제목과 평점
url <- "https://www.imdb.com/chart/top/?ref_=nv_mv_250%29"

library(rvest)
library(stringr)

# html 문서 파싱
page <- read_html(url)
page

# 1. 제목 추출
# SelectorGadget 확장프로그램 사용해서 css 선택자 추출
title <- html_nodes(page, ".titleColumn a") %>%
  html_text()
head(title) # 영화제목 추출 확인
length(title)


# 2. 순위 추출
# 순위 데이터만을 식별할 수 있는 선택자가 없음
# -> 순위 데이터를 포함한 전체 텍스트에서 정규표현식으로 추출
rank <- html_nodes(page, ".titleColumn") %>%
  html_text()
head(rank) #순위와 함께 다른 텍스트도 추출됨
rank <- str_trim(gsub("\\..*", "", rank)) # "." 이후의 텍스트 삭제, 앞의 공백 삭제
head(rank) # 순위만 추출됨

# 파이프 연산자로 한 번에 처리하기
rank <- html_nodes(page, ".titleColumn") %>%
  html_text() %>%
  gsub("\\..*", "", .) %>%
  str_trim() %>%
  as.numeric()
head(rank)


# 3. 개봉연도 추출
year <- html_nodes(page, ".secondaryInfo") %>%
  html_text()
head(year) # 괄호 포함됨, 제거해야 함
year <- gsub("[\\(//)]", "", year)
head(year)

# 파이프 연산자로 한 번에 처리하기
year <- html_nodes(page, ".secondaryInfo") %>%
  html_text() %>%
  gsub("[\\(//)]", "", .) %>%
  as.numeric()
head(year)


# 4. 평점 추출
rating <- html_nodes(page, ".imdbRating") %>%
  html_text()
head(rating) # 전처리 필요함(공백 제거)
rating <- str_trim(rating)
head(rating)

# 파이프 연산자로 한 번에 처리하기
rating <- html_nodes(page, ".imdbRating") %>%
  html_text() %>%
  str_trim() %>%
  as.numeric()
head(rating)


# 쇼생크 탈출 상세 페이지
title.url <- 'https://www.imdb.com/title/tt0111161/?pf_rd_m=A2FGELUUNOQJNL&pf_rd_p=1a264172-ae11-42e4-8ef7-7fed1973bb8f&pf_rd_r=YP9X9YHDR5S6EXD1GQ6V&pf_rd_s=center-1&pf_rd_t=15506&pf_rd_i=top&ref_=chttp_tt_1'
page <- read_html(title.url)


# 5. 감독 이름 추출
director <- html_nodes(page, "li a") %>%
  html_text() %>%
  .[6]
director
# 웹페이지 변동으로 css 선택자 정상적으로 추출 안됨, 전체 노드에서 감독 이름 부분만 추출


# 6. 상영시간 추출
runtime <- html_nodes(page, "ul li") %>%
  html_text() %>%
  .[26]
runtime


# 7. 장르 추출
genre <- html_nodes(page, "div a") %>%
  html_text() %>%
  .[56]
genre


title.url2 <- "https://www.imdb.com/title/tt0044741/?pf_rd_m=A2FGELUUNOQJNL&pf_rd_p=1a264172-ae11-42e4-8ef7-7fed1973bb8f&pf_rd_r=YP9X9YHDR5S6EXD1GQ6V&pf_rd_s=center-1&pf_rd_t=15506&pf_rd_i=top&ref_=chttp_tt_98"
page2 <- read_html(title.url2)
director <- html_nodes(page2, "li a") %>%
  html_text()
head(director)
genre <- html_nodes(page2, "div a") %>%
  html_text() %>%
  .[56]
genre
# 다른 페이지에서도 장르 제대로 추출됨 확인



# 250개 영화 모두의 텍스트 추출
page <- read_html(url)
title.url <- html_nodes(page, ".titleColumn a")
head(title.url)

# 영화 제목 클릭 시url 추출
title.url <- html_nodes(page, ".titleColumn a") %>%
  html_attr(name="href")
head(title.url)

title.url <- paste0("https://imdb.com", title.url)
title.url

# 빈 데이터프레임 생성
extra.info <- data.frame(matrix(nrow=length(title.url), ncol=3),
                         stringsAsFactors = FALSE)
colnames(extra.info) <- c("director", "runtime", "genre")
extra.info

for (i in 1:length(title.url)) {
  page <- read_html(title.url[i])
  director <- html_nodes(page, "li a") %>%
    html_text() %>%
    .[6]
  runtime <- html_nodes(page, "ul li") %>%
    html_text() %>%
    .[26]
  genre <- html_nodes(page, "div a") %>%
    html_text() %>%
    .[56]
  extra.info[i,] <- c(director, runtime, genre)
  Sys.sleep(sample(10,1)*0.1) # 오류 방지 위해 랜덤한 간격 줌
}

head(extra.info)
extra.info
extra.info$genre <- factor(extra.info$genre)

save(extra.info, file="imdb-extrainfo.rda")
load("imdb-extrainfo.rda")

movie250 <- data.frame(rank=rank, title=title,
                       year=year, rating=rating) %>%
  cbind(extra.info)
head(movie250)
View(movie250)

save(movie250, file="imdb-movie250.rda")
load("imdb-movie250.rda")

# 장르 빈도 분석
table(movie250$genre)

# 그래프 생성
library(ggplot2)
ggplot(movie250, aes(x=genre, fill=genre)) + 
  geom_bar(color="black", show.legend=FALSE, width=0.8) +
  labs(x="", y="Frequency",
       title="250 Top Rated Movies",
       subtitle="Distribution of frequency by genre",
       caption="Souce: IMDb") +
  theme(plot.title=element_text(face="bold"),
        axis.text=element_text(face="bold"),
        axis.text.x=element_text(angle=30, hjust=1))
