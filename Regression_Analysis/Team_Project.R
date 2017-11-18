##### 데이터 전처리 ######


setwd("C:/Users/Hyein/Desktop/regression_analysis")

movie <- read.csv("2015_movie.csv")
head(movie)
str(movie)
names(movie)
movie <- movie[,-c(1,3,4,5,8,9,14,15)]
names(movie)
str(movie)

# 쉼표 버리고 factor를 numeric으로 
movie[,5] <- as.numeric(gsub(",", "", movie[,5]))
movie[,7] <- as.numeric(gsub(",", "", movie[,7]))
str(movie)

sort(movie$전국스크린수)
mean(movie$전국스크린수)
nrow(movie)
1264-713
small <- which(movie$전국스크린수 < 10)
length(small)
mm <- movie[-small, ]
nrow(mm)
mean(mm$전국스크린수)
nrow(movie[movie$전국스크린수 >= 200, ]) # 전국스크린수가 50개 이상인 영화는 203편
movie <- movie[movie$전국스크린수 >= 200, ]
str(movie) # 203 obs.

library(stringr)
nrow(movie)
korean <- rep(0,203)
korean[which(str_detect(movie[,4], "한국"))] <- 1
movie <- cbind(movie, korean=as.factor(korean))
# 한국영화: 1, 외국영화: 0
head(movie[,c(4,13)],20) # 확인

movie <- movie[,-4]
str(movie)
# CJ, 폭스, 롯데, 워너, 소니, NEW, 쇼박스 7개 배급사를 대형 배급사로 취급
levels(movie[,2])
distributor <- rep(0,203)
distributor[which(str_detect(movie[,2], "씨제이"))] <- 1
distributor[which(str_detect(movie[,2], "폭스"))] <- 1
distributor[which(str_detect(movie[,2], "롯데"))] <- 1
distributor[which(str_detect(movie[,2], "워너"))] <- 1
distributor[which(str_detect(movie[,2], "소니"))] <- 1
distributor[which(str_detect(movie[,2], "NEW"))] <- 1
distributor[which(str_detect(movie[,2], "쇼박스"))] <- 1
str(movie[,2])
movie <- cbind(movie, distributor=as.factor(distributor))
names(movie)
head(movie[,c(2,13)], 20)
tail(movie[,c(2,13)], 20)
str(movie)
movie <- movie[,-2]
str(movie)

commercial <- rep(0,203)
commercial[which(movie$영화구분=="상업영화")] <- 1
commercial
movie <- cbind(movie, commercial=as.factor(commercial))
str(movie)
head(movie[,c(8,13)], 20)
tail(movie[,c(8,13)], 20)

movie <- movie[,-8]
str(movie)

head(movie$개봉일)
Q1 <- rep(0,203); Q2 <- rep(0,203); Q3 <- rep(0,203); Q4 <- rep(0,203)

Q1[which(str_detect(movie$개봉일, "2015-01"))] <- 1
Q1[which(str_detect(movie$개봉일, "2015-02"))] <- 1
Q1[which(str_detect(movie$개봉일, "2015-03"))] <- 1

Q2[which(str_detect(movie$개봉일, "2015-04"))] <- 1
Q2[which(str_detect(movie$개봉일, "2015-05"))] <- 1
Q2[which(str_detect(movie$개봉일, "2015-06"))] <- 1

Q3[which(str_detect(movie$개봉일, "2015-07"))] <- 1
Q3[which(str_detect(movie$개봉일, "2015-08"))] <- 1
Q3[which(str_detect(movie$개봉일, "2015-09"))] <- 1

Q4[which(str_detect(movie$개봉일, "2015-10"))] <- 1
Q4[which(str_detect(movie$개봉일, "2015-11"))] <- 1
Q4[which(str_detect(movie$개봉일, "2015-12"))] <- 1

head(cbind(Q1, Q2, Q3, Q4), 10)
apply(cbind(Q1, Q2, Q3, Q4), 1, sum)
str_count(movie$개봉일, "2014")


movie <- cbind(movie, Q1=as.factor(Q1), Q2=as.factor(Q2), Q3=as.factor(Q3), Q4=as.factor(Q4))
str(movie)
head(movie[,c(2,13:16)], 10)
movie <- movie[,-2]
str(movie)



levels(movie$장르)
# SF, 가족, 공포(호러), 다큐멘터리, 드라마, 멜로/로맨스, 뮤지컬, 미스터리, 범죄, 사극, 스릴러, 애니메이션, 액션, 어드벤처, 전쟁, 코미디, 판타지

