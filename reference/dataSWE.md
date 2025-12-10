# The Sweden dataset

Single site dataset containing 48 experimental units (plots), with four
species seeded at two density levels, representing fifteen communities.
One ecosystem function response is recorded for each plot at a three
time points.

## Usage

``` r
data("dataSWE")
```

## Format

A data frame with 432 observations on the following 9 variables.

- `YEARN`:

  a numeric vector indicating the time point (year) that the ecosystem
  function recording was measured at

- `PLOT`:

  a numeric vector indicating the ID of the experimental unit from which
  the observation was recorded

- `TREAT`:

  a vector of factors with two levels, 1 or 2, indicating the treatment
  applied to the plot

- `G1`:

  a numeric vector ranging from 0 to 1, the proportion of the species G1

- `G2`:

  a numeric vector ranging from 0 to 1, the proportion of the species G2

- `L1`:

  a numeric vector ranging from 0 to 1, the proportion of the species L1

- `L2`:

  a numeric vector ranging from 0 to 1, the proportion of the species L2

- `DENS`:

  a character vector representing the seeding density of the plot (-1 or
  1)

- `YIELD`:

  a numeric vector indicating the value of the harvest recorded

## Details

Data comes from a single site from a wider agrodiversity experiment
conducted in Sweden.  
The four species used were Lolium perenne (G1), Dactylis glomerata (G2),
Trifolium pratense (L1), and Trifolium repens (L2). There are two
recommended functional groupings: grouping grasses (G1, G2) and legumes
(L1, L2), or grouping fast-establishing species (G1, L1) and temporally
persistent species (G2, L2).  
One ecosystem function (aboveground biomass (t DM ha-1)) was recorded by
summing recordings from four harvests over each year, for three years.  
The treatment applied varied the quantity of nitrogen applied (core
plots with a quantity of 0 units while treated plots had 180 units
applied).

## Source

Kirwan, L., Connolly, J., Brophy, C., Baadshaug, O.H., Belanger, G.,
Black, A., Carnus, T., Collins, R.P., Cop, J., Delgado, I., De Vliegher,
A., Elgersma A., Frankow-Lindberg, B., Golinski, P., Grieu, P.,
Gustavsson, A.M., Helgadóttir, Á., Höglind, M., Huguenin-Elie, O.,
Jørgensen, M., Kadžiulienė, Ž., Lunnan, T., Lüscher, A., Kurki, P.,
Porqueddu, C., Sebastia, M.-T., Thumm, U., Walmsley, D., and Finn, J.,
2014.  
The Agrodiversity Experiment: three years of data from a multisite study
in intensively managed grasslands.  

## References

Dooley, A., Isbell, F., Kirwan, L., Connolly, J., Finn, J.A. and Brophy,
C., 2015.  
Testing the effects of diversity on ecosystem multifunctionality using a
multivariate model.  
Ecology Letters, 18(11), pp.1242-1251.  

Kirwan, L., Connolly, J., Brophy, C., Baadshaug, O.H., Belanger, G.,
Black, A., Carnus, T., Collins, R.P., Cop, J., Delgado, I., De Vliegher,
A., Elgersma A., Frankow-Lindberg, B., Golinski, P., Grieu, P.,
Gustavsson, A.M., Helgadóttir, Á., Höglind, M., Huguenin-Elie, O.,
Jørgensen, M., Kadžiulienė, Ž., Lunnan, T., Lüscher, A., Kurki, P.,
Porqueddu, C., Sebastia, M.-T., Thumm, U., Walmsley, D., and Finn, J.,
2014.  
The Agrodiversity Experiment: three years of data from a multisite study
in intensively managed grasslands.  

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
####################################################################################################
####################################################################################################
#> <STYLE type='text/css' scoped>
#> PRE.fansi SPAN {padding-top: .25em; padding-bottom: .25em};
#> </STYLE>
## Modelling Example

# For a more thorough example of the workflow of this package, please see vignette
# DImulti_workflow using the following code:

# vignette("DImulti_workflow")


head(dataSWE)
#>   YEARN PLOT TREAT DENS   G1   G2   L1   L2     YIELD
#> 1     1    1     1 High 0.70 0.10 0.10 0.10  7.774822
#> 2     1    2     1 High 0.10 0.70 0.10 0.10 10.302994
#> 3     1    3     1 High 0.10 0.10 0.70 0.10 12.643246
#> 4     1    4     1 High 0.10 0.10 0.10 0.70 12.174211
#> 5     1    5     1 High 0.25 0.25 0.25 0.25  9.063782
#> 6     1    6     1 High 0.40 0.40 0.10 0.10  9.148516

