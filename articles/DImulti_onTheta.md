# On the usage and estimation of theta in DImulti()

``` r
library(DImodelsMulti)
library(DImodels)
```

## A quick overview

The main function of the R package DImodelsMulti is DImulti(). It is
designed to fit (1) multivariate Diversity-Interactions (DI) models
(Dooley *et al.*, 2015), (2) repeated measures DI models (Finn *et al.*,
2013), and (3) multivariate repeated measures DI models.

An example of a multivariate repeated measures DI model can be seen
below:

$$y_{kmt} = \sum\limits_{i = 1}^{S}{\beta_{ikt}p_{im}} + \sum\limits_{\substack{i,j = 1 \\ i < j}}^{S}{\delta_{ijkt}\left( p_{im}p_{jm} \right)^{\theta_{k}}} + \epsilon_{kmt}$$

where $y_{kmt}$ refers to the value of the $k^{th}$ ecosystem function
from the $m^{th}$ experimental unit at a time point $t$. For an
experimental unit $m$, $\beta_{ikt}$ scaled by $p_{im}$ is the expected
contribution of the $i^{th}$ species to the $k^{th}$ response at time
point $t$ and is referred to as the $i^{th}$ species’ ID effect. $S$
represents the number of unique species present in the study. Similarly
to the ID effect, the interaction effect, $\delta$, between species is
scaled by some combination of the products of species proportions, which
depends on the interaction structure chosen. The example above shows the
full pairwise structure, which has a unique interaction term,
$\delta_{ij}$, per pair of species $i$ & $j$.

The nonlinear term $\theta$ (Connolly *et al.*, 2013; Vishwakarma *et
al.*, 2023), the focus of this vignette, is applied as a power to each
pair of species proportions included in the interaction terms of the
model. It is included in the model to allow the shape of the BEF
relationship to change. The value of the nonlinear parameter $\theta$ is
allowed to vary between ecosystem functions, in turn allowing the fixed
effect structure to change across functions, in recognition that the
nature of the species interactions could change between ecosystem
functions.

![A figure showing how the DI model fits to the data with varying values
of theta](Theta.png) Image Credit: Connolly *et al.* 2013

## DImulti()’s estimation process for $\theta$

In the function DImulti(), $\theta$ values may be supplied by a user
through the parameter ‘theta’ or estimated by specifying TRUE through
‘estimate_theta’. The non-linear term may also be “left out” by setting
‘theta’ equal to 1 and ‘estimate_theta’ to FALSE, which is the default
for the function.

``` r
DImulti(..., theta = c(0.5, 1, 1.2))
DImulti(..., theta = 1)
```

Setting a value for theta supplied by a user is a straightforward
process thanks to the function DI_data() from the parent package
DImodels (Moral *et al.*, 2023). We divide the dataset by ecosystem
function, as multivariate data can have differing values of theta for
each, then pass each subset into the function, specifying the desired
$\theta$ value and base interaction structure. The subsets are then
bound together again and the dataset is ready for use with theta.

The below example would transform the usual format of a full pairwise
structure from
$\delta_{12}p_{1}p_{2} + \delta_{13}p_{1}p_{3} + \delta_{23}p_{2}p_{3}$
to
$\delta_{12}\left( p_{1}p_{2} \right)^{1.2} + \delta_{13}\left( p_{1}p_{3} \right)^{1.2} + \delta_{23}\left( p_{2}p_{3} \right)^{1.2}$.

``` r
DI_data(..., theta = 1.2, what = "FULL")
```

When theta is estimated, the process is a bit more involved. We create a
function to fit multivariate repeated measures DI models, wrapping
DImulti(), which accepts a vector of theta values, one per ecosystem
function, and returns the negative log likelihood of the produced model.
We then use optim() to minimise the returned value from this function
over the space of the allowable values of theta (0.1 to 1.5).

After fitting a model where theta is estimated. This model should then
be compared to a model with the same fixed effects structure using
$\theta = 1$ using information criteria (AIC, BIC, AICc, BICc) to test
the significance of the estimated values. This may be done all at once,
as below:

``` r
AICc(DImodel)
AICc(DImodel_theta)
```

Or each value of theta should be tested individually while the others
are held constant at a value of 1.

``` r
AICc(DImodel)
AICc(DImodel_thetaFunc1)

AICc(DImodel)
AICc(DImodel_thetaFunc2)

AICc(DImodel)
AICc(DImodel_thetaFunc3)
```

The best method for estimating and testing theta values has not yet been
thoroughly tested.

In the event that the preferred model has an estimated value of theta
that differs from 1 but causes fitting issues, e.g., predictions are
unrealistic, either in the model used for estimation or a final selected
model, set the theta value equal to 1 and continue/redo the analysis.

## Implications of this methodology

The methodology used in this package allows a user to estimate the value
of theta for each ecosystem function in the dataset one-by-one (single),
simultaneously (joint) or ignoring response correlations (univariate)
using log-likelihood as a measure of model fit quality.

For multivariate and repeated measures DI models, we have allowed the
value of theta to vary across ecosystem functions, which in turn allows
the change in fixed effects structures to vary across functions. This is
not common practice in multivariate regression and so its
effects/implications will require further study.

The methodology used in this R package may change in future updates to
align with research findings on the topic.

## References

Vishwakarma, R., Byrne, L., Connolly, J., de Andrade Moral, R. and
Brophy, C., 2023. Estimation of the non-linear parameter in Generalised
Diversity-Interactions models is unaffected by change in structure of
the interaction terms. Environmental and Ecological Statistics, 30(3),
pp.555-574.

Moral, R.A., Vishwakarma, R., Connolly, J., Byrne, L., Hurley, C., Finn,
J.A. and Brophy, C., 2023. Going beyond richness: Modelling the BEF
relationship using species identity, evenness, richness and species
interactions via the DImodels R package. Methods in Ecology and
Evolution, 14(9), pp.2250-2258.

Dooley, Á., Isbell, F., Kirwan, L., Connolly, J., Finn, J.A. and Brophy,
C., 2015. Testing the effects of diversity on ecosystem
multifunctionality using a multivariate model. Ecology Letters, 18(11),
pp.1242-1251.

Finn, J.A., Kirwan, L., Connolly, J., Sebastià, M.T., Helgadottir, A.,
Baadshaug, O.H., Bélanger, G., Black, A., Brophy, C., Collins, R.P. and
Čop, J., 2013. Ecosystem function enhanced by combining four functional
types of plant species in intensively managed grassland mixtures: a
3‐year continental‐scale field experiment. Journal of Applied Ecology,
50(2), pp.365-375 .

Connolly, J., Bell, T., Bolger, T., Brophy, C., Carnus, T., Finn, J.A.,
Kirwan, L., Isbell, F., Levine, J., Lüscher, A. and Picasso, V., 2013.
An improved model to predict the effects of changing biodiversity levels
on ecosystem function.

Journal of Ecology, 101(2), pp.344-355.

Kirwan, L., Connolly, J., Finn, J.A., Brophy, C., Lüscher, A., Nyfeler,
D. and Sebastià, M.T., 2009. Diversity-interaction modeling: estimating
contributions of species identities and interactions to ecosystem
function. Ecology, 90(8), pp.2032-2038.

Brent, R.P., 1973. Some efficient algorithms for solving systems of
nonlinear equations. SIAM Journal on Numerical Analysis, 10(2),
pp.327-344.