sort(table(movie$장르), decreasing=T)
# 203 * 0.05 = 16.5
# 5%가 16.5 이므로 16편 미만인 장르는 기타로 분류 (000000)
drama <- rep(0,203)
drama[which(movie$장르=="드라마")] <- 1

animation <- rep(0,203)
animation[which(movie$장르=="애니메이션")] <- 1

action <- rep(0,203)
action[which(movie$장르=="액션")] <- 1

comedy <- rep(0,203)
comedy[which(movie$장르=="코미디")] <- 1

romance <- rep(0,203)
romance[which(movie$장르=="멜로/로맨스")] <- 1

thriller <- rep(0,203)
thriller[which(movie$장르=="스릴러")] <- 1

head(cbind(drama, animation, action, comedy, romance, thriller),10)
movie <- cbind(movie, drama=as.factor(drama), animation=as.factor(animation), action=as.factor(action), comedy=as.factor(comedy), romance=as.factor(romance), thriller=as.factor(thriller))

str(movie)
head(cbind(movie[,c(5,16:21)]),10)
tail(cbind(movie[,c(5,16:21)]),10)
movie <- movie[,-5]
str(movie)

levels(movie$등급)
yr.12 <- rep(0,203)
yr.12[which(movie$등급=="12세이상관람가")] <- 1

yr.15 <- rep(0,203)
yr.15[which(movie$등급=="15세이상관람가")] <- 1

yr.19 <- rep(0,203)
yr.19[which(movie$등급=="청소년관람불가")] <- 1
yr.19

movie <- cbind(movie, yr.12=as.factor(yr.12), yr.15=as.factor(yr.15), yr.19=as.factor(yr.19))
str(movie)
head(movie[, c(5,21:23)])
tail(cbind(yr.12, yr.15, yr.19), 10)
str(movie)
movie <- movie[,-5]
str(movie)

movie <- movie[,-3]
str(movie)
movie.1 <- cbind(전국관객수=movie$전국관객수, movie[,-c(1,3)])
str(movie.1)
names(movie.1)




#######################################


# 1. 결측치 처리
ind <- which(is.na(movie.1$기자평론가평점)); ind
mean(movie.1$관람객평점[-ind]) - mean(movie.1$기자평론가평점, na.rm=T)
movie.1[ind, ][,4]
naa <- movie.1[ind,][,3] - 2
for(i in 1:19) movie.1[ind, ][,4][i] <- naa[i]
summary(movie.1)



# 모델 적합
model.1 <- lm(전국관객수~., data=movie.1)
summary(model.1)

# ri vs. fitted value
rstd.1 <- rstandard(model.1)
fv.1 <- model.1$fitted.values
plot(rstd.1 ~ fv.1, xlab="fitted value", ylab="standard residual")
identify(fv.1, rstd.1, labels=1:203, cex=0.8, col="blue") 
movie$영화명[c(51,97,41,4,203,200,202,119)]

windows()
par(mfrow=c(3,3))
plot(rstd.1~movie.1$전국스크린수)
plot(rstd.1~movie.1$관람객평점)
plot(rstd.1~movie.1$기자평론가평점)
plot(rstd.1~movie.1$korean)
plot(rstd.1~movie.1$distributor)
plot(rstd.1~movie.1$commercial)
plot(rstd.1~movie.1$Q1)
plot(rstd.1~movie.1$Q2)
plot(rstd.1~movie.1$Q3)
plot(rstd.1~movie.1$Q4)
plot(rstd.1~movie.1$drama)
plot(rstd.1~movie.1$animation)
plot(rstd.1~movie.1$action)
plot(rstd.1~movie.1$comedy)
plot(rstd.1~movie.1$romance)
plot(rstd.1~movie.1$thriller)
plot(rstd.1~movie.1$yr.12)
plot(rstd.1~movie.1$yr.15)
plot(rstd.1~movie.1$yr.19)
names(movie.1)


# Draw residual plus component plots
library(car)
crPlots(model.1,smooth=FALSE)


# Draw a normal probability plot
par(mfrow=c(1,1))
rstd.1 <- rstandard(model.1)
qqnorm(rstd.1, ylab="Standardized Residuals", xlab="Normal Scores" )
abline(a=0, b=1, col="red")