# We begin by transforming the time identifier column to a factor, to better group coefficients

dataSWE$YEARN <- as.factor(dataSWE$YEARN)

# We fit a repeated measures DI model using the main function DImulti().
# We begin by passing the initial species proportions column names through 'prop' and the
# response value column name through 'y'.
# As the data contains multiple time points, we include the 'time' parameter, through which we
# specify the column name containing the repeated measure indicator and the autocorrelation
# structure we want to use, in this case, we use compound symmetry (CS).
# The experimental unit ID is stored in the column "PLOT" and so we pass this to 'unit_IDs'.
# We request that the method fits an average interaction structure and we include the treatments
# DENS and TREAT as additional fixed effects.
# We opt to use the ML estimation method to allow for model comparisons with different fixed
# effects.
# Finally, we specify the data object, dataSWE, through 'data'.

SWEmodel <- DImulti(y = "YIELD", time = c("YEARN", "CS"), unit_IDs = "PLOT",
                    prop = 5:8, data = dataSWE, DImodel = "AV",
                    extra_fixed = ~ 1:(DENS:TREAT),
                    method = "ML")

print(SWEmodel)
#> Note: 
#> Method Used = ML 
#> Correlation Structure Used = CS
#>  Average Term Model
#> Theta value(s) = 1
#> 
#> Generalized least squares fit by maximum likelihood
#>   Model: YIELD ~ 0 + YEARN:((G1_ID + G2_ID + L1_ID + L2_ID + AV):(DENS:TREAT)) 
#>       AIC       BIC    logLik 
#>  481.5727  665.7011 -178.7863 
#> 
#>  Repeated Measure Correlation Structure: Compound symmetry
#>  Formula: ~0 | PLOT 
#>  Parameter estimate(s):
#>       Rho 
#> 0.5934976 
#> 
#> 
#> Table: Fixed Effect Coefficients
#> 
#>                                Beta      Std. Error   t-value   p-value     Signif 
#> -----------------------------  --------  -----------  --------  ----------  -------
#> YEARN1:G1_ID:DENSHigh:TREAT1   +7.247    1.103        6.569     3.999e-09   ***    
#> YEARN2:G1_ID:DENSHigh:TREAT1   +4.404    1.103        3.992     0.0001397   ***    
#> YEARN3:G1_ID:DENSHigh:TREAT1   +2.749    1.103        2.492     0.01467     *      
#> YEARN1:G1_ID:DENSLow:TREAT1    +7.564    1.103        6.856     1.111e-09   ***    
#> YEARN2:G1_ID:DENSLow:TREAT1    +3.748    1.103        3.397     0.001042    **     
#> YEARN3:G1_ID:DENSLow:TREAT1    +2.861    1.103        2.593     0.01122     *      
#> YEARN1:G1_ID:DENSHigh:TREAT2   +10.605   1.155        9.185     2.52e-14    ***    
#> YEARN2:G1_ID:DENSHigh:TREAT2   +7.905    1.155        6.847     1.159e-09   ***    
#> YEARN3:G1_ID:DENSHigh:TREAT2   +6.164    1.155        5.339     7.821e-07   ***    
#> YEARN1:G1_ID:DENSLow:TREAT2    +9.509    1.155        8.236     2.041e-12   ***    
#> YEARN2:G1_ID:DENSLow:TREAT2    +7.103    1.155        6.152     2.499e-08   ***    
#> YEARN3:G1_ID:DENSLow:TREAT2    +5.447    1.155        4.717     9.423e-06   ***    
#> YEARN1:G2_ID:DENSHigh:TREAT1   +7.412    1.103        6.718     2.057e-09   ***    
#> YEARN2:G2_ID:DENSHigh:TREAT1   +5.286    1.103        4.792     7.053e-06   ***    
#> YEARN3:G2_ID:DENSHigh:TREAT1   +4.293    1.103        3.891     0.0001991   ***    
#> YEARN1:G2_ID:DENSLow:TREAT1    +7.629    1.103        6.915     8.52e-10    ***    
#> YEARN2:G2_ID:DENSLow:TREAT1    +6.194    1.103        5.614     2.489e-07   ***    
#> YEARN3:G2_ID:DENSLow:TREAT1    +4.791    1.103        4.343     3.908e-05   ***    
#> YEARN1:G2_ID:DENSHigh:TREAT2   +12.244   1.155        10.605    3.612e-17   ***    
#> YEARN2:G2_ID:DENSHigh:TREAT2   +11.280   1.155        9.770     1.68e-15    ***    
#> YEARN3:G2_ID:DENSHigh:TREAT2   +9.434    1.155        8.170     2.764e-12   ***    
#> YEARN1:G2_ID:DENSLow:TREAT2    +12.185   1.155        10.553    4.58e-17    ***    
#> YEARN2:G2_ID:DENSLow:TREAT2    +10.478   1.155        9.075     4.199e-14   ***    
#> YEARN3:G2_ID:DENSLow:TREAT2    +9.152    1.155        7.926     8.517e-12   ***    
#> YEARN1:L1_ID:DENSHigh:TREAT1   +9.475    1.103        8.589     3.991e-13   ***    
#> YEARN2:L1_ID:DENSHigh:TREAT1   +7.245    1.103        6.567     4.027e-09   ***    
#> YEARN3:L1_ID:DENSHigh:TREAT1   +3.269    1.103        2.963     0.003964    **     
#> YEARN1:L1_ID:DENSLow:TREAT1    +8.150    1.103        7.388     1.005e-10   ***    
#> YEARN2:L1_ID:DENSLow:TREAT1    +5.371    1.103        4.868     5.223e-06   ***    
#> YEARN3:L1_ID:DENSLow:TREAT1    +3.773    1.103        3.420     0.0009679   ***    
#> YEARN1:L1_ID:DENSHigh:TREAT2   +11.322   1.155        9.806     1.422e-15   ***    
#> YEARN2:L1_ID:DENSHigh:TREAT2   +9.371    1.155        8.116     3.553e-12   ***    
#> YEARN3:L1_ID:DENSHigh:TREAT2   +5.873    1.155        5.086     2.19e-06    ***    
#> YEARN1:L1_ID:DENSLow:TREAT2    +10.581   1.155        9.164     2.774e-14   ***    
#> YEARN2:L1_ID:DENSLow:TREAT2    +8.815    1.155        7.634     3.256e-11   ***    
#> YEARN3:L1_ID:DENSLow:TREAT2    +6.277    1.155        5.436     5.231e-07   ***    
#> YEARN1:L2_ID:DENSHigh:TREAT1   +8.638    1.103        7.829     1.33e-11    ***    
#> YEARN2:L2_ID:DENSHigh:TREAT1   +7.772    1.103        7.045     4.75e-10    ***    
#> YEARN3:L2_ID:DENSHigh:TREAT1   +5.782    1.103        5.241     1.169e-06   ***    
#> YEARN1:L2_ID:DENSLow:TREAT1    +8.184    1.103        7.418     8.743e-11   ***    
#> YEARN2:L2_ID:DENSLow:TREAT1    +7.295    1.103        6.613     3.297e-09   ***    
#> YEARN3:L2_ID:DENSLow:TREAT1    +6.697    1.103        6.070     3.556e-08   ***    
#> YEARN1:L2_ID:DENSHigh:TREAT2   +8.531    1.155        7.389     1e-10       ***    
#> YEARN2:L2_ID:DENSHigh:TREAT2   +8.047    1.155        6.969     6.686e-10   ***    
#> YEARN3:L2_ID:DENSHigh:TREAT2   +6.793    1.155        5.883     7.95e-08    ***    
#> YEARN1:L2_ID:DENSLow:TREAT2    +8.235    1.155        7.132     3.201e-10   ***    
#> YEARN2:L2_ID:DENSLow:TREAT2    +8.091    1.155        7.007     5.635e-10   ***    
#> YEARN3:L2_ID:DENSLow:TREAT2    +7.256    1.155        6.284     1.401e-08   ***    
#> YEARN1:AV:DENSHigh:TREAT1      +8.000    2.405        3.326     0.001307    **     
#> YEARN2:AV:DENSHigh:TREAT1      +14.532   2.405        6.042     4.02e-08    ***    
#> YEARN3:AV:DENSHigh:TREAT1      +16.668   2.405        6.930     7.961e-10   ***    
#> YEARN1:AV:DENSLow:TREAT1       +7.187    2.405        2.988     0.003678    **     
#> YEARN2:AV:DENSLow:TREAT1       +16.129   2.405        6.706     2.173e-09   ***    
#> YEARN3:AV:DENSLow:TREAT1       +15.116   2.405        6.285     1.398e-08   ***    
#> YEARN1:AV:DENSHigh:TREAT2      +10.452   3.124        3.346     0.001228    **     
#> YEARN2:AV:DENSHigh:TREAT2      +15.438   3.124        4.942     3.895e-06   ***    
#> YEARN3:AV:DENSHigh:TREAT2      +15.672   3.124        5.017     2.888e-06   ***    
#> YEARN1:AV:DENSLow:TREAT2       +10.213   3.124        3.269     0.001563    **     
#> YEARN2:AV:DENSLow:TREAT2       +15.793   3.124        5.056     2.473e-06   ***    
#> YEARN3:AV:DENSLow:TREAT2       +14.843   3.124        4.752     8.231e-06   ***    
#> 
#> Signif codes: 0-0.001 '***', 0.001-0.01 '**', 0.01-0.05 '*', 0.05-0.1 '+', 0.1-1.0 ' '
#> 
#> Degrees of freedom: 144 total; 84 residual
#> Residual standard error: 0.9922969 
#> 
#> Marginal variance covariance matrix
#>         1       2       3
#> 1 0.98465 0.58439 0.58439
#> 2 0.58439 0.98465 0.58439
#> 3 0.58439 0.58439 0.98465
#>   Standard Deviations: 0.9923 0.9923 0.9923 

