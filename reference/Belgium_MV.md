# The multivariate Belgium dataset

Single site dataset containing thirty experimental units (plots), with
four species seeded at two density levels, representing fifteen
communities. Three ecosystem function responses are recorded for each
plot in a single year. The responses have been linearly transformed to
lie on the same scale. Data is in a stacked format.

## Usage

``` r
data("Belgium_MV")
```

## Format

A data frame with 150 observations on the following 9 variables.

- `YEARN`:

  a numeric vector indicating the time point (year) that the ecosystem
  function recording was measured at

- `PLOT`:

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

- `DENS`:

  a vector of factors with two levels, -1 or 1, representing the seeding
  density of the plot

- `Var`:

  a character vector indicating the ecosystem function recorded

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
Three ecosystem functions were recorded by summing recordings from
multiple harvests over the years of of the experiment: (1) aboveground
biomass of sown species (Sown) (t DM ha-1), (2) aboveground biomass of
weed species (Weed) (t DM ha-1) and (3) the total annual yield of
nitrogen in harvested aboveground biomass (N) (t DM ha-1). A linear
transformation on the response was applied to the value 'Y', where they
now represent a percentage of the top 10% of recorded values for each
function, i.e., each response was multiplied by 100, then divided by the
mean of the top three readings.  
This dataset was extracted from the dataset 'Belgium'.

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
#How to extra and transform the data from the 'Belgium' dataset

## Libraries ################################################
library(reshape2)
library(dplyr)
#> 
#> Attaching package: ‘dplyr’
#> The following objects are masked from ‘package:stats’:
#> 
#>     filter, lag
#> The following objects are masked from ‘package:base’:
#> 
#>     intersect, setdiff, setequal, union
library(DImodelsMulti)
#############################################################
## Read in data##################################
data("Belgium")

Belgium_MV <- Belgium[which(Belgium$YEARN == 3), ]

#Top 3 values for each ecosystem function
top <- Belgium_MV %>%
  arrange(desc(Y)) %>%
  group_by(Var) %>%
  slice(1:3)

#Divide by average of top values
top <- aggregate(Y ~ Var, data = top, FUN = "mean")
Belgium_MV$Y <- 100*Belgium_MV$Y

#Sown
condition <- which(Belgium_MV$Var == "Sown")
Belgium_MV$Y[condition] <- Belgium_MV$Y[condition] /
  top[1, "Y"]

#N
condition <- which(Belgium_MV$Var == "N")
Belgium_MV$Y[condition] <- Belgium_MV$Y[condition] /
  top[2, "Y"]

#Weed
condition <- which(Belgium_MV$Var == "Weed")
Belgium_MV$Y[condition] <- Belgium_MV$Y[condition] /
  top[3, "Y"]


