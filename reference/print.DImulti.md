# print.DImulti

Print details of the fitted DI models supplied

## Usage

``` r
# S3 method for class 'DImulti'
print(x, ...)
```

## Arguments

- x:

  an object of class DImulti

- ...:

  some methods for this generic function require additional arguments.
  None are used in this method.

## Value

object x

## Details

The appearance of the printed information will differ depending on
whether a user has installed some combination of the suggested packages
"crayon", "cli", and "fansi". These changes are mainly cosmetic, with
crayon making the output easier to read, cli providing links to help
files, and fansi enabling the reading of special characters in R
markdown (Rmd) files. See 'Examples' below for suggested code to include
in Rmd files.

## See also

[`print`](https://rdrr.io/r/base/print.html) which this function wraps.

## Examples

``` r
## Set up for R markdown for crayon and cli output if user has packages installed

if(requireNamespace("fansi", quietly = TRUE) &
   requireNamespace("crayon", quietly = TRUE) &
   requireNamespace("cli", quietly = TRUE))
{
 options(crayon.enabled = TRUE)

 ansi_aware_handler <- function(x, options)
 {
  paste0(
    "<pre class=\"r-output\"><code>",
    fansi::sgr_to_html(x = x, warn = FALSE, term.cap = "256"),
    "</code></pre>"
  )
 }

 old_hooks <- fansi::set_knit_hooks(knitr::knit_hooks,
                                    which = c("output", "message", "error", "warning"))

 knitr::knit_hooks$set(
   output = ansi_aware_handler,
   message = ansi_aware_handler,
   warning = ansi_aware_handler,
   error = ansi_aware_handler
  )
 }
#> <STYLE type='text/css' scoped>
#> PRE.fansi SPAN {padding-top: .25em; padding-bottom: .25em};
#> </STYLE>
#################################################################################################

## Usage

model <- DImulti(prop = c("G1", "G2", "L1", "L2"), y = "Y", eco_func = c("Var", "un"),
                 unit_IDs = "Plot", theta = c(0.5, 1, 1.2), DImodel = "FG",
                 FG = c("Grass", "Grass", "Legume", "Legume"), extra_fixed = ~ Density,
                 method = "REML", data = dataBEL)

print(model)
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
```