# We can now make any changes to the model's fixed effects and use a series of anovas (if the
# models are nested) or information criteria such as AIC, AICc, BIC, or BICc to select a final model
# We choose to change the interactions structure to functional groups, grouping the grasses and
# legumes, and simplify the extra_fixed terms, as an example, by only crossing the ID effect of G1
# with the treatments, and no longer crossing them with each other.

SWEmodel2 <- DImulti(y = "YIELD", time = c("YEARN", "CS"), unit_IDs = "PLOT",
                    prop = 5:8, data = dataSWE, DImodel = "FG", FG = c("G", "G", "L", "L"),
                    extra_fixed = ~ G1_ID:(DENS+TREAT),
                    method = "ML")

BICc(SWEmodel); BICc(SWEmodel2)
#> [1] 905.3566
#> [1] 588.6466

# We select the model with the lower information criteria, which is our functional group model, and
# refit it using the "REML" estimation method, for unbiased estimates.

SWEmodel2 <- DImulti(y = "YIELD", time = c("YEARN", "CS"), unit_IDs = "PLOT",
                    prop = 5:8, data = dataSWE, DImodel = "FG", FG = c("G", "G", "L", "L"),
                    extra_fixed = ~ G1_ID:(DENS+TREAT),
                    method = "REML")

# With this model, we can examine the coefficients

