survey<-read.csv("C:/Users/rvdmi/OneDrive/대학/커넥트/팀세션/뉴트로 현상에 있어서의 독특성 연구(응답).csv", fileEncoding = "euc-kr")
summary(survey)
survey$성별<-ifelse(survey$성별=="남성", 1, 2)
survey$성별<-as.factor(survey$성별)
prop.table(table(survey$성별))
table(survey$age)
prop.table(table(survey$age))
sd(survey$troy/4)
mean(survey$troy/4)

0.01923077+0.15384615

library(car)
vif(reg)



# 크론바흐 알파

alpha(survey[,4:6])
alpha(survey[,7:10])
alpha(survey[,11:14])
alpha(survey[,15:17])
alpha(survey[,18:21])

# 태도

reg1 <- lm(tatt ~ tunq + tnstg, data = survey)
plot(reg1, 1)
ncvTest(reg1)
res = residuals(reg1)
shapiro.test(res)
summary(reg1)
reg1

install.packages("openxlsx")
library("openxlsx")
install.packages("rempsyc")
library(apaTables)
pkgs <- c("flextable", "broom", "report", "effectsize")
install.packages(pkgs)
table4 <- apa.reg.table(reg1,
                        table.number = 4)
print(table4, preview ="docx")
flextable::save_as_docx(table4[["table_body"]], path = "table4.docx")
write.xlsx(table4[["table_body"]], sheetName="table4", file="newtro tables.xlsx")

library(mediation)
model.y1 <- lm(tatt ~ tunq + tnstg, data = survey)     # lm(종속~독립+매개)
model.m1 <- lm(tnstg ~ tunq, data = survey)    # lm(매개~독립)

reg4 <- lm(troy ~ tunq, data = survey)
summary(reg4)
summary(model.m1)

result <- mediate(model.m1, model.y1, treat="tunq", mediator="tnstg")
summary(result)
result
table5 <- apa.reg.table(result)

library(psych)
out1<-mediate(y="tatt", x="tunq", m="tnstg", data=survey, n.iter = 5000)
print(out1, short = FALSE)
out1

cor(survey$tatt, survey$tunq)
cor(survey$tint, survey$tunq)
cor(survey$troy, survey$tunq)


library(lmSupport)
reg7<-lm(tatt~tunq+tnstg, data=survey) 
reg8<-lm(tatt~tunq*tnstg, data=survey) 
modelCompare(reg7, reg8)




# 구매의도

reg2 <- lm(tint ~ tunq + tnstg, data = survey)
plot(reg2, 1)
ncvTest(reg2)
res2 = residuals(reg2)
shapiro.test(res2)

summary(reg2)

table5 <- apa.reg.table(reg2,
                        table.number = 5)
write.xlsx(table5[["table_body"]], sheetName="table5", file="newtro tables.xlsx")

model.y2 <- lm(tint ~ tunq + tnstg, data = survey)     # lm(종속~독립+매개)
model.m2 <- lm(tnstg ~ tunq, data = survey)    # lm(매개~독립)

result <- mediate(model.m2, model.y2, treat="tunq", mediator="tnstg")
summary(result)

out2<-mediate(y="tint", x="tunq", m="tnstg", data=survey, n.iter = 5000)
out2


reg7<-lm(tint~tunq+tnstg, data=survey) 
reg8<-lm(tint~tunq*tnstg, data=survey) 
modelCompare(reg7, reg8)



# 충성도

reg3 <- lm(troy ~ tunq + tnstg, data = survey)
plot(reg3, 1)
ncvTest(reg3)
res3 = residuals(reg3)
shapiro.test(res3)

summary(reg3)

table6 <- apa.reg.table(reg3,
                        table.number = 6)
write.xlsx(table6[["table_body"]], sheetName="table6", file="newtro tables.xlsx")


model.y3 <- lm(troy ~ tunq + tnstg, data = survey)     # lm(종속~독립+매개)
model.m3 <- lm(tnstg ~ tunq, data = survey)    # lm(매개~독립)

result <- mediate(model.m3, model.y3, treat="tunq", mediator="tnstg")
summary(result)

out3<-mediate(y="troy", x="tunq", m="tnstg", data=survey, n.iter = 5000)
out3

reg7<-lm(troy~tunq+tnstg, data=survey) 
reg8<-lm(troy~tunq*tnstg, data=survey) 
modelCompare(reg7, reg8)