Belgium_MV
#>     YEARN PLOT DENS   G1   G2   L1   L2  Var         Y
#> 3       3   12 High 1.00 0.00 0.00 0.00 Sown  97.28529
#> 6       3   27  Low 1.00 0.00 0.00 0.00 Sown  85.30130
#> 9       3   13 High 0.00 1.00 0.00 0.00 Sown 109.38330
#> 12      3   28  Low 0.00 1.00 0.00 0.00 Sown 104.85410
#> 15      3   14 High 0.00 0.00 1.00 0.00 Sown 111.79308
#> 18      3   29  Low 0.00 0.00 1.00 0.00 Sown 104.84389
#> 21      3    1 High 0.70 0.10 0.10 0.10 Sown 147.27697
#> 24      3   16  Low 0.70 0.10 0.10 0.10 Sown 128.27171
#> 27      3    6 High 0.40 0.40 0.10 0.10 Sown 146.85606
#> 30      3   21  Low 0.40 0.40 0.10 0.10 Sown 147.96639
#> 33      3    2 High 0.10 0.70 0.10 0.10 Sown 137.97764
#> 36      3   17  Low 0.10 0.70 0.10 0.10 Sown 143.39015
#> 39      3    7 High 0.40 0.10 0.40 0.10 Sown 131.38370
#> 42      3   22  Low 0.40 0.10 0.40 0.10 Sown 142.80896
#> 45      3    9 High 0.10 0.40 0.40 0.10 Sown 140.76013
#> 48      3   24  Low 0.10 0.40 0.40 0.10 Sown 136.03128
#> 51      3    3 High 0.10 0.10 0.70 0.10 Sown 152.90260
#> 54      3   18  Low 0.10 0.10 0.70 0.10 Sown 147.25813
#> 57      3    5 High 0.25 0.25 0.25 0.25 Sown 140.51727
#> 60      3   20  Low 0.25 0.25 0.25 0.25 Sown 147.04639
#> 63      3    8 High 0.40 0.10 0.10 0.40 Sown 140.15944
#> 66      3   23  Low 0.40 0.10 0.10 0.40 Sown 153.93166
#> 69      3   10 High 0.10 0.40 0.10 0.40 Sown 128.04480
#> 72      3   25  Low 0.10 0.40 0.10 0.40 Sown 141.35070
#> 75      3   11 High 0.10 0.10 0.40 0.40 Sown 148.07851
#> 78      3   26  Low 0.10 0.10 0.40 0.40 Sown 134.12903
#> 81      3    4 High 0.10 0.10 0.10 0.70 Sown 150.12933
#> 84      3   19  Low 0.10 0.10 0.10 0.70 Sown 137.59442
#> 87      3   15 High 0.00 0.00 0.00 1.00 Sown  33.45700
#> 90      3   30  Low 0.00 0.00 0.00 1.00 Sown  16.70037
#> 91      3   12 High 1.00 0.00 0.00 0.00    N  42.33555
#> 92      3   27  Low 1.00 0.00 0.00 0.00    N  48.12690
#> 93      3   13 High 0.00 1.00 0.00 0.00    N  36.45611
#> 94      3   28  Low 0.00 1.00 0.00 0.00    N  39.37299
#> 95      3   14 High 0.00 0.00 1.00 0.00    N  66.34598
#> 96      3   29  Low 0.00 0.00 1.00 0.00    N  64.22847
#> 97      3    1 High 0.70 0.10 0.10 0.10    N  48.13995
#> 98      3   16  Low 0.70 0.10 0.10 0.10    N  44.52076
#> 99      3    6 High 0.40 0.40 0.10 0.10    N  51.25177
#> 100     3   21  Low 0.40 0.40 0.10 0.10    N  45.23530
#> 101     3    2 High 0.10 0.70 0.10 0.10    N  50.11961
#> 102     3   17  Low 0.10 0.70 0.10 0.10    N  43.80623
#> 103     3    7 High 0.40 0.10 0.40 0.10    N  55.71274
#> 104     3   22  Low 0.40 0.10 0.40 0.10    N  53.72819
#> 105     3    9 High 0.10 0.40 0.40 0.10    N  50.46709
#> 106     3   24  Low 0.10 0.40 0.40 0.10    N  48.34876
#> 107     3    3 High 0.10 0.10 0.70 0.10    N  52.66698
#> 108     3   18  Low 0.10 0.10 0.70 0.10    N  58.48606
#> 109     3    5 High 0.25 0.25 0.25 0.25    N  48.64893
#> 110     3   20  Low 0.25 0.25 0.25 0.25    N  46.74758
#> 111     3    8 High 0.40 0.10 0.10 0.40    N  43.63004
#> 112     3   23  Low 0.40 0.10 0.10 0.40    N  49.49969
#> 113     3   10 High 0.10 0.40 0.10 0.40    N  46.93355
#> 114     3   25  Low 0.10 0.40 0.10 0.40    N  51.18815
#> 115     3   11 High 0.10 0.10 0.40 0.40    N  46.90908
#> 116     3   26  Low 0.10 0.10 0.40 0.40    N  56.71195
#> 117     3    4 High 0.10 0.10 0.10 0.70    N  50.23462
#> 118     3   19  Low 0.10 0.10 0.10 0.70    N  47.69458
#> 119     3   15 High 0.00 0.00 0.00 1.00    N  62.05794
#> 120     3   30  Low 0.00 0.00 0.00 1.00    N  66.37779
#> 121     3   12 High 1.00 0.00 0.00 0.00 Weed  90.23570
#> 122     3   27  Low 1.00 0.00 0.00 0.00 Weed  95.69545
#> 123     3   13 High 0.00 1.00 0.00 0.00 Weed  99.76610
#> 124     3   28  Low 0.00 1.00 0.00 0.00 Weed  99.83487
#> 125     3   14 High 0.00 0.00 1.00 0.00 Weed  96.80273
#> 126     3   29  Low 0.00 0.00 1.00 0.00 Weed  81.37624
#> 127     3    1 High 0.70 0.10 0.10 0.10 Weed 100.00000
#> 128     3   16  Low 0.70 0.10 0.10 0.10 Weed 100.00000
#> 129     3    6 High 0.40 0.40 0.10 0.10 Weed  94.96939
#> 130     3   21  Low 0.40 0.40 0.10 0.10 Weed 100.00000
#> 131     3    2 High 0.10 0.70 0.10 0.10 Weed 100.00000
#> 132     3   17  Low 0.10 0.70 0.10 0.10 Weed 100.00000
#> 133     3    7 High 0.40 0.10 0.40 0.10 Weed  99.99467
#> 134     3   22  Low 0.40 0.10 0.40 0.10 Weed 100.00000
#> 135     3    9 High 0.10 0.40 0.40 0.10 Weed 100.00000
#> 136     3   24  Low 0.10 0.40 0.40 0.10 Weed 100.00000
#> 137     3    3 High 0.10 0.10 0.70 0.10 Weed 100.00000
#> 138     3   18  Low 0.10 0.10 0.70 0.10 Weed 100.00000
#> 139     3    5 High 0.25 0.25 0.25 0.25 Weed  99.96881
#> 140     3   20  Low 0.25 0.25 0.25 0.25 Weed  99.64182
#> 141     3    8 High 0.40 0.10 0.10 0.40 Weed  92.23312
#> 142     3   23  Low 0.40 0.10 0.10 0.40 Weed 100.00000
#> 143     3   10 High 0.10 0.40 0.10 0.40 Weed 100.00000
#> 144     3   25  Low 0.10 0.40 0.10 0.40 Weed 100.00000
#> 145     3   11 High 0.10 0.10 0.40 0.40 Weed  99.83170
#> 146     3   26  Low 0.10 0.10 0.40 0.40 Weed  98.73048
#> 147     3    4 High 0.10 0.10 0.10 0.70 Weed 100.00000
#> 148     3   19  Low 0.10 0.10 0.10 0.70 Weed  99.75334
#> 149     3   15 High 0.00 0.00 0.00 1.00 Weed  19.93108
#> 150     3   30  Low 0.00 0.00 0.00 1.00 Weed   0.00000
```
