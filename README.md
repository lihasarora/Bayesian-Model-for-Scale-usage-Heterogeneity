# Bayesian Model for Survey Data Heterogeneity
 Ratings data is often biased in a market research survey. If not corrected properly, It can lead to false inferences for covariance based methods such as regression. In this project, I develop a Bayesian model to tackle the survey data heterogeneity. Upon model implementation, I show how does accounting for survey data heterogeneity changes inferences about people with extreme view and correlation among different responses

The two main insights were as follows:
1. Elimination of spurious correlations
I demonstrated that when adjusted for Survey Usage Heterogeneity, the questions that probe about different aspects of a product in survey should don't have high correlation, leading to better inferences
Below is the snapshot of the slide that showcases this in detail

![image](https://user-images.githubusercontent.com/87246714/142694668-65b8e347-2e31-4351-9e66-2294800fe1ec.png)


2. The second usecase was identifying people with extreme views. I demonstrated that people classified as extreme views people are much lower when adjusted for scale usage.
I used a scatterplot with 'Median' on the x-axis and 'Range' on the Y-Axis to demonstrate the effect. 

Below visual explains it in detail. The points in the visual have been jittered to better dislpay the quantum of individuals at each level

Pre Adjustment
![image](https://user-images.githubusercontent.com/87246714/142695104-4429324a-1158-4de9-9e5c-64252b084047.png)

Post Adjustment
![image](https://user-images.githubusercontent.com/87246714/142695150-aae60ef6-1c93-4a98-9d6e-0cfc911af182.png)
