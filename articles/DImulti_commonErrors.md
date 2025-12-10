# Common errors & warnings encountered in DImulti()

``` r
library(DImodelsMulti)
data("dataBEL"); data("dataSWE"); data("simMV"); data("simRM"); data("simMVRM")
```

## Incorrect argument specifications

The DImulti() function has a long list of possible parameters, which can
make it difficult to ensure that all arguments supplied are in the
requested format. See below for an example of each parameter and the
included datasets, dataBEL, dataSWE, simMV, simRM and simMVRM, for
examples of dataset formatting.

### y

This is a required argument. It can be passed in three forms, using
either column names or indices:

- #### Univariate

In this case, we pass a single name or index of a numerical column
containing the ecosystem function response value. See ?dataSWE for an
example of a univariate dataset suitable for use with DImulti().

``` r
DImulti(y = "YIELD", ..., data = dataSWE)
DImulti(y = 9, ..., data = dataSWE)
```

``` r-output
#>       YIELD
#> 1  7.774822
#> 2 10.302994
#> 3 12.643246
#> 4 12.174211
#> 5  9.063782
#> 6  9.148516
```

- #### Multivariate stacked

In this case, we pass a single name or index of a numerical column
containing the ecosystem function response value. See ?dataBEL for an
example of a multivariate stacked dataset suitable for use with
DImulti().

``` r
DImulti(y = "Y", ..., data = dataBEL)
DImulti(y = 9, ..., data = dataBEL)
```

``` r-output
#>         Y
#> 1 104.156
#> 2 100.058
#> 3  87.996
#> 4  82.547
#> 5  89.801
#> 6  72.239
```

- #### Multivariate wide

In this case, we pass multiple names or indices of numerical columns
containing the ecosystem function response values. See ?simMV for an
example of a multivariate wide dataset suitable for use with DImulti().

``` r
DImulti(y = c("Y1", "Y2", "Y3", "Y4"), ..., data = simMV)
DImulti(y = 9:12, ..., data = simMV)
```

``` r-output
#>          Y1       Y2         Y3         Y4
#> 1  1.880817 5.108158 -1.9712356  4.8247704
#> 2  7.103477 5.183822 -4.0598298  3.1094539
#> 3 -1.444736 6.900983  6.3342200  4.9055054
#> 4 -1.756776 4.784160  5.2155726  5.3583856
#> 5  5.311257 4.258924 -0.4694982 -2.3078377
#> 6  5.975319 3.148215  1.9509040 -0.6064387
```

### eco_func

This is a required argument for multivariate data and excluded for
univariate data. It can be passed in two forms:

- #### Multivariate stacked

In this case, we pass a vector of size two. The first index contains a
single column name for the ecosystem function response type, a factor,
the second contains the autocorrelation structure desired, either “UN”
or “CS”. See ?dataBEL for an example of a multivariate stacked dataset
suitable for use with DImulti().

``` r
DImulti(eco_func = c("Var", "UN"), ..., data = dataBEL)
```

``` r-output
#>    Var
#> 1 Sown
#> 2 Weed
#> 3    N
#> 4 Sown
#> 5 Weed
#> 6    N
```

- #### Multivariate wide

In this case, we pass a vector of size two. The first index contains the
string “NA”, the second contains the autocorrelation structure desired,
either “UN” or “CS”. See ?simMV for an example of a multivariate stacked
dataset suitable for use with DImulti().

``` r
DImulti(eco_func = c("NA", "UN"), ..., data = simMV)
```

### time

This is a required argument for repeated measures data and excluded for
data taken at a single time point. It can be passed in the following
form:

- #### Repeated Measures

In this case, we pass a vector of size two. The first index contains a
single column name for the time point reference, a factor, the second
contains the autocorrelation structure desired, either “UN”, “CS”, or
“AR1”. See ?dataSWE for an example of a repeated measures dataset
suitable for use with DImulti().

``` r
DImulti(time = c("YEARN", "AR1"), ..., data = dataSWE)
```

``` r-output
#>    YEARN
#> 1      1
#> 49     2
#> 97     3
#> 2      1
#> 50     2
#> 98     3
```

### unit_IDs

This is a required argument for any data.

It can be passed a column name or index, referencing a unique reference
for each experimental unit, used for grouping responses from different
ecosystem functions or time points.

``` r
DImulti(unit_IDs = "plot", ..., data = simMVRM)
DImulti(unit_IDs = 1, ..., data = simMVRM)
```

