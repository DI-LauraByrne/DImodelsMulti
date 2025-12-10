# The repeated measures Belgium dataset

Single site dataset containing thirty experimental units (plots), with
four species seeded at two density levels, representing fifteen
communities. A single ecosystem function response is recorded for each
plot over three years. The responses have been linearly transformed to
lie on a percentage scale. Data is in a stacked format.

## Usage

``` r
data("Belgium_RM")
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
The ecosystem function (aboveground biomass of sown species (Sown) (t DM
ha-1)) were recorded by summing recordings from multiple harvests over
the years of of the experiment. A linear transformation on the response
was applied to the value 'Y', where it now represents a percentage of
the top 10% of recorded values, i.e., each response was multiplied by
100, then divided by the mean of the top nine readings.  
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
library(DImodelsMulti)
#############################################################
## Read in data##################################
data("Belgium")
#############################################################
## Standardise responses for Analysis 1 (RM) #################
Belgium_RM <- Belgium
#Top 9 values
top <- Belgium_RM %>%
  arrange(desc(Y)) %>%
  group_by(Var) %>%
  slice(1:9)
#Average of top values
top <- aggregate(Y ~ Var, data = top, FUN = "mean")

Belgium_RM$Y <- 100*Belgium_RM$Y

#Sown
condition <- which(Belgium_RM$Var == "Sown")
Belgium_RM$Y[condition] <- Belgium_RM$Y[condition] /
  top[1, "Y"]

#Subset to just the Sown response
Belgium_RM <- Belgium_RM[which(Belgium_RM$Var == "Sown"), ]


Belgium_RM
#>    YEARN PLOT DENS   G1   G2   L1   L2  Var         Y
#> 1      1   12 High 1.00 0.00 0.00 0.00 Sown  87.44931
#> 2      2   12 High 1.00 0.00 0.00 0.00 Sown  80.42454
#> 3      3   12 High 1.00 0.00 0.00 0.00 Sown 107.17870
#> 4      1   27  Low 1.00 0.00 0.00 0.00 Sown  99.65902
#> 5      2   27  Low 1.00 0.00 0.00 0.00 Sown  96.56732
#> 6      3   27  Low 1.00 0.00 0.00 0.00 Sown  93.97601
#> 7      1   13 High 0.00 1.00 0.00 0.00 Sown  83.24496
#> 8      2   13 High 0.00 1.00 0.00 0.00 Sown 113.10767
#> 9      3   13 High 0.00 1.00 0.00 0.00 Sown 120.50702
#> 10     1   28  Low 0.00 1.00 0.00 0.00 Sown  70.69485
#> 11     2   28  Low 0.00 1.00 0.00 0.00 Sown 109.60502
#> 12     3   28  Low 0.00 1.00 0.00 0.00 Sown 115.51723
#> 13     1   14 High 0.00 0.00 1.00 0.00 Sown 124.33131
#> 14     2   14 High 0.00 0.00 1.00 0.00 Sown 168.53835
#> 15     3   14 High 0.00 0.00 1.00 0.00 Sown 123.16186
#> 16     1   29  Low 0.00 0.00 1.00 0.00 Sown 118.45355
#> 17     2   29  Low 0.00 0.00 1.00 0.00 Sown 147.33609
#> 18     3   29  Low 0.00 0.00 1.00 0.00 Sown 115.50598
#> 19     1    1 High 0.70 0.10 0.10 0.10 Sown 160.64814
#> 20     2    1 High 0.70 0.10 0.10 0.10 Sown 179.02140
#> 21     3    1 High 0.70 0.10 0.10 0.10 Sown 162.25429
#> 22     1   16  Low 0.70 0.10 0.10 0.10 Sown 135.07897
#> 23     2   16  Low 0.70 0.10 0.10 0.10 Sown 182.43164
#> 24     3   16  Low 0.70 0.10 0.10 0.10 Sown 141.31629
#> 25     1    6 High 0.40 0.40 0.10 0.10 Sown 131.70721
#> 26     2    6 High 0.40 0.40 0.10 0.10 Sown 177.69451
#> 27     3    6 High 0.40 0.40 0.10 0.10 Sown 161.79057
#> 28     1   21  Low 0.40 0.40 0.10 0.10 Sown 134.88313
#> 29     2   21  Low 0.40 0.40 0.10 0.10 Sown 173.43763
#> 30     3   21  Low 0.40 0.40 0.10 0.10 Sown 163.01382
#> 31     1    2 High 0.10 0.70 0.10 0.10 Sown 127.31889
#> 32     2    2 High 0.10 0.70 0.10 0.10 Sown 183.10781
#> 33     3    2 High 0.10 0.70 0.10 0.10 Sown 152.00926
#> 34     1   17  Low 0.10 0.70 0.10 0.10 Sown 117.74664
#> 35     2   17  Low 0.10 0.70 0.10 0.10 Sown 166.21709
#> 36     3   17  Low 0.10 0.70 0.10 0.10 Sown 157.97219
#> 37     1    7 High 0.40 0.10 0.40 0.10 Sown 152.60986
#> 38     2    7 High 0.40 0.10 0.40 0.10 Sown 186.00376
#> 39     3    7 High 0.40 0.10 0.40 0.10 Sown 144.74475
#> 40     1   22  Low 0.40 0.10 0.40 0.10 Sown 143.00579
#> 41     2   22  Low 0.40 0.10 0.40 0.10 Sown 186.88097
#> 42     3   22  Low 0.40 0.10 0.40 0.10 Sown 157.33190
#> 43     1    9 High 0.10 0.40 0.40 0.10 Sown 128.04326
#> 44     2    9 High 0.10 0.40 0.40 0.10 Sown 193.09648
#> 45     3    9 High 0.10 0.40 0.40 0.10 Sown 155.07472
#> 46     1   24  Low 0.10 0.40 0.40 0.10 Sown 128.53674
#> 47     2   24  Low 0.10 0.40 0.40 0.10 Sown 177.63092
#> 48     3   24  Low 0.10 0.40 0.40 0.10 Sown 149.86497
#> 49     1    3 High 0.10 0.10 0.70 0.10 Sown 149.45721
#> 50     2    3 High 0.10 0.10 0.70 0.10 Sown 176.45823
#> 51     3    3 High 0.10 0.10 0.70 0.10 Sown 168.45201
#> 52     1   18  Low 0.10 0.10 0.70 0.10 Sown 133.03722
#> 53     2   18  Low 0.10 0.10 0.70 0.10 Sown 179.57537
#> 54     3   18  Low 0.10 0.10 0.70 0.10 Sown 162.23353
#> 55     1    5 High 0.25 0.25 0.25 0.25 Sown 145.38963
#> 56     2    5 High 0.25 0.25 0.25 0.25 Sown 185.73949
#> 57     3    5 High 0.25 0.25 0.25 0.25 Sown 154.80716
#> 58     1   20  Low 0.25 0.25 0.25 0.25 Sown 144.84636
#> 59     2   20  Low 0.25 0.25 0.25 0.25 Sown 175.97434
#> 60     3   20  Low 0.25 0.25 0.25 0.25 Sown 162.00025
#> 61     1    8 High 0.40 0.10 0.10 0.40 Sown 139.80615
#> 62     2    8 High 0.40 0.10 0.10 0.40 Sown 189.06078
#> 63     3    8 High 0.40 0.10 0.10 0.40 Sown 154.41294
#> 64     1   23  Low 0.40 0.10 0.10 0.40 Sown 137.39378
#> 65     2   23  Low 0.40 0.10 0.10 0.40 Sown 176.54789
#> 66     3   23  Low 0.40 0.10 0.10 0.40 Sown 169.58572
#> 67     1   10 High 0.10 0.40 0.10 0.40 Sown 120.43205
#> 68     2   10 High 0.10 0.40 0.10 0.40 Sown 176.64443
#> 69     3   10 High 0.10 0.40 0.10 0.40 Sown 141.06631
#> 70     1   25  Low 0.10 0.40 0.10 0.40 Sown 114.26796
#> 71     2   25  Low 0.10 0.40 0.10 0.40 Sown 171.26852
#> 72     3   25  Low 0.10 0.40 0.10 0.40 Sown 155.72534
#> 73     1   11 High 0.10 0.10 0.40 0.40 Sown 132.78575
#> 74     2   11 High 0.10 0.10 0.40 0.40 Sown 174.27806
#> 75     3   11 High 0.10 0.10 0.40 0.40 Sown 163.13734
#> 76     1   26  Low 0.10 0.10 0.40 0.40 Sown 131.43052
#> 77     2   26  Low 0.10 0.10 0.40 0.40 Sown 174.52577
#> 78     3   26  Low 0.10 0.10 0.40 0.40 Sown 147.76927
#> 79     1    4 High 0.10 0.10 0.10 0.70 Sown 127.27669
#> 80     2    4 High 0.10 0.10 0.10 0.70 Sown 171.65712
#> 81     3    4 High 0.10 0.10 0.10 0.70 Sown 165.39671
#> 82     1   19  Low 0.10 0.10 0.10 0.70 Sown 135.86455
#> 83     2   19  Low 0.10 0.10 0.10 0.70 Sown 167.26133
#> 84     3   19  Low 0.10 0.10 0.10 0.70 Sown 151.58707
#> 85     1   15 High 0.00 0.00 0.00 1.00 Sown  66.75652
#> 86     2   15 High 0.00 0.00 0.00 1.00 Sown  67.65311
#> 87     3   15 High 0.00 0.00 0.00 1.00 Sown  36.85941
#> 88     1   30  Low 0.00 0.00 0.00 1.00 Sown  79.37764
#> 89     2   30  Low 0.00 0.00 0.00 1.00 Sown  65.64431
#> 90     3   30  Low 0.00 0.00 0.00 1.00 Sown  18.39871
```
