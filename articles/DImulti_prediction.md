# On prediction from multivariate repeated measures DI models

``` r
library(DImodelsMulti)
```

For this vignette, we will use the final model achieved in the vignette
[workflow](https://di-laurabyrne.github.io/DImodelsMulti/articles/DImulti_workflow.md)
as an example.

``` r
modelFinal <- DImulti(y = c("Y1", "Y2", "Y3"), eco_func = c("NA", "UN"), time = c("time", "CS"),
                    unit_IDs = 1, prop = 2:5, data = simMVRM, DImodel = "AV", method = "REML")
print(modelFinal)
```

``` r-output
#> Note: 
#> Method Used = REML 
#> Correlation Structure Used = UN@CS
#>  Average Term Model
#> Theta value(s) = 1
#> 
#> Generalized least squares fit by REML
#>   Model: value ~ 0 + func:time:((p1_ID + p2_ID + p3_ID + p4_ID + AV)) 
#>       AIC       BIC    logLik 
#>  7929.642  8103.053 -3933.821 
#> 
#>  Multivariate Correlation Structure: General
#>  Formula: ~0 | plot 
#>  Parameter estimate(s):
#>  Correlation: 
#>   1      2     
#> 2  0.612       
#> 3 -0.311 -0.364
#> 
#>  Repeated Measure Correlation Structure: Compound symmetry
#>  Formula: ~0 | plot 
#>  Parameter estimate(s):
#>       Rho 
#> 0.3161182 
#> 
#> 
#> Table: Fixed Effect Coefficients
#> 
#>                      Beta      Std. Error   t-value   p-value      Signif 
#> -------------------  --------  -----------  --------  -----------  -------
#> funcY1:time1:p1_ID   -1.407    0.402        -3.505    0.0004669    ***    
#> funcY2:time1:p1_ID   +0.354    0.402        0.880     0.3787              
#> funcY3:time1:p1_ID   +0.946    0.402        2.357     0.01853      *      
#> funcY1:time2:p1_ID   +0.142    0.402        0.353     0.7238              
#> funcY2:time2:p1_ID   +2.630    0.402        6.549     7.354e-11    ***    
#> funcY3:time2:p1_ID   -0.552    0.402        -1.375    0.1693              
#> funcY1:time1:p2_ID   +4.770    0.372        12.824    3.149e-36    ***    
#> funcY2:time1:p2_ID   +4.273    0.372        11.488    1.273e-29    ***    
#> funcY3:time1:p2_ID   +6.704    0.372        18.023    2.221e-67    ***    
#> funcY1:time2:p2_ID   +4.976    0.372        13.378    3.818e-39    ***    
#> funcY2:time2:p2_ID   +2.707    0.372        7.279     4.817e-13    ***    
#> funcY3:time2:p2_ID   +6.806    0.372        18.297    3.09e-69     ***    
#> funcY1:time1:p3_ID   +2.665    0.404        6.602     5.191e-11    ***    
#> funcY2:time1:p3_ID   -0.766    0.404        -1.896    0.05807      +      
#> funcY3:time1:p3_ID   +3.321    0.404        8.226     3.472e-16    ***    
#> funcY1:time2:p3_ID   +4.394    0.404        10.883    7.839e-27    ***    
#> funcY2:time2:p3_ID   -3.350    0.404        -8.298    1.925e-16    ***    
#> funcY3:time2:p3_ID   +3.008    0.404        7.452     1.369e-13    ***    
#> funcY1:time1:p4_ID   -0.900    0.453        -1.984    0.04738      *      
#> funcY2:time1:p4_ID   +0.325    0.453        0.717     0.4734              
#> funcY3:time1:p4_ID   +4.924    0.453        10.859    1.005e-26    ***    
#> funcY1:time2:p4_ID   -2.504    0.453        -5.522    3.79e-08     ***    
#> funcY2:time2:p4_ID   +2.019    0.453        4.453     8.958e-06    ***    
#> funcY3:time2:p4_ID   +3.544    0.453        7.816     8.783e-15    ***    
#> funcY1:time1:AV      +2.892    0.984        2.938     0.003342     **     
#> funcY2:time1:AV      +7.938    0.984        8.065     1.254e-15    ***    
#> funcY3:time1:AV      +6.184    0.984        6.283     4.07e-10     ***    
#> funcY1:time2:AV      +34.080   0.984        34.624    6.175e-206   ***    
#> funcY2:time2:AV      +4.827    0.984        4.904     1.016e-06    ***    
#> funcY3:time2:AV      +18.944   0.984        19.247    7.827e-76    ***    
#> 
#> Signif codes: 0-0.001 '***', 0.001-0.01 '**', 0.01-0.05 '*', 0.05-0.1 '+', 0.1-1.0 ' '
#> 
#> Degrees of freedom: 2016 total; 1986 residual
#> Residual standard error: 1.951116 
#> 
#> $Multivariate
#> Marginal variance covariance matrix
#>         [,1]    [,2]    [,3]
#> [1,]  4.9140  2.3738 -1.3783
#> [2,]  2.3738  3.0605 -1.2758
#> [3,] -1.3783 -1.2758  4.0093
#>   Standard Deviations: 2.2168 1.7494 2.0023 
#> 
#> $`Repeated Measure`
#> Marginal variance covariance matrix
#>        [,1]   [,2]
#> [1,] 4.6263 1.4625
#> [2,] 1.4625 4.6263
#>   Standard Deviations: 2.1509 2.1509 
#> 
#> $Combined
#> Marginal variance covariance matrix
#>          Y1:1     Y1:2     Y2:1     Y2:2     Y3:1     Y3:2
#> Y1:1  3.80690  1.20340  2.33020  0.73662 -1.18210 -0.37368
#> Y1:2  1.20340  3.80690  0.73662  2.33020 -0.37368 -1.18210
#> Y2:1  2.33020  0.73662  3.80690  1.20340 -1.38640 -0.43828
#> Y2:2  0.73662  2.33020  1.20340  3.80690 -0.43828 -1.38640
#> Y3:1 -1.18210 -0.37368 -1.38640 -0.43828  3.80690  1.20340
#> Y3:2 -0.37368 -1.18210 -0.43828 -1.38640  1.20340  3.80690
#>   Standard Deviations: 1.9511 1.9511 1.9511 1.9511 1.9511 1.9511
```

## Prediction how-to overview

To predict for any data from this model, which has custom class DImulti,
we use the predict() function, which is formatted as below, where object
is the DImulti model object, newdata is a dataframe or tibble containing
the community designs that you wish to predict from, if left NULL then
the data used to train the model will be predicted from instead, and
stacked is a boolean which determines whether the output from this
function will be given in a stacked/long format (TRUE) or wide format
(FALSE).

``` r
predict.DImulti(object, newdata = NULL, stacked = TRUE, ...)
```

The first option for prediction is to simply provide the model object to
the function to predict from the dataframe we used to train it
(simMVRM). By default, the prediction dataframe is output in a stacked
format, as it is more commonly used for plotting than a wide output.

``` r
head(predict(modelFinal))
```

``` r-output
#>   plot     Yvalue Ytype
#> 1    1 -1.4073525  Y1:1
#> 2    1  0.1419124  Y1:2
#> 3    1  0.3535514  Y2:1
#> 4    1  2.6296879  Y2:2
#> 5    1  0.9463605  Y3:1
#> 6    1 -0.5521430  Y3:2
```

If we would rather a wide output, which can be easier to infer from
without plotting, we can set stacked = FALSE.

``` r
head(predict(modelFinal, stacked = FALSE))
```

``` r-output
#>   plot      Y1:1      Y1:2      Y2:1     Y2:2      Y3:1      Y3:2
#> 1    1 -1.407353 0.1419124 0.3535514 2.629688 0.9463605 -0.552143
#> 2    2 -1.407353 0.1419124 0.3535514 2.629688 0.9463605 -0.552143
#> 3    3 -1.407353 0.1419124 0.3535514 2.629688 0.9463605 -0.552143
#> 4    4  4.769928 4.9758685 4.2730527 2.707455 6.7037708  6.805558
#> 5    5  4.769928 4.9758685 4.2730527 2.707455 6.7037708  6.805558
#> 6    6  4.769928 4.9758685 4.2730527 2.707455 6.7037708  6.805558
```

We can also provide some subset of the original dataset rather than
using it all.

``` r
predict(modelFinal, newdata = simMVRM[c(1, 4, 7, 10, 21), ])
```

``` r-output
#>    plot     Yvalue Ytype
#> 1     1 -1.4073525  Y1:1
#> 2     1  0.3535514  Y2:1
#> 3     1  0.9463605  Y3:1
#> 4     4  4.7699282  Y1:1
#> 5     4  4.2730527  Y2:1
#> 6     4  6.7037708  Y3:1
#> 7     7  2.6653214  Y1:1
#> 8     7 -0.7655644  Y2:1
#> 9     7  3.3207690  Y3:1
#> 10   10 -0.8997879  Y1:1
#> 11   10  0.3252207  Y2:1
#> 12   10  4.9242752  Y3:1
#> 13   21  2.9732237  Y1:1
#> 14   21  3.9330478  Y2:1
#> 15   21  5.7183530  Y3:1
```

Or we can use a dataset which follows the same format as simMVRM but is
entirely new data. If no information is supplied for which ecosystem
functions or time points from which you wish to predict, then all will
be included automatically.

``` r
newSim <- data.frame(plot = c(1, 2),
                     p1 = c(0.25, 0.6),
                     p2 = c(0.25, 0.2),
                     p3 = c(0.25, 0.1),
                     p4 = c(0.25, 0.1)) 

predict(modelFinal, newdata = newSim)
```

``` r-output
#>    plot    Yvalue Ytype
#> 1     1  2.366443  Y1:1
#> 2     1 14.531716  Y1:2
#> 3     1  4.023354  Y2:1
#> 4     1  2.811557  Y2:2
#> 5     1  6.292853  Y3:1
#> 6     1 10.305704  Y3:2
#> 7     2  1.124742  Y1:1
#> 8     2 11.152407  Y1:2
#> 9     2  3.324757  Y2:1
#> 10    2  3.385953  Y2:2
#> 11    2  4.526481  Y3:1
#> 12    2  7.178993  Y3:2
```

Otherwise, only the ecosystem functions/time points specified will be
predicted from. As our dataset is in a wide format, we will need to
supply some arbitrary value to our desired ecosystem function column.

``` r
newSim <- data.frame(plot = c(1, 2),
                     p1 = c(0.25, 0.6),
                     p2 = c(0.25, 0.2),
                     p3 = c(0.25, 0.1),
                     p4 = c(0.25, 0.1),
                     Y1 = 0) 

predict(modelFinal, newdata = newSim)
```

``` r-output
#>   plot    Yvalue Ytype
#> 1    1  2.366443  Y1:1
#> 2    1 14.531716  Y1:2
#> 3    2  1.124742  Y1:1
#> 4    2 11.152407  Y1:2
```

In the case that some information is missing from this new data, the
function will try to set a value for the column and will inform the user
through a warning printed to the console.

``` r
newSim <- data.frame(p1 = c(0.25, 0.6),
                     p2 = c(0.25, 0.2),
                     p3 = c(0.25, 0.1),
                     p4 = c(0.25, 0.1)) 

predict(modelFinal, newdata = newSim)
```

``` r-output
#> Warning in predict.DImulti(modelFinal, newdata = newSim): The column containing
#> unit_IDs has not been supplied through newdata. This column is required as a
#> grouping factor for the covarying responses, although its value does not matter
#> as there is no between subject effect included. Defaulting to row numbers.
```

``` r-output
#>    plot    Yvalue Ytype
#> 1     1  2.366443  Y1:1
#> 2     1 14.531716  Y1:2
#> 3     1  4.023354  Y2:1
#> 4     1  2.811557  Y2:2
#> 5     1  6.292853  Y3:1
#> 6     1 10.305704  Y3:2
#> 7     2  1.124742  Y1:1
#> 8     2 11.152407  Y1:2
#> 9     2  3.324757  Y2:1
#> 10    2  3.385953  Y2:2
#> 11    2  4.526481  Y3:1
#> 12    2  7.178993  Y3:2
```

## Caution

### Merging predictions

You may wish to merge your predictions to your newdata dataframe for
plotting, printing, or further analysis. As the function DImulti(), and
as a consequence, the function predict.DImulti(), sorts the data it is
provided, to ensure proper labelling, you may not be able to directly
use cbind() to append the predictions to your dataset. In this case,
ensure the unit_IDs column contains unique identifiers for your data
rows and that you specify stacked to correctly match your data layout.
Then use the function merge().

``` r
newSim <- data.frame(plot = c(1, 2),
                     p1 = c(0.25, 0.6),
                     p2 = c(0.25, 0.2),
                     p3 = c(0.25, 0.1),
                     p4 = c(0.25, 0.1)) 

preds <- predict(modelFinal, newdata = newSim, stacked = FALSE)

merge(newSim, preds, by = "plot")
```

``` r-output
#>   plot   p1   p2   p3   p4     Y1:1     Y1:2     Y2:1     Y2:2     Y3:1
#> 1    1 0.25 0.25 0.25 0.25 2.366443 14.53172 4.023354 2.811557 6.292853
#> 2    2 0.60 0.20 0.10 0.10 1.124742 11.15241 3.324757 3.385953 4.526481
#>        Y3:2
#> 1 10.305704
#> 2  7.178993
```

### Non-unique unit_IDs

In the case that your newdata contains non-unique unit_IDs values and
stacked = FALSE, any rows with common unit_IDs will be aggregated using
the mean() function.

``` r
newSim <- data.frame(plot = c(1, 1),
                     p1 = c(0.25, 0.6),
                     p2 = c(0.25, 0.2),
                     p3 = c(0.25, 0.1),
                     p4 = c(0.25, 0.1)) 

predict(modelFinal, newdata = newSim, stacked = FALSE)
```

``` r-output
#>   plot     Y1:1     Y1:2     Y2:1     Y2:2     Y3:1     Y3:2
#> 1    1 1.745592 12.84206 3.674056 3.098755 5.409667 8.742349
```
