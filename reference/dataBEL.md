# The Belgium dataset

Single site dataset containing thirty experimental units (plots), with
four species seeded at two density levels, representing fifteen
communities. Three ecosystem function responses are recorded for each
plot at a single time point. Data is in a stacked format.

## Usage

``` r
data("dataBEL")
```

## Format

A data frame with 90 observations on the following 9 variables.

- `Plot`:

  a numeric vector indicating the ID of the experimental unit from which
  the observation was recorded

- `G1`:

  a numeric vector ranging from 0 to 1, the proportion of the species G1

- `G2`:

  a numeric vector ranging from 0 to 1, the proportion of the species G2

- `L1`:

  a numeric vector ranging from 0 to 1, the proportion of the species L1

- `L2`:

  a numeric vector ranging from 0 to 1, the proportion of the species L2

- `Density`:

  a vector of factors with two levels, -1 or 1, representing the seeding
  density of the plot

- `Var`:

  a character vector indicating the ecosystem function recorded

- `VarNum`:

  a vector of factors with three levels, 1, 2, or 3 indicating the
  ecosystem function recorded

- `Y`:

  a numeric vector indicating the value of the ecosystem function
  recorded

## Details

Data comes from a single site from a wider agrodiversity experiment
conducted in Belgium, established in 2002.  
The four species used were Lolium perenne (G1), Phleum pratense (G2),
Trifolium pratense (L1), and Trifolium repens (L2). There are two
recommended functional groupings: grouping grasses (G1, G2) and legumes
(L1, L2), or grouping fast-establishing species (G1, L1) and temporally
persistent species (G2, L2).  
Three ecosystem functions were recorded by summing recordings from four
harvests over the first year of the experiment: (1) aboveground biomass
of sown species (Sown) (t DM ha-1), (2) aboveground biomass of weed
species (Weed) (t DM ha-1) and (3) the total annual yield of nitrogen in
harvested aboveground biomass (N) (t DM ha-1).

## Source

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

#
# In this example, we repeat the analysis in Dooley et al. 2015.

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

# We can also retrieve the variance covariance matrix information from this object.

summary(belModel$corr[[1]])
#> Correlation Structure: General
#>  Formula: ~0 | Plot 
#>  Parameter estimate(s):
#>  Correlation: 
#>   1     2    
#> 2 0.797      
#> 3 0.065 0.523
nlme::getVarCov(belModel)
#> Marginal variance covariance matrix
#>            N   Sown     Weed
#> N    41.3320 36.716   5.8403
#> Sown 36.7160 51.407  52.2200
#> Weed  5.8403 52.220 193.7900
#>   Standard Deviations: 6.429 7.1699 13.921 

```
