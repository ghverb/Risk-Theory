#This is an application 

install.packages("actuar")

#Missing data (user data here)
data("data")

#Calculation of first 3 empirical moments and empirical limited expected value at data points
emm("data", order = 1:3)
lev <- elev("data")
lev(knots(lev))

#Graph moments to see empirical CDF, fit distribution according to CDF
plot(lev, type = "o", pch = 19)

#Verify Emiprical CDF- ogive for grouped, ecdf for individual
ogive(x)
ecdf(x)

#Fit model to data using cvm, chi-square, and layer average severity
mde("data", "distribution", start = list(rate = 1/200),measure = "CvM")
mde("data", "distribution", start = list(rate = 1/200),measure = "chi-square")
mde("data", "distribution", start = list(rate = 1/200),measure = "LAS")

#When working with just distributions- deriving Aggregate Claim Amount ECDF from frequency and severity distributions
#Usually, some assumptions will have to be made here
fx <- discretize(distribution(x, parameters), method = "unbiased",
                 from = 0, to = 22, step = 0.5, lev = levdistribution(x, parameters))
Fx <- aggregateDist("recursive", model.freq = "distribution",
                    model.sev = fx, lambda = " ", x.scale = 0.5)

#Simulated data using fitted model
rcompound("number of data points", frequencymodel("parameters"), severitymodel("parameters"))

