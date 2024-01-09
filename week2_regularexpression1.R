
# 0) 정규표현식

# 정규표현식(regular expression): 특정한 규칙을 갖는 문자열 패턴을 표현하는 방법
### ABC, ABBA, ACE -> ‘A로 시작하는 문자열’

# 정규표현식은 연속된 문자열로 정의

# 메타문자(metacharacter)
### 정규표현식에 사용되는, 특별한 용도의 특수 문자

# html 문서에서 텍스트 추출 후 전처리를 할 때 정규표현식이 유용하게 사용될 수 있음.

# 하나의 문자열도 정규표현식으로 활용할 수 있음. 문자열을 하나의 패턴으로 간주



# 1) 문자열 매칭

string <- c("banana is yellow", 
            "panda is next to bamboo", 
            "X-men are dancing the samba")

grep(pattern="X-men", x=string) # "X-men"이 포함되어 있는 문자열의 인덱스를 반환
grep(pattern="X-men", x=string, value = TRUE) # 값 자체를 반환

# 기본적으로 대소문자 구분함, 매칭이 안 되었을 경우 빈 integer 반환
grep(pattern="x-men", x=string)
grep(pattern="x-men", x=string, ignore.case=TRUE) # 대소문자 구분하지 않음

# 반드시 단어 단위일 필요는 없음
grep(pattern="ana", x=string, value = TRUE)
# 공백 포함해도 됨
grep(pattern="next to", x=string, value = TRUE)

# ^(caret), $
grep(pattern="ba", x=string, value = TRUE) # 텍스트에 "ba" 포함된 경우 모두 찾음
grep(pattern="^ba", x=string, value = TRUE) # 텍스트의 시작이 "ba"인 경우를 찾음
grep(pattern="ba$", x=string, value = TRUE) # 텍스트의 끝이 "ba"인 경우를 찾음

# |(pipe) -> or 개념
grep(pattern="banana|bamboo", x=string, value = TRUE) # "banana" 혹은 "bamboo" 포함

# . 고정되지 않은, 임의의 한 문자를 대체함
grep(pattern="p.", x=string, value = TRUE) # "p"를 포함한 문자열



# 2) 
