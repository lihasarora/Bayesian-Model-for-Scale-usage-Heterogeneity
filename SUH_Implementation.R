################################################################################
library(bayesm)
library(dplyr)
library(MASS)
library(matlib)

df_1 <- data(customerSat)
#write.csv(customerSat,"csat.csv")


if(nchar(Sys.getenv("LONG_TEST")) != 0) {R=5000} else {R=5000} 
{
  
  surveydat = list(k=10,x=as.matrix(customerSat))
  
  Mcmc1 = list(R=R)
  set.seed(66)
  out=rscaleUsage(Data=surveydat,Mcmc=Mcmc1)
  
  summary(out$mudraw)
}
################################################################################

mu_matrix = matrix(unlist(as.list(out$mudraw)),nrow = R, ncol = 10)
tau_draw_matrix = matrix(unlist(as.list(out$taudraw)),nrow = R, ncol = 1811)
small_sigma_draw_matrix = matrix(unlist(as.list(out$sigmadraw)),nrow = R, ncol = 1811)
lambda_draw_matrix = matrix(unlist(as.list(out$Lambdadraw)),nrow = R, ncol = 4)
capital_sigma_draw_matrix = matrix(unlist(as.list(out$Sigmadraw)),nrow = R, ncol = 100)
e_draw_matrix = matrix(unlist(as.list(out$edraw)),nrow = R, ncol = 1)

#### Expected Value of the MCMC samples #########

mean_mu_matrix = colMeans(mu_matrix)
mean_tau_matrix = colMeans(tau_draw_matrix)
mean_small_sigma_draw_matrix = colMeans(small_sigma_draw_matrix)
mean_lambda_draw_matrix = colMeans(lambda_draw_matrix)
mean_e_draw = mean(e_draw_matrix[R,])
mean_capital_sigma_draw_matrix = matrix(colMeans(capital_sigma_draw_matrix),10,10)

#covariance_matrix = matrix(mean_capital_sigma_draw_matrix,10,10)

## Sample from a multivariate normal distribution

## Now, we have generated the distributions for each person, each question

## Mu matrix for yi
mu_final = matrix(rep(0,18110), 1811,10)
###################################
for (i in 1:1811)
{
  mu_final[i,] = mean_mu_matrix 
}

## Adding tau to it
tau_final = matrix(rep(0,18110), 1811,10)

for (i in 1:10)
{
  tau_final[,i] =  mean_tau_matrix
}


####################################

mu_plus_tau = mu_final + tau_final


variance_of_each_respondent = matrix(rep(0,10),1,10)
combined_variance_all_respondents = matrix(rep(0,18110),1811,10)

random_sample_from_z = mvrnorm(n = 1811, mu = rep(0,10), Sigma = mean_capital_sigma_draw_matrix)

final_y = mu_plus_tau+ mean_small_sigma_draw_matrix*random_sample_from_z 

final_y_df = data.frame(final_y)

my_func <- function(x)
{
  if(x<1.5)
  {return (1)}
  
  else if(x>10)
  {return (10)}
  
  else{
    return(round(x,0))
  }
}

final_y_ranking_adj = apply(final_y,c(1,2), FUN = my_func)
