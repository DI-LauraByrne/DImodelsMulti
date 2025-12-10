# Multivariate Diversity-Interactions (DI) Models with Repeated Measures

This package is an add-on to the 'DImodels' package (Moral *et al.*,
2023). It enables the fitting of Diversity-Interactions (DI) models for
(1) univariate repeated measures responses(Finn *et al.*, 2013), (2)
multivariate responses at a single point in time (Dooley *et al.*,
2015), or (3) multivariate repeated measures responses. These responses
will come from a biodiversity and ecosystem function (BEF) relationship
study which aims to test the relationship between ecosystem functioning
and ecosystem design, including species identities, interactions, and
additional factors such as treatments and time. This data can be used to
construct a regression model through the main function of this package
[`DImulti`](https://di-laurabyrne.github.io/DImodelsMulti/reference/DImulti.md).  

## Details

**Data**  

This package is intended for use with data containing multiple ecosystem
function responses and/or time points from a biodiversity and ecosystem
function (BEF) relationship study. The dataset should contain a column
for each species' proportion, so that each row of these columns sum to
one. Each row of the data should also contain an identifier for the
experimental unit being referenced, these identifiers must be unique to
each experimental unit, but remain consistent over time and across
functions. For each experimental unit included there must be recordings
of either:  
- a single community level ecosystem function response variable taken at
multiple time points (repeated measures),  
- multiple community level ecosystem function responses (multivariate),
or  
- multiple community level ecosystem function responses taken at
multiple time points (multivariate repeated measures).  
Ecosystem functions may be stored in a long or wide format while
repeated measures must be stored in a long format.  
Additionally, by calling the function DImultiApp(), you can interact
with the provided R Shiny app, which aids in fitting and visualising
multivariate or repeated measures models through a user-friendly
interface.  

**Introduction to multivariate & repeated measures
Diversity-Interactions models**  

Diversity-Interactions (DI) models are a regression based approach to
modelling the biodiversity ecosystem function (BEF) relationship which
assumes that the main driver behind changes in ecosystem functioning is
the initial relative abundance (or proportions) of the species present.
These models can be estimated using least squares estimation methods.  
An example of a univariate DI model can be seen below,  
\$\$ y = \sum^{S}\_{i=1}{\beta\_{i} p\_{i}} + \sum^{S}\_{\substack{i,j=1
\\ i\<j}}{\delta\_{ij}(p\_{i}p\_{j})^{\theta} + \alpha A + \epsilon
}\$\$ where the response \\y\\ represents the recorded ecosystem
function, \\p\_{i}\\ represents the initial proportion of the \\i^{th}\\
species, therefore the \\p\\ values sum to 1 and form a simplex space,
and scales the ID effect of the species, \\\beta\_{i}\\; if no species
interactions or treatments are required in the model, the response \\y\\
is the weighted average of the species identity effects. \\S\\
represents the number of unique species present in the study. Similarly
to the ID effect, the interaction effect, \\\delta\\, between species is
scaled by some combination of the products of species proportions, which
depends on the interaction structure chosen. The example above shows the
full pairwise structure, which has a unique interaction term,
\\\delta\_{ij}\\, per pair of species \\i\\ & \\j\\. The nonlinear term
\\\theta\\ (Connolly *et al.*, 2013; Vishwakarma *et al.*, 2023) is
included in the model to allow the shape of the BEF relationship to
change. This parameter can be estimated using profile log-likelihood
optimisation (Brent, 1973) or can be assigned a set value based on an *a
priori* assumption/knowledge. \\A\\ may include blocks or treatment
terms, and \\\alpha\\ is a vector of the corresponding effect
coefficients.  
For further details of univariate DI modelling, see `?DImodels`, Kirwan
*et al.*, 2009, and Moral *et al.*, 2023.  

The multivariate DI model (Dooley *et al.*, 2015) extends the DI
modelling framework to allow for the estimation of multiple ecosystem
functions simultaneously, accounting for any existing covariance between
functions through the error term. These models can be further extended
through the introduction of repeated measures over multiple time
points.  
The structure for such models is: \$\$ y\_{kmt} =
\sum^{S}\_{i=1}{\beta\_{ikt} p\_{im}} + \sum^{S}\_{\substack{i,j=1 \\
i\<j}}{\delta\_{ijkt}(p\_{im}p\_{jm})^{\theta\_{k}}} + \alpha\_{kt}A +
\epsilon\_{kmt} \$\$

where \\y\_{kmt}\\ refers to the value of the \\k^{th}\\ ecosystem
function from the \\m^{th}\\ experimental unit at a time point \\t\\.
For an experimental unit \\m\\, \\\beta\_{ikt}\\ scaled by \\p\_{im}\\
is the expected contribution of the \\i^{th}\\ species to the \\k^{th}\\
response at time point \\t\\ and is referred to as the \\i^{th}\\
species' ID effect. The value of the nonlinear parameter \\\theta\\ is
allowed to vary between ecosystem functions, in turn allowing the fixed
effect structure to change across functions, in recognition that the
nature of the species interactions could change between ecosystem
functions.  

In the case that a dataset contains only a single ecosystem function,
the corresponding subscript \\k\\ can simply be removed from the
equation, the same can be said for the removal of the subscript \\t\\ in
the instance that a dataset contains a single time point.  

**The structure of the error term**  

For a univariate DI model, the error term is assumed to follow a normal
distribution with mean \\0\\ and variance \\\sigma^{2}\\. \$\$ \epsilon
\sim N(0, \sigma^{2})\$\$

When the model is extended to fit multivariate (\\k\>1\\) and/or
repeated measures (\\t\>1\\) data, the error term is now assumed to
follow a multivariate normal distribution with mean \\0\\ and variance
\\\Sigma^{\*}\\. \$\$ \epsilon \sim MVN(0, \Sigma^{\*}) \$\$
\\\Sigma^{\*}\\ is a block diagonal matrix, with one \\kt\\ x \\kt\\
block, \\\Sigma\\, for each experimental unit \\m\\. We refer to
\\\Sigma\\ as the variance covariance matrix for our ecosystem functions
and time points. Typically, it includes a unique variance per
combination of ecosystem functions and time points along the diagonal
and a unique covariance between each pair of combinations on the
off-diagonal. Autocorrelation structures may be implemented on the
matrix \\\Sigma\\, either to simplify the estimation process or based on
*a priori* knowledge. One structure is chosen for the ecosystem
functions and another for repeated measures/time points, the two
matrices are then estimated independently and combined using the
Kronecker product (\\\otimes\\), a matrix multiplication method. In the
case that the data is only multivariate (\\k\>1\\ & \\t=1\\) or only has
repeated measures (\\k=1\\ & \\t\>1\\), only one autocorrelation
structure needs to be chosen, with no multiplication necessary.  
Three such structures are currently available in this package for
repeated measures responses, and two are available for multivariate
responses:  

1.  **UN**: When each element of \\\Sigma\\ is set to estimate
    independently, it is said to be unstructured or follow the general
    structure and is the preferred option in the case that there is no a
    priori information on the nature of these relationships.
    [`corSymm`](https://rdrr.io/pkg/nlme/man/corSymm.html)  

2.  **CS**: A simpler structure is compound symmetry, where it is
    assumed that each ecosystem function or time point has the same
    variance value \\\sigma^{2}\\ and each pair has the same covariance
    value \\\sigma^{2}\rho\\. This structure is not preferred for use
    with multiple ecosystem functions as it provides no meaningful
    interpretation, however it is allowed in this package if the model
    requires simplification.
    [`corCompSymm`](https://rdrr.io/pkg/nlme/man/corCompSymm.html)  

3.  **AR(1)**: An autocorrelation structure exclusive to repeated
    measures data is an autoregressive model of order one, which assumes
    that, each time point has the same variance, \\\sigma^{2}\\, and as
    the distance in pairs of time points increases, the covariance
    between them changes by a factor of \\\rho\\.
    [`corAR1`](https://rdrr.io/pkg/nlme/man/corAR1.html)

## References

Vishwakarma, R., Byrne, L., Connolly, J., de Andrade Moral, R. and
Brophy, C., 2023.  
Estimation of the non-linear parameter in Generalised
Diversity-Interactions models is unaffected by change in structure of
the interaction terms.  
Environmental and Ecological Statistics, 30(3), pp.555-574.  

Moral, R.A., Vishwakarma, R., Connolly, J., Byrne, L., Hurley, C., Finn,
J.A. and Brophy, C., 2023.  
Going beyond richness: Modelling the BEF relationship using species
identity, evenness, richness and species interactions via the DImodels R
package.  
Methods in Ecology and Evolution, 14(9), pp.2250-2258.  

Dooley, A., Isbell, F., Kirwan, L., Connolly, J., Finn, J.A. and Brophy,
C., 2015.  
Testing the effects of diversity on ecosystem multifunctionality using a
multivariate model.  
Ecology Letters, 18(11), pp.1242-1251.  

Finn, J.A., Kirwan, L., Connolly, J., Sebastia, M.T., Helgadottir, A.,
Baadshaug, O.H., Belanger, G., Black, A., Brophy, C., Collins, R.P. and
Cop, J., 2013.  
Ecosystem function enhanced by combining four functional types of plant
species in intensively managed grassland mixtures: a 3-year
continental-scale field experiment.  
Journal of Applied Ecology, 50(2), pp.365-375 .  

Connolly, J., Bell, T., Bolger, T., Brophy, C., Carnus, T., Finn, J.A.,
Kirwan, L., Isbell, F., Levine, J., Luscher, A. and Picasso, V., 2013.  
An improved model to predict the effects of changing biodiversity levels
on ecosystem function.  
Journal of Ecology, 101(2), pp.344-355.  

Kirwan, L., Connolly, J., Finn, J.A., Brophy, C., Luscher, A., Nyfeler,
D. and Sebastia, M.T., 2009.  
Diversity-interaction modeling: estimating contributions of species
identities and interactions to ecosystem function.  
Ecology, 90(8), pp.2032-2038.  

Brent, R.P., 1973.  
Some efficient algorithms for solving systems of nonlinear equations.  
SIAM Journal on Numerical Analysis, 10(2), pp.327-344.  

## See also

This package:
[`DImulti`](https://di-laurabyrne.github.io/DImodelsMulti/reference/DImulti.md),
[`DImultiApp`](https://di-laurabyrne.github.io/DImodelsMulti/reference/DImultiApp.md)  
Example datasets:
[`dataBEL`](https://di-laurabyrne.github.io/DImodelsMulti/reference/dataBEL.md),
[`dataSWE`](https://di-laurabyrne.github.io/DImodelsMulti/reference/dataSWE.md),
[`simRM`](https://di-laurabyrne.github.io/DImodelsMulti/reference/simRM.md),
[`simMV`](https://di-laurabyrne.github.io/DImodelsMulti/reference/simMV.md),
[`simMVRM`](https://di-laurabyrne.github.io/DImodelsMulti/reference/simMVRM.md)  
Package family:
[`DImodels`](https://rdrr.io/pkg/DImodels/man/DImodels-package.html)`, `[`autoDI`](https://rdrr.io/pkg/DImodels/man/autoDI.html)`, `[`DI`](https://rdrr.io/pkg/DImodels/man/DI.html)`, `[`DI_data`](https://rdrr.io/pkg/DImodels/man/DI_data_manipulation.html)  
Modelling package: [`nlme`](https://rdrr.io/pkg/nlme/man/nlme.html),
[`gls`](https://rdrr.io/pkg/nlme/man/gls.html)

## Author

Laura Byrne \[aut, cre\], Rishabh Vishwakarma \[aut\], Rafael de Andrade
Moral \[aut\], Caroline Brophy \[aut\]  
  
Maintainer: Laura Byrne <byrnel54@tcd.ie>

## Examples

``` r
#################################################################################################
#################################################################################################
#> <STYLE type='text/css' scoped>
#> PRE.fansi SPAN {padding-top: .25em; padding-bottom: .25em};
#> </STYLE>

## Modelling Examples

# For a more thorough example of the workflow of this package, please see vignette
# DImulti_workflow using the following code:

# \donttest{
vignette("DImulti_workflow")
#> Warning: vignette ‘DImulti_workflow’ not found
# }

## The simMVRM dataset
#
# This simulated dataset contains multiple ecosystem functions (k=3) and multiple time points
# (t=2). The dataset was
# simulated using unstructured Sigma matrices.
# The true values can be found in the help file for the data, ?simMVRM

data(simMVRM)
head(simMVRM)
#>   plot p1 p2 p3 p4         Y1          Y2        Y3 time
#> 1    1  1  0  0  0 -3.2201614 -0.28424570 4.0353997    1
#> 2    2  1  0  0  0  0.2166701  0.90917719 0.1719544    1
#> 3    3  1  0  0  0 -2.1709989  0.04832118 0.6787839    1
#> 4    4  0  1  0  0  5.3908779  4.08309086 6.5332521    1
#> 5    5  0  1  0  0  5.2733174  4.29488262 6.2761877    1
#> 6    6  0  1  0  0  4.1985826  3.57457447 7.0207313    1

# We will start the analysis with a call to the package's main function, DImulti().
# We begin the call by specifying the column indices holding the initial species proportions
# (p_i) through 'prop' and the columns which hold the ecosystem response values through 'y'.
# Since our data is multivariate, we include the 'eco_func' parameter, specifying "na" as our
# data is in a wide format (multiple columns in 'y') and "un" to fit an unstructured Sigma
# for our ecosystem functions.
# The data also contains repeated measures, so we include the 'time' parameter, specifying "time"
# as the column containing the time point indicator for each row and "ar1" to fit an AR(1)
# autocorrelation structure for our time points.
# Next, we specify that the experimental unit identifier is in column 1 through 'unit_IDs'. We
# indicate that we do not want to estimate the non-linear parameter theta, but do not provide
# any values, opting for the default value of 1.
# We specify a full pairwise (FULL) interaction structure through 'DImodel' and estimate the
# model using maximum likelihood (ML) as we may compare models.
# Finally, we provide the data object simMVRM through 'data'.

simModel_FULL <- DImulti(prop = 2:5, y = 6:8, eco_func = c("na", "un"), time = c("time", "ar1"),
                         unit_IDs = 1, estimate_theta = FALSE, DImodel = "FULL", method = "ML",
                         data = simMVRM)

# simModel_FULL is an object of custom class DImulti, which can be used with a number of S3
# methods and any method compatible with gls objects. We use summary() to examine the model fit,
# including fixed effect coefficients and the variance covariance matrix Sigma.

print(simModel_FULL)
#> Note: 
#> Method Used = ML 
#> Correlation Structure Used = un@ar1
#>  Full Pairwise Model
#> Theta value(s) = 1
#> 
#> Generalized least squares fit by maximum likelihood
#>   Model: value ~ 0 + func:time:((p1_ID + p2_ID + p3_ID + p4_ID + FULL.p1.p2 +      FULL.p1.p3 + FULL.p1.p4 + FULL.p2.p3 + FULL.p2.p4 + FULL.p3.p4)) 
#>       AIC       BIC    logLik 
#>  7969.803  8311.945 -3923.902 
#> 
#>  Multivariate Correlation Structure: General
#>  Formula: ~0 | plot 
#>  Parameter estimate(s):
#>  Correlation: 
#>   1      2     
#> 2  0.612       
#> 3 -0.310 -0.360
#> 
#>  Repeated Measure Correlation Structure: AR(1)
#>  Formula: ~0 + as.numeric(time) | plot/func 
#>  Parameter estimate(s):
#>       Phi 
#> 0.3184991 
#> 
#> 
#> Table: Fixed Effect Coefficients
#> 
#>                           Beta      Std. Error   t-value   p-value     Signif 
#> ------------------------  --------  -----------  --------  ----------  -------
#> funcY1:time1:p1_ID        -1.750    0.535        -3.274    0.001078    **     
#> funcY2:time1:p1_ID        +0.399    0.535        0.747     0.4554             
#> funcY3:time1:p1_ID        +0.840    0.535        1.572     0.116              
#> funcY1:time2:p1_ID        +0.454    0.535        0.850     0.3955             
#> funcY2:time2:p1_ID        +3.122    0.535        5.840     6.095e-09   ***    
#> funcY3:time2:p1_ID        -0.533    0.535        -0.998    0.3186             
#> funcY1:time1:p2_ID        +5.054    0.458        11.029    1.751e-27   ***    
#> funcY2:time1:p2_ID        +4.458    0.458        9.730     7.004e-22   ***    
#> funcY3:time1:p2_ID        +6.544    0.458        14.281    4.378e-44   ***    
#> funcY1:time2:p2_ID        +5.009    0.458        10.933    4.79e-27    ***    
#> funcY2:time2:p2_ID        +2.706    0.458        5.907     4.108e-09   ***    
#> funcY3:time2:p2_ID        +6.663    0.458        14.542    1.442e-45   ***    
#> funcY1:time1:p3_ID        +2.764    0.534        5.177     2.483e-07   ***    
#> funcY2:time1:p3_ID        -0.622    0.534        -1.166    0.2439             
#> funcY3:time1:p3_ID        +3.171    0.534        5.939     3.388e-09   ***    
#> funcY1:time2:p3_ID        +4.114    0.534        7.706     2.046e-14   ***    
#> funcY2:time2:p3_ID        -3.673    0.534        -6.880    8.035e-12   ***    
#> funcY3:time2:p3_ID        +2.792    0.534        5.230     1.879e-07   ***    
#> funcY1:time1:p4_ID        -0.991    0.609        -1.629    0.1034             
#> funcY2:time1:p4_ID        -0.123    0.609        -0.203    0.8395             
#> funcY3:time1:p4_ID        +5.431    0.609        8.926     9.95e-19    ***    
#> funcY1:time2:p4_ID        -2.586    0.609        -4.251    2.233e-05   ***    
#> funcY2:time2:p4_ID        +1.808    0.609        2.971     0.003002    **     
#> funcY3:time2:p4_ID        +3.969    0.609        6.523     8.772e-11   ***    
#> funcY1:time1:FULL.p1.p2   +3.292    1.899        1.734     0.08309     +      
#> funcY2:time1:FULL.p1.p2   +7.657    1.899        4.033     5.726e-05   ***    
#> funcY3:time1:FULL.p1.p2   +6.776    1.899        3.569     0.0003675   ***    
#> funcY1:time2:FULL.p1.p2   +32.544   1.899        17.140    1.844e-61   ***    
#> funcY2:time2:FULL.p1.p2   +3.174    1.899        1.672     0.09473     +      
#> funcY3:time2:FULL.p1.p2   +19.498   1.899        10.269    3.949e-24   ***    
#> funcY1:time1:FULL.p1.p3   +3.232    1.955        1.653     0.09842     +      
#> funcY2:time1:FULL.p1.p3   +6.802    1.955        3.480     0.0005128   ***    
#> funcY3:time1:FULL.p1.p3   +7.057    1.955        3.610     0.0003136   ***    
#> funcY1:time2:FULL.p1.p3   +33.570   1.955        17.173    1.114e-61   ***    
#> funcY2:time2:FULL.p1.p3   +4.154    1.955        2.125     0.03371     *      
#> funcY3:time2:FULL.p1.p3   +19.103   1.955        9.772     4.697e-22   ***    
#> funcY1:time1:FULL.p1.p4   +4.977    2.231        2.231     0.0258      *      
#> funcY2:time1:FULL.p1.p4   +9.175    2.231        4.113     4.072e-05   ***    
#> funcY3:time1:FULL.p1.p4   +5.448    2.231        2.442     0.01469     *      
#> funcY1:time2:FULL.p1.p4   +34.133   2.231        15.301    5.257e-50   ***    
#> funcY2:time2:FULL.p1.p4   +3.481    2.231        1.560     0.1188             
#> funcY3:time2:FULL.p1.p4   +18.009   2.231        8.073     1.185e-15   ***    
#> funcY1:time1:FULL.p2.p3   +1.621    1.830        0.886     0.3757             
#> funcY2:time1:FULL.p2.p3   +6.701    1.830        3.662     0.0002567   ***    
#> funcY3:time1:FULL.p2.p3   +7.567    1.830        4.136     3.691e-05   ***    
#> funcY1:time2:FULL.p2.p3   +35.388   1.830        19.339    2.158e-76   ***    
#> funcY2:time2:FULL.p2.p3   +5.926    1.830        3.238     0.001222    **     
#> funcY3:time2:FULL.p2.p3   +20.525   1.830        11.217    2.422e-28   ***    
#> funcY1:time1:FULL.p2.p4   +1.686    1.953        0.863     0.3882             
#> funcY2:time1:FULL.p2.p4   +8.136    1.953        4.165     3.245e-05   ***    
#> funcY3:time1:FULL.p2.p4   +5.257    1.953        2.692     0.00717     **     
#> funcY1:time2:FULL.p2.p4   +33.761   1.953        17.285    2.081e-62   ***    
#> funcY2:time2:FULL.p2.p4   +5.241    1.953        2.683     0.007352    **     
#> funcY3:time2:FULL.p2.p4   +17.665   1.953        9.044     3.533e-19   ***    
#> funcY1:time1:FULL.p3.p4   +3.364    2.104        1.599     0.11               
#> funcY2:time1:FULL.p3.p4   +9.872    2.104        4.692     2.898e-06   ***    
#> funcY3:time1:FULL.p3.p4   +4.387    2.104        2.085     0.0372      *      
#> funcY1:time2:FULL.p3.p4   +35.150   2.104        16.705    1.149e-58   ***    
#> funcY2:time2:FULL.p3.p4   +6.951    2.104        3.304     0.0009714   ***    
#> funcY3:time2:FULL.p3.p4   +18.366   2.104        8.729     5.416e-18   ***    
#> 
#> Signif codes: 0-0.001 '***', 0.001-0.01 '**', 0.01-0.05 '*', 0.05-0.1 '+', 0.1-1.0 ' '
#> 
#> Degrees of freedom: 2016 total; 1956 residual
#> Residual standard error: 1.931155 
#> 
#> $Multivariate
#> Marginal variance covariance matrix
#>         [,1]    [,2]    [,3]
#> [1,]  4.8157  2.3236 -1.3479
#> [2,]  2.3236  2.9908 -1.2351
#> [3,] -1.3479 -1.2351  3.9281
#>   Standard Deviations: 2.1945 1.7294 1.982 
#> 
#> $`Repeated Measure`
#> Marginal variance covariance matrix
#>        [,1]   [,2]
#> [1,] 4.5364 1.4449
#> [2,] 1.4449 4.5364
#>   Standard Deviations: 2.1299 2.1299 
#> 
#> $Combined
#> Marginal variance covariance matrix
#>          Y1:1     Y1:2     Y2:1     Y2:2     Y3:1     Y3:2
#> Y1:1  3.72940  1.18780  2.28330  0.72724 -1.15570 -0.36810
#> Y1:2  1.18780  3.72940  0.72724  2.28330 -0.36810 -1.15570
#> Y2:1  2.28330  0.72724  3.72940  1.18780 -1.34380 -0.42801
#> Y2:2  0.72724  2.28330  1.18780  3.72940 -0.42801 -1.34380
#> Y3:1 -1.15570 -0.36810 -1.34380 -0.42801  3.72940  1.18780
#> Y3:2 -0.36810 -1.15570 -0.42801 -1.34380  1.18780  3.72940
#>   Standard Deviations: 1.9312 1.9312 1.9312 1.9312 1.9312 1.9312 
#> 

# From this summary, we can see that there are many coefficients, a number of which are not
# statistically significant at an
# alpha level of 0.05, therefore this model may not be ideal for our data. We refit the model
# using an average interaction structure instead as it reduces the number of interaction terms
# to 1 per ecosystem function and time point.

simModel_AV <- DImulti(prop = 2:5, y = 6:8, eco_func = c("na", "un"), time = c("time", "ar1"),
                       unit_IDs = 1, estimate_theta = FALSE, DImodel = "AV", method = "ML",
                       data = simMVRM)
print(simModel_AV)
#> Note: 
#> Method Used = ML 
#> Correlation Structure Used = un@ar1
#>  Average Term Model
#> Theta value(s) = 1
#> 
#> Generalized least squares fit by maximum likelihood
#>   Model: value ~ 0 + func:time:((p1_ID + p2_ID + p3_ID + p4_ID + AV)) 
#>       AIC       BIC    logLik 
#>  7921.064  8094.939 -3929.532 
#> 
#>  Multivariate Correlation Structure: General
#>  Formula: ~0 | plot 
#>  Parameter estimate(s):
#>  Correlation: 
#>   1      2     
#> 2  0.612       
#> 3 -0.310 -0.364
#> 
#>  Repeated Measure Correlation Structure: AR(1)
#>  Formula: ~0 + as.numeric(time) | plot/func 
#>  Parameter estimate(s):
#>       Phi 
#> 0.3161191 
#> 
#> 
#> Table: Fixed Effect Coefficients
#> 
#>                      Beta      Std. Error   t-value   p-value      Signif 
#> -------------------  --------  -----------  --------  -----------  -------
#> funcY1:time1:p1_ID   -1.407    0.402        -3.505    0.0004663    ***    
#> funcY2:time1:p1_ID   +0.354    0.402        0.881     0.3787              
#> funcY3:time1:p1_ID   +0.946    0.402        2.357     0.01852      *      
#> funcY1:time2:p1_ID   +0.142    0.402        0.353     0.7238              
#> funcY2:time2:p1_ID   +2.630    0.402        6.550     7.324e-11    ***    
#> funcY3:time2:p1_ID   -0.552    0.402        -1.375    0.1692              
#> funcY1:time1:p2_ID   +4.770    0.372        12.825    3.103e-36    ***    
#> funcY2:time1:p2_ID   +4.273    0.372        11.489    1.258e-29    ***    
#> funcY3:time1:p2_ID   +6.704    0.372        18.025    2.163e-67    ***    
#> funcY1:time2:p2_ID   +4.976    0.372        13.379    3.759e-39    ***    
#> funcY2:time2:p2_ID   +2.707    0.372        7.280     4.793e-13    ***    
#> funcY3:time2:p2_ID   +6.806    0.372        18.299    3.007e-69    ***    
#> funcY1:time1:p3_ID   +2.665    0.404        6.603     5.17e-11     ***    
#> funcY2:time1:p3_ID   -0.766    0.404        -1.896    0.05804      +      
#> funcY3:time1:p3_ID   +3.321    0.404        8.226     3.45e-16     ***    
#> funcY1:time2:p3_ID   +4.394    0.404        10.884    7.756e-27    ***    
#> funcY2:time2:p3_ID   -3.350    0.404        -8.299    1.913e-16    ***    
#> funcY3:time2:p3_ID   +3.008    0.404        7.452     1.362e-13    ***    
#> funcY1:time1:p4_ID   -0.900    0.453        -1.984    0.04736      *      
#> funcY2:time1:p4_ID   +0.325    0.453        0.717     0.4733              
#> funcY3:time1:p4_ID   +4.924    0.453        10.860    9.948e-27    ***    
#> funcY1:time2:p4_ID   -2.504    0.453        -5.523    3.779e-08    ***    
#> funcY2:time2:p4_ID   +2.019    0.453        4.453     8.941e-06    ***    
#> funcY3:time2:p4_ID   +3.544    0.453        7.817     8.734e-15    ***    
#> funcY1:time1:AV      +2.892    0.984        2.938     0.003339     **     
#> funcY2:time1:AV      +7.938    0.984        8.066     1.246e-15    ***    
#> funcY3:time1:AV      +6.184    0.984        6.284     4.055e-10    ***    
#> funcY1:time2:AV      +34.080   0.984        34.628    5.753e-206   ***    
#> funcY2:time2:AV      +4.827    0.984        4.904     1.014e-06    ***    
#> funcY3:time2:AV      +18.944   0.984        19.249    7.598e-76    ***    
#> 
#> Signif codes: 0-0.001 '***', 0.001-0.01 '**', 0.01-0.05 '*', 0.05-0.1 '+', 0.1-1.0 ' '
#> 
#> Degrees of freedom: 2016 total; 1986 residual
#> Residual standard error: 1.936361 
#> 
#> $Multivariate
#> Marginal variance covariance matrix
#>         [,1]    [,2]    [,3]
#> [1,]  4.8390  2.3374 -1.3561
#> [2,]  2.3374  3.0147 -1.2559
#> [3,] -1.3561 -1.2559  3.9495
#>   Standard Deviations: 2.1998 1.7363 1.9873 
#> 
#> $`Repeated Measure`
#> Marginal variance covariance matrix
#>        [,1]   [,2]
#> [1,] 4.5575 1.4407
#> [2,] 1.4407 4.5575
#>   Standard Deviations: 2.1348 2.1348 
#> 
#> $Combined
#> Marginal variance covariance matrix
#>          Y1:1     Y1:2     Y2:1     Y2:2     Y3:1     Y3:2
#> Y1:1  3.74950  1.18530  2.29460  0.72537 -1.16310 -0.36768
#> Y1:2  1.18530  3.74950  0.72537  2.29460 -0.36768 -1.16310
#> Y2:1  2.29460  0.72537  3.74950  1.18530 -1.36470 -0.43139
#> Y2:2  0.72537  2.29460  1.18530  3.74950 -0.43139 -1.36470
#> Y3:1 -1.16310 -0.36768 -1.36470 -0.43139  3.74950  1.18530
#> Y3:2 -0.36768 -1.16310 -0.43139 -1.36470  1.18530  3.74950
#>   Standard Deviations: 1.9364 1.9364 1.9364 1.9364 1.9364 1.9364 
#> 

# This model looks like it is a better fit, with less insignificant terms, but we can test this
# formally using a likelihood ratio test, as the DImodels interaction structures are nested in
# nature (with the exception of "ADD" and "FG", which are on the same level in the nesting
# hierarchy).
# This will test the null hypothesis that the likelihood of the two models do not significantly
# differ, in other words, the added parameters of the more complex model are not worth it.

anova(simModel_FULL, simModel_AV)
#>               Model df      AIC      BIC    logLik   Test  L.Ratio p-value
#> simModel_FULL     1 61 7969.803 8311.945 -3923.902                        
#> simModel_AV       2 31 7921.064 8094.939 -3929.532 1 vs 2 11.26025  0.9992

# As the p-value is greater than our selected alpha value (0.05), we fail to reject the null
# hypothesis and so continue with the simpler model, simModel_AV.
# We can confirm this result by using information criteria such as AIC or BIC.
# We select the model with the lower value as it indicates a better fit.
# We use the second order versions of AIC and BIC (AICc and BICc) as we have a large number of
# terms, which can cause AIC and BIC to favour more complex models.

AICc(simModel_FULL); AICc(simModel_AV)
#> [1] 7975.676
#> [1] 7924.065
BICc(simModel_FULL); BICc(simModel_AV)
#> [1] 8326.672
#> [1] 8098.743

# We refit our chosen model using the REML estimation method to have unbiased estimates.

simModel_AV <- DImulti(prop = 2:5, y = 6:8, eco_func = c("na", "un"), time = c("time", "ar1"),
                       unit_IDs = 1, estimate_theta = FALSE, DImodel = "AV", method = "REML",
                       data = simMVRM)

# We can now examine the variance covariance matrix, Sigma, and the fixed effect coefficients,
# which can be retrieved from our initial summary() check or individually.

coef(simModel_AV)
#> funcY1:time1:p1_ID funcY2:time1:p1_ID funcY3:time1:p1_ID funcY1:time2:p1_ID 
#>         -1.4073525          0.3535514          0.9463605          0.1419124 
#> funcY2:time2:p1_ID funcY3:time2:p1_ID funcY1:time1:p2_ID funcY2:time1:p2_ID 
#>          2.6296879         -0.5521430          4.7699282          4.2730527 
#> funcY3:time1:p2_ID funcY1:time2:p2_ID funcY2:time2:p2_ID funcY3:time2:p2_ID 
#>          6.7037708          4.9758685          2.7074546          6.8055585 
#> funcY1:time1:p3_ID funcY2:time1:p3_ID funcY3:time1:p3_ID funcY1:time2:p3_ID 
#>          2.6653214         -0.7655644          3.3207690          4.3935222 
#> funcY2:time2:p3_ID funcY3:time2:p3_ID funcY1:time1:p4_ID funcY2:time1:p4_ID 
#>         -3.3501635          3.0082933         -0.8997879          0.3252207 
#> funcY3:time1:p4_ID funcY1:time2:p4_ID funcY2:time2:p4_ID funcY3:time2:p4_ID 
#>          4.9242752         -2.5041979          2.0191631          3.5443872 
#>    funcY1:time1:AV    funcY2:time1:AV    funcY3:time1:AV    funcY1:time2:AV 
#>          2.8917739          7.9381038          6.1841587         34.0798392 
#>    funcY2:time2:AV    funcY3:time2:AV 
#>          4.8267227         18.9444801 
simModel_AV$vcov
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

# An example of what we can infer from this is that ecosystem functions Y1 and Y2 have a positive
# covariance at time 1, while Y3 has a negative covariance with both Y1 and Y2 at the same time
# point. This means that maximising Y1 would not negatively impact Y2 but it would be at the cost
# of Y3. However, as our interaction term is positive and significant at this time point for all
# three ecosystem functions, we should be able to include a mixture of species that have positive
# ID effects for each response to help mitigate this trade-off.
# We can also predict from the model if we want to compare responses from different conditions,
# even those not included in the original data.

predict(simModel_AV, newdata = simMVRM[which(simMVRM$plot == 1:2), ])
#>    plot     Yvalue Ytype
#> 1     1 -1.4073525  Y1:1
#> 2     1  0.1419124  Y1:2
#> 3     1  0.3535514  Y2:1
#> 4     1  2.6296879  Y2:2
#> 5     1  0.9463605  Y3:1
#> 6     1 -0.5521430  Y3:2
#> 7     2 -1.4073525  Y1:1
#> 8     2  0.1419124  Y1:2
#> 9     2  0.3535514  Y2:1
#> 10    2  2.6296879  Y2:2
#> 11    2  0.9463605  Y3:1
#> 12    2 -0.5521430  Y3:2


#################################################################################################
## The Belgium dataset
#
# This real world dataset contains multiple ecosystem functions (k=3) at a single time point
# (t=1). The dataset also contains seeding density as a treatment in the form of a factor with
# two levels (1, -1). More detail can be found at ?dataBEL.

data(dataBEL)
head(dataBEL)
#>   Plot  G1  G2  L1  L2 Density  Var VarNum       Y
#> 1    1 0.7 0.1 0.1 0.1       1 Sown      1 104.156
#> 2    1 0.7 0.1 0.1 0.1       1 Weed      2 100.058
#> 3    1 0.7 0.1 0.1 0.1       1    N      3  87.996
#> 4    2 0.1 0.7 0.1 0.1       1 Sown      1  82.547
#> 5    2 0.1 0.7 0.1 0.1       1 Weed      2  89.801
#> 6    2 0.1 0.7 0.1 0.1       1    N      3  72.239

# We begin with the main function DImulti(), passing the initial species proportions column names
# through 'prop' and the response value column name through 'y'.
# As the data is in a long or stacked format, we specify the ecosystem function type through the
# first index of the 'eco_func' parameter, along with specifying that we want an unstructured
# Sigma for these response types.
# The experimental unit ID is stored in the column "Plot" and so we pass this to 'unit_IDs'.
# Rather than estimating the nonlinear parameter theta, we opt to provide a value for each
# ecosystem function type through the parameter 'theta', which will be applied to the
# interaction terms as a power. In this case, we use functional group (FG) interactions, which
# requires an additional argument FG to be provided, specifying which group each species present
# in 'prop' belongs to. In this case, we group the grasses and the legumes.
# We include the treatment Density as an additional fixed effect.
# We opt to use the REML estimation method as we will not be doing any model comparisons.
# Finally, we specify the data object, dataBEL, through 'data'.

belModel <- DImulti(prop = c("G1", "G2", "L1", "L2"), y = "Y", eco_func = c("Var", "un"),
                    unit_IDs = "Plot", theta = c(0.5, 1, 1.2), DImodel = "FG",
                    FG = c("Grass", "Grass", "Legume", "Legume"), extra_fixed = ~ Density,
                    method = "REML", data = dataBEL)

# We can now print the output from our model, stored in belModel with class DImulti.

print(belModel)
#> Note: 
#> Method Used = REML 
#> Correlation Structure Used = un
#>  Functional Group Model
#> Theta value(s) = N:0.5, Sown:1, Weed:1.2
#> 
#> Generalized least squares fit by REML
#>   Model: Y ~ 0 + Var:((G1_ID + G2_ID + L1_ID + L2_ID + FG.bfg_Grass_Legume +      FG.wfg_Grass + FG.wfg_Legume) + Density) 
#>       AIC       BIC    logLik 
#>  488.8132  554.5029 -214.4066 
#> 
#>  Multivariate Correlation Structure: General
#>  Formula: ~0 | Plot 
#>  Parameter estimate(s):
#>  Correlation: 
#>   1     2    
#> 2 0.797      
#> 3 0.065 0.523
#> 
#> 
#> Table: Fixed Effect Coefficients
#> 
#>                               Beta       Std. Error   t-value   p-value     Signif 
#> ----------------------------  ---------  -----------  --------  ----------  -------
#> VarN:G1_ID                    +44.867    4.209        10.661    5.433e-16   ***    
#> VarSown:G1_ID                 +65.337    4.656        14.033    1.745e-21   ***    
#> VarWeed:G1_ID                 +79.372    9.039        8.781     1.065e-12   ***    
#> VarN:G2_ID                    +28.926    4.209        6.873     2.722e-09   ***    
#> VarSown:G2_ID                 +46.808    4.656        10.053    6.096e-15   ***    
#> VarWeed:G2_ID                 +90.654    9.039        10.029    6.706e-15   ***    
#> VarN:L1_ID                    +98.246    4.209        23.344    1.322e-33   ***    
#> VarSown:L1_ID                 +76.396    4.656        16.408    5.561e-25   ***    
#> VarWeed:L1_ID                 +50.032    9.039        5.535     5.782e-07   ***    
#> VarN:L2_ID                    +77.067    4.209        18.312    1.438e-27   ***    
#> VarSown:L2_ID                 +51.062    4.656        10.967    1.629e-16   ***    
#> VarWeed:L2_ID                 +33.951    9.039        3.756     0.0003674   ***    
#> VarN:FG.bfg_Grass_Legume      +14.538    13.281       1.095     0.2777             
#> VarSown:FG.bfg_Grass_Legume   +86.492    18.699       4.625     1.796e-05   ***    
#> VarWeed:FG.bfg_Grass_Legume   +152.157   49.542       3.071     0.003095    **     
#> VarN:FG.wfg_Grass             +58.483    28.072       2.083     0.0411      *      
#> VarSown:FG.wfg_Grass          +107.670   41.360       2.603     0.0114      *      
#> VarWeed:FG.wfg_Grass          -9.702     108.079      -0.090    0.9287             
#> VarN:FG.wfg_Legume            -16.215    28.072       -0.578    0.5655             
#> VarSown:FG.wfg_Legume         +60.847    41.360       1.471     0.146              
#> VarWeed:FG.wfg_Legume         +242.472   108.079      2.243     0.02823     *      
#> VarN:Density1                 -1.261     2.348        -0.537    0.593              
#> VarSown:Density1              +2.290     2.618        0.875     0.3849             
#> VarWeed:Density1              +0.991     5.083        0.195     0.846              
#> 
#> Signif codes: 0-0.001 '***', 0.001-0.01 '**', 0.01-0.05 '*', 0.05-0.1 '+', 0.1-1.0 ' '
#> 
#> Degrees of freedom: 90 total; 66 residual
#> Residual standard error: 6.428977 
#> 
#> Marginal variance covariance matrix
#>            N   Sown     Weed
#> N    41.3320 36.716   5.8403
#> Sown 36.7160 51.407  52.2200
#> Weed  5.8403 52.220 193.7900
#>   Standard Deviations: 6.429 7.1699 13.921 


#################################################################################################
## The Sweden dataset
#
# This real-world dataset contains a single ecosystem function read at multiple time points
# (k=1 & t=3). The data contains two treatments, TREAT and DENS, each with two levels
# 1 & 2 and High & Low, respectively.
# More details can be found at ?dataSWE

data(dataSWE)
head(dataSWE)
#>   YEARN PLOT TREAT DENS   G1   G2   L1   L2     YIELD
#> 1     1    1     1 High 0.70 0.10 0.10 0.10  7.774822
#> 2     1    2     1 High 0.10 0.70 0.10 0.10 10.302994
#> 3     1    3     1 High 0.10 0.10 0.70 0.10 12.643246
#> 4     1    4     1 High 0.10 0.10 0.10 0.70 12.174211
#> 5     1    5     1 High 0.25 0.25 0.25 0.25  9.063782
#> 6     1    6     1 High 0.40 0.40 0.10 0.10  9.148516

# We transform the "YEARN" column to factors to better act as groups in our models, giving us a
# coefficient per year number as opposed to acting as a continuous scaling factor.

dataSWE$YEARN <- as.factor(dataSWE$YEARN)

# We use the DImulti() function to fit a repeated measures DI model to this data.
# We specify the column indices 5 through 8 for our initial species proportions and the response
# value column name "YIELD".
# As there are multiple time points (repeated measures), we use the parameter 'time', providing
# the column name containing the time identifier through the first index and the desired Sigma
# structure (compound symmetry) through the second.
# The experimental unit ID is stored in column index two, which is passed through 'unit_IDs'.
# The interaction structure chosen is the average interaction term, "AV".
# We include both of the treatment terms, TREAT and DENS, as extra fixed effects crossed with
# each ID effect, the interaction effect, and with each other.
# We opt to use the REML
# estimation method for the model as we will not be doing any model comparisons.
# Finally, we specify the data object, dataSWE, through 'data'

SWEmodel <- DImulti(prop = 5:8, y = c("YIELD"), time = c("YEARN", "CS"),
                    unit_IDs = 2, DImodel = "AV", extra_fixed = ~ 1:(TREAT:DENS),
                    method = "REML", data = dataSWE)

print(SWEmodel)
#> Note: 
#> Method Used = REML 
#> Correlation Structure Used = CS
#>  Average Term Model
#> Theta value(s) = 1
#> 
#> Generalized least squares fit by REML
#>   Model: YIELD ~ 0 + YEARN:((G1_ID + G2_ID + L1_ID + L2_ID + AV):(TREAT:DENS)) 
#>       AIC       BIC    logLik 
#>  386.0460  536.7567 -131.0230 
#> 
#>  Repeated Measure Correlation Structure: Compound symmetry
#>  Formula: ~0 | PLOT 
#>  Parameter estimate(s):
#>       Rho 
#> 0.5934898 
#> 
#> 
#> Table: Fixed Effect Coefficients
#> 
#>                                Beta      Std. Error   t-value   p-value     Signif 
#> -----------------------------  --------  -----------  --------  ----------  -------
#> YEARN1:G1_ID:TREAT1:DENSHigh   +7.247    1.103        6.569     3.998e-09   ***    
#> YEARN2:G1_ID:TREAT1:DENSHigh   +4.404    1.103        3.992     0.0001397   ***    
#> YEARN3:G1_ID:TREAT1:DENSHigh   +2.749    1.103        2.492     0.01467     *      
#> YEARN1:G1_ID:TREAT2:DENSHigh   +10.605   1.155        9.185     2.52e-14    ***    
#> YEARN2:G1_ID:TREAT2:DENSHigh   +7.905    1.155        6.847     1.159e-09   ***    
#> YEARN3:G1_ID:TREAT2:DENSHigh   +6.164    1.155        5.339     7.82e-07    ***    
#> YEARN1:G1_ID:TREAT1:DENSLow    +7.564    1.103        6.856     1.111e-09   ***    
#> YEARN2:G1_ID:TREAT1:DENSLow    +3.748    1.103        3.397     0.001042    **     
#> YEARN3:G1_ID:TREAT1:DENSLow    +2.861    1.103        2.593     0.01122     *      
#> YEARN1:G1_ID:TREAT2:DENSLow    +9.509    1.155        8.236     2.041e-12   ***    
#> YEARN2:G1_ID:TREAT2:DENSLow    +7.103    1.155        6.152     2.498e-08   ***    
#> YEARN3:G1_ID:TREAT2:DENSLow    +5.447    1.155        4.717     9.422e-06   ***    
#> YEARN1:G2_ID:TREAT1:DENSHigh   +7.412    1.103        6.719     2.057e-09   ***    
#> YEARN2:G2_ID:TREAT1:DENSHigh   +5.286    1.103        4.792     7.052e-06   ***    
#> YEARN3:G2_ID:TREAT1:DENSHigh   +4.293    1.103        3.891     0.0001991   ***    
#> YEARN1:G2_ID:TREAT2:DENSHigh   +12.244   1.155        10.605    3.611e-17   ***    
#> YEARN2:G2_ID:TREAT2:DENSHigh   +11.280   1.155        9.770     1.679e-15   ***    
#> YEARN3:G2_ID:TREAT2:DENSHigh   +9.434    1.155        8.170     2.763e-12   ***    
#> YEARN1:G2_ID:TREAT1:DENSLow    +7.629    1.103        6.915     8.518e-10   ***    
#> YEARN2:G2_ID:TREAT1:DENSLow    +6.194    1.103        5.614     2.489e-07   ***    
#> YEARN3:G2_ID:TREAT1:DENSLow    +4.791    1.103        4.343     3.907e-05   ***    
#> YEARN1:G2_ID:TREAT2:DENSLow    +12.185   1.155        10.553    4.579e-17   ***    
#> YEARN2:G2_ID:TREAT2:DENSLow    +10.478   1.155        9.075     4.198e-14   ***    
#> YEARN3:G2_ID:TREAT2:DENSLow    +9.152    1.155        7.926     8.516e-12   ***    
#> YEARN1:L1_ID:TREAT1:DENSHigh   +9.475    1.103        8.589     3.99e-13    ***    
#> YEARN2:L1_ID:TREAT1:DENSHigh   +7.245    1.103        6.567     4.027e-09   ***    
#> YEARN3:L1_ID:TREAT1:DENSHigh   +3.269    1.103        2.963     0.003964    **     
#> YEARN1:L1_ID:TREAT2:DENSHigh   +11.322   1.155        9.806     1.422e-15   ***    
#> YEARN2:L1_ID:TREAT2:DENSHigh   +9.371    1.155        8.116     3.552e-12   ***    
#> YEARN3:L1_ID:TREAT2:DENSHigh   +5.873    1.155        5.086     2.19e-06    ***    
#> YEARN1:L1_ID:TREAT1:DENSLow    +8.150    1.103        7.388     1.005e-10   ***    
#> YEARN2:L1_ID:TREAT1:DENSLow    +5.371    1.103        4.868     5.223e-06   ***    
#> YEARN3:L1_ID:TREAT1:DENSLow    +3.773    1.103        3.420     0.0009678   ***    
#> YEARN1:L1_ID:TREAT2:DENSLow    +10.581   1.155        9.164     2.773e-14   ***    
#> YEARN2:L1_ID:TREAT2:DENSLow    +8.815    1.155        7.634     3.255e-11   ***    
#> YEARN3:L1_ID:TREAT2:DENSLow    +6.277    1.155        5.436     5.23e-07    ***    
#> YEARN1:L2_ID:TREAT1:DENSHigh   +8.638    1.103        7.829     1.33e-11    ***    
#> YEARN2:L2_ID:TREAT1:DENSHigh   +7.772    1.103        7.045     4.749e-10   ***    
#> YEARN3:L2_ID:TREAT1:DENSHigh   +5.782    1.103        5.241     1.169e-06   ***    
#> YEARN1:L2_ID:TREAT2:DENSHigh   +8.531    1.155        7.389     9.999e-11   ***    
#> YEARN2:L2_ID:TREAT2:DENSHigh   +8.047    1.155        6.969     6.685e-10   ***    
#> YEARN3:L2_ID:TREAT2:DENSHigh   +6.793    1.155        5.883     7.949e-08   ***    
#> YEARN1:L2_ID:TREAT1:DENSLow    +8.184    1.103        7.418     8.741e-11   ***    
#> YEARN2:L2_ID:TREAT1:DENSLow    +7.295    1.103        6.613     3.297e-09   ***    
#> YEARN3:L2_ID:TREAT1:DENSLow    +6.697    1.103        6.070     3.555e-08   ***    
#> YEARN1:L2_ID:TREAT2:DENSLow    +8.235    1.155        7.132     3.201e-10   ***    
#> YEARN2:L2_ID:TREAT2:DENSLow    +8.091    1.155        7.007     5.634e-10   ***    
#> YEARN3:L2_ID:TREAT2:DENSLow    +7.256    1.155        6.285     1.401e-08   ***    
#> YEARN1:AV:TREAT1:DENSHigh      +8.000    2.405        3.326     0.001307    **     
#> YEARN2:AV:TREAT1:DENSHigh      +14.532   2.405        6.042     4.02e-08    ***    
#> YEARN3:AV:TREAT1:DENSHigh      +16.668   2.405        6.930     7.959e-10   ***    
#> YEARN1:AV:TREAT2:DENSHigh      +10.452   3.124        3.346     0.001228    **     
#> YEARN2:AV:TREAT2:DENSHigh      +15.438   3.124        4.942     3.895e-06   ***    
#> YEARN3:AV:TREAT2:DENSHigh      +15.672   3.124        5.017     2.888e-06   ***    
#> YEARN1:AV:TREAT1:DENSLow       +7.187    2.405        2.988     0.003678    **     
#> YEARN2:AV:TREAT1:DENSLow       +16.129   2.405        6.706     2.172e-09   ***    
#> YEARN3:AV:TREAT1:DENSLow       +15.116   2.405        6.285     1.398e-08   ***    
#> YEARN1:AV:TREAT2:DENSLow       +10.213   3.124        3.269     0.001563    **     
#> YEARN2:AV:TREAT2:DENSLow       +15.793   3.124        5.056     2.473e-06   ***    
#> YEARN3:AV:TREAT2:DENSLow       +14.843   3.124        4.752     8.23e-06    ***    
#> 
#> Signif codes: 0-0.001 '***', 0.001-0.01 '**', 0.01-0.05 '*', 0.05-0.1 '+', 0.1-1.0 ' '
#> 
#> Degrees of freedom: 144 total; 84 residual
#> Residual standard error: 1.299215 
#> 
#> Marginal variance covariance matrix
#>        1      2      3
#> 1 1.6880 1.0018 1.0018
#> 2 1.0018 1.6880 1.0018
#> 3 1.0018 1.0018 1.6880
#>   Standard Deviations: 1.2992 1.2992 1.2992 

```
