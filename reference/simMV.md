# The simulated multivariate "simMV" dataset

The `simMV` dataset was simulated from a multivariate DI model. It
contains 192 plots comprising of six species that vary in proportions
(`p1` - `p6`). Each plot was replicated once for testing a two-level
factor `treat`, included at levels 0 and 1, resulting in a total of 384
plots. There are four simulated responses (`Y1` - `Y4`) recorded in a
wide data format (one column per response). The data was simulated
assuming that there were existing covariances between the responses, an
additive treatment effect, and both species identity and species
interaction effects were present.

## Usage

``` r
data("simMV")
```

## Format

A data frame with 384 observations on the following twelve variables.

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

- `p5`:

  A numeric vector indicating the initial proportion of species 5

- `p6`:

  A numeric vector indicating the initial proportion of species 6

- `treat`:

  A two-level factor indicating whether a treatment was applied (1) or
  not (0)

- `Y1`:

  A numeric vector giving the simulated response for ecosystem function
  1

- `Y2`:

  A numeric vector giving the simulated response for ecosystem function
  2

- `Y3`:

  A numeric vector giving the simulated response for ecosystem function
  3

- `Y4`:

  A numeric vector giving the simulated response for ecosystem function
  4

## Details

**What are Diversity-Interactions (DI) models?**

