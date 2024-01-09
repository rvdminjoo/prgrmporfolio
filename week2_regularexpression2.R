
# 5) 이스케이프 시퀀스

### 이스케이프 문자(escape character) \로 시작하는 문자 조합을
### 이스케이프 시퀀스(escape sequence)라고 하며
### 문자열 내에 특수한 용도의 문자(ex. 메타문자)를 포함시키기 위해 사용됩니다.
### 이스케이프 시퀀스로 표현된 메타문자는 정규표현식 내에서
### 특별한 용도에서 '벗어나' 본래의 고유한 의미로 사용됩니다.

# string <- 'Alice's Adventures'
# 오류 발생. 작은따옴표가 문자열을 정의하는 용도로 사용되기 때문

string <- 'Alice\'s Adventures'
string
# 백슬래시 사용 시 정상적으로 저장됨


# 이스케이프 시퀀스 종류
### \n : 줄바꿈
### \r : 캐리지리턴 (커서를 맨 앞으로 이동)
### \t : 탭
### \b : 백스페이스
### \\ : 역슬래시
### \' : 작은따옴표
### \" : 큰따옴표


string <- "long tab lines can be broken with newlines"
string

string <- "long\t\ttab lines can be\nbroken with newlines"
cat(string)
# 탭 키와 엔터 키가 반영되어 출력됨

gsub("\t\t", " ", string)
# 탭 키를 공백으로 변환
cat(gsub("\t\t", " ", string))


string <- "I need 100$, but she gave me a ^."
string

gsub(".", "!", string)
# 온점을 느낌표로 바꾸고 싶음
# .이 메타문자로 인식되어서 모든 문자가 느낌표로 변환됨

gsub("\.", "!", string)
# 에러 발생. 백슬래시도 메타문자이기 때문
gsub("\\.", "!", string)
# 이스케이프 시퀀스 두 번 사용시 정상 작동

gsub("$", "dollars", string)
# $는 메타문자로 텍스트의 끝을 의미하기 때문에 끝이 바뀜
gsub("\\$", "dollars", string)

gsub("^", "carrot", string)
# ^은 텍스트의 시작을 의미하는 메타문자
gsub("\\^", "carrot", string)


txt <- "Hello\Wonderful\World"
# 에러 발생. 백슬래시는 문자열에 직접 저장할 수 없음. 익스케이프 시퀀스로 인식됨
txt <- "Hello\\Wonderful\\World"
cat(txt)

gsub("\\", " ", txt)
# 백슬래시를 공백으로 바꾸려는 의도. 에러 발생
gsub("\\\\", " ", txt)
# 백슬래시 4개 필요


string
gsub("\\^\\.", "carrot!", string)
# 메타문자 앞에 매번 백슬래시를 두 개씩 입력해야 함.
gsub("^.", "carrot!", string, fixed=TRUE)
# fixed 인자를 추가함으로써 모든 메타문자 앞에 백슬래시 두 개를 추가하는 효과.



# 6) 문자 클래스 시퀀스

### 사전 정의된 문자 클래스(character class)를
### 이스케이프 시퀀스(escape sequence) 형태로 간단히 나타낸 것을
### 문자 클래스 시퀀스(character class sequence)라고 합니다.
### 이스케이프 문자 \와 한 개의 영문자 또는 심볼로 구성됩니다.

# 문자 클래스
### [:digit:] : 숫자
### [:lower:] : 알파벳 소문자
### [:upper:] : 알파벳 대문자
### [:alpha:] : 알파벳 문자
### [:alnum:] : 알파벳 문자 + 숫자
### [:punct:] : 문장부호
### [:blank:] : 블랭크 문자; 스페이스, 탭
### [:space:] : 스페이스 문자; 스페이스, 탭, 뉴라인, 폼피드, 캐리지리턴
### [:print:] : 프린트 가능 문자
### [:graph:] : 그래프 문자

# 문자 클래스 시퀀스
### \w : 단어 문자; [[:alnum:]_]
### \W : 단어 문자를 제외한 문자; [^[:alnum:]_]
### \d : 숫자
### \D : 숫자를 제외한 문자
### \s : 스페이스 문자
### \S : 스페이스 문자를 제외한 문자
### \b : 단어 경계의 빈 문자열
### \B : 단어 경계가 아닌 빈 문자열
### \< : 단어 시작
### \> : 단어 끝