``` r-output
#>   plot
#> 1    1
#> 2    2
#> 3    3
#> 4    4
#> 5    5
#> 6    6
```

### prop

This is a required argument for any data.

It can be passed as a vector of column names or indices, referencing the
(numerical) initial proportions of any species included in the
experimental design. In the event that a species is included as a factor
as opposed to a numerical value, e.g. if it only appears at values 0 or
1, only the numerical species should be included here, while the factor
species is passed through the extra_fixed parameter. A warning will be
printed to the console warning the user of not meeting the simplex
requirement.

``` r
DImulti(unit_IDs = paste0("p", 1:4), ..., data = simMVRM)
DImulti(unit_IDs = 2:5, ..., data = simMVRM)
```

``` r-output
#>   p1 p2 p3 p4
#> 1  1  0  0  0
#> 2  1  0  0  0
#> 3  1  0  0  0
#> 4  0  1  0  0
#> 5  0  1  0  0
#> 6  0  1  0  0
```

### data

This is a required argument for any data.

This argument should be a dataframe or tibble which contains all columns
referenced in the DImulti() call. There are some restrictions on columns
names allowed in this dataset. An error will be printed to the console
to inform a user of name changes required.

``` r
DImulti(..., data = simMVRM)
DImulti(..., data = simMVRM)
```

``` r-output
#>   plot p1 p2 p3 p4         Y1          Y2        Y3 time
#> 1    1  1  0  0  0 -3.2201614 -0.28424570 4.0353997    1
#> 2    2  1  0  0  0  0.2166701  0.90917719 0.1719544    1
#> 3    3  1  0  0  0 -2.1709989  0.04832118 0.6787839    1
#> 4    4  0  1  0  0  5.3908779  4.08309086 6.5332521    1
#> 5    5  0  1  0  0  5.2733174  4.29488262 6.2761877    1
#> 6    6  0  1  0  0  4.1985826  3.57457447 7.0207313    1
```

### DImodel

This is a required argument for any data.

This argument should be a single string selected from the list of
included interaction structures: “STR”, “ID”, “FULL”, “E”, “AV”, “ADD”,
“FG”.

``` r
DImulti(DImodel = "FULL", ...)
DImulti(DImodel = "AV", ...)
```

### FG

This is a required argument if the argument “FG” is passed through
DImodel and can be excluded otherwise.

This argument should be a vector of strings, of the same length as prop,
which maps each species in the experiment to a functional grouping.

``` r
DImulti(prop = c("G1", "G2", "L1", "L2"), DImodel = "FG", 
        FG = c("Grass", "Grass", "Legume", "Legume"), ..., data = dataBEL)
```

### ID

This is an optional argument.

This argument should be a vector of strings, of the same length as prop,
which maps each species in the experiment to a identity grouping,
assuming functional redundancy between within-group species for their ID
effects, this grouping does not affect interactions.

``` r
DImulti(prop = c("G1", "G2", "L1", "L2"), ID = c("Grass", "Grass", "Legume", "Legume"), 
        ..., data = dataBEL)
```

### extra_fixed

This is an optional argument.

This parameter can be passed a formula of any additional fixed effects
to be included, e.g.  treatments. These effects can be easily crossed
with the automatic DI model formula by prefacing the formula passed with
1: or 1\*. See ?dataSWE for a dataset containing treatments suitable for
use with DImulti().

``` r
DImulti(extra_fixed = ~DENS, ..., data = dataSWE)
DImulti(extra_fixed = ~DENS + TREAT, ..., data = dataSWE)
DImulti(extra_fixed = ~1*DENS, ..., data = dataSWE)
DImulti(extra_fixed = ~1:(DENS+TREAT), ..., data = dataSWE)
DImulti(extra_fixed = ~1:DENS:TREAT, ..., data = dataSWE)
```

``` r-output
#>   DENS TREAT
#> 1 High     1
#> 2 High     1
#> 3 High     1
#> 4 High     1
#> 5 High     1
#> 6 High     1
```

### estimate_theta

This is an optional argument.

This parameter can be passed a boolean value (FALSE), indicating whether
the user wants the function to use profile likelihood to estimate values
for the non-linear parameter $\theta$. Defaults to \<span
class=“R\>FALSE, indicating that estimation will not occur, instead
fixed values of $\theta$ will be used. If “STR” or “ID” was passed
through the parameter DImodel, then setting estimate_theta = TRUE will
cause a warning to be printed to the console, as $\theta$ only applies
to interaction terms, which do not exist for those options.

