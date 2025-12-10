# The simulated repeated measures "simRM" dataset

The `simRM` dataset was simulated from a repeated measures DI model. It
contains 116 plots comprising of four species that vary in proportions
(`p1` - `p4`). There is one simulated response (`Y`), taken at three
differing time points, recorded in a stacked data format (one row per
response value). The data was simulated assuming that there were
existing covariances between the responses and both species identity and
species interaction effects were present.

## Usage

``` r
data("simRM")
```

## Format

A data frame with 384 observations on the following seven variables.

- `plot`:

  A numeric vector identifying each unique experimental unit

- `p1`:

  A numeric vector indicating the initial proportion of species 1

- `p2`:

  A numeric vector indicating the initial proportion of species 2

- `p3`:

  A numeric vector indicating the initial proportion of species 3

- `p4`:

  A numeric vector indicating the initial proportion of species 4

- `Y`:

  A numeric vector giving the simulated response for an ecosystem
  function

- `time`:

  A three-level factor indicating the time point at which the response
  `Y` was recorded

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

Repeated measures DI models take the general form of:

\$\${y}\_{mt} = {Identities}\_{mt} + {Interactions}\_{mt} +
{Structures}\_{t} + {\epsilon}\_{mt}\$\$

where \\y\\ are the community-level responses, the \\Identities\\ are
the effects of species identities for each response and enter the model
as individual species proportions measured at the beginning of the time
period, the \\Interactions\\ are the interactions among the species
proportions, while \\Structures\\ include other experimental structures
such as blocks, treatments, or density.

The dataset `simRM` was simulated with:

- identity effects for the four species for each time:

  - time1 = 4.1, 2.1, 3.6, 4.8

  - time2 = 2.3, 2.4, 5.1, 5.0

  - time3 = 0.7, 2.3, 6.5, 5.9

- additive interaction effects for each time:

  - time1 = 3.3, 4.0, 1.3, 5.2

  - time2 = 3.6, 4.5, 0.5, 6.5

  - time3 = 4.5, 5.2, 0.6, 7.8

- \\\epsilon\\ assumed to have a multivaraite normal distribution with
  mean 0 and Sigma:

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


head(simRM)
#>   plot p1 p2 p3 p4        Y time
#> 1    1  1  0  0  0 4.763873    1
#> 2    2  1  0  0  0 4.762302    1
#> 3    3  0  1  0  0 2.413846    1
#> 4    4  0  1  0  0 1.929837    1
#> 5    5  0  0  1  0 2.750093    1
#> 6    6  0  0  1  0 5.071534    1

# We call DImulti() to fit a series of models, with increasing complexity, and test whether the
# additional terms are worth keeping.

# We begin with an ID DI model, ensuring to use method = "ML" as we will be comparing fixed effects

RMmodel <- DImulti(y = "Y", time = c("time", "AR1"), unit_IDs = "plot",
                   prop = paste0("p", 1:4), data = simRM, DImodel = "ID",
                   method = "ML")
print(RMmodel)
#> Note: 
#> Method Used = ML 
#> Correlation Structure Used = AR1
#>  Identity Model
#> Theta value(s) = 1
#> 
#> Generalized least squares fit by maximum likelihood
#>   Model: Y ~ 0 + time:((p1_ID + p2_ID + p3_ID + p4_ID)) 
#>       AIC       BIC    logLik 
#> 1316.8028 1370.7336 -644.4014 
#> 
#>  Repeated Measure Correlation Structure: AR(1)
#>  Formula: ~0 + as.numeric(time) | plot 
#>  Parameter estimate(s):
#>       Phi 
#> 0.2206503 
#> 
#> 
#> Table: Fixed Effect Coefficients
#> 
#>               Beta      Std. Error   t-value   p-value     Signif 
#> ------------  --------  -----------  --------  ----------  -------
#> time1:p1_ID   +6.151    0.482        12.765    1.076e-30   ***    
#> time2:p1_ID   +5.320    0.482        11.042    2.154e-24   ***    
#> time3:p1_ID   +3.443    0.482        7.145     5.624e-12   ***    
#> time1:p2_ID   +4.794    0.504        9.513     3.724e-19   ***    
#> time2:p2_ID   +6.381    0.504        12.662    2.614e-30   ***    
#> time3:p2_ID   +5.137    0.504        10.192    1.957e-21   ***    
#> time1:p3_ID   +4.791    0.431        11.124    1.101e-24   ***    
#> time2:p3_ID   +7.442    0.431        17.277    2.612e-48   ***    
#> time3:p3_ID   +7.227    0.431        16.779    2.512e-46   ***    
#> time1:p4_ID   +7.099    0.459        15.457    4.348e-41   ***    
#> time2:p4_ID   +10.485   0.459        22.830    2.578e-70   ***    
#> time3:p4_ID   +9.100    0.459        19.814    1.988e-58   ***    
#> 
#> Signif codes: 0-0.001 '***', 0.001-0.01 '**', 0.01-0.05 '*', 0.05-0.1 '+', 0.1-1.0 ' '
#> 
#> Degrees of freedom: 348 total; 336 residual
#> Residual standard error: 1.567414 
#> 
#> Marginal variance covariance matrix
#>         1       2       3
#> 1 2.45680 0.54209 0.11961
#> 2 0.54209 2.45680 0.54209
#> 3 0.11961 0.54209 2.45680
#>   Standard Deviations: 1.5674 1.5674 1.5674 

