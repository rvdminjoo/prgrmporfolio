data<-read.csv("C:/Users/rvdmi/OneDrive/대학/심포지엄/2023 서울대학교 소비자학과 심포지엄 설문조사(응답).CSV", header=T, fileEncoding = "euc-kr")



# 변수 이름 설명
#
# 건강 - health -> h
# 학습 - learning -> l
# 취미 - pastime -> p
# 생활습관 - routine -> r
# 
# 1-내재
# 2-외적조절
# 3-동일시조절
# 4-내사적조절
# 
# ex. h_1_1 = 건강, 내재적 동기, 1번 질문
#
# likeness - 타인 의식
# ex - 외부의 영향



# 데이터 가공 - 평균 내기

data$h_1=rowMeans(data[,c('h_1_1', 'h_1_2', 'h_1_3')])
data$h_2=rowMeans(data[,c('h_2_1', 'h_2_2', 'h_2_3')])
data$h_3=rowMeans(data[,c('h_3_1', 'h_3_2', 'h_3_3')])
data$h_4=rowMeans(data[,c('h_4_1', 'h_4_2', 'h_4_3')])

data$l_1=rowMeans(data[,c('l_1_1', 'l_1_2', 'l_1_3')])
data$l_2=rowMeans(data[,c('l_2_1', 'l_2_2', 'l_2_3')])
data$l_3=rowMeans(data[,c('l_3_1', 'l_3_2', 'l_3_3')])
data$l_4=rowMeans(data[,c('l_4_1', 'l_4_2', 'l_4_3')])

data$p_1=rowMeans(data[,c('p_1_1', 'p_1_2', 'p_1_3')])
data$p_2=rowMeans(data[,c('p_2_1', 'p_2_2', 'p_2_3')])
data$p_3=rowMeans(data[,c('p_3_1', 'p_3_2', 'p_3_3')])
data$p_4=rowMeans(data[,c('p_4_1', 'p_4_2', 'p_4_3')])

data$r_1=rowMeans(data[,c('r_1_1', 'r_1_2', 'r_1_3')])
data$r_2=rowMeans(data[,c('r_2_1', 'r_2_2', 'r_2_3')])
data$r_3=rowMeans(data[,c('r_3_1', 'r_3_2', 'r_3_3')])
data$r_4=rowMeans(data[,c('r_4_1', 'r_4_2', 'r_4_3')])

data$likeness=rowMeans(data[,c('likeness_1', 'likeness_2', 'likeness_3')])
data$ex=rowMeans(data[,c('ex_1', 'ex_2', 'ex_3', 'ex_4')])



# 다중회귀모델

# 건강
model_h = lm(h_bhv ~ h_1+h_2+h_3+h_4, data=data)
summary(model_h)

model_hm1 = lm(h_bhv ~ h_1*likeness, data=data)
summary(model_hm1)

model_hm2 = lm(h_bhv ~ h_2*likeness, data=data)
summary(model_hm2)

model_hm3 = lm(h_bhv ~ h_3*likeness, data=data)
summary(model_hm3)

model_hm4 = lm(h_bhv ~ h_4*likeness, data=data)
summary(model_hm4)

model_likey = lm(h_bhv ~ likeness, data=data)
summary(model_likey)

model_ex = lm(h_bhv ~ ex, data=data)
summary(model_ex)



# 학습
model_l = lm(l_bhv ~ l_1+l_2+l_3+l_4, data=data)
summary(model_l)

model_p = lm(p_bhv ~ p_1+p_2+p_3+p_4, data=data)
summary(model_p)

model_r = lm(r_bhv ~ r_1+r_2+r_3+r_4, data=data)
summary(model_r)



# 크론바흐 알파

library(psych)
alpha(data[,c('h_1_1', 'h_1_2', 'h_1_3')])  # 0.77
alpha(data[,c('h_2_1', 'h_2_2', 'h_2_3')])  # 0.42
alpha(data[,c('h_3_1', 'h_3_2', 'h_3_3')])  # 0.9
alpha(data[,c('h_4_1', 'h_4_2', 'h_4_3')])  # 0.92

alpha(data[,c('l_1_1', 'l_1_2', 'l_1_3')])  # 0.84
alpha(data[,c('l_2_1', 'l_2_2', 'l_2_3')])  # 0.75
alpha(data[,c('l_3_1', 'l_3_2', 'l_3_3')])  # 0.92
alpha(data[,c('l_4_1', 'l_4_2', 'l_4_3')])  # 0.92

alpha(data[,c('p_1_1', 'p_1_2', 'p_1_3')])  # 0.8
alpha(data[,c('p_2_1', 'p_2_2', 'p_2_3')])  # 0.78
alpha(data[,c('p_3_1', 'p_3_2', 'p_3_3')])  # 0.96
alpha(data[,c('p_4_1', 'p_4_2', 'p_4_3')])  # 0.9

alpha(data[,c('r_1_1', 'r_1_2', 'r_1_3')])  # 0.83
alpha(data[,c('r_2_1', 'r_2_2', 'r_2_3')])  # 0.94
alpha(data[,c('r_3_1', 'r_3_2', 'r_3_3')])  # 0.94
alpha(data[,c('r_4_1', 'r_4_2', 'r_4_3')])  # 0.96

