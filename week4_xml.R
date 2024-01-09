
# nodename[predicate]: predicate으로 지정된 조건을 충족하는 nodename 노드를 선택

html.string <- c(
  '<!DOCTYPE html>',
  '<html>',
  '<head>',
  '<title>Movie Quotes</title>',
  '</head>',
  '<body>',
  '<h1>Famous Quotes from Movies</h1>',
  '<div time="1h 39min" genre="drama" lang="english" date="December/16/1970">',
  '<h2>Ali MacGraw as Jennifer Cavilleri</h2>',
  '<p><i>Love means never having to say you\'re sorry.</i></p>',
  '<p><b>Movie: </b>Love Story</p>',
  '</div>',
  '<div time="2h 22min"  genre="comedy" date="June/23/1994">',
  '<h2>Tom Hanks as Forrest Gump</h2>',
  "<p><i>My mama always said, 'Life was like a box of chocolates; you never know what you\'re gonna get.'</i></p>",
  "<p><i>Mama says,'Stupid is as stupid does.'</i></p>",
  '<p><b>Movie: </b><a href="http://www.imdb.com/title/tt0109830/?ref_=nv_sr_1">Forrest Gump</a></p>',
  '</div>',
  '<p>',
  '<b>Sources:</b><br>',
  '<a href="http://www.afi.com/"><i>American Film Institute</i></a><br>',
  '<a href="http://www.hollywoodreporter.com/"><i>Hollywood Reporters</i></a>',
  '</p>',
  '</body>',
  '</html>'
)
writeLines(html.string, "moviequotes.html")

library(pander)
openFileInOS("moviequotes.html")

library(XML)
quotes <- htmlParse("moviequotes.html")
quotes

xpathSApply(quotes, "//p[./i]")
# i 노드를 자식 노드로 가지는 p 노드 3개 선택됨

xpathSApply(quotes, "//div[@date='December/16/1970']")
# date 속성이 1970년 12월 16일인 div 노드 선택
xpathSApply(quotes, "//div[@date='December/16/1970']//i")

# 조건문 활용
xpathSApply(quotes, "//div[@date='December/16/1970' or @genre='comedy']")
xpathSApply(quotes, "//div[@date='December/16/1970' or @genre='comedy']//i")

# position(): 현재 처리 중인 노드의 위치 인덱스 반환
# last(): 현재 처리 중인 노드셋의 노드 개수를 반환 (마지막 노드 선택)
# count(): 노드셋의 요소 개수를 반환
# string-length(): 현재 노드의 텍스트 문자 개수 반환
# @attribute: 노드의 속성값 반환
# name(): 노드의 이름 반환
# text(): 노드의 콘텐츠(텍스트) 반환

# contains(): 첫 번째 문자열이 두 번째 문자열을 포함하고 있으면 TRUE 반환
# starts-with(): 첫 번째 문자열이 두 번째 문자열로 시작하면 TRUE 반환
# substring-before: 첫 번째 문자열로부터 두 번째 문자열 이전 부분의 문자열을 반환# substring-before: 첫 번째 문자열로부터 두 번째 문자열 이전 부분의 문자열을 반환
# substring-after: 첫 번째 문자열로부터 두 번째 문자열 이후 부분의 문자열을 반환
# not(): 평가 결과를 거꾸로 반환(TRUE->FALSE, FALSE->TRUE)
# local-name: 네임스페이스 참조 없이 현재 로컬 노드의 이름을 반환

xpathSApply(quotes, "//div/p[position()=1]")
xpathSApply(quotes, "//div/p[position()=last()]")

# position은 생략 가능
xpathSApply(quotes, "//div/p[1]")
xpathSApply(quotes, "//div/p[last()]")
# 마지막에서 두 번째 노드 추출
xpathSApply(quotes, "//div/p[last()-1]")

xpathSApply(quotes, "//div/p[count(.//a) > 0]")
# div 노드의 속성 개수 카운트
xpathSApply(quotes, "//div[count(./@*) >= 4]")

# 문자 개수가 60보다 큰 노드만 추출
xpathSApply(quotes, "//*[string-length(text()) > 60]")
xpathSApply(quotes, "//*[not(string-length(text()) <= 60)]")
xpathSApply(quotes, "//div[not(count(./@*) < 4)]")
# 동일한 결과

xpathSApply(quotes, "//div[@lang]")
xpathSApply(quotes, "//div[not(@lang)]")

xpathSApply(quotes, "//div[@date='December/16/1970']")
xpathSApply(quotes, "//*[contains(text(), 'Love')]")
xpathSApply(quotes, "//*[contains(text(), 'love')]")
# 대소문자 구분

xpathSApply(quotes,"//div[starts-with(./@time, '1h')]")
xpathSApply(quotes,"//div[starts-with(./@time, '1h')]/p[2]")

xpathSApply(quotes,"//div[substring-before(./@date, '/')='December']")
xpathSApply(quotes,"//div[substring-before(./@date, '/')='December']/p[2]")

xpathSApply(quotes,"//div[substring-after(substring-after(./@date, '/'), '/')='1970']")
xpathSApply(quotes,"//div[substring-after(substring-after(./@date, '/'), '/')='1970']/p[2]")


# 텍스트, 요소 추출
### xmlName(): 노드 이름
### xmlGetAttr(): 노드의 특정 속성

xpathSApply(quotes, "//p/i")
xpathSApply(quotes, "//p/i", fun=xmlValue)

xpathSApply(quotes, "//h2/i")
xpathSApply(quotes, "//h2/i", xmlValue)
# 빈 리스트 반환

xpathSApply(quotes, "//div", xmlAttrs)

xpathSApply(quotes, "//div", xmlGetAttr, "date")
xpathSApply(quotes, "//div", xmlGetAttr, "lang")
# 찾고자 하는 값이 없으면 NULL 반환

# 추출한 결과를 모두 소문자로 바꾸는 함수 작성
lowertextFun <- function(x) {
  x <- tolower(xmlValue(x))
  return(x)
}

xpathSApply(quotes, "//p/i", fun=lowertextFun)

# 4자리의 연도 추출하는 함수 작성     
yearFun <- function(x) {
  library(stringr)
  date <- xmlGetAttr(x, "date")
  year <- str_extract(date, "[0-9]{4}")
  return(year)
}       

xpathSApply(quotes, "//div", yearFun)

xpathSApply(quotes, "//div", xmlGetAttr, "lang")

# NULL 값인지 아닌지 여부를 확인하는 함수 작성 (오류 줄이기 위함)
langFun <- function(x) {
  lang <- xmlGetAttr(x, "lang")
  lang <- ifelse(is.null(lang), "Not Exist", lang)
  return(lang)
}

xpathSApply(quotes, "//div", langFun)