``` r
DImulti(estimate_theta = TRUE, ...)
DImulti(estimate_theta = FALSE, ...)
```

### theta

This is an optional argument.

This argument should contain numerical values representing the
non-linear parameter $\theta$, which will be applied as a power to the
products of pairs of species in the interaction terms of the model. A
single value may be passed, which will be applied to each ecosystem
function, or a different value may be passed for each ecosystem
function. If “STR” or “ID” was passed through the parameter DImodel,
then setting a non-1 value for theta will cause a warning to be printed
to the console, as $\theta$ only applies to interaction terms, which do
not exist for those options.

``` r
DImulti(theta = 1, ...)
DImulti(theta = c(0.5, 1, 1.2), ...)
```

### method

This is an optional argument.

This parameter is used to change the estimation method used by
DImulti(). The options are “REML”, referring to restricted maximum
likelihood, and “ML”, referring to maximum likelihood. Defaults to
“REML”.

``` r
DImulti(method = "REML", ...)
DImulti(method = "ML", ...)
```

## Singular fit

A singular fit error, thrown by nlme::gls() when fitting the model,
occurs when an element with value of exactly zero exists in the fixed
effect variance covariance matrix of the model. This usually caused by
rank deficiency in the model, i.e. two terms explaining the same
variance. The fix is usually to simplify/change the fixed effect terms,
be it the interactions structure, treatment terms, or theta values. To
aid in this change, the fixed effect formula and any estimated theta
values are printed to the console with the error.

As an example, we use the dataset dataSWE\</span, which is included in
this package.

XXDO NOT
RUNXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX

``` r
DImulti(prop = 5:8, y = "YIELD", time = c("YEARN", "CS"), unit_IDs = "PLOT", data = dataSWE, 
        DImodel = "ID", extra_fixed = ~DENS+TREAT, method = "REML")
```

``` r-output
#> Note: 
#> Method Used = REML 
#> Correlation Structure Used = CS
#>  Identity Model
#> Theta value(s) = 1
#> 
#> Generalized least squares fit by REML
#>   Model: YIELD ~ 0 + YEARN:((G1_ID + G2_ID + L1_ID + L2_ID) + DENS + TREAT) 
#>       AIC       BIC    logLik 
#>  538.6412  595.3668 -249.3206 
#> 
#>  Repeated Measure Correlation Structure: Compound symmetry
#>  Formula: ~0 | PLOT 
#>  Parameter estimate(s):
#>       Rho 
#> 0.8454513 
#> 
#> 
#> Table: Fixed Effect Coefficients
#> 
#>                  Beta      Std. Error   t-value   p-value     Signif 
#> ---------------  --------  -----------  --------  ----------  -------
#> YEARN1:G1_ID     +9.481    1.019        9.306     5.336e-16   ***    
#> YEARN2:G1_ID     +7.821    1.019        7.677     3.922e-12   ***    
#> YEARN3:G1_ID     +6.402    1.019        6.284     4.935e-09   ***    
#> YEARN1:G2_ID     +10.554   1.019        10.359    1.441e-18   ***    
#> YEARN2:G2_ID     +10.288   1.019        10.098    6.303e-18   ***    
#> YEARN3:G2_ID     +8.960    1.019        8.794     9.136e-15   ***    
#> YEARN1:L1_ID     +10.648   1.019        10.451    8.567e-19   ***    
#> YEARN2:L1_ID     +9.751    1.019        9.571     1.212e-16   ***    
#> YEARN3:L1_ID     +6.909    1.019        6.781     4.136e-10   ***    
#> YEARN1:L2_ID     +9.230    1.019        9.060     2.105e-15   ***    
#> YEARN2:L2_ID     +9.922    1.019        9.739     4.738e-17   ***    
#> YEARN3:L2_ID     +8.798    1.019        8.635     2.195e-14   ***    
#> YEARN1:DENSLow   -0.526    0.687        -0.765    0.4454             
#> YEARN2:DENSLow   -0.286    0.687        -0.417    0.6774             
#> YEARN3:DENSLow   +0.044    0.687        0.064     0.9488             
#> YEARN1:TREAT2    +2.218    0.709        3.128     0.002183    **     
#> YEARN2:TREAT2    +1.900    0.709        2.679     0.008368    **     
#> YEARN3:TREAT2    +1.524    0.709        2.148     0.03359     *      
#> 
#> Signif codes: 0-0.001 '***', 0.001-0.01 '**', 0.01-0.05 '*', 0.05-0.1 '+', 0.1-1.0 ' '
#> 
#> Degrees of freedom: 144 total; 126 residual
#> Residual standard error: 2.378508 
#> 
#> Marginal variance covariance matrix
#>        1      2      3
#> 1 5.6573 4.7830 4.7830
#> 2 4.7830 5.6573 4.7830
#> 3 4.7830 4.7830 5.6573
#>   Standard Deviations: 2.3785 2.3785 2.3785
```

XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
As we include no theta values or interaction terms, and use the simple
structure “CS”, compound symmetry, for our repeated measure, the only
complication in this model is the inclusion of the two treatment terms,
DENS and TREAT. When multiple treatments are included, it is usually
good to check that one cannot be inferred from the other, e.g. if DENS =
High then we know that TREAT = 1. Luckily this is not the case here.

``` r-output
#>    DENS TREAT
#> 1  High     1
#> 16  Low     1
#> 31 High     2
#> 40  Low     2
```

Instead, we change the formatting of our formula, from creating
intercepts to crossing the treatment with our ID effects, but not each
other.

``` r
DImulti(prop = 5:8, y = "YIELD", time = c("YEARN", "CS"), unit_IDs = "PLOT", data = dataSWE, 
        DImodel = "ID", extra_fixed = ~1:(DENS+TREAT), method = "REML")
```

``` r-output
#> Note: 
#> Method Used = REML 
#> Correlation Structure Used = CS
#>  Identity Model
#> Theta value(s) = 1
#> 
#> Generalized least squares fit by REML
#>   Model: YIELD ~ 0 + YEARN:((G1_ID + G2_ID + L1_ID + L2_ID):(DENS + TREAT)) 
#>       AIC       BIC    logLik 
#>  519.2773  621.1983 -221.6386 
#> 
#>  Repeated Measure Correlation Structure: Compound symmetry
#>  Formula: ~0 | PLOT 
#>  Parameter estimate(s):
#>       Rho 
#> 0.8390275 
#> 
#> 
#> Table: Fixed Effect Coefficients
#> 
#>                         Beta      Std. Error   t-value   p-value     Signif 
#> ----------------------  --------  -----------  --------  ----------  -------
#> YEARN1:G1_ID:DENSHigh   +9.308    1.623        5.735     8.968e-08   ***    
#> YEARN2:G1_ID:DENSHigh   +7.706    1.623        4.748     6.341e-06   ***    
#> YEARN3:G1_ID:DENSHigh   +6.561    1.623        4.043     9.94e-05    ***    
#> YEARN1:G1_ID:DENSLow    +8.859    1.623        5.459     3.083e-07   ***    
#> YEARN2:G1_ID:DENSLow    +7.222    1.623        4.450     2.096e-05   ***    
#> YEARN3:G1_ID:DENSLow    +6.073    1.623        3.742     0.0002941   ***    
#> YEARN1:G1_ID:TREAT2     +2.506    1.937        1.294     0.1985             
#> YEARN2:G1_ID:TREAT2     +2.356    1.937        1.217     0.2264             
#> YEARN3:G1_ID:TREAT2     +1.752    1.937        0.904     0.3678             
#> YEARN1:G2_ID:DENSHigh   +9.207    1.623        5.673     1.188e-07   ***    
#> YEARN2:G2_ID:DENSHigh   +8.955    1.623        5.518     2.377e-07   ***    
#> YEARN3:G2_ID:DENSHigh   +8.093    1.623        4.986     2.361e-06   ***    
#> YEARN1:G2_ID:DENSLow    +9.191    1.623        5.663     1.242e-07   ***    
#> YEARN2:G2_ID:DENSLow    +9.301    1.623        5.731     9.142e-08   ***    
#> YEARN3:G2_ID:DENSLow    +8.016    1.623        4.939     2.882e-06   ***    
#> YEARN1:G2_ID:TREAT2     +4.548    1.937        2.348     0.02068     *      
#> YEARN2:G2_ID:TREAT2     +4.067    1.937        2.100     0.03807     *      
#> YEARN3:G2_ID:TREAT2     +3.502    1.937        1.808     0.0734      +      
#> YEARN1:L1_ID:DENSHigh   +11.068   1.623        6.820     5.463e-10   ***    
#> YEARN2:L1_ID:DENSHigh   +10.204   1.623        6.287     7.007e-09   ***    
#> YEARN3:L1_ID:DENSHigh   +6.909    1.623        4.257     4.429e-05   ***    
#> YEARN1:L1_ID:DENSLow    +9.914    1.623        6.108     1.619e-08   ***    
#> YEARN2:L1_ID:DENSLow    +9.188    1.623        5.661     1.251e-07   ***    
#> YEARN3:L1_ID:DENSLow    +7.157    1.623        4.410     2.453e-05   ***    
#> YEARN1:L1_ID:TREAT2     +1.993    1.937        1.029     0.3058             
#> YEARN2:L1_ID:TREAT2     +1.713    1.937        0.884     0.3785             
#> YEARN3:L1_ID:TREAT2     +1.305    1.937        0.674     0.502              
#> YEARN1:L2_ID:DENSHigh   +10.330   1.623        6.365     4.847e-09   ***    
#> YEARN2:L2_ID:DENSHigh   +10.918   1.623        6.727     8.564e-10   ***    
#> YEARN3:L2_ID:DENSHigh   +9.505    1.623        5.857     5.167e-08   ***    
#> YEARN1:L2_ID:DENSLow    +9.847    1.623        6.068     1.956e-08   ***    
#> YEARN2:L2_ID:DENSLow    +10.926   1.623        6.732     8.364e-10   ***    
#> YEARN3:L2_ID:DENSLow    +9.998    1.623        6.161     1.269e-08   ***    
#> YEARN1:L2_ID:TREAT2     -0.173    1.937        -0.089    0.9289             
#> YEARN2:L2_ID:TREAT2     -0.537    1.937        -0.277    0.7822             
#> YEARN3:L2_ID:TREAT2     -0.464    1.937        -0.240    0.8111             
#> 
#> Signif codes: 0-0.001 '***', 0.001-0.01 '**', 0.01-0.05 '*', 0.05-0.1 '+', 0.1-1.0 ' '
#> 
#> Degrees of freedom: 144 total; 108 residual
#> Residual standard error: 2.483701 
#> 
#> Marginal variance covariance matrix
#>        1      2      3
#> 1 6.1688 5.1758 5.1758
#> 2 5.1758 6.1688 5.1758
#> 3 5.1758 5.1758 6.1688
#>   Standard Deviations: 2.4837 2.4837 2.4837
```

