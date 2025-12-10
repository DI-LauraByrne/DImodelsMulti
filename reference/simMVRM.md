# The simulated multivariate repeated measures "simMVRM" dataset

The `simMVRM` dataset was simulated from a multivariate repeated
measures DI model. It contains 336 plots comprising of four species that
vary in proportions (`p1` - `p4`). There are three simulated responses
(`Y1, Y2, Y3`), taken at two differing time points, recorded in a wide
data format (one column per response type). The data was simulated
assuming that there were existing covariances between the responses and
between the time pointsand both species identity and species interaction
effects were present.

## Usage

``` r
data("simMVRM")
```

## Format

A data frame with 672 observations on the following 9 variables.

- `plot`:

  a factor vector indicating the ID of the experimental unit

- `p1`:

  a numeric vector indicating the initial proportion of species 1

- `p2`:

  a numeric vector indicating the initial proportion of species 2

- `p3`:

  a numeric vector indicating the initial proportion of species 3

- `p4`:

  a numeric vector indicating the initial proportion of species 4

- `Y1`:

  a numeric vector indicating the response of ecosystem function 1

- `Y2`:

  a numeric vector indicating the response of ecosystem function 2

- `Y3`:

  a numeric vector indicating the response of ecosystem function 3

- `time`:

  a factor with levels `1` `2`

## Details

**What are Diversity-Interactions (DI) models?**