# Draw an index plot of residuals;
rstd.1 <- rstandard(model.1)
plot(rstd.1 ,ylab="Standardized Residuals", xlab="Observation Number")
abline(a=2, b=0, col="red")
abline(a=-2, b=0, col="red")
identify(rstd.1, labels=1:203, cex=0.8, col="blue") 
movie$영화명[c(4,17,41,51,57,97,131,119,190,200,203,202)] # outlier


# Draw an index plot of cook's D;
cookd.1 <- cooks.distance(model.1)
plot(cookd.1 ,ylab="Cook's Distance", xlab="Observation Number")
identify(cookd.1, labels=1:203, cex=0.8, col="blue") 
movie$영화명[c(1,4,2,116)] # influential points

# Draw an index plot of DFITS;
dfits.1 <- dffits(model.1)
plot(dfits.1,ylab="DFITS", xlab="Observation Number")
abline(a=1, b=0, col="red")
abline(a=-1, b=0, col="red")
identify(dfits.1, labels=1:203, cex=0.8, col="blue") 
movie$영화명[c(1,4,2,116)] # 








##########################################################


movie.2 <- movie.1
movie.2[,1] <- log(movie.1[,1])
head(movie.2,1 )

model.2 <- lm(전국관객수~., data=movie.2)
summary(model.2)

# ri vs. fitted value
rstd.2 <- rstandard(model.2)
fv.2 <- model.2$fitted.values
plot(rstd.2 ~ fv.2, xlab="fitted value", ylab="standard residual")
identify(fv.2, rstd.2, labels=1:203, cex=0.8, col="blue") 
movie$영화명[c(51,97,41,4,203,200,202,119)]

windows()
par(mfrow=c(3,3))
plot(rstd.2~movie.1$전국스크린수)
plot(rstd.2~movie.1$관람객평점)
plot(rstd.2~movie.1$기자평론가평점)
plot(rstd.2~movie.1$korean)
plot(rstd.2~movie.1$distributor)
plot(rstd.2~movie.1$commercial)
plot(rstd.2~movie.1$Q1)
plot(rstd.2~movie.1$Q2)
plot(rstd.2~movie.1$Q3)
plot(rstd.2~movie.1$Q4)
plot(rstd.2~movie.1$drama)
plot(rstd.2~movie.1$animation)
plot(rstd.2~movie.1$action)
plot(rstd.2~movie.1$comedy)
plot(rstd.2~movie.1$romance)
plot(rstd.2~movie.1$thriller)
plot(rstd.2~movie.1$yr.12)
plot(rstd.2~movie.1$yr.15)
plot(rstd.2~movie.1$yr.19)


# Draw residual plus component plots
library(car)
crPlots(model.2,smooth=FALSE)


# Draw a normal probability plot
par(mfrow=c(1,1))
rstd.2 <- rstandard(model.2)
qqnorm(rstd.1, ylab="Standardized Residuals", xlab="Normal Scores" )
abline(a=0, b=1, col="red")

# Draw an index plot of residuals;
rstd.2 <- rstandard(model.2)
plot(rstd.2 ,ylab="Standardized Residuals", xlab="Observation Number")
abline(a=2, b=0, col="red")
abline(a=-2, b=0, col="red")
identify(rstd.2, labels=1:203, cex=0.8, col="blue") 
movie$영화명[c(4,17,41,51,57,97,131,119,190,200,203,202)] # outlier


# Draw an index plot of cook's D;
cookd.2 <- cooks.distance(model.2)
plot(cookd.2 ,ylab="Cook's Distance", xlab="Observation Number", ylim=c(0,0.23), xlim=c(0, 230))
identify(cookd.2, labels=1:203, cex=0.8, col="blue") 
movie$영화명[c(51,202,203)] # influential points

movie[c(51,202,203),]

# Draw an index plot of DFITS;
dfits.2 <- dffits(model.2)
plot(dfits.2,ylab="DFITS", xlab="Observation Number", xlim=c(0,210), ylim=c(-2.3, 2.3))
abline(a=1, b=0, col="red")
abline(a=-1, b=0, col="red")
identify(dfits.2, labels=1:203, cex=0.8, col="blue") 
movie$영화명[c(4,51,97,190,200,202,203)] # 

# Draw an index plot of leverage values;
lvrg.2 <- hatvalues(model.2)
plot(lvrg.2 ,ylab="Leverage Values", xlab="Observation Number", xlim=c(0,210),ylim=c(0.05,0.23))
abline(a=0.2, b=0, col="red")
identify(lvrg.2, labels=1:203, cex=0.8, col="blue") 



######################################################