Which has resolved our issue.

We show another example using the multivariate dataset dataBEL and
estimating $\theta$. We would first set theta = 1 and use model
selection to choose an appropriate interaction structure, which gives us
the following model, with a functional group structure:

``` r
model1 <- DImulti(prop = 2:5, y = "Y", eco_func = c("Var", "UN"), unit_IDs = 1, data = dataBEL,
                  FG = c("Grass", "Grass", "Leg", "Leg"), DImodel = "FG", extra_fixed = ~Density, 
                  method = "ML", theta = 1)
```

## Comparing models: ML vs REML

The optional parameter method in the function DImulti() allows a user to
change the estimation method used, between the default “REML”,
restricted maximum likelihood, and “ML”, maximum likelihood.

“REML” was chosen as the default as it provides unbiased estimates, as
opposed to “ML”, however, “REML” is not appropriate for use with model
comparison where fixed effects vary between models, as we can see from
the following warning message:

XXDO NOT
RUNXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX

``` r
model1 <- DImulti(prop = 2:5, y = "Y", eco_func = c("Var", "UN"), unit_IDs = 1, data = dataBEL,
                  FG = c("Grass", "Grass", "Leg", "Leg"), DImodel = "FG", 
                  method = "REML")

model2 <- DImulti(prop = 2:5, y = "Y", eco_func = c("Var", "UN"), unit_IDs = 1, data = dataBEL,
                  FG = c("Grass", "Grass", "Leg", "Leg"), DImodel = "FG", extra_fixed = ~Density,
                  method = "REML")

anova(model1, model2)
```

``` r-output
#> Warning in nlme::anova.lme(object = model1, model2): fitted objects with
#> different fixed effects. REML comparisons are not meaningful.
```

``` r-output
#>        Model df      AIC      BIC    logLik   Test  L.Ratio p-value
#> model1     1 27 501.7634 562.0843 -223.8817                        
#> model2     2 30 488.0671 553.7567 -214.0335 1 vs 2 19.69631   2e-04
```

XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX

In this case, we should use “ML” to fit the models for comparison, then
refit the chosen model using “REML”, for the unbiased estimates.