Diversity-Interactions (DI) models (Kirwan *et al.*, 2009) are a set of
tools for analysing and interpreting data from experiments that explore
the effects of species diversity on community-level responses. We
strongly recommend that users read the short introduction to
Diversity-Interactions models (available at:
[`DImodels`](https://rdrr.io/pkg/DImodels/man/DImodels-package.html)).
Further information on Diversity-Interactions models is also available
in Kirwan *et al.*, 2009 and Connolly *et al.*, 2013.

**Parameter values for the simulation**

Multivariate repeated measures DI models take the general form of:

\$\${y}\_{kmt} = {Identities}\_{kmt} + {Interactions}\_{kmt} +
{Structures}\_{kt} + {\epsilon}\_{kmt}\$\$

where \\y\\ are the community-level responses, the \\Identities\\ are
the effects of species identities for each response and enter the model
as individual species proportions measured at the beginning of the time
period, the \\Interactions\\ are the interactions among the species
proportions, while \\Structures\\ include other experimental structures
such as blocks, treatments, or density.

The dataset `simRM` was simulated with:

- identity effects for the four species for each time and ecosystem
  function:

  - Y1time1 = -1.0, 5.0, 2.8, -0.9

  - Y1time2 = 0.5, 5.4, 4.9, -2.1

  - Y2time1 = 0.1, 4.1, -0.5, 0.3

  - Y2time2 = 2.3, 3.2, -3.1, 2.1

  - Y3time1 = 0.9, 6.6, 3.5, 6.1

  - Y3time2 = -0.1, 7.0, 2.8, 4.0

- evenness interaction effect for each time and ecosystem function:

  - Y1time1 = -0.1

  - Y1time2 = 12.0

  - Y2time1 = 2.3

  - Y2time2 = 1.6

  - Y3time1 = 2.1

  - Y3time2 = 6.8

- \\\epsilon\\ assumed to have a multivaraite normal distribution with
  mean 0. An ecosystem function matrix Sigma:

  |     |     |     |     |     |
  |-----|-----|-----|-----|-----|
  |     |     |     |     |     |

  and a time matrix Sigma:

  |     |     |     |     |     |
  |-----|-----|-----|-----|-----|
  |     |     |     |     |     |

## References

Dooley, A., Isbell, F., Kirwan, L., Connolly, J., Finn, J.A. and Brophy,
C., 2015.  
Testing the effects of diversity on ecosystem multifunctionality using a
multivariate model.  
Ecology Letters, 18(11), pp.1242-1251.  

Finn, J.A., Kirwan, L., Connolly, J., Sebastia, M.T., Helgadottir, A.,
Baadshaug, O.H., Belanger, G., Black, A., Brophy, C., Collins, R.P.,
Cop, J., Dalmannsdóttir, S., Delgado, I., Elgersma, A., Fothergill, M.,
Frankow-Lindberg, B.E., Ghesquiere, A., Golinska, B., Golinski, P.,
Grieu, P., Gustavsson, A.M., Höglind, M., Huguenin-Elie, O., Jørgensen,
M., Kadziuliene, Z., Kurki, P., Llurba, R., Lunnan, T., Porqueddu, C.,
Suter, M., Thumm, U., and Lüscher, A., 2013.  
Ecosystem function enhanced by combining four functional types of plant
species in intensively managed grassland mixtures: a 3-year
continental-scale field experiment.  
Journal of Applied Ecology, 50(2), pp.365-375 .  

Kirwan, L., Connolly, J., Finn, J.A., Brophy, C., Luscher, A., Nyfeler,
D. and Sebastia, M.T., 2009.  
Diversity-interaction modeling: estimating contributions of species
identities and interactions to ecosystem function.  
Ecology, 90(8), pp.2032-2038.  

## Examples

``` r
###################################################################################################
###################################################################################################
#> <STYLE type='text/css' scoped>
#> PRE.fansi SPAN {padding-top: .25em; padding-bottom: .25em};
#> </STYLE>
## Modelling Example

# For a more thorough example of the workflow of this package, please see vignette
# DImulti_workflow using the following code:

# vignette("DImulti_workflow")

head(simMVRM)
#>   plot p1 p2 p3 p4         Y1          Y2        Y3 time
#> 1    1  1  0  0  0 -3.2201614 -0.28424570 4.0353997    1
#> 2    2  1  0  0  0  0.2166701  0.90917719 0.1719544    1
#> 3    3  1  0  0  0 -2.1709989  0.04832118 0.6787839    1
#> 4    4  0  1  0  0  5.3908779  4.08309086 6.5332521    1
#> 5    5  0  1  0  0  5.2733174  4.29488262 6.2761877    1
#> 6    6  0  1  0  0  4.1985826  3.57457447 7.0207313    1

# We call DImulti() to fit a series of models, with increasing complexity, and test whether the
# additional terms are worth keeping.

# We begin with an ID DI model, ensuring to use method = "ML" as we will be comparing fixed effects

MVRMmodel <- DImulti(y = 6:8, eco_func = c("Na", "un"), time = c("time", "CS"), unit_IDs = 1,
                   prop = 2:5, data = simMVRM, DImodel = "ID",
                   method = "ML")
print(MVRMmodel)
#> Note: 
#> Method Used = ML 
#> Correlation Structure Used = un@CS
#>  Identity Model
#> Theta value(s) = 1
#> 
#> Generalized least squares fit by maximum likelihood
#>   Model: value ~ 0 + func:time:((p1_ID + p2_ID + p3_ID + p4_ID)) 
#>       AIC       BIC    logLik 
#>  9670.780  9811.002 -4810.390 
#> 
#>  Multivariate Correlation Structure: General
#>  Formula: ~0 | plot 
#>  Parameter estimate(s):
#>  Correlation: 
#>   1      2     
#> 2  0.606       
#> 3 -0.246 -0.168
#> 
#>  Repeated Measure Correlation Structure: Compound symmetry
#>  Formula: ~0 | plot 
#>  Parameter estimate(s):
#>       Rho 
#> 0.2275234 
#> 
#> 
#> Table: Fixed Effect Coefficients
#> 
#>                      Beta      Std. Error   t-value   p-value      Signif 
#> -------------------  --------  -----------  --------  -----------  -------
#> funcY1:time1:p1_ID   -0.709    0.485        -1.462    0.144               
#> funcY2:time1:p1_ID   +2.271    0.485        4.681     3.045e-06    ***    
#> funcY3:time1:p1_ID   +2.440    0.485        5.030     5.343e-07    ***    
#> funcY1:time2:p1_ID   +8.372    0.485        17.260    2.537e-62    ***    
#> funcY2:time2:p1_ID   +3.795    0.485        7.825     8.197e-15    ***    
#> funcY3:time2:p1_ID   +4.023    0.485        8.294     1.992e-16    ***    
#> funcY1:time1:p2_ID   +5.375    0.464        11.577    4.797e-30    ***    
#> funcY2:time1:p2_ID   +5.934    0.464        12.781    5.209e-36    ***    
#> funcY3:time1:p2_ID   +7.998    0.464        17.226    4.229e-62    ***    
#> funcY1:time2:p2_ID   +12.106   0.464        26.075    3.365e-129   ***    
#> funcY2:time2:p2_ID   +3.717    0.464        8.007     1.981e-15    ***    
#> funcY3:time2:p2_ID   +10.769   0.464        23.196    1.459e-105   ***    
#> funcY1:time1:p3_ID   +3.383    0.482        7.025     2.935e-12    ***    
#> funcY2:time1:p3_ID   +1.205    0.482        2.503     0.0124       *      
#> funcY3:time1:p3_ID   +4.856    0.482        10.083    2.367e-23    ***    
#> funcY1:time2:p3_ID   +12.855   0.482        26.691    1.959e-134   ***    
#> funcY2:time2:p3_ID   -2.152    0.482        -4.468    8.356e-06    ***    
#> funcY3:time2:p3_ID   +7.712    0.482        16.012    2.241e-54    ***    
#> funcY1:time1:p4_ID   -0.104    0.545        -0.191    0.8488              
#> funcY2:time1:p4_ID   +2.510    0.545        4.604     4.399e-06    ***    
#> funcY3:time1:p4_ID   +6.626    0.545        12.156    7.556e-33    ***    
#> funcY1:time2:p4_ID   +6.875    0.545        12.612    3.845e-35    ***    
#> funcY2:time2:p4_ID   +3.348    0.545        6.141     9.874e-10    ***    
#> funcY3:time2:p4_ID   +8.758    0.545        16.067    1.031e-54    ***    
#> 
#> Signif codes: 0-0.001 '***', 0.001-0.01 '**', 0.01-0.05 '*', 0.05-0.1 '+', 0.1-1.0 ' '
#> 
#> Degrees of freedom: 2016 total; 1992 residual
#> Residual standard error: 2.906918 
#> 
#> $Multivariate
#> Marginal variance covariance matrix
#>         [,1]     [,2]     [,3]
#> [1,]  4.9364  2.60580 -1.14680
#> [2,]  2.6058  3.75180 -0.68183
#> [3,] -1.1468 -0.68183  4.39700
#>   Standard Deviations: 2.2218 1.937 2.0969 
#> 
#> $`Repeated Measure`
#> Marginal variance covariance matrix
#>         [,1]    [,2]
#> [1,] 11.3980  2.5933
#> [2,]  2.5933 11.3980
#>   Standard Deviations: 3.3761 3.3761 
#> 
#> $Combined
#> Marginal variance covariance matrix
#>          Y1:1     Y1:2     Y2:1     Y2:2     Y3:1     Y3:2
#> Y1:1  8.45020  1.92260  5.11670  1.16420 -2.08000 -0.47325
#> Y1:2  1.92260  8.45020  1.16420  5.11670 -0.47325 -2.08000
#> Y2:1  5.11670  1.16420  8.45020  1.92260 -1.41850 -0.32275
#> Y2:2  1.16420  5.11670  1.92260  8.45020 -0.32275 -1.41850
#> Y3:1 -2.08000 -0.47325 -1.41850 -0.32275  8.45020  1.92260
#> Y3:2 -0.47325 -2.08000 -0.32275 -1.41850  1.92260  8.45020
#>   Standard Deviations: 2.9069 2.9069 2.9069 2.9069 2.9069 2.9069 
#> 

# Next, we include the simplest interaction structure available in this package, "AV", which adds
# a single extra term per ecosystem function and time point

MVRMmodel_AV <- DImulti(y = 6:8, eco_func = c("Na", "un"), time = c("time", "CS"), unit_IDs = 1,
                   prop = 2:5, data = simMVRM, DImodel = "AV",
                   method = "ML")

anova(MVRMmodel, MVRMmodel_AV)
#>              Model df      AIC      BIC    logLik   Test  L.Ratio p-value
#> MVRMmodel        1 25 9670.780 9811.002 -4810.390                        
#> MVRMmodel_AV     2 31 7921.064 8094.939 -3929.532 1 vs 2 1761.716  <.0001

# We select the more model with the lower AIC/BIC value or we use the p-value of the likelihood
# ratio test to determine if we reject the null hypothesis that the extra terms in the model are
# equal to zero, which in this case is lower than our alpha value of 0.05, so we do reject this
# hypothesis and continue with our more complex model.
#
# We can continue increasing the complexity of the interaction structure in the same fashion, this
# time we elect to use the additive interaction structure

MVRMmodel_ADD <- DImulti(y = 6:8, eco_func = c("Na", "un"), time = c("time", "CS"), unit_IDs = 1,
                   prop = 2:5, data = simMVRM, DImodel = "ADD",
                   method = "ML")

anova(MVRMmodel_AV, MVRMmodel_ADD)
#>               Model df      AIC      BIC    logLik   Test  L.Ratio p-value
#> MVRMmodel_AV      1 31 7921.064 8094.939 -3929.532                        
#> MVRMmodel_ADD     2 49 7948.032 8222.867 -3925.016 1 vs 2 9.031852   0.959

# We fail to reject the null hypothesis and so we select the average interaction structure.
#
# Finally, we can also increase the model complexity via the inclusion of the non-linear parameter
# theta, which we can estimate, or select a value for. We also choose to estimate using the "REML"
# method as we will do no further fixed effect model comparisons

# \donttest{
MVRMmodel_theta <- DImulti(y = 6:8, eco_func = c("Na", "un"), time = c("time", "CS"), unit_IDs = 1,
                   prop = 2:5, data = simMVRM, DImodel = "AV",
                   estimate_theta = TRUE, method = "REML")

print(MVRMmodel_theta)
#> Note: 
#> Method Used = REML 
#> Correlation Structure Used = un@CS
#>  Average Term Model
#> Theta estimate(s) = Y1:0.9704, Y2:0.7538, Y3:1.0089
#> 
#> Generalized least squares fit by REML
#>   Model: value ~ 0 + func:time:((p1_ID + p2_ID + p3_ID + p4_ID + AV)) 
#>       AIC       BIC    logLik 
#>  7933.636  8107.046 -3935.818 
#> 
#>  Multivariate Correlation Structure: General
#>  Formula: ~0 | plot 
#>  Parameter estimate(s):
#>  Correlation: 
#>   1      2     
#> 2  0.609       
#> 3 -0.310 -0.363
#> 
#>  Repeated Measure Correlation Structure: Compound symmetry
#>  Formula: ~0 | plot 
#>  Parameter estimate(s):
#>       Rho 
#> 0.3126024 
#> 
#> 
#> Table: Fixed Effect Coefficients
#> 
#>                      Beta      Std. Error   t-value   p-value      Signif 
#> -------------------  --------  -----------  --------  -----------  -------
#> funcY1:time1:p1_ID   -1.364    0.397        -3.431    0.0006143    ***    
#> funcY2:time1:p1_ID   +0.594    0.384        1.549     0.1216              
#> funcY3:time1:p1_ID   +0.915    0.401        2.283     0.02253      *      
#> funcY1:time2:p1_ID   +0.202    0.397        0.509     0.6111              
#> funcY2:time2:p1_ID   +2.666    0.384        6.947     5.054e-12    ***    
#> funcY3:time2:p1_ID   -0.542    0.401        -1.352    0.1767              
#> funcY1:time1:p2_ID   +4.810    0.368        13.062    1.822e-37    ***    
#> funcY2:time1:p2_ID   +4.523    0.355        12.737    8.871e-36    ***    
#> funcY3:time1:p2_ID   +6.675    0.371        17.977    4.537e-67    ***    
#> funcY1:time2:p2_ID   +5.052    0.368        13.720    5.335e-41    ***    
#> funcY2:time2:p2_ID   +2.767    0.355        7.792     1.056e-14    ***    
#> funcY3:time2:p2_ID   +6.811    0.371        18.343    1.514e-69    ***    
#> funcY1:time1:p3_ID   +2.711    0.399        6.790     1.48e-11     ***    
#> funcY2:time1:p3_ID   -0.498    0.384        -1.298    0.1945              
#> funcY3:time1:p3_ID   +3.288    0.403        8.160     5.882e-16    ***    
#> funcY1:time2:p3_ID   +4.467    0.399        11.187    3.234e-28    ***    
#> funcY2:time2:p3_ID   -3.299    0.384        -8.597    1.633e-17    ***    
#> funcY3:time2:p3_ID   +3.017    0.403        7.489     1.04e-13     ***    
#> funcY1:time1:p4_ID   -0.853    0.449        -1.897    0.05792      +      
#> funcY2:time1:p4_ID   +0.543    0.437        1.242     0.2143              
#> funcY3:time1:p4_ID   +4.890    0.452        10.811    1.649e-26    ***    
#> funcY1:time2:p4_ID   -2.469    0.449        -5.493    4.453e-08    ***    
#> funcY2:time2:p4_ID   +2.023    0.437        4.628     3.926e-06    ***    
#> funcY3:time2:p4_ID   +3.562    0.452        7.875     5.58e-15     ***    
#> funcY1:time1:AV      +2.560    0.905        2.828     0.004729     **     
#> funcY2:time1:AV      +4.283    0.529        8.091     1.021e-15    ***    
#> funcY3:time1:AV      +6.424    0.998        6.436     1.531e-10    ***    
#> funcY1:time2:AV      +31.946   0.905        35.291    3.302e-212   ***    
#> funcY2:time2:AV      +2.885    0.529        5.450     5.669e-08    ***    
#> funcY3:time2:AV      +19.229   0.998        19.264    5.916e-76    ***    
#> 
#> Signif codes: 0-0.001 '***', 0.001-0.01 '**', 0.01-0.05 '*', 0.05-0.1 '+', 0.1-1.0 ' '
#> 
#> Degrees of freedom: 2016 total; 1986 residual
#> Residual standard error: 1.948135 
#> 
#> $Multivariate
#> Marginal variance covariance matrix
#>         [,1]    [,2]    [,3]
#> [1,]  4.9095  2.3475 -1.3752
#> [2,]  2.3475  3.0305 -1.2650
#> [3,] -1.3752 -1.2650  4.0087
#>   Standard Deviations: 2.2157 1.7408 2.0022 
#> 
#> $`Repeated Measure`
#> Marginal variance covariance matrix
#>        [,1]   [,2]
#> [1,] 4.6330 1.4483
#> [2,] 1.4483 4.6330
#>   Standard Deviations: 2.1524 2.1524 
#> 
#> $Combined
#> Marginal variance covariance matrix
#>          Y1:1     Y1:2     Y2:1     Y2:2     Y3:1     Y3:2
#> Y1:1  3.79520  1.18640  2.30980  0.72204 -1.17640 -0.36776
#> Y1:2  1.18640  3.79520  0.72204  2.30980 -0.36776 -1.17640
#> Y2:1  2.30980  0.72204  3.79520  1.18640 -1.37740 -0.43059
#> Y2:2  0.72204  2.30980  1.18640  3.79520 -0.43059 -1.37740
#> Y3:1 -1.17640 -0.36776 -1.37740 -0.43059  3.79520  1.18640
#> Y3:2 -0.36776 -1.17640 -0.43059 -1.37740  1.18640  3.79520
#>   Standard Deviations: 1.9481 1.9481 1.9481 1.9481 1.9481 1.9481 
#> 


#Finally, we can utilise this model for our interpretation and predictions

head(predict(MVRMmodel_theta))
#>   plot     Yvalue Ytype
#> 1    1 -1.3637130  Y1:1
#> 2    1  0.2021854  Y1:2
#> 3    1  0.5944749  Y2:1
#> 4    1  2.6663312  Y2:2
#> 5    1  0.9148420  Y3:1
#> 6    1 -0.5415428  Y3:2
# }

##################################################################################################
#
##################################################################################################

## Code to simulate data
# \donttest{
set.seed(746)

props <- data.frame(plot = integer(),
                    p1 = integer(),
                    p2 = integer(),
                    p3 = integer(),
                    p4 = integer())

index <- 1 #row number

#Monocultures
for(i in 1:4) #6 species
{
  for(j in 1:3) #2 technical reps
  {
    props[index, i+1] <- 1
    index <- index + 1
  }
}


#Equal Mixtures
for(rich in sort(rep(2:4, 4))) #3 reps at each richness level
{
  sp <- sample(1:4, rich) #randomly pick species from pool

  for(j in 1:2) #2 technical reps
  {
    for(i in sp)
    {
      props[index, i+1] <- 1/rich #equal proportions
    }
    index <- index + 1
  }
}


#Unequal Mixtures
for(rich in sort(rep(c(2, 3, 4), 50))) #15 reps at each richness level
{
  sp <- sample(1:4, rich, replace = TRUE) #randomly pick species from pool

  for(j in 1:2) #2 technical reps
  {
    for(i in 1:4)
    {
      props[index, i+1] <- sum(sp==i)/rich #equal proportions
    }
    index <- index + 1
  }
}


props[is.na(props)] <- 0

mySimData <- props

ADDs <- DImodels::DI_data(prop=2:5, what=c("ADD"), data=mySimData)
mySimData <- cbind(mySimData, ADDs)

E_AV <- DImodels::DI_data(prop=2:5, what=c("E", "AV"), data=mySimData)
mySimData <- cbind(mySimData, E_AV)

mySimData$plot <- 1:nrow(mySimData)

mySimData$Y1 <- NA
mySimData$Y2 <- NA
mySimData$Y3 <- NA

mySimData$time <- 1
mySimDataT1 <- mySimData
mySimDataT2 <- mySimData
mySimDataT2$time <- 2


nT <- 2 #Number of s
#Principal Components (make sure it's positive definite)
pT <- qr.Q(qr(matrix(stats::rnorm(nT^2), nT)))
ST <- crossprod(pT, pT*(nT:1)) #Sigma
mT <- stats::runif(nT, -0.25, 1.5)

nY <- 3 #Number of Ys
#Principal Components (make sure it's positive definite)
pY <- qr.Q(qr(matrix(stats::rnorm(nY^2), nY)))
SY <- crossprod(pY, pY*(nY:1)) #Sigma
mY <- stats::runif(nY, -0.25, 1.5)


#runif(7, -1, 7) #decide on betas randomly
for(i in 1:nrow(mySimData))
{
  #Within subject error
  errorT <- MASS::mvrnorm(n=1, mu=mT, Sigma=ST)
  errorY <- MASS::mvrnorm(n=1, mu=mY, Sigma=SY)
  mySimDataT1$Y1[i] <- -1.0*mySimDataT1$p1[i] + 5.0*mySimDataT1$p2[i] + 2.8*mySimDataT1$p3[i] +
  -0.9*mySimDataT1$p4[i] + -0.1*mySimDataT1$E[i] + errorT[1]*errorY[1]
  mySimDataT2$Y1[i] <- 0.5*mySimDataT2$p1[i] + 5.4*mySimDataT2$p2[i] + 4.9*mySimDataT2$p3[i] +
  -2.1*mySimDataT2$p4[i] + 12.0*mySimDataT1$E[i] + errorT[2]*errorY[1]

  mySimDataT1$Y2[i] <- 0.1*mySimDataT1$p1[i] + 4.1*mySimDataT1$p2[i] + -0.5*mySimDataT1$p3[i] +
  0.3*mySimDataT1$p4[i] + 2.3*mySimDataT1$E[i] + errorT[1]*errorY[2]
  mySimDataT2$Y2[i] <- 2.3*mySimDataT2$p1[i] + 3.2*mySimDataT2$p2[i] + -3.1*mySimDataT2$p3[i] +
  2.1*mySimDataT2$p4[i] + 1.6*mySimDataT2$E[i] + errorT[2]*errorY[2]

  mySimDataT1$Y3[i] <- 0.9*mySimDataT1$p1[i] + 6.6*mySimDataT1$p2[i] + 3.5*mySimDataT1$p3[i] +
  6.1*mySimDataT1$p4[i] + 2.1*mySimDataT1$E[i] + errorT[1]*errorY[3]
  mySimDataT2$Y3[i] <- -0.1*mySimDataT2$p1[i] + 7.0*mySimDataT2$p2[i] + 2.8*mySimDataT2$p3[i] +
  4.0*mySimDataT2$p4[i] + 6.8*mySimDataT2$E[i] + errorT[2]*errorY[3]
}

mySimData <- rbind(mySimDataT1, mySimDataT2)

mySimData$time <- as.factor(mySimData$time)
mySimData$plot <- as.factor(mySimData$plot)
# }
```