Diversity-Interactions (DI) models (Kirwan *et al.*, 2009) are a set of
tools for analysing and interpreting data from experiments that explore
the effects of species diversity on community-level responses. We
strongly recommend that users read the short introduction to
Diversity-Interactions models (available at:
[`DImodels`](https://rdrr.io/pkg/DImodels/man/DImodels-package.html)).
Further information on Diversity-Interactions models is also available
in Kirwan et al 2009 and Connolly et al 2013. The multivariate DI model
was developed by Dooley *et al.*, 2015.

**Parameter values for the simulation**

Multivariate DI models take the general form of:

\$\${y}\_{km} = {Identities}\_{km} + {Interactions}\_{km} +
{Structures}\_{k} + {\epsilon}\_{km}\$\$

where \\y\\ are the community-level responses, the \\Identities\\ are
the effects of species identities for each response and enter the model
as individual species proportions at the beginning of the time period,
the \\Interactions\\ are the interactions among the species proportions,
while \\Structures\\ include other experimental structures such as
blocks, treatments or density.

The dataset `simMV` was simulated with:

- identity effects for the six species for response:

  - Y1 = 6.9, -0.3, 6.6, 1.7, -0.8, 4.3

  - Y2 = 4.9, 3.6, 4.4, 2.3, 4.3, 6.6

  - Y3 = -0.3, 4.6, 1.2, 6.8, 1.4, 6.9

  - Y4 = 4.1, 4.2, -0.5, 4.9, 6.7, -0.9, -1.0

- an average pairwise interaction effect for response:

  - Y1 = 1.8

  - Y2 = 6.8

  - Y3 = 1.4

  - Y4 = 0.3

- a teatment effect for response:

  - Y1 = 3.5

  - Y2 = -0.3

  - Y3 = 5.5

  - Y4 = -1.0

- \\\epsilon\\ assumed to have a multivaraite normal distribution with
  mean 0 and Sigma:

  |                              |                              |                               |                             |     |
  |------------------------------|------------------------------|-------------------------------|-----------------------------|-----|
  | \[1,\] 3.87 -0.17 -0.23 0.31 | \[2,\] -0.17 1.34 -0.11 0.49 | \[3,\] -0.23 -0.11 2.95 -0.36 | \[4,\] 0.31 0.49 -0.36 1.83 |     |

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

# We use head() to view the dataset
head(simMV)
#>   plot p1 p2 p3 p4 p5 p6 treat        Y1       Y2         Y3         Y4
#> 1    1  1  0  0  0  0  0     0  1.880817 5.108158 -1.9712356  4.8247704
#> 2    2  1  0  0  0  0  0     0  7.103477 5.183822 -4.0598298  3.1094539
#> 3    3  0  1  0  0  0  0     0 -1.444736 6.900983  6.3342200  4.9055054
#> 4    4  0  1  0  0  0  0     0 -1.756776 4.784160  5.2155726  5.3583856
#> 5    5  0  0  1  0  0  0     0  5.311257 4.258924 -0.4694982 -2.3078377
#> 6    6  0  0  1  0  0  0     0  5.975319 3.148215  1.9509040 -0.6064387


# We can use the function DImulti() to fit a multivariate DI model, with an intercept for "treat"
# for each ecosystem function. The dataset is wide, so the Y columns are all entered through 'y'
# and the first index of eco_func is "NA". We fit the average interaction structure and use "ML"
# so that we can perform model comparisons with varying fixed effects
MVmodel <- DImulti(y = paste0("Y", 1:4), eco_func = c("NA", "UN"), unit_IDs = 1,
                   prop = paste0("p", 1:6), data = simMV, DImodel = "AV", extra_fixed = ~ treat,
                   method = "ML")
print(MVmodel)
#> Note: 
#> Method Used = ML 
#> Correlation Structure Used = UN
#>  Average Term Model
#> Theta value(s) = 1
#> 
#> Generalized least squares fit by maximum likelihood
#>   Model: value ~ 0 + func:((p1_ID + p2_ID + p3_ID + p4_ID + p5_ID + p6_ID +      AV) + treat) 
#>       AIC       BIC    logLik 
#>  5602.953  5827.104 -2759.476 
#> 
#>  Multivariate Correlation Structure: General
#>  Formula: ~0 | plot 
#>  Parameter estimate(s):
#>  Correlation: 
#>   1      2      3     
#> 2 -0.108              
#> 3 -0.019 -0.033       
#> 4  0.041  0.241 -0.104
#> 
#> 
#> Table: Fixed Effect Coefficients
#> 
#>                 Beta     Std. Error   t-value   p-value      Signif 
#> --------------  -------  -----------  --------  -----------  -------
#> funcY1:p1_ID    +6.659   0.554        12.025    7.253e-32    ***    
#> funcY2:p1_ID    +5.023   0.299        16.784    4.393e-58    ***    
#> funcY3:p1_ID    -1.110   0.434        -2.557    0.01065      *      
#> funcY4:p1_ID    +4.637   0.331        14.015    4.946e-42    ***    
#> funcY1:p2_ID    -0.007   0.558        -0.013    0.9897              
#> funcY2:p2_ID    +4.288   0.301        14.229    3.382e-43    ***    
#> funcY3:p2_ID    +4.405   0.437        10.082    3.539e-23    ***    
#> funcY4:p2_ID    +5.353   0.333        16.070    9.468e-54    ***    
#> funcY1:p3_ID    +6.948   0.597        11.640    4.808e-30    ***    
#> funcY2:p3_ID    +4.395   0.323        13.624    6.109e-40    ***    
#> funcY3:p3_ID    +1.325   0.468        2.831     0.004695     **     
#> funcY4:p3_ID    -0.614   0.357        -1.722    0.08536      +      
#> funcY1:p4_ID    +2.581   0.545        4.733     2.422e-06    ***    
#> funcY2:p4_ID    +1.993   0.295        6.763     1.93e-11     ***    
#> funcY3:p4_ID    +5.873   0.427        13.745    1.384e-40    ***    
#> funcY4:p4_ID    +5.400   0.326        16.577    8.141e-57    ***    
#> funcY1:p5_ID    -1.034   0.581        -1.779    0.07552      +      
#> funcY2:p5_ID    +4.733   0.314        15.070    6.646e-48    ***    
#> funcY3:p5_ID    +1.448   0.455        3.180     0.001505     **     
#> funcY4:p5_ID    +7.225   0.347        20.810    9.933e-85    ***    
#> funcY1:p6_ID    +4.374   0.533        8.203     4.99e-16     ***    
#> funcY2:p6_ID    +7.332   0.288        25.441    4.79e-119    ***    
#> funcY3:p6_ID    +6.508   0.418        15.571    8.463e-51    ***    
#> funcY4:p6_ID    -0.146   0.319        -0.458    0.6471              
#> funcY1:AV       +2.215   1.085        2.041     0.04144      *      
#> funcY2:AV       +7.502   0.586        12.791    1.228e-35    ***    
#> funcY3:AV       +2.470   0.850        2.905     0.003727     **     
#> funcY4:AV       +0.037   0.648        0.058     0.9541              
#> funcY1:treat1   +3.368   0.214        15.702    1.447e-51    ***    
#> funcY2:treat1   -0.449   0.116        -3.875    0.0001113    ***    
#> funcY3:treat1   +5.602   0.168        33.329    7.422e-183   ***    
#> funcY4:treat1   -1.002   0.128        -7.821    9.78e-15     ***    
#> 
#> Signif codes: 0-0.001 '***', 0.001-0.01 '**', 0.01-0.05 '*', 0.05-0.1 '+', 0.1-1.0 ' '
#> 
#> Degrees of freedom: 1536 total; 1504 residual
#> Residual standard error: 2.079496 
#> 
#> Marginal variance covariance matrix
#>           Y1        Y2        Y3       Y4
#> Y1  4.324300 -0.253190 -0.063976  0.10660
#> Y2 -0.253190  1.263000 -0.059597  0.33650
#> Y3 -0.063976 -0.059597  2.655800 -0.21084
#> Y4  0.106600  0.336500 -0.210840  1.54340
#>   Standard Deviations: 2.0795 1.1238 1.6297 1.2423 

# We can adjust the previous model to now cross "treat" with each other ID effect. We also specify
# different values of theta for each ecosystem function and use the "REML" method to get unbiased
# estimates.
# \donttest{
MVmodel_theta <- DImulti(y = paste0("Y", 1:4), eco_func = c("NA", "UN"), unit_IDs = 1,
                   prop = paste0("p", 1:6), data = simMV, DImodel = "AV", extra_fixed = ~ 1:treat,
                   theta = c(1, 0.5, 0.8, 0.6), method = "REML")

summary(MVmodel_theta)
#> Generalized least squares fit by REML
#>   Model: value ~ 0 + func:((p1_ID + p2_ID + p3_ID + p4_ID + p5_ID + p6_ID +      AV):treat) 
#>   Data: data 
#>        AIC      BIC    logLik
#>   5656.549 6006.336 -2762.275
#> 
#> Correlation Structure: General
#>  Formula: ~0 | plot 
#>  Parameter estimate(s):
#>  Correlation: 
#>   1      2      3     
#> 2 -0.093              
#> 3 -0.015 -0.026       
#> 4  0.043  0.241 -0.109
#> Variance function:
#>  Structure: Different standard deviations per stratum
#>  Formula: ~0 | func 
#>  Parameter estimates:
#>        Y1        Y2        Y3        Y4 
#> 1.0000000 0.5658241 0.7829125 0.5930811 
#> 
#> Coefficients:
#>                         Value Std.Error   t-value p-value
#> funcY1:p1_ID:treat0  6.074314 0.7699716  7.889010  0.0000
#> funcY2:p1_ID:treat0  6.281537 0.3739749 16.796678  0.0000
#> funcY3:p1_ID:treat0 -0.887469 0.5551350 -1.598654  0.1101
#> funcY4:p1_ID:treat0  4.824526 0.3988368 12.096491  0.0000
#> funcY1:p1_ID:treat1 10.435051 0.7699716 13.552514  0.0000
#> funcY2:p1_ID:treat1  5.879588 0.3739749 15.721876  0.0000
#> funcY3:p1_ID:treat1  4.650491 0.5551350  8.377225  0.0000
#> funcY4:p1_ID:treat1  3.602901 0.3988368  9.033523  0.0000
#> funcY1:p2_ID:treat0 -0.546413 0.7755777 -0.704524  0.4812
#> funcY2:p2_ID:treat0  4.871846 0.4089567 11.912865  0.0000
#> funcY3:p2_ID:treat0  4.884123 0.5869862  8.320676  0.0000
#> funcY4:p2_ID:treat0  5.533862 0.4329721 12.781106  0.0000
#> funcY1:p2_ID:treat1  3.753696 0.7755777  4.839872  0.0000
#> funcY2:p2_ID:treat1  4.809390 0.4089567 11.760146  0.0000
#> funcY3:p2_ID:treat1  9.723044 0.5869862 16.564347  0.0000
#> funcY4:p2_ID:treat1  4.332442 0.4329721 10.006285  0.0000
#> funcY1:p3_ID:treat0  6.523914 0.8321763  7.839582  0.0000
#> funcY2:p3_ID:treat0  5.022780 0.4179306 12.018214  0.0000
#> funcY3:p3_ID:treat0  1.035904 0.6149437  1.684551  0.0923
#> funcY4:p3_ID:treat0 -1.169494 0.4454722 -2.625291  0.0087
#> funcY1:p3_ID:treat1 10.544432 0.8321763 12.670911  0.0000
#> funcY2:p3_ID:treat1  5.470532 0.4179306 13.089569  0.0000
#> funcY3:p3_ID:treat1  7.494440 0.6149437 12.187196  0.0000
#> funcY4:p3_ID:treat1 -0.847901 0.4454722 -1.903375  0.0572
#> funcY1:p4_ID:treat0  2.921773 0.7576065  3.856584  0.0001
#> funcY2:p4_ID:treat0  2.954543 0.3715477  7.951988  0.0000
#> funcY3:p4_ID:treat0  5.602123 0.5527220 10.135517  0.0000
#> funcY4:p4_ID:treat0  5.373394 0.3970943 13.531782  0.0000
#> funcY1:p4_ID:treat1  5.423992 0.7576065  7.159379  0.0000
#> funcY2:p4_ID:treat1  2.802422 0.3715477  7.542563  0.0000
#> funcY3:p4_ID:treat1 12.046152 0.5527220 21.794232  0.0000
#> funcY4:p4_ID:treat1  4.612772 0.3970943 11.616312  0.0000
#> funcY1:p5_ID:treat0 -1.577562 0.8094772 -1.948865  0.0515
#> funcY2:p5_ID:treat0  5.984675 0.4092022 14.625227  0.0000
#> funcY3:p5_ID:treat0  1.199457 0.5986821  2.003496  0.0453
#> funcY4:p5_ID:treat0  7.751561 0.4352873 17.807918  0.0000
#> funcY1:p5_ID:treat1  2.695421 0.8094772  3.329829  0.0009
#> funcY2:p5_ID:treat1  5.097724 0.4092022 12.457714  0.0000
#> funcY3:p5_ID:treat1  7.577898 0.5986821 12.657633  0.0000
#> funcY4:p5_ID:treat1  5.891723 0.4352873 13.535251  0.0000
#> funcY1:p6_ID:treat0  3.895051 0.7403994  5.260743  0.0000
#> funcY2:p6_ID:treat0  8.300093 0.3688007 22.505633  0.0000
#> funcY3:p6_ID:treat0  6.201641 0.5409894 11.463517  0.0000
#> funcY4:p6_ID:treat0 -0.335013 0.3921846 -0.854224  0.3931
#> funcY1:p6_ID:treat1  8.061220 0.7403994 10.887664  0.0000
#> funcY2:p6_ID:treat1  8.125028 0.3688007 22.030947  0.0000
#> funcY3:p6_ID:treat1 12.741699 0.5409894 23.552587  0.0000
#> funcY4:p6_ID:treat1 -0.810038 0.3921846 -2.065452  0.0391
#> funcY1:AV:treat0     3.458425 1.5363658  2.251043  0.0245
#> funcY2:AV:treat0     1.228740 0.1473665  8.337984  0.0000
#> funcY3:AV:treat0     1.689570 0.5974726  2.827861  0.0047
#> funcY4:AV:treat0    -0.021516 0.2209063 -0.097399  0.9224
#> funcY1:AV:treat1     1.573802 1.5363658  1.024367  0.3058
#> funcY2:AV:treat1     0.993603 0.1473665  6.742389  0.0000
#> funcY3:AV:treat1     0.741279 0.5974726  1.240691  0.2149
#> funcY4:AV:treat1    -0.181836 0.2209063 -0.823135  0.4106
#> 
#> Theta values: Y1:1, Y2:0.5, Y3:0.8, Y4:0.6
#> 
#> 
#>  Correlation: 
#>                     fY1:1_ID:0 fY2:1_ID:0 fY3:1_ID:0 fY4:1_ID:0 fY1:1_ID:1
#> funcY2:p1_ID:treat0 -0.086                                                
#> funcY3:p1_ID:treat0 -0.015     -0.025                                     
#> funcY4:p1_ID:treat0  0.041      0.241     -0.108                          
#> funcY1:p1_ID:treat1  0.000      0.000      0.000      0.000               
#> funcY2:p1_ID:treat1  0.000      0.000      0.000      0.000     -0.086    
#> funcY3:p1_ID:treat1  0.000      0.000      0.000      0.000     -0.015    
#> funcY4:p1_ID:treat1  0.000      0.000      0.000      0.000      0.041    
#> funcY1:p2_ID:treat0  0.177     -0.001     -0.002      0.002      0.000    
#> funcY2:p2_ID:treat0 -0.005     -0.020     -0.001     -0.001      0.000    
#> funcY3:p2_ID:treat0 -0.002      0.000      0.082     -0.003      0.000    
#> funcY4:p2_ID:treat0  0.004     -0.003     -0.005      0.008      0.000    
#> funcY1:p2_ID:treat1  0.000      0.000      0.000      0.000      0.177    
#> funcY2:p2_ID:treat1  0.000      0.000      0.000      0.000     -0.005    
#> funcY3:p2_ID:treat1  0.000      0.000      0.000      0.000     -0.002    
#> funcY4:p2_ID:treat1  0.000      0.000      0.000      0.000      0.004    
#> funcY1:p3_ID:treat0  0.256     -0.005     -0.003      0.004      0.000    
#> funcY2:p3_ID:treat0 -0.010      0.018     -0.002      0.009      0.000    
#> funcY3:p3_ID:treat0 -0.003     -0.001      0.142     -0.009      0.000    
#> funcY4:p3_ID:treat0  0.006      0.007     -0.011      0.052      0.000    
#> funcY1:p3_ID:treat1  0.000      0.000      0.000      0.000      0.256    
#> funcY2:p3_ID:treat1  0.000      0.000      0.000      0.000     -0.010    
#> funcY3:p3_ID:treat1  0.000      0.000      0.000      0.000     -0.003    
#> funcY4:p3_ID:treat1  0.000      0.000      0.000      0.000      0.006    
#> funcY1:p4_ID:treat0  0.342     -0.014     -0.004      0.008      0.000    
#> funcY2:p4_ID:treat0 -0.018      0.112     -0.004      0.032      0.000    
#> funcY3:p4_ID:treat0 -0.004     -0.004      0.232     -0.019      0.000    
#> funcY4:p4_ID:treat0  0.010      0.030     -0.021      0.145      0.000    
#> funcY1:p4_ID:treat1  0.000      0.000      0.000      0.000      0.342    
#> funcY2:p4_ID:treat1  0.000      0.000      0.000      0.000     -0.018    
#> funcY3:p4_ID:treat1  0.000      0.000      0.000      0.000     -0.004    
#> funcY4:p4_ID:treat1  0.000      0.000      0.000      0.000      0.010    
#> funcY1:p5_ID:treat0  0.159      0.004     -0.001      0.000      0.000    
#> funcY2:p5_ID:treat0  0.000     -0.100      0.001     -0.019      0.000    
#> funcY3:p5_ID:treat0 -0.001      0.001      0.033      0.004      0.000    
#> funcY4:p5_ID:treat0  0.002     -0.021      0.001     -0.064      0.000    
#> funcY1:p5_ID:treat1  0.000      0.000      0.000      0.000      0.159    
#> funcY2:p5_ID:treat1  0.000      0.000      0.000      0.000      0.000    
#> funcY3:p5_ID:treat1  0.000      0.000      0.000      0.000     -0.001    
#> funcY4:p5_ID:treat1  0.000      0.000      0.000      0.000      0.002    
#> funcY1:p6_ID:treat0  0.215     -0.003     -0.002      0.003      0.000    
#> funcY2:p6_ID:treat0 -0.004     -0.038      0.000     -0.005      0.000    
#> funcY3:p6_ID:treat0 -0.002      0.000      0.087     -0.003      0.000    
#> funcY4:p6_ID:treat0  0.003     -0.006     -0.004     -0.006      0.000    
#> funcY1:p6_ID:treat1  0.000      0.000      0.000      0.000      0.215    
#> funcY2:p6_ID:treat1  0.000      0.000      0.000      0.000     -0.004    
#> funcY3:p6_ID:treat1  0.000      0.000      0.000      0.000     -0.002    
#> funcY4:p6_ID:treat1  0.000      0.000      0.000      0.000      0.003    
#> funcY1:AV:treat0    -0.583      0.026      0.007     -0.015      0.000    
#> funcY2:AV:treat0     0.047     -0.323      0.012     -0.089      0.000    
#> funcY3:AV:treat0     0.008      0.008     -0.471      0.039      0.000    
#> funcY4:AV:treat0    -0.023     -0.078      0.051     -0.367      0.000    
#> funcY1:AV:treat1     0.000      0.000      0.000      0.000     -0.583    
#> funcY2:AV:treat1     0.000      0.000      0.000      0.000      0.047    
#> funcY3:AV:treat1     0.000      0.000      0.000      0.000      0.008    
#> funcY4:AV:treat1     0.000      0.000      0.000      0.000     -0.023    
#>                     fY2:1_ID:1 fY3:1_ID:1 fY4:1_ID:1 fY1:2_ID:0 fY2:2_ID:0
#> funcY2:p1_ID:treat0                                                       
#> funcY3:p1_ID:treat0                                                       
#> funcY4:p1_ID:treat0                                                       
#> funcY1:p1_ID:treat1                                                       
#> funcY2:p1_ID:treat1                                                       
#> funcY3:p1_ID:treat1 -0.025                                                
#> funcY4:p1_ID:treat1  0.241     -0.108                                     
#> funcY1:p2_ID:treat0  0.000      0.000      0.000                          
#> funcY2:p2_ID:treat0  0.000      0.000      0.000     -0.089               
#> funcY3:p2_ID:treat0  0.000      0.000      0.000     -0.015     -0.026    
#> funcY4:p2_ID:treat0  0.000      0.000      0.000      0.042      0.241    
#> funcY1:p2_ID:treat1 -0.001     -0.002      0.002      0.000      0.000    
#> funcY2:p2_ID:treat1 -0.020     -0.001     -0.001      0.000      0.000    
#> funcY3:p2_ID:treat1  0.000      0.082     -0.003      0.000      0.000    
#> funcY4:p2_ID:treat1 -0.003     -0.005      0.008      0.000      0.000    
#> funcY1:p3_ID:treat0  0.000      0.000      0.000      0.139     -0.001    
#> funcY2:p3_ID:treat0  0.000      0.000      0.000     -0.001     -0.035    
#> funcY3:p3_ID:treat0  0.000      0.000      0.000     -0.001      0.000    
#> funcY4:p3_ID:treat0  0.000      0.000      0.000      0.002     -0.005    
#> funcY1:p3_ID:treat1 -0.005     -0.003      0.004      0.000      0.000    
#> funcY2:p3_ID:treat1  0.018     -0.002      0.009      0.000      0.000    
#> funcY3:p3_ID:treat1 -0.001      0.142     -0.009      0.000      0.000    
#> funcY4:p3_ID:treat1  0.007     -0.011      0.052      0.000      0.000    
#> funcY1:p4_ID:treat0  0.000      0.000      0.000      0.201     -0.007    
#> funcY2:p4_ID:treat0  0.000      0.000      0.000     -0.006      0.024    
#> funcY3:p4_ID:treat0  0.000      0.000      0.000     -0.002     -0.002    
#> funcY4:p4_ID:treat0  0.000      0.000      0.000      0.004      0.009    
#> funcY1:p4_ID:treat1 -0.014     -0.004      0.008      0.000      0.000    
#> funcY2:p4_ID:treat1  0.112     -0.004      0.032      0.000      0.000    
#> funcY3:p4_ID:treat1 -0.004      0.232     -0.019      0.000      0.000    
#> funcY4:p4_ID:treat1  0.030     -0.021      0.145      0.000      0.000    
#> funcY1:p5_ID:treat0  0.000      0.000      0.000      0.231     -0.011    
#> funcY2:p5_ID:treat0  0.000      0.000      0.000     -0.011      0.081    
#> funcY3:p5_ID:treat0  0.000      0.000      0.000     -0.003     -0.003    
#> funcY4:p5_ID:treat0  0.000      0.000      0.000      0.006      0.022    
#> funcY1:p5_ID:treat1  0.004     -0.001      0.000      0.000      0.000    
#> funcY2:p5_ID:treat1 -0.100      0.001     -0.019      0.000      0.000    
#> funcY3:p5_ID:treat1  0.001      0.033      0.004      0.000      0.000    
#> funcY4:p5_ID:treat1 -0.021      0.001     -0.064      0.000      0.000    
#> funcY1:p6_ID:treat0  0.000      0.000      0.000      0.194     -0.008    
#> funcY2:p6_ID:treat0  0.000      0.000      0.000     -0.005      0.022    
#> funcY3:p6_ID:treat0  0.000      0.000      0.000     -0.002     -0.002    
#> funcY4:p6_ID:treat0  0.000      0.000      0.000      0.003      0.009    
#> funcY1:p6_ID:treat1 -0.003     -0.002      0.003      0.000      0.000    
#> funcY2:p6_ID:treat1 -0.038      0.000     -0.005      0.000      0.000    
#> funcY3:p6_ID:treat1  0.000      0.087     -0.003      0.000      0.000    
#> funcY4:p6_ID:treat1 -0.006     -0.004     -0.006      0.000      0.000    
#> funcY1:AV:treat0     0.000      0.000      0.000     -0.480      0.027    
#> funcY2:AV:treat0     0.000      0.000      0.000      0.038     -0.337    
#> funcY3:AV:treat0     0.000      0.000      0.000      0.007      0.009    
#> funcY4:AV:treat0     0.000      0.000      0.000     -0.019     -0.081    
#> funcY1:AV:treat1     0.026      0.007     -0.015      0.000      0.000    
#> funcY2:AV:treat1    -0.323      0.012     -0.089      0.000      0.000    
#> funcY3:AV:treat1     0.008     -0.471      0.039      0.000      0.000    
#> funcY4:AV:treat1    -0.078      0.051     -0.367      0.000      0.000    
#>                     fY3:2_ID:0 fY4:2_ID:0 fY1:2_ID:1 fY2:2_ID:1 fY3:2_ID:1
#> funcY2:p1_ID:treat0                                                       
#> funcY3:p1_ID:treat0                                                       
#> funcY4:p1_ID:treat0                                                       
#> funcY1:p1_ID:treat1                                                       
#> funcY2:p1_ID:treat1                                                       
#> funcY3:p1_ID:treat1                                                       
#> funcY4:p1_ID:treat1                                                       
#> funcY1:p2_ID:treat0                                                       
#> funcY2:p2_ID:treat0                                                       
#> funcY3:p2_ID:treat0                                                       
#> funcY4:p2_ID:treat0 -0.109                                                
#> funcY1:p2_ID:treat1  0.000      0.000                                     
#> funcY2:p2_ID:treat1  0.000      0.000     -0.089                          
#> funcY3:p2_ID:treat1  0.000      0.000     -0.015     -0.026               
#> funcY4:p2_ID:treat1  0.000      0.000      0.042      0.241     -0.109    
#> funcY1:p3_ID:treat0 -0.001      0.002      0.000      0.000      0.000    
#> funcY2:p3_ID:treat0  0.000     -0.005      0.000      0.000      0.000    
#> funcY3:p3_ID:treat0  0.059     -0.002      0.000      0.000      0.000    
#> funcY4:p3_ID:treat0 -0.002     -0.008      0.000      0.000      0.000    
#> funcY1:p3_ID:treat1  0.000      0.000      0.139     -0.001     -0.001    
#> funcY2:p3_ID:treat1  0.000      0.000     -0.001     -0.035      0.000    
#> funcY3:p3_ID:treat1  0.000      0.000     -0.001      0.000      0.059    
#> funcY4:p3_ID:treat1  0.000      0.000      0.002     -0.005     -0.002    
#> funcY1:p4_ID:treat0 -0.002      0.005      0.000      0.000      0.000    
#> funcY2:p4_ID:treat0 -0.002      0.009      0.000      0.000      0.000    
#> funcY3:p4_ID:treat0  0.119     -0.009      0.000      0.000      0.000    
#> funcY4:p4_ID:treat0 -0.008      0.051      0.000      0.000      0.000    
#> funcY1:p4_ID:treat1  0.000      0.000      0.201     -0.007     -0.002    
#> funcY2:p4_ID:treat1  0.000      0.000     -0.006      0.024     -0.002    
#> funcY3:p4_ID:treat1  0.000      0.000     -0.002     -0.002      0.119    
#> funcY4:p4_ID:treat1  0.000      0.000      0.004      0.009     -0.008    
#> funcY1:p5_ID:treat0 -0.003      0.006      0.000      0.000      0.000    
#> funcY2:p5_ID:treat0 -0.003      0.022      0.000      0.000      0.000    
#> funcY3:p5_ID:treat0  0.161     -0.014      0.000      0.000      0.000    
#> funcY4:p5_ID:treat0 -0.014      0.103      0.000      0.000      0.000    
#> funcY1:p5_ID:treat1  0.000      0.000      0.231     -0.011     -0.003    
#> funcY2:p5_ID:treat1  0.000      0.000     -0.011      0.081     -0.003    
#> funcY3:p5_ID:treat1  0.000      0.000     -0.003     -0.003      0.161    
#> funcY4:p5_ID:treat1  0.000      0.000      0.006      0.022     -0.014    
#> funcY1:p6_ID:treat0 -0.002      0.005      0.000      0.000      0.000    
#> funcY2:p6_ID:treat0 -0.001      0.007      0.000      0.000      0.000    
#> funcY3:p6_ID:treat0  0.110     -0.009      0.000      0.000      0.000    
#> funcY4:p6_ID:treat0 -0.007      0.045      0.000      0.000      0.000    
#> funcY1:p6_ID:treat1  0.000      0.000      0.194     -0.008     -0.002    
#> funcY2:p6_ID:treat1  0.000      0.000     -0.005      0.022     -0.001    
#> funcY3:p6_ID:treat1  0.000      0.000     -0.002     -0.002      0.110    
#> funcY4:p6_ID:treat1  0.000      0.000      0.003      0.009     -0.007    
#> funcY1:AV:treat0     0.006     -0.014      0.000      0.000      0.000    
#> funcY2:AV:treat0     0.011     -0.087      0.000      0.000      0.000    
#> funcY3:AV:treat0    -0.420      0.039      0.000      0.000      0.000    
#> funcY4:AV:treat0     0.045     -0.362      0.000      0.000      0.000    
#> funcY1:AV:treat1     0.000      0.000     -0.480      0.027      0.006    
#> funcY2:AV:treat1     0.000      0.000      0.038     -0.337      0.011    
#> funcY3:AV:treat1     0.000      0.000      0.007      0.009     -0.420    
#> funcY4:AV:treat1     0.000      0.000     -0.019     -0.081      0.045    
#>                     fY4:2_ID:1 fY1:3_ID:0 fY2:3_ID:0 fY3:3_ID:0 fY4:3_ID:0
#> funcY2:p1_ID:treat0                                                       
#> funcY3:p1_ID:treat0                                                       
#> funcY4:p1_ID:treat0                                                       
#> funcY1:p1_ID:treat1                                                       
#> funcY2:p1_ID:treat1                                                       
#> funcY3:p1_ID:treat1                                                       
#> funcY4:p1_ID:treat1                                                       
#> funcY1:p2_ID:treat0                                                       
#> funcY2:p2_ID:treat0                                                       
#> funcY3:p2_ID:treat0                                                       
#> funcY4:p2_ID:treat0                                                       
#> funcY1:p2_ID:treat1                                                       
#> funcY2:p2_ID:treat1                                                       
#> funcY3:p2_ID:treat1                                                       
#> funcY4:p2_ID:treat1                                                       
#> funcY1:p3_ID:treat0  0.000                                                
#> funcY2:p3_ID:treat0  0.000     -0.087                                     
#> funcY3:p3_ID:treat0  0.000     -0.015     -0.026                          
#> funcY4:p3_ID:treat0  0.000      0.042      0.241     -0.109               
#> funcY1:p3_ID:treat1  0.002      0.000      0.000      0.000      0.000    
#> funcY2:p3_ID:treat1 -0.005      0.000      0.000      0.000      0.000    
#> funcY3:p3_ID:treat1 -0.002      0.000      0.000      0.000      0.000    
#> funcY4:p3_ID:treat1 -0.008      0.000      0.000      0.000      0.000    
#> funcY1:p4_ID:treat0  0.000      0.307     -0.015     -0.004      0.008    
#> funcY2:p4_ID:treat0  0.000     -0.013      0.100     -0.004      0.028    
#> funcY3:p4_ID:treat0  0.000     -0.004     -0.004      0.213     -0.018    
#> funcY4:p4_ID:treat0  0.000      0.008      0.028     -0.018      0.132    
#> funcY1:p4_ID:treat1  0.005      0.000      0.000      0.000      0.000    
#> funcY2:p4_ID:treat1  0.009      0.000      0.000      0.000      0.000    
#> funcY3:p4_ID:treat1 -0.009      0.000      0.000      0.000      0.000    
#> funcY4:p4_ID:treat1  0.051      0.000      0.000      0.000      0.000    
#> funcY1:p5_ID:treat0  0.000      0.332     -0.019     -0.004      0.010    
#> funcY2:p5_ID:treat0  0.000     -0.018      0.158     -0.005      0.041    
#> funcY3:p5_ID:treat0  0.000     -0.004     -0.005      0.251     -0.023    
#> funcY4:p5_ID:treat0  0.000      0.010      0.041     -0.023      0.184    
#> funcY1:p5_ID:treat1  0.006      0.000      0.000      0.000      0.000    
#> funcY2:p5_ID:treat1  0.022      0.000      0.000      0.000      0.000    
#> funcY3:p5_ID:treat1 -0.014      0.000      0.000      0.000      0.000    
#> funcY4:p5_ID:treat1  0.103      0.000      0.000      0.000      0.000    
#> funcY1:p6_ID:treat0  0.000      0.237     -0.009     -0.003      0.006    
#> funcY2:p6_ID:treat0  0.000     -0.006      0.019     -0.001      0.008    
#> funcY3:p6_ID:treat0  0.000     -0.002     -0.002      0.132     -0.010    
#> funcY4:p6_ID:treat0  0.000      0.004      0.009     -0.008      0.050    
#> funcY1:p6_ID:treat1  0.005      0.000      0.000      0.000      0.000    
#> funcY2:p6_ID:treat1  0.007      0.000      0.000      0.000      0.000    
#> funcY3:p6_ID:treat1 -0.009      0.000      0.000      0.000      0.000    
#> funcY4:p6_ID:treat1  0.045      0.000      0.000      0.000      0.000    
#> funcY1:AV:treat0     0.000     -0.598      0.034      0.008     -0.018    
#> funcY2:AV:treat0     0.000      0.048     -0.429      0.014     -0.111    
#> funcY3:AV:treat0     0.000      0.009      0.011     -0.528      0.049    
#> funcY4:AV:treat0     0.000     -0.024     -0.104      0.057     -0.460    
#> funcY1:AV:treat1    -0.014      0.000      0.000      0.000      0.000    
#> funcY2:AV:treat1    -0.087      0.000      0.000      0.000      0.000    
#> funcY3:AV:treat1     0.039      0.000      0.000      0.000      0.000    
#> funcY4:AV:treat1    -0.362      0.000      0.000      0.000      0.000    
#>                     fY1:3_ID:1 fY2:3_ID:1 fY3:3_ID:1 fY4:3_ID:1 fY1:4_ID:0
#> funcY2:p1_ID:treat0                                                       
#> funcY3:p1_ID:treat0                                                       
#> funcY4:p1_ID:treat0                                                       
#> funcY1:p1_ID:treat1                                                       
#> funcY2:p1_ID:treat1                                                       
#> funcY3:p1_ID:treat1                                                       
#> funcY4:p1_ID:treat1                                                       
#> funcY1:p2_ID:treat0                                                       
#> funcY2:p2_ID:treat0                                                       
#> funcY3:p2_ID:treat0                                                       
#> funcY4:p2_ID:treat0                                                       
#> funcY1:p2_ID:treat1                                                       
#> funcY2:p2_ID:treat1                                                       
#> funcY3:p2_ID:treat1                                                       
#> funcY4:p2_ID:treat1                                                       
#> funcY1:p3_ID:treat0                                                       
#> funcY2:p3_ID:treat0                                                       
#> funcY3:p3_ID:treat0                                                       
#> funcY4:p3_ID:treat0                                                       
#> funcY1:p3_ID:treat1                                                       
#> funcY2:p3_ID:treat1 -0.087                                                
#> funcY3:p3_ID:treat1 -0.015     -0.026                                     
#> funcY4:p3_ID:treat1  0.042      0.241     -0.109                          
#> funcY1:p4_ID:treat0  0.000      0.000      0.000      0.000               
#> funcY2:p4_ID:treat0  0.000      0.000      0.000      0.000     -0.087    
#> funcY3:p4_ID:treat0  0.000      0.000      0.000      0.000     -0.015    
#> funcY4:p4_ID:treat0  0.000      0.000      0.000      0.000      0.042    
#> funcY1:p4_ID:treat1  0.307     -0.015     -0.004      0.008      0.000    
#> funcY2:p4_ID:treat1 -0.013      0.100     -0.004      0.028      0.000    
#> funcY3:p4_ID:treat1 -0.004     -0.004      0.213     -0.018      0.000    
#> funcY4:p4_ID:treat1  0.008      0.028     -0.018      0.132      0.000    
#> funcY1:p5_ID:treat0  0.000      0.000      0.000      0.000      0.197    
#> funcY2:p5_ID:treat0  0.000      0.000      0.000      0.000     -0.003    
#> funcY3:p5_ID:treat0  0.000      0.000      0.000      0.000     -0.002    
#> funcY4:p5_ID:treat0  0.000      0.000      0.000      0.000      0.003    
#> funcY1:p5_ID:treat1  0.332     -0.019     -0.004      0.010      0.000    
#> funcY2:p5_ID:treat1 -0.018      0.158     -0.005      0.041      0.000    
#> funcY3:p5_ID:treat1 -0.004     -0.005      0.251     -0.023      0.000    
#> funcY4:p5_ID:treat1  0.010      0.041     -0.023      0.184      0.000    
#> funcY1:p6_ID:treat0  0.000      0.000      0.000      0.000      0.228    
#> funcY2:p6_ID:treat0  0.000      0.000      0.000      0.000     -0.004    
#> funcY3:p6_ID:treat0  0.000      0.000      0.000      0.000     -0.002    
#> funcY4:p6_ID:treat0  0.000      0.000      0.000      0.000      0.003    
#> funcY1:p6_ID:treat1  0.237     -0.009     -0.003      0.006      0.000    
#> funcY2:p6_ID:treat1 -0.006      0.019     -0.001      0.008      0.000    
#> funcY3:p6_ID:treat1 -0.002     -0.002      0.132     -0.010      0.000    
#> funcY4:p6_ID:treat1  0.004      0.009     -0.008      0.050      0.000    
#> funcY1:AV:treat0     0.000      0.000      0.000      0.000     -0.616    
#> funcY2:AV:treat0     0.000      0.000      0.000      0.000      0.049    
#> funcY3:AV:treat0     0.000      0.000      0.000      0.000      0.009    
#> funcY4:AV:treat0     0.000      0.000      0.000      0.000     -0.025    
#> funcY1:AV:treat1    -0.598      0.034      0.008     -0.018      0.000    
#> funcY2:AV:treat1     0.048     -0.429      0.014     -0.111      0.000    
#> funcY3:AV:treat1     0.009      0.011     -0.528      0.049      0.000    
#> funcY4:AV:treat1    -0.024     -0.104      0.057     -0.460      0.000    
#>                     fY2:4_ID:0 fY3:4_ID:0 fY4:4_ID:0 fY1:4_ID:1 fY2:4_ID:1
#> funcY2:p1_ID:treat0                                                       
#> funcY3:p1_ID:treat0                                                       
#> funcY4:p1_ID:treat0                                                       
#> funcY1:p1_ID:treat1                                                       
#> funcY2:p1_ID:treat1                                                       
#> funcY3:p1_ID:treat1                                                       
#> funcY4:p1_ID:treat1                                                       
#> funcY1:p2_ID:treat0                                                       
#> funcY2:p2_ID:treat0                                                       
#> funcY3:p2_ID:treat0                                                       
#> funcY4:p2_ID:treat0                                                       
#> funcY1:p2_ID:treat1                                                       
#> funcY2:p2_ID:treat1                                                       
#> funcY3:p2_ID:treat1                                                       
#> funcY4:p2_ID:treat1                                                       
#> funcY1:p3_ID:treat0                                                       
#> funcY2:p3_ID:treat0                                                       
#> funcY3:p3_ID:treat0                                                       
#> funcY4:p3_ID:treat0                                                       
#> funcY1:p3_ID:treat1                                                       
#> funcY2:p3_ID:treat1                                                       
#> funcY3:p3_ID:treat1                                                       
#> funcY4:p3_ID:treat1                                                       
#> funcY1:p4_ID:treat0                                                       
#> funcY2:p4_ID:treat0                                                       
#> funcY3:p4_ID:treat0 -0.026                                                
#> funcY4:p4_ID:treat0  0.241     -0.108                                     
#> funcY1:p4_ID:treat1  0.000      0.000      0.000                          
#> funcY2:p4_ID:treat1  0.000      0.000      0.000     -0.087               
#> funcY3:p4_ID:treat1  0.000      0.000      0.000     -0.015     -0.026    
#> funcY4:p4_ID:treat1  0.000      0.000      0.000      0.042      0.241    
#> funcY1:p5_ID:treat0 -0.002     -0.002      0.003      0.000      0.000    
#> funcY2:p5_ID:treat0 -0.036     -0.001     -0.004      0.000      0.000    
#> funcY3:p5_ID:treat0  0.000      0.088     -0.004      0.000      0.000    
#> funcY4:p5_ID:treat0 -0.005     -0.004     -0.001      0.000      0.000    
#> funcY1:p5_ID:treat1  0.000      0.000      0.000      0.197     -0.002    
#> funcY2:p5_ID:treat1  0.000      0.000      0.000     -0.003     -0.036    
#> funcY3:p5_ID:treat1  0.000      0.000      0.000     -0.002      0.000    
#> funcY4:p5_ID:treat1  0.000      0.000      0.000      0.003     -0.005    
#> funcY1:p6_ID:treat0 -0.006     -0.002      0.005      0.000      0.000    
#> funcY2:p6_ID:treat0 -0.013     -0.001      0.000      0.000      0.000    
#> funcY3:p6_ID:treat0 -0.001      0.111     -0.007      0.000      0.000    
#> funcY4:p6_ID:treat0  0.001     -0.006      0.021      0.000      0.000    
#> funcY1:p6_ID:treat1  0.000      0.000      0.000      0.228     -0.006    
#> funcY2:p6_ID:treat1  0.000      0.000      0.000     -0.004     -0.013    
#> funcY3:p6_ID:treat1  0.000      0.000      0.000     -0.002     -0.001    
#> funcY4:p6_ID:treat1  0.000      0.000      0.000      0.003      0.001    
#> funcY1:AV:treat0     0.033      0.008     -0.018      0.000      0.000    
#> funcY2:AV:treat0    -0.417      0.014     -0.109      0.000      0.000    
#> funcY3:AV:treat0     0.011     -0.534      0.049      0.000      0.000    
#> funcY4:AV:treat0    -0.101      0.057     -0.453      0.000      0.000    
#> funcY1:AV:treat1     0.000      0.000      0.000     -0.616      0.033    
#> funcY2:AV:treat1     0.000      0.000      0.000      0.049     -0.417    
#> funcY3:AV:treat1     0.000      0.000      0.000      0.009      0.011    
#> funcY4:AV:treat1     0.000      0.000      0.000     -0.025     -0.101    
#>                     fY3:4_ID:1 fY4:4_ID:1 fY1:5_ID:0 fY2:5_ID:0 fY3:5_ID:0
#> funcY2:p1_ID:treat0                                                       
#> funcY3:p1_ID:treat0                                                       
#> funcY4:p1_ID:treat0                                                       
#> funcY1:p1_ID:treat1                                                       
#> funcY2:p1_ID:treat1                                                       
#> funcY3:p1_ID:treat1                                                       
#> funcY4:p1_ID:treat1                                                       
#> funcY1:p2_ID:treat0                                                       
#> funcY2:p2_ID:treat0                                                       
#> funcY3:p2_ID:treat0                                                       
#> funcY4:p2_ID:treat0                                                       
#> funcY1:p2_ID:treat1                                                       
#> funcY2:p2_ID:treat1                                                       
#> funcY3:p2_ID:treat1                                                       
#> funcY4:p2_ID:treat1                                                       
#> funcY1:p3_ID:treat0                                                       
#> funcY2:p3_ID:treat0                                                       
#> funcY3:p3_ID:treat0                                                       
#> funcY4:p3_ID:treat0                                                       
#> funcY1:p3_ID:treat1                                                       
#> funcY2:p3_ID:treat1                                                       
#> funcY3:p3_ID:treat1                                                       
#> funcY4:p3_ID:treat1                                                       
#> funcY1:p4_ID:treat0                                                       
#> funcY2:p4_ID:treat0                                                       
#> funcY3:p4_ID:treat0                                                       
#> funcY4:p4_ID:treat0                                                       
#> funcY1:p4_ID:treat1                                                       
#> funcY2:p4_ID:treat1                                                       
#> funcY3:p4_ID:treat1                                                       
#> funcY4:p4_ID:treat1 -0.108                                                
#> funcY1:p5_ID:treat0  0.000      0.000                                     
#> funcY2:p5_ID:treat0  0.000      0.000     -0.088                          
#> funcY3:p5_ID:treat0  0.000      0.000     -0.015     -0.026               
#> funcY4:p5_ID:treat0  0.000      0.000      0.042      0.241     -0.109    
#> funcY1:p5_ID:treat1 -0.002      0.003      0.000      0.000      0.000    
#> funcY2:p5_ID:treat1 -0.001     -0.004      0.000      0.000      0.000    
#> funcY3:p5_ID:treat1  0.088     -0.004      0.000      0.000      0.000    
#> funcY4:p5_ID:treat1 -0.004     -0.001      0.000      0.000      0.000    
#> funcY1:p6_ID:treat0  0.000      0.000      0.270     -0.013     -0.003    
#> funcY2:p6_ID:treat0  0.000      0.000     -0.010      0.068     -0.003    
#> funcY3:p6_ID:treat0  0.000      0.000     -0.003     -0.003      0.170    
#> funcY4:p6_ID:treat0  0.000      0.000      0.006      0.020     -0.013    
#> funcY1:p6_ID:treat1 -0.002      0.005      0.000      0.000      0.000    
#> funcY2:p6_ID:treat1 -0.001      0.000      0.000      0.000      0.000    
#> funcY3:p6_ID:treat1  0.111     -0.007      0.000      0.000      0.000    
#> funcY4:p6_ID:treat1 -0.006      0.021      0.000      0.000      0.000    
#> funcY1:AV:treat0     0.000      0.000     -0.575      0.032      0.007    
#> funcY2:AV:treat0     0.000      0.000      0.046     -0.402      0.013    
#> funcY3:AV:treat0     0.000      0.000      0.008      0.010     -0.500    
#> funcY4:AV:treat0     0.000      0.000     -0.023     -0.097      0.054    
#> funcY1:AV:treat1     0.008     -0.018      0.000      0.000      0.000    
#> funcY2:AV:treat1     0.014     -0.109      0.000      0.000      0.000    
#> funcY3:AV:treat1    -0.534      0.049      0.000      0.000      0.000    
#> funcY4:AV:treat1     0.057     -0.453      0.000      0.000      0.000    
#>                     fY4:5_ID:0 fY1:5_ID:1 fY2:5_ID:1 fY3:5_ID:1 fY4:5_ID:1
#> funcY2:p1_ID:treat0                                                       
#> funcY3:p1_ID:treat0                                                       
#> funcY4:p1_ID:treat0                                                       
#> funcY1:p1_ID:treat1                                                       
#> funcY2:p1_ID:treat1                                                       
#> funcY3:p1_ID:treat1                                                       
#> funcY4:p1_ID:treat1                                                       
#> funcY1:p2_ID:treat0                                                       
#> funcY2:p2_ID:treat0                                                       
#> funcY3:p2_ID:treat0                                                       
#> funcY4:p2_ID:treat0                                                       
#> funcY1:p2_ID:treat1                                                       
#> funcY2:p2_ID:treat1                                                       
#> funcY3:p2_ID:treat1                                                       
#> funcY4:p2_ID:treat1                                                       
#> funcY1:p3_ID:treat0                                                       
#> funcY2:p3_ID:treat0                                                       
#> funcY3:p3_ID:treat0                                                       
#> funcY4:p3_ID:treat0                                                       
#> funcY1:p3_ID:treat1                                                       
#> funcY2:p3_ID:treat1                                                       
#> funcY3:p3_ID:treat1                                                       
#> funcY4:p3_ID:treat1                                                       
#> funcY1:p4_ID:treat0                                                       
#> funcY2:p4_ID:treat0                                                       
#> funcY3:p4_ID:treat0                                                       
#> funcY4:p4_ID:treat0                                                       
#> funcY1:p4_ID:treat1                                                       
#> funcY2:p4_ID:treat1                                                       
#> funcY3:p4_ID:treat1                                                       
#> funcY4:p4_ID:treat1                                                       
#> funcY1:p5_ID:treat0                                                       
#> funcY2:p5_ID:treat0                                                       
#> funcY3:p5_ID:treat0                                                       
#> funcY4:p5_ID:treat0                                                       
#> funcY1:p5_ID:treat1  0.000                                                
#> funcY2:p5_ID:treat1  0.000     -0.088                                     
#> funcY3:p5_ID:treat1  0.000     -0.015     -0.026                          
#> funcY4:p5_ID:treat1  0.000      0.042      0.241     -0.109               
#> funcY1:p6_ID:treat0  0.007      0.000      0.000      0.000      0.000    
#> funcY2:p6_ID:treat0  0.019      0.000      0.000      0.000      0.000    
#> funcY3:p6_ID:treat0 -0.015      0.000      0.000      0.000      0.000    
#> funcY4:p6_ID:treat0  0.095      0.000      0.000      0.000      0.000    
#> funcY1:p6_ID:treat1  0.000      0.270     -0.013     -0.003      0.007    
#> funcY2:p6_ID:treat1  0.000     -0.010      0.068     -0.003      0.019    
#> funcY3:p6_ID:treat1  0.000     -0.003     -0.003      0.170     -0.015    
#> funcY4:p6_ID:treat1  0.000      0.006      0.020     -0.013      0.095    
#> funcY1:AV:treat0    -0.017      0.000      0.000      0.000      0.000    
#> funcY2:AV:treat0    -0.104      0.000      0.000      0.000      0.000    
#> funcY3:AV:treat0     0.046      0.000      0.000      0.000      0.000    
#> funcY4:AV:treat0    -0.431      0.000      0.000      0.000      0.000    
#> funcY1:AV:treat1     0.000     -0.575      0.032      0.007     -0.017    
#> funcY2:AV:treat1     0.000      0.046     -0.402      0.013     -0.104    
#> funcY3:AV:treat1     0.000      0.008      0.010     -0.500      0.046    
#> funcY4:AV:treat1     0.000     -0.023     -0.097      0.054     -0.431    
#>                     fY1:6_ID:0 fY2:6_ID:0 fY3:6_ID:0 fY4:6_ID:0 fY1:6_ID:1
#> funcY2:p1_ID:treat0                                                       
#> funcY3:p1_ID:treat0                                                       
#> funcY4:p1_ID:treat0                                                       
#> funcY1:p1_ID:treat1                                                       
#> funcY2:p1_ID:treat1                                                       
#> funcY3:p1_ID:treat1                                                       
#> funcY4:p1_ID:treat1                                                       
#> funcY1:p2_ID:treat0                                                       
#> funcY2:p2_ID:treat0                                                       
#> funcY3:p2_ID:treat0                                                       
#> funcY4:p2_ID:treat0                                                       
#> funcY1:p2_ID:treat1                                                       
#> funcY2:p2_ID:treat1                                                       
#> funcY3:p2_ID:treat1                                                       
#> funcY4:p2_ID:treat1                                                       
#> funcY1:p3_ID:treat0                                                       
#> funcY2:p3_ID:treat0                                                       
#> funcY3:p3_ID:treat0                                                       
#> funcY4:p3_ID:treat0                                                       
#> funcY1:p3_ID:treat1                                                       
#> funcY2:p3_ID:treat1                                                       
#> funcY3:p3_ID:treat1                                                       
#> funcY4:p3_ID:treat1                                                       
#> funcY1:p4_ID:treat0                                                       
#> funcY2:p4_ID:treat0                                                       
#> funcY3:p4_ID:treat0                                                       
#> funcY4:p4_ID:treat0                                                       
#> funcY1:p4_ID:treat1                                                       
#> funcY2:p4_ID:treat1                                                       
#> funcY3:p4_ID:treat1                                                       
#> funcY4:p4_ID:treat1                                                       
#> funcY1:p5_ID:treat0                                                       
#> funcY2:p5_ID:treat0                                                       
#> funcY3:p5_ID:treat0                                                       
#> funcY4:p5_ID:treat0                                                       
#> funcY1:p5_ID:treat1                                                       
#> funcY2:p5_ID:treat1                                                       
#> funcY3:p5_ID:treat1                                                       
#> funcY4:p5_ID:treat1                                                       
#> funcY1:p6_ID:treat0                                                       
#> funcY2:p6_ID:treat0 -0.087                                                
#> funcY3:p6_ID:treat0 -0.015     -0.026                                     
#> funcY4:p6_ID:treat0  0.042      0.241     -0.108                          
#> funcY1:p6_ID:treat1  0.000      0.000      0.000      0.000               
#> funcY2:p6_ID:treat1  0.000      0.000      0.000      0.000     -0.087    
#> funcY3:p6_ID:treat1  0.000      0.000      0.000      0.000     -0.015    
#> funcY4:p6_ID:treat1  0.000      0.000      0.000      0.000      0.042    
#> funcY1:AV:treat0    -0.552      0.026      0.006     -0.014      0.000    
#> funcY2:AV:treat0     0.044     -0.320      0.011     -0.086      0.000    
#> funcY3:AV:treat0     0.008      0.008     -0.449      0.038      0.000    
#> funcY4:AV:treat0    -0.022     -0.077      0.048     -0.358      0.000    
#> funcY1:AV:treat1     0.000      0.000      0.000      0.000     -0.552    
#> funcY2:AV:treat1     0.000      0.000      0.000      0.000      0.044    
#> funcY3:AV:treat1     0.000      0.000      0.000      0.000      0.008    
#> funcY4:AV:treat1     0.000      0.000      0.000      0.000     -0.022    
#>                     fY2:6_ID:1 fY3:6_ID:1 fY4:6_ID:1 fY1:AV:0 fY2:AV:0 fY3:AV:0
#> funcY2:p1_ID:treat0                                                            
#> funcY3:p1_ID:treat0                                                            
#> funcY4:p1_ID:treat0                                                            
#> funcY1:p1_ID:treat1                                                            
#> funcY2:p1_ID:treat1                                                            
#> funcY3:p1_ID:treat1                                                            
#> funcY4:p1_ID:treat1                                                            
#> funcY1:p2_ID:treat0                                                            
#> funcY2:p2_ID:treat0                                                            
#> funcY3:p2_ID:treat0                                                            
#> funcY4:p2_ID:treat0                                                            
#> funcY1:p2_ID:treat1                                                            
#> funcY2:p2_ID:treat1                                                            
#> funcY3:p2_ID:treat1                                                            
#> funcY4:p2_ID:treat1                                                            
#> funcY1:p3_ID:treat0                                                            
#> funcY2:p3_ID:treat0                                                            
#> funcY3:p3_ID:treat0                                                            
#> funcY4:p3_ID:treat0                                                            
#> funcY1:p3_ID:treat1                                                            
#> funcY2:p3_ID:treat1                                                            
#> funcY3:p3_ID:treat1                                                            
#> funcY4:p3_ID:treat1                                                            
#> funcY1:p4_ID:treat0                                                            
#> funcY2:p4_ID:treat0                                                            
#> funcY3:p4_ID:treat0                                                            
#> funcY4:p4_ID:treat0                                                            
#> funcY1:p4_ID:treat1                                                            
#> funcY2:p4_ID:treat1                                                            
#> funcY3:p4_ID:treat1                                                            
#> funcY4:p4_ID:treat1                                                            
#> funcY1:p5_ID:treat0                                                            
#> funcY2:p5_ID:treat0                                                            
#> funcY3:p5_ID:treat0                                                            
#> funcY4:p5_ID:treat0                                                            
#> funcY1:p5_ID:treat1                                                            
#> funcY2:p5_ID:treat1                                                            
#> funcY3:p5_ID:treat1                                                            
#> funcY4:p5_ID:treat1                                                            
#> funcY1:p6_ID:treat0                                                            
#> funcY2:p6_ID:treat0                                                            
#> funcY3:p6_ID:treat0                                                            
#> funcY4:p6_ID:treat0                                                            
#> funcY1:p6_ID:treat1                                                            
#> funcY2:p6_ID:treat1                                                            
#> funcY3:p6_ID:treat1 -0.026                                                     
#> funcY4:p6_ID:treat1  0.241     -0.108                                          
#> funcY1:AV:treat0     0.000      0.000      0.000                               
#> funcY2:AV:treat0     0.000      0.000      0.000     -0.080                    
#> funcY3:AV:treat0     0.000      0.000      0.000     -0.014   -0.026           
#> funcY4:AV:treat0     0.000      0.000      0.000      0.040    0.242   -0.107  
#> funcY1:AV:treat1     0.026      0.006     -0.014      0.000    0.000    0.000  
#> funcY2:AV:treat1    -0.320      0.011     -0.086      0.000    0.000    0.000  
#> funcY3:AV:treat1     0.008     -0.449      0.038      0.000    0.000    0.000  
#> funcY4:AV:treat1    -0.077      0.048     -0.358      0.000    0.000    0.000  
#>                     fY4:AV:0 fY1:AV:1 fY2:AV:1 fY3:AV:1
#> funcY2:p1_ID:treat0                                    
#> funcY3:p1_ID:treat0                                    
#> funcY4:p1_ID:treat0                                    
#> funcY1:p1_ID:treat1                                    
#> funcY2:p1_ID:treat1                                    
#> funcY3:p1_ID:treat1                                    
#> funcY4:p1_ID:treat1                                    
#> funcY1:p2_ID:treat0                                    
#> funcY2:p2_ID:treat0                                    
#> funcY3:p2_ID:treat0                                    
#> funcY4:p2_ID:treat0                                    
#> funcY1:p2_ID:treat1                                    
#> funcY2:p2_ID:treat1                                    
#> funcY3:p2_ID:treat1                                    
#> funcY4:p2_ID:treat1                                    
#> funcY1:p3_ID:treat0                                    
#> funcY2:p3_ID:treat0                                    
#> funcY3:p3_ID:treat0                                    
#> funcY4:p3_ID:treat0                                    
#> funcY1:p3_ID:treat1                                    
#> funcY2:p3_ID:treat1                                    
#> funcY3:p3_ID:treat1                                    
#> funcY4:p3_ID:treat1                                    
#> funcY1:p4_ID:treat0                                    
#> funcY2:p4_ID:treat0                                    
#> funcY3:p4_ID:treat0                                    
#> funcY4:p4_ID:treat0                                    
#> funcY1:p4_ID:treat1                                    
#> funcY2:p4_ID:treat1                                    
#> funcY3:p4_ID:treat1                                    
#> funcY4:p4_ID:treat1                                    
#> funcY1:p5_ID:treat0                                    
#> funcY2:p5_ID:treat0                                    
#> funcY3:p5_ID:treat0                                    
#> funcY4:p5_ID:treat0                                    
#> funcY1:p5_ID:treat1                                    
#> funcY2:p5_ID:treat1                                    
#> funcY3:p5_ID:treat1                                    
#> funcY4:p5_ID:treat1                                    
#> funcY1:p6_ID:treat0                                    
#> funcY2:p6_ID:treat0                                    
#> funcY3:p6_ID:treat0                                    
#> funcY4:p6_ID:treat0                                    
#> funcY1:p6_ID:treat1                                    
#> funcY2:p6_ID:treat1                                    
#> funcY3:p6_ID:treat1                                    
#> funcY4:p6_ID:treat1                                    
#> funcY1:AV:treat0                                       
#> funcY2:AV:treat0                                       
#> funcY3:AV:treat0                                       
#> funcY4:AV:treat0                                       
#> funcY1:AV:treat1     0.000                             
#> funcY2:AV:treat1     0.000   -0.080                    
#> funcY3:AV:treat1     0.000   -0.014   -0.026           
#> funcY4:AV:treat1     0.000    0.040    0.242   -0.107  
#> 
#> Standardized residuals:
#>         Min          Q1         Med          Q3         Max 
#> -2.94493716 -0.65287965 -0.01437135  0.67321174  3.86323102 
#> 
#> Residual standard error: 2.1071 
#> Degrees of freedom: 1536 total; 1480 residual


# We can now use any S3 method compatible with a gls object, for example, predict()

predict(MVmodel_theta, newdata = simMV[which(simMV$plot == 1), ])
#>   plot     Yvalue func
#> 1    1  6.0743137   Y1
#> 2    1  6.2815368   Y2
#> 3    1 -0.8874687   Y3
#> 4    1  4.8245259   Y4
# }

##################################################################################################
#
##################################################################################################
## Code to simulate data
#
#
# \donttest{
set.seed(412)

props <- data.frame(plot = integer(),
                    p1 = integer(),
                    p2 = integer(),
                    p3 = integer(),
                    p4 = integer(),
                    p5 = integer(),
                    p6 = integer())

index <- 1 #row number

#Monocultures
for(i in 1:6) #6 species
{
  for(j in 1:2) #2 technical reps
  {
    props[index, i+1] <- 1
    index <- index + 1
  }
}


#Equal Mixtures
for(rich in sort(rep(2:6, 3))) #3 reps at each richness level
{
  sp <- sample(1:6, rich) #randomly pick species from pool

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
for(rich in sort(rep(c(2, 3, 4, 5, 6), 15))) #15 reps at each richness level
{
  sp <- sample(1:6, rich, replace = TRUE) #randomly pick species from pool

  for(j in 1:2) #2 technical reps
  {
    for(i in 1:6)
    {
      props[index, i+1] <- sum(sp==i)/rich #equal proportions
    }
    index <- index + 1
  }
}


props[is.na(props)] <- 0

mySimData <- props

mySimData$treat <- 0
mySimDataDupe <- mySimData
mySimDataDupe$treat <- 1
mySimData <- rbind(mySimData, mySimDataDupe)

mySimData$plot <- 1:nrow(mySimData)

mySimData$Y1 <- NA
mySimData$Y2 <- NA
mySimData$Y3 <- NA
mySimData$Y4 <- NA

ADDs <- DImodels::DI_data(prop=2:7, what=c("ADD"), data=mySimData)
mySimData <- cbind(mySimData, ADDs)

E_AV <- DImodels::DI_data(prop=2:7, what=c("E", "AV"), data=mySimData)
mySimData <- cbind(mySimData, E_AV)

n <- 4 #Number of Ys
p <- qr.Q(qr(matrix(stats::rnorm(n^2), n))) #Principal Components (make sure it's positive definite)
S <- crossprod(p, p*(n:1)) #Sigma
m <- stats::runif(n, -0.25, 1.5)

#runif(8, -1, 7) #decide on betas randomly

for(i in 1:nrow(mySimData))
{
  #Within subject error
  error <- MASS::mvrnorm(n=1, mu=m, Sigma=S)
  mySimData$Y1[i] <- 6.9*mySimData$p1[i] + -0.3*mySimData$p2[i] + 6.6*mySimData$p3[i] +
  1.7*mySimData$p4[i] + -0.8*mySimData$p5[i] + 4.3*mySimData$p6[i] + 3.5*mySimData$treat[i] +
  1.8*mySimData$AV[i] + error[1]
  mySimData$Y2[i] <- 4.9*mySimData$p1[i] + 3.6*mySimData$p2[i] + 4.4*mySimData$p3[i] +
  2.3*mySimData$p4[i] + 4.3*mySimData$p5[i] + 6.6*mySimData$p6[i] + -0.3*mySimData$treat[i] +
  6.8*mySimData$AV[i] + error[2]
  mySimData$Y3[i] <- -0.3*mySimData$p1[i] + 4.6*mySimData$p2[i] + 1.2*mySimData$p3[i] +
  6.8*mySimData$p4[i] + 1.4*mySimData$p5[i] + 6.9*mySimData$p6[i] + 5.5*mySimData$treat[i] +
  1.4*mySimData$AV[i] + error[3]
  mySimData$Y4[i] <- 4.1*mySimData$p1[i] + 4.2*mySimData$p2[i] + -0.5*mySimData$p3[i] +
  4.9*mySimData$p4[i] + 6.7*mySimData$p5[i] + -0.9*mySimData$p6[i] + -1.0*mySimData$treat[i] +
  0.3*mySimData$AV[i] + error[4]
}

mySimData$treat <- as.factor(mySimData$treat)
# }
```