# We can simplify the above model by grouping the ID effect terms into two categories, G1 and G2

RMmodel_ID <- DImulti(y = "Y", time = c("time", "AR1"), unit_IDs = "plot",
                   prop = paste0("p", 1:4), data = simRM, DImodel = "ID",
                   ID = c("G1", "G1", "G2", "G2"),
                   method = "ML")

# We can compare the two models by calling the anova function to perform a likelihood ratio test

anova(RMmodel, RMmodel_ID)
#>            Model df      AIC      BIC    logLik   Test  L.Ratio p-value
#> RMmodel        1 14 1316.803 1370.734 -644.4014                        
#> RMmodel_ID     2  8 1344.644 1375.462 -664.3221 1 vs 2 39.84144  <.0001

# As the p-value < an alpha value of 0.05, we reject the null hypthesis that the extra terms are
# equal to zero, therefore we continue with the larger model.
# We can confirm this result by selecting the model with the lower AIC value.

AIC(RMmodel); AIC(RMmodel_ID)
#> [1] 1316.803
#> [1] 1344.644

# Next, we include the simplest interaction structure available in this package, "AV", which adds
# a single extra term per ecosystem function

RMmodel_AV <- DImulti(y = "Y", time = c("time", "AR1"), unit_IDs = "plot",
                   prop = paste0("p", 1:4), data = simRM, DImodel = "AV",
                   method = "ML")

anova(RMmodel, RMmodel_AV)
#>            Model df      AIC      BIC    logLik   Test  L.Ratio p-value
#> RMmodel        1 14 1316.803 1370.734 -644.4014                        
#> RMmodel_AV     2 17 1255.744 1321.232 -610.8722 1 vs 2 67.05833  <.0001

# Once again, we select the more complex model.
#
# We can continue increasing the complexity of the interaction structure in the same fashion, this
# time we elect to use the additive interaction structure

RMmodel_ADD <- DImulti(y = "Y", time = c("time", "AR1"), unit_IDs = "plot",
                   prop = paste0("p", 1:4), data = simRM, DImodel = "ADD",
                   method = "ML")

anova(RMmodel_AV, RMmodel_ADD)
#>             Model df      AIC      BIC    logLik   Test  L.Ratio p-value
#> RMmodel_AV      1 17 1255.744 1321.232 -610.8722                        
#> RMmodel_ADD     2 26 1236.971 1337.128 -592.4856 1 vs 2 36.77332  <.0001

# We continue with the additive interactions structure, the next interaction structure to test
# functional group interactions, is not nested with our additive model, so we compare th two using
# information criterion. In this case we choose to use AICc, to better penalise extra terms, as AIC
# becomes biased towards the more complex model as parameters numbers increase.
# The functional group strcuture requires an additional parameter, FG, to specify groups.

RMmodel_FG <- DImulti(y = "Y", time = c("time", "AR1"), unit_IDs = "plot",
                   prop = paste0("p", 1:4), data = simRM, DImodel = "FG",
                   FG = c("G1", "G1", "G2", "G2"),
                   method = "ML")

AICc(RMmodel_ADD); AICc(RMmodel_FG)
#> [1] 1243.351
#> [1] 1263.574