coef(SWEmodel2)
#>         YEARN1:G1_ID         YEARN2:G1_ID         YEARN3:G1_ID 
#>            7.5729869            3.9436908            2.5825595 
#>         YEARN1:G2_ID         YEARN2:G2_ID         YEARN3:G2_ID 
#>           10.2715952            8.3922725            6.9327048 
#>         YEARN1:L1_ID         YEARN2:L1_ID         YEARN3:L1_ID 
#>            9.4996347            7.6097151            4.7693333 
#>         YEARN1:L2_ID         YEARN2:L2_ID         YEARN3:L2_ID 
#>            8.0816864            7.7804133            6.6584057 
#>    YEARN1:FG.bfg_G_L    YEARN2:FG.bfg_G_L    YEARN3:FG.bfg_G_L 
#>           10.8208347           13.5505353           14.4412685 
#>      YEARN1:FG.wfg_G      YEARN2:FG.wfg_G      YEARN3:FG.wfg_G 
#>          -10.9099707           11.6936379           12.6962405 
#>      YEARN1:FG.wfg_L      YEARN2:FG.wfg_L      YEARN3:FG.wfg_L 
#>           10.5492339           17.8021550           15.4746646 
#> YEARN1:G1_ID:DENSLow YEARN2:G1_ID:DENSLow YEARN3:G1_ID:DENSLow 
#>           -0.7974119           -0.6232490           -0.3472993 
#>  YEARN1:G1_ID:TREAT2  YEARN2:G1_ID:TREAT2  YEARN3:G1_ID:TREAT2 
#>            4.3168232            4.8914212            4.1921989 

# or the variance and correlation structures

SWEmodel2$corr
#> $`Repeated Measure`
#> Correlation structure of class corCompSymm representing
#>       Rho 
#> 0.8244173 
#> 
nlme::getVarCov(SWEmodel2)
#> Marginal variance covariance matrix
#>        1      2      3
#> 1 2.7966 2.3055 2.3055
#> 2 2.3055 2.7966 2.3055
#> 3 2.3055 2.3055 2.7966
#>   Standard Deviations: 1.6723 1.6723 1.6723 

```