movie.3 <- movie.2[-c(51,202,203),]
nrow(movie.3)
model.3 <- lm(전국관객수~., data=movie.3)


# Draw an index plot of cook's D;
cookd.3 <- cooks.distance(model.3)
plot(cookd.3 ,ylab="Cook's Distance", xlab="Observation Number")
identify(cookd.3, labels=1:200, cex=0.8, col="blue") 
movie$영화명[c(51,202,203)] # influential points

# Draw an index plot of DFITS;
dfits.3 <- dffits(model.3)
plot(dfits.3,ylab="DFITS", xlab="Observation Number")
abline(a=1, b=0, col="red")
abline(a=-1, b=0, col="red")
identify(dfits.3, labels=1:200, cex=0.8, col="blue") 
movie$영화명[c(3,4,96,115,199,200)] # 


summary(model.3)






#############
names(movie.3)
fit.con <- lm(전국관객수 ~ 1,data=movie.3) #상수항만 있는?????

fit.both <- step(fit.con, scope=list(lower=fit.con, upper=model.3), direction="both")
fit.both


summary(model.3)
vif(model.3)
#다중공선성을 확인하기 위해


sqrt(vif(model.3))>2
#2보다 크면 다중공선성이 있다고 판단함
#다중공선성 문제가 생기면 vif가 가장 높은 애를 빼주면 됨


names(movie.3)
movie.4 <- movie.3[,-19]
model.4 <- lm(전국관객수~., data=movie.4)


vif(model.4)
sqrt(vif(model.4))>2



summary(model.4)


# Draw residual plus component plots
library(car)
crPlots(model.4,smooth=FALSE)

summary(fit.both)

##########################################
names(movie.4)
movie.5 <- movie.4[,-15]
model.5 <- lm(전국관객수~., data=movie.5)
summary(model.5)

names(movie.5)
movie.6 <- movie.5[,-18]
model.6 <- lm(전국관객수~., data=movie.6)
summary(model.6)

names(movie.6)
movie.7 <- movie.6[,-15]
model.7 <- lm(전국관객수~., data=movie.7)
summary(model.7)

names(movie.7)
movie.8 <- movie.7[,-14]
model.8 <- lm(전국관객수~., data=movie.8)
summary(model.8)

names(movie.8)
movie.9 <- movie.8[,-15]
model.9 <- lm(전국관객수~., data=movie.9)
summary(model.9)

names(movie.9)
movie.10 <- movie.9[,-3]
model.10 <- lm(전국관객수~., data=movie.10)
summary(model.10)

names(movie.10)
movie.11 <- movie.10[,-13]
model.11 <- lm(전국관객수~., data=movie.11)
summary(model.11)

names(movie.11)
movie.12 <- movie.11[,-11]
model.12 <- lm(전국관객수~., data=movie.12)
summary(model.12)


plot(movie.12[,c(2,3)])
windows()
par(mfrow=c(2,2))
plot(model.12)


######################3

# ri vs. fitted value
rstd.12 <- rstandard(model.12)
fv.12 <- model.12$fitted.values
plot(rstd.12 ~ fv.12, xlab="fitted value", ylab="standard residual")

names(movie.12)
windows()
par(mfrow=c(2,5))
plot(rstd.12~movie.12$전국스크린수)
plot(rstd.12~movie.12$기자평론가평점)
plot(rstd.12~movie.12$korean)
plot(rstd.12~movie.12$distributor)
plot(rstd.12~movie.12$commercial)
plot(rstd.12~movie.12$Q1)
plot(rstd.12~movie.12$Q2)
plot(rstd.12~movie.12$Q3)
plot(rstd.12~movie.12$Q4)
plot(rstd.12~movie.12$animation)


# Draw residual plus component plots
library(car)
crPlots(model.12,smooth=FALSE)


# Draw a normal probability plot
par(mfrow=c(1,1))
rstd.12 <- rstandard(model.12)
qqnorm(rstd.12, ylab="Standardized Residuals", xlab="Normal Scores" )
abline(a=0, b=1, col="red")

# Draw an index plot of residuals;
rstd.12 <- rstandard(model.12)
plot(rstd.12 ,ylab="Standardized Residuals", xlab="Observation Number")
abline(a=2, b=0, col="red")
abline(a=-2, b=0, col="red")
identify(rstd.12, labels=1:200, cex=0.8, col="blue") 

sfs <- rstandard(fit.both)
plot(sfs ,ylab="Standardized Residuals", xlab="Observation Number")

fit.both
summary(fit.both)