# In this case, we choose the lower valued model, which is the additive structure.
#
# The last interaction structure to test is the full pairwise model. Which we can see is not worth
# the extra terms. So our final interaction structure chosen is additive.

RMmodel_FULL <- DImulti(y = "Y", time = c("time", "AR1"), unit_IDs = "plot",
                   prop = paste0("p", 1:4), data = simRM, DImodel = "FULL",
                   method = "ML")

anova(RMmodel_ADD, RMmodel_FULL)
#>              Model df      AIC      BIC    logLik   Test  L.Ratio p-value
#> RMmodel_ADD      1 26 1236.971 1337.128 -592.4856                        
#> RMmodel_FULL     2 32 1237.600 1360.870 -586.7999 1 vs 2 11.37142  0.0776

# Finally, we can also increase the model complexity via the inclusion of the non-linear parameter
# theta, which we can estimate, or select a value for. We also choose to estimate using the "REML"
# method as we will do no further fixed effect model comparisons

RMmodel_theta <- DImulti(y = "Y", time = c("time", "AR1"), unit_IDs = "plot",
                      prop = paste0("p", 1:4), data = simRM, DImodel = "ADD",
                      estimate_theta = TRUE, method = "REML")

print(RMmodel_theta)
#> Note: 
#> Method Used = REML 
#> Correlation Structure Used = AR1
#>  Additive Interactions Model
#> Theta estimate(s) = 0.9991
#> 
#> Generalized least squares fit by REML
#>   Model: Y ~ 0 + time:((p1_ID + p2_ID + p3_ID + p4_ID + p1_add + p2_add +      p3_add + p4_add)) 
#>       AIC       BIC    logLik 
#> 1203.6852 1301.9845 -575.8426 
#> 
#>  Repeated Measure Correlation Structure: AR(1)
#>  Formula: ~0 + as.numeric(time) | plot 
#>  Parameter estimate(s):
#>        Phi 
#> 0.01150876 
#> 
#> 
#> Table: Fixed Effect Coefficients
#> 
#>                Beta      Std. Error   t-value   p-value     Signif 
#> -------------  --------  -----------  --------  ----------  -------
#> time1:p1_ID    +4.882    0.817        5.975     6.07e-09    ***    
#> time2:p1_ID    +4.292    0.817        5.252     2.727e-07   ***    
#> time3:p1_ID    +1.231    0.817        1.507     0.1328             
#> time1:p2_ID    +2.119    0.815        2.600     0.009763    **     
#> time2:p2_ID    +4.398    0.815        5.395     1.326e-07   ***    
#> time3:p2_ID    +2.290    0.815        2.808     0.00528     **     
#> time1:p3_ID    +3.657    0.531        6.882     3.068e-11   ***    
#> time2:p3_ID    +7.043    0.531        13.252    2.505e-32   ***    
#> time3:p3_ID    +6.442    0.531        12.121    3.868e-28   ***    
#> time1:p4_ID    +4.988    0.819        6.094     3.128e-09   ***    
#> time2:p4_ID    +5.933    0.819        7.248     3.125e-12   ***    
#> time3:p4_ID    +4.975    0.819        6.078     3.423e-09   ***    
#> time1:p1_add   +2.245    1.835        1.224     0.2219             
#> time2:p1_add   +2.006    1.835        1.093     0.2751             
#> time3:p1_add   +4.825    1.835        2.630     0.008949    **     
#> time1:p2_add   +5.517    1.866        2.956     0.00334     **     
#> time2:p2_add   +3.227    1.866        1.729     0.08469     +      
#> time3:p2_add   +5.291    1.866        2.835     0.004869    **     
#> time1:p3_add   +2.354    1.444        1.630     0.1041             
#> time2:p3_add   -0.857    1.444        -0.593    0.5534             
#> time3:p3_add   +0.238    1.444        0.165     0.869              
#> time1:p4_add   +4.256    1.892        2.250     0.02515     *      
#> time2:p4_add   +11.096   1.892        5.865     1.111e-08   ***    
#> time3:p4_add   +9.209    1.892        4.867     1.769e-06   ***    
#> 
#> Signif codes: 0-0.001 '***', 0.001-0.01 '**', 0.01-0.05 '*', 0.05-0.1 '+', 0.1-1.0 ' '
#> 
#> Degrees of freedom: 348 total; 324 residual
#> Residual standard error: 1.376275 
#> 
#> Marginal variance covariance matrix
#>            1        2          3
#> 1 1.89410000 0.021799 0.00025088
#> 2 0.02179900 1.894100 0.02179900
#> 3 0.00025088 0.021799 1.89410000
#>   Standard Deviations: 1.3763 1.3763 1.3763 

