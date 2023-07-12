\name{simMV}
\alias{simMV}
\docType{data}
\title{The Simulated Multivariate "simMV" Dataset}
\description{
The \code{simMV} dataset was simulated from a multivariate DI model. It contains 192 plots comprising of six species that vary in proportions (\code{p1} - \code{p6}). Each plot was replicated once for testing a two-level factor \code{treat}, included at levels 0 and 1, resulting in a total of 384 plots. There are four simulated responses (\code{Y1} - \code{Y4}) recorded in a wide data format (one column per response). The data was simulated assuming that there were existing covariances between the responses, an additive treatment effect, and both species identity and species interaction effects were present.
}
\usage{data("simMV")}
\format{
  A data frame with 384 observations on the following twelve variables.
  \describe{
    \item{\code{plot}}{A numeric vector identifying each unique experimental unit}
    \item{\code{p1}}{A numeric vector indicating the initial proportion of species 1}
    \item{\code{p2}}{A numeric vector indicating the initial proportion of species 2}
    \item{\code{p3}}{A numeric vector indicating the initial proportion of species 3}
    \item{\code{p4}}{A numeric vector indicating the initial proportion of species 4}
    \item{\code{p5}}{A numeric vector indicating the initial proportion of species 5}
    \item{\code{p6}}{A numeric vector indicating the initial proportion of species 6}
    \item{\code{treat}}{A two-level factor indicating whether a treatment was applied (1) or not (0)}
    \item{\code{Y1}}{A numeric vector giving the simulated response for ecosystem function 1}
    \item{\code{Y2}}{A numeric vector giving the simulated response for ecosystem function 2}
    \item{\code{Y3}}{A numeric vector giving the simulated response for ecosystem function 3}
    \item{\code{Y4}}{A numeric vector giving the simulated response for ecosystem function 4}
  }
}
\details{
\bold{What are Diversity-Interactions (DI) models?}

Diversity-Interactions (DI) models (Kirwan et al 2009) are a set of tools for analysing and interpreting data from experiments that explore the effects of species diversity on community-level responses. We strongly recommend that users read the short introduction to Diversity-Interactions models (available at: [DImodels]). Further information on Diversity-Interactions models is also available in Kirwan et al 2009 and Connolly et al 2013.

\bold{Parameter values for the simulation}

Multivariate DI models take the general form of:

\deqn{y = Identities + Interactions + Structures + \epsilon}

where \eqn{y} are the community-level responses, the \eqn{Identities} are the effects of species identities for each response and enter the model as individual species proportions at the beginning of the time period, the \eqn{Interactions} are the interactions among the species proportions, while \eqn{Structures} include other experimental structures such as blocks, treatments or density.

The dataset \code{simMV} was simulated with:
\itemize{
  \item identity effects for the six species for response:
  \itemize{
     \item Y1 = 6.9, -0.3, 6.6, 1.7, -0.8, 4.3
     \item Y2 = 4.9, 3.6, 4.4, 2.3, 4.3, 6.6
     \item Y3 = -0.3, 4.6, 1.2, 6.8, 1.4, 6.9
     \item Y4 = 4.1, 4.2, -0.5, 4.9, 6.7, -0.9, -1.0
     }
  \item an average pairwise interaction effect for response:
  \itemize{
     \item Y1 = 1.8
     \item Y2 = 6.8
     \item Y3 = 1.4
     \item Y4 = 0.3
    }
  \item a teatment effect for response:
  \itemize{
     \item Y1 = 3.5
     \item Y2 = -0.3
     \item Y3 = 5.5
     \item Y4 = -1.0
    }
  \item \eqn{\epsilon} assumed to have a multivaraite normal distribution with mean 0 and Sigma:
    \tabular{lllll}{
      [1,]  3.87  -0.17  -0.23  0.31 \cr
      [2,]  -0.17  1.34  -0.11  0.49 \cr
      [3,]  -0.23  -0.11  2.95  -0.36 \cr
      [4,]  0.31  0.49  -0.36  1.83 \cr
      }
  }
}

\references{
Kirwan L, J Connolly, JA Finn, C Brophy, A Lüscher, D Nyfeler and MT Sebastia (2009) Diversity-interaction modelling - estimating contributions of species identities and interactions to ecosystem function. Ecology, 90, 2032-2038.

Dooley, Á., Isbell, F., Kirwan, L., Connolly, J., Finn, J. A., & Brophy, C. (2015). Testing the effects of diversity on ecosystem multifunctionality using a multivariate model. Ecology Letters, 18(11), 1242-1251.
}
\examples{
data(simMV)

MVmodel <- DImulti()
}
\keyword{datasets}
