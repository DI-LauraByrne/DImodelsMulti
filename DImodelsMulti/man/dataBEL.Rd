\name{dataBEL}
\alias{dataBEL}
\docType{data}
\title{
The Belgium Dataset
}
\description{
Single site dataset containing thirty experimental units (plots), with four species seeded at two density levels, representing fifteen communities. Three ecosystem function responses are recorded
for each plot at a single time point. Data is in a stacked format
}
\usage{data("dataBEL")}
\format{
  A data frame with 90 observations on the following 9 variables.
  \describe{
    \item{\code{Plot}}{a numeric vector indicating the ID of the experimental unit from which the observation was recorded}
    \item{\code{G1}}{a numeric vector ranging from 0 to 1, the proportion of the species G1}
    \item{\code{G2}}{a numeric vector ranging from 0 to 1, the proportion of the species G2}
    \item{\code{L1}}{a numeric vector ranging from 0 to 1, the proportion of the species L1}
    \item{\code{L2}}{a numeric vector ranging from 0 to 1, the proportion of the species L2}
    \item{\code{Density}}{a vector of factors with two levels, -1 or 1, representing the seeding density of the plot}
    \item{\code{Var}}{a character vector indicating the ecosystem function recorded}
    \item{\code{VarNum}}{a vector of factors with three levels, 1, 2, or 3 indicating the ecosystem function recorded}
    \item{\code{Y}}{a numeric vector indicating the value of the ecosystem function recorded}
  }
}
\details{
Data comes from a single site from a wider agrosdiversity experiment conducted in Belgium,
established in 2002. \cr
The four species used were Lolium perenne (G1), Phleum pratense (G2), Trifolium pratense (L1), and Trifolium repens (L2). There are two recommended functional groupings: grouping grasses (G1, G2) and legumes (L1, L2), or grouping fast-establishing species (G1, L1) and temporally persistent species
(G2, L2). \cr
Three ecosystem functions were recorded by summing recordings from four harvests over the first year
of the experiment: (1) aboveground biomass of sown species (Sown) (t DM ha−1), (2) aboveground
biomass of weed species (Weed) (t DM ha−1) and (3) the total annual yield of nitrogen in harvested aboveground biomass (N) (t DM ha−1).
}
\source{
Dooley, Á., Isbell, F., Kirwan, L., Connolly, J., Finn, J.A. and Brophy, C., 2015. \cr
Testing the effects of diversity on ecosystem multifunctionality using a multivariate model. \cr
Ecology Letters, 18(11), pp.1242-1251.
}
\references{
Dooley, Á., Isbell, F., Kirwan, L., Connolly, J., Finn, J.A. and Brophy, C., 2015. \cr
Testing the effects of diversity on ecosystem multifunctionality using a multivariate model. \cr
Ecology Letters, 18(11), pp.1242-1251. \cr \cr

Kirwan, L., Connolly, J., Brophy, C., Baadshaug, O.H., Belanger, G., Black, A., Carnus, T., Collins,
R.P., Čop, J., Delgado, I. and De Vliegher, A., 2014. \cr
The Agrodiversity Experiment: three years of data from a multisite study in intensively managed grasslands. \cr \cr

Finn, J.A., Kirwan, L., Connolly, J., Sebastià, M.T., Helgadottir, A., Baadshaug, O.H.,
Bélanger, G., Black, A., Brophy, C., Collins, R.P. and Čop, J., 2013. \cr
Ecosystem function enhanced by combining four functional types of plant species in intensively
managed grassland mixtures: a 3‐year continental‐scale field experiment.\cr
Journal of Applied Ecology, 50(2), pp.365-375 .\cr \cr

Kirwan, L., Connolly, J., Finn, J.A., Brophy, C., Lüscher, A., Nyfeler, D. and Sebastià, M.T.,
2009. \cr
Diversity–interaction modeling: estimating contributions of species identities and interactions
to ecosystem function. \cr
Ecology, 90(8), pp.2032-2038. \cr \cr
}
\examples{
data(dataBEL)

# INCLUDE EXAMPLE

}
\keyword{datasets}