# We can however test changes to the correlation structure, testing the AR(1) structure we have been
# using against the simpler CS strcuture.

RMmodel_CS <- DImulti(y = "Y", time = c("time", "CS"), unit_IDs = "plot",
                      prop = paste0("p", 1:4), data = simRM, DImodel = "ADD",
                      theta = 0.9991, method = "REML")

AICc(RMmodel_theta); AICc(RMmodel_CS)
#> [1] 1210.065
#> [1] 1210.1

# We see that they are practically identical, but the AR(1) strcuture is preferred.

##################################################################################################
#
##################################################################################################

## Code to simulate data
# \donttest{
set.seed(523)

props <- data.frame(plot = integer(),
                    p1 = integer(),
                    p2 = integer(),
                    p3 = integer(),
                    p4 = integer())

index <- 1 #row number

#Monocultures
for(i in 1:4) #4 species
{
  for(j in 1:2) #2 technical reps
  {
    props[index, i+1] <- 1
    index <- index + 1
  }
}


#Equal Mixtures
for(rich in sort(rep(2:4, 3))) #3 reps at each richness level
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
for(rich in sort(rep(c(2, 3, 4), 15))) #15 reps at each richness level
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
mySimData$Y <- NA

ADDs <- DImodels::DI_data(prop=2:5, what=c("ADD"), data=mySimData)
mySimData <- cbind(mySimData, ADDs)

E_AV <- DImodels::DI_data(prop=2:5, what=c("E", "AV"), data=mySimData)
mySimData <- cbind(mySimData, E_AV)

mySimData$plot <- 1:nrow(mySimData)

mySimData$time <- 1
mySimDataT1 <- mySimData
mySimDataT2 <- mySimData
mySimDataT3 <- mySimData
mySimDataT2$time <- 2
mySimDataT3$time <- 3


n <- 3 #Number of Ys
p <- qr.Q(qr(matrix(stats::rnorm(n^2), n))) #Principal Components (make sure it's positive definite)
S <- crossprod(p, p*(n:1)) #Sigma
m <- stats::runif(n, -0.25, 1.5)

#runif(11, -1, 7) #decide on betas randomly

for(i in 1:nrow(mySimData))
{
  #Within subject error
  error <- MASS::mvrnorm(n=1, mu=m, Sigma=S)
  mySimDataT1$Y[i] <- 4.1*mySimDataT1$p1[i] + 2.1*mySimDataT1$p2[i] + 3.6*mySimDataT1$p3[i] +
  4.8*mySimDataT1$p4[i] + 3.3*mySimDataT1$p1_add[i] + 4.0*mySimDataT1$p2_add[i] +
  1.3*mySimDataT1$p3_add[i] + 5.2*mySimDataT1$p4_add[i] + error[1]
  mySimDataT2$Y[i] <- 2.3*mySimDataT2$p1[i] + 2.4*mySimDataT2$p2[i] + 5.1*mySimDataT2$p3[i] +
  5.0*mySimDataT2$p4[i] + 3.6*mySimDataT2$p1_add[i] + 4.5*mySimDataT2$p2_add[i] +
  0.5*mySimDataT2$p3_add[i] + 6.5*mySimDataT2$p4_add[i] + error[2]
  mySimDataT3$Y[i] <- 0.7*mySimDataT3$p1[i] + 2.3*mySimDataT3$p2[i] + 6.5*mySimDataT3$p3[i] +
  5.9*mySimDataT3$p4[i] + 4.5*mySimDataT3$p1_add[i] + 5.2*mySimDataT3$p2_add[i] +
  0.6*mySimDataT3$p3_add[i] + 7.8*mySimDataT3$p4_add[i] + error[3]
}

mySimData <- rbind(mySimDataT1, mySimDataT2)
mySimData <- rbind(mySimData, mySimDataT3)

mySimData$time <- as.factor(mySimData$time)
mySimData$plot <- as.factor(mySimData$plot)
# }
```