string <- "<123> Alice's Adventures in Wonder_land!-$10"

gsub("\\w", "*", string)
# 문자, 숫자, 언더스코어 매칭
gsub("\\w+", "*", string)
# 단어 단위로 매칭
gsub("\\W+", "+", string)
# 단어 문자 제외 매칭

gsub("\\d+", "*", string)
# 숫자 부분 매칭
gsub("\\D+", "+", string)
# 숫자 부분 제외 매칭

gsub("\\s+", "*", string)
# 공백 부분 매칭
gsub("\\S+", "+", string)
# 공백 부분 제외 매칭

gsub("\\b", "_", string, perl=TRUE)
# 단어 경계 매칭, gsub 함수는 기본적으로 \b를 지원하지 않으므로 perl 인자 필요
gsub("d", "ds", string, perl=TRUE)
# 모든 d 매칭
gsub("d\\b", "ds", string, perl=TRUE)
# d 중에서 단어의 경계에 있는 것만 매칭
gsub("\\B", "+", string, perl=TRUE)
# 문자와 문자 사이 매칭


txt <- c("Korea", "Korean", "Koreans")
grep("Korea", txt, value=TRUE)
# "Korea" 포함되어 있는 모든 요소 매칭
grep("\\bKorea\\b", txt, value=TRUE, perl=TRUE)


txt2 <- "banana is next to bamboo and panda"
gsub("\\<b", "*", txt2)
# 단어의 시작에 있는 b 매칭
gsub("^b", "*", txt2)
# 전체 텍스트의 시작을 매칭
gsub("a\\>", "*", txt2)
# 단어의 끝에 있는 a 매칭
gsub("a$", "*", txt2)
# 전체 텍스트의 끝을 매칭



# 7) 백레퍼런스

### 정규표현식(regular expression)을 이용하여 문자열 패턴을 매칭할 때
### 한 번 매칭된 것과 동일한 문자열을 나중에 다시 매칭할 수 있습니다.
### 이러한 매칭 방법을 백레퍼런스(back reference)라고 합니다.
### 백레퍼런스는 텍스트 내의 반복되는 문자열을 탐색할 때 유용합니다.

txt <-"# a small thing makes a big difference #"
gsub("([[:alpha:]]).+\\1", "*", txt)
# a로 시작해서 a로 끝나는 부분이 매칭됨
gsub("([[:alpha:]]).+?\\1", "*", txt, perl=TRUE)


string <- "<div class='power'>100%</div>"
gsub("(<.*?>)(.*)(<.*?>)", "\\2", string)


state.name
grep("^New", state.name, value=TRUE)
gsub("^New(.*[xy].*)", "NEW\\1", state.name, ignore.case=TRUE)




# 8) 연습: 전화번호부
telephones <- "Barabasi, Albert-Laszlo917 1843James Bond(02)563-1987(1)John F. Kennedy051-776-5879(123)Dr. Who(062) 324-9576McCartney, J. Paul0648323912"
# 이름과 전화번호가 쌍을 이루고 있는 데이터

pattern <- "[[:alpha:]., -]{2,}"
# 알파벳 문자, 쉼표, 공백, 하이픈 두 개 이상 출현
name <- unlist(regmatches(x=telephones,
                          m=gregexpr(pattern=pattern,
                                     telephones)))
name


pattern2 <- 
  "\\(?(\\d{2,3})?\\)?(-| )?\\d{3}(-| )?\\d{4}\\(?(\\d{1,3})?\\)?"
# 지역번호 자리수, 괄호 유무, 하이픈, 공백 등 복잡함
# 지역번호 2자리 or 3자리, 있기도 하고 없기도 함, 괄호 있기도 하고 없기도 함
# 하이픈 있기도 하고 없기도 함
# 가운데 7자리 번호
# 내선번호 1자리 이상 3자리 이하, 있기도 하고 없기도 함
phone <- unlist(regmatches(x=telephones,
                           m=gregexpr(pattern=pattern2,
                                      telephones)))
phone

data.frame(name=name, phone=phone)
