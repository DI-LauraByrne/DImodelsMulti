##################################################################################################################################################################
#' print.DImulti
#' @method print DImulti
#'
#' @description Print details of the fitted DI models supplied
#'
#' @param x an object of class DImulti
#' @param ... some methods for this generic function require additional arguments. None are used in
#' this method.
#'
#' @return object x
#'
#' @seealso
#' \code{\link[base]{print}} which this function wraps.
#'
#' @export

print.DImulti <- function(x, ...)
{
  #Print notes
  cat(crayon::bold("Make note that: \n"))
  cat(crayon::bold(paste(crayon::magenta("Method Used ="), crayon::underline(attr(x, "method")), "\n")))
  cat(crayon::bold(crayon::magenta("Correlation Structure Used = ")))
  switch(tolower(attr(x, "correlation")),
         "un" = cat(crayon::bold(crayon::underline(cli::cli_text("{.help [UN](nlme::corSymm)}")))),
         "cs" = cat(crayon::bold(crayon::underline(cli::cli_text("{.help [CS](nlme::corCompSymm)}")))),
         "ar1" = cat(crayon::bold(crayon::underline(cli::cli_text("{.help [AR(1)](nlme::corAR1)}")))),
         "un@un" = cat(crayon::bold(crayon::underline(cli::cli_text("{.help [UN](nlme::corSymm)} @ {.help [UN](nlme::corSymm)}")))),
         "un@cs" = cat(crayon::bold(crayon::underline(cli::cli_text("{.help [UN](nlme::corSymm)} @ {.help [CS](nlme::corCompSymm)}")))),
         "un@ar1" = cat(crayon::bold(crayon::underline(cli::cli_text("{.help [UN](nlme::corSymm)} @ {.help [AR(1)](nlme::corAR1)}")))),
         "cs@un" = cat(crayon::bold(crayon::underline(cli::cli_text("{.help [CS](nlme::corCompSymm)} @ {.help [UN](nlme::corSymm)}")))),
         "cs@cs" = cat(crayon::bold(crayon::underline(cli::cli_text("{.help [CS](nlme::corCompSymm)} @ {.help [CS](nlme::corCompSymm)}")))),
         "cs@ar1" = cat(crayon::bold(crayon::underline(cli::cli_text("{.help [CS](nlme::corCompSymm)} @ {.help [AR(1)](nlme::corAR1)}"))))
  )

  #Print Model Name
  cat(crayon::bold(crayon::green(attr(x, "name"))))
  #If an interaction model, print theta
  if(attr(x, "name") != "Intercept Only Model" & attr(x, "name") != "ID Model")
  {
    if(attr(x, "estThetas") == TRUE)
    {
      cat(crayon::bold(crayon::magenta("\nTheta estimate(s) = ")))
    }
    else
    {
      cat(crayon::bold(crayon::magenta("\nTheta value(s) = ")))
    }
    cat(crayon::bold(crayon::underline(round(attr(x, "thetas"), 4))), sep = ", ")
  }

  cat("\n")

  dd <- x$dims
  mCall <- x$call

  if(inherits(x, "gnls"))
  {
    cat("\nGeneralized nonlinear least squares fit\n")
  }
  else
  {
    cat("\nGeneralized least squares fit by ")
    cat(if(x$method == "REML") "REML\n"
        else "maximum likelihood\n")
  }
  cat("  Model:", deparse(x$call$model), "\n")
  if(!is.null(x$call$subset))
  {
    cat("  Subset:", deparse(stats::asOneSidedFormula(x$call$subset)[[2]]),
        "\n")
  }
  print(stats::setNames(c(stats::AIC(x), stats::BIC(x), stats::logLik(x)), c("AIC", "BIC", "logLik")))

  if(attr(x, "MVflag"))
  {
    cat("\n Multivariate ")
    print(summary(x$corrMV))
  }
  if(attr(x, "Timeflag"))
  {
    cat("\n Repeated Measure ")
    print(summary(x$corrT))
  }

  tTable <- invisible(summary(x, notes = FALSE)$tTable)
  stars <- ifelse(tTable[, 4] < 0.001, "***",
                  ifelse(tTable[, 4] <= 0.01, "**",
                         ifelse(tTable[, 4] <= 0.05, "*",
                                ifelse(tTable[, 4] <= 0.1, "+", "")))
  )
  base::print(knitr::kable(cbind(formatC(tTable[, c(1)], format = "f", digits = 3, flag = "+"),
                                 formatC(tTable[, c(2)], format = "f", digits = 3),
                                 formatC(tTable[, c(4)], format = "g"),
                                 stars),
                           caption = crayon::bold("Fixed Effect Coefficients"), col.names = c("Beta", "Std. Error", "p-value", "Signif"),
                           format = "simple"))
  cat("\n")
  cat(
    noquote(
      "Signif codes: 0-0.001 '***', 0.001-0.01 '**', 0.01-0.05 '*', 0.05-0.1 '+', 0.1-1.0 ' '"))

  cat("\n\n")

  cat("Degrees of freedom:", dd[["N"]], "total;", dd[["N"]] -
        dd[["p"]], "residual\n")
  cat("Residual standard error:", format(x$sigma), "\n\n")

  print(x$yvcov)

  invisible(x)
}


##################################################################################################################################################################
#' summary.DImulti
#' @method summary DImulti
#'
#' @description Print a summary of the fitted DI models supplied
#'
#' @param object an object inheriting from class DImulti, representing a generalized least squared fitted linear model using the
#' Diversity-Interactions framework
#' @param verbose an optional logical value used to control the amount of output when the object is printed. Defaults to FALSE.
#' @param ... some methods for this generic function require additional arguments. None are used in
#' this method.
#'
#' @return an object inheriting from class summary.gls with all components included in object (see glsObject for a full description of the
#' components) plus the following components:
#'
#' corBeta,
#' approximate correlation matrix for the coefficients estimates
#'
#' tTable,
#' a matrix with columns Value, Std. Error, t-value, and p-value representing respectively the coefficients estimates, their approximate
#' standard errors, the ratios between the estimates and their standard errors, and the associated p-value under a
#' t approximation. Rows correspond to the different coefficients.
#'
#' residuals,
#' if more than five observations are used in the gls fit, a vector with the minimum, first quartile, median, third quartile, and maximum of
#' the residuals distribution; else the residuals.
#'
#' AIC,
#' the Akaike Information Criterion corresponding to object.
#'
#' BIC,
#' the Bayesian Information Criterion corresponding to object.
#'
#' @seealso
#' \code{\link[nlme]{summary.gls}} which this function wraps.
#'
#' @export
#'

summary.DImulti <- function(object, verbose = FALSE, ...)
{
  fixSig <- attr(object[["modelStruct"]], "fixedSigma")
  fixSig <- !is.null(fixSig) && fixSig

  stdBeta <- sqrt(diag(as.matrix(object$varBeta)))
  corBeta <- t(object$varBeta/stdBeta)/stdBeta
  beta <- object$coefficients

  dims <- object$dims
  dimnames(corBeta) <- list(names(beta), names(beta))
  object$corBeta <- corBeta

  tTable <- data.frame(beta, stdBeta, beta/stdBeta, beta)
  dimnames(tTable) <- list(names(beta), c("Value", "Std.Error",
                                          "t-value", "p-value"))
  tTable[, "p-value"] <- 2 * stats::pt(-abs(tTable[, "t-value"]),
                                dims$N - dims$p)

  object$tTable <- as.matrix(tTable) #Save tTable to object

  resd <- stats::resid(object, type = "pearson")
  if (length(resd) > 5)
  {
    resd <- stats::quantile(resd, na.rm = TRUE)
    names(resd) <- c("Min", "Q1", "Med", "Q3", "Max")
  }
  object$residuals <- resd
  aux <- stats::logLik(object)

  structure(c(object, list(BIC = stats::BIC(aux), AIC = stats::AIC(aux))),
            verbose = verbose, class = c("summary.DImulti", "summary.gls", class(object)))
}


##################################################################################################################################################################

##################################################################################################################################################################
#' predict.DImulti
#'
#' @method predict DImulti
#'
#' @description Predict from a multivariate repeated measures DI model
#'
#' @param object an object of class DImulti
#' @param newdata an optional dataframe containing the communities from which to predict
#' @param stacked a logical value used to determine whether the output is in a wide or stacked format. Defaults to FALSE, meaning output is wide.
#' @param ... some methods for this generic function require additional arguments. None are used in
#' this method.
#'
#' @return The predictions from the supplied fitted DI models for the provided newdata, or the data used to fit the model if no newdata is
#' supplied.
#'
#' @seealso
#' \code{\link[nlme]{predict.gls}} which this function wraps.
#'
#' @export

predict.DImulti <- function(object, newdata = NULL, stacked = FALSE, ...)
{
  if(is.null(newdata))
  {
    newdata <- attr(object, "data")
  }
  else if(attr(object, "MVflag"))
  {
    if(inherits(newdata, 'tbl_df'))
    {
      newdata <- as.data.frame(newdata)
    }

    #If wide data, stack
    if(length(attr(object, "y")) != 1)
    {
      predictors <- setdiff(colnames(newdata), attr(object, "y"))

      newdata <- reshape2::melt(newdata,
                                id.vars = predictors,
                                variable.name = "func",
                                value.name = "value")
    }
    newdata <- newdata[order(newdata[[attr(object, "unitIDs")]], newdata[[attr(object, "Yfunc")]]),]
  }
  else
  {
    newdata <- newdata[order(newdata[[attr(object, "unitIDs")]]),]
  }

  singleRow <- FALSE

  if(nrow(newdata) == 1)
  {
    singleRow <- TRUE
    newdata <- rbind(newdata, newdata)
  }


  if((attr(object, "DImodel") != "STR") & (attr(object, "DImodel") != "ID"))
  {
    if(length(unique(attr(object, "thetas")) == 1)) # All the same theta value
    {
      intCols <- DImodels::DI_data(prop = attr(object, "props"), FG = attr(object, "FGs"), data = newdata, theta = attr(object, "thetas")[1],
                                   what = attr(object, "DImodel"))

      #Change new column names
      if(attr(object, "DImodel") == "FULL")
      {
        for(i in 1:ncol(intCols))
        {
          colnames(intCols)[i] <- paste0("FULL.", colnames(intCols)[i])
        }
        newdata <- cbind(newdata, data.frame(intCols))
      }
      else if(attr(object, "DImodel") == "FG")
      {
        for(i in 1:ncol(intCols))
        {
          colnames(intCols)[i] <- paste0("FG.", colnames(intCols)[i])
        }
        newdata <- cbind(newdata, data.frame(intCols))
      }
      else if(attr(object, "DImodel") %in% c("AV", "E"))
      {
        newdata <- cbind(newdata, data.frame(intCols))

        colnames(newdata)[ncol(newdata)] <- attr(object, "DImodel")
      }
      else if(attr(object, "DImodel") == "ADD")
      {
        newdata <- cbind(newdata, data.frame(intCols))
      }
    }

    else # Differing theta values
    {
      dataTemp <- data.frame()
      iCount <- 1

      #need to divide up dataset by EF and apply each theta in loop
      for(i in unique(newdata[, attr(object, "Yfunc")]))
      {
        intCols <- DImodels::DI_data(prop = attr(object, "props"), FG = attr(object, "FGs"),
                                     data = newdata[which(newdata[, attr(object, "Yfunc")] == i), ], theta = attr(object, "thetas")[iCount],
                                     what = attr(object, "DImodel"))

        #Change new column names
        if(attr(object, "DImodel") == "FULL")
        {
          for(j in 1:ncol(intCols))
          {
            colnames(intCols)[j] <- paste0("FULL.", gsub(":", ".", colnames(intCols)[j]))
          }
        }
        else if(attr(object, "DImodel") == "FG")
        {
          for(j in 1:ncol(intCols))
          {
            colnames(intCols)[j] <- paste0("FG.", colnames(intCols)[j])
          }
        }

        dataTemp <- rbind(dataTemp, cbind(newdata[which(newdata[, attr(object, "Yfunc")] == i), ], intCols))

        iCount <- iCount + 1
      }
      newdata <- dataTemp

      if(attr(object, "DImodel") %in% c("AV", "E"))
      {
        colnames(newdata)[ncol(newdata)] <- attr(object, "DImodel")
      }

      newdata <- newdata[order(newdata[[attr(object, "unitIDs")]], newdata[[attr(object, "Yfunc")]]), ]
    }

  }

  #ID grouping
  ID_name_check(ID = attr(object, "IDs"), prop = attr(object, "props"), FG = attr(object, "FGs"))
  grouped_ID <- group_IDs(data = newdata, prop = attr(object, "props"), ID = attr(object, "IDs"))

  newdata <- cbind(newdata, grouped_ID)


  #Number of responses to be predicted
  nFuncs <- 1
  nTimes <- 1

  if(attr(object, "MVflag"))
  {
    nFuncs <- nlevels(as.factor(newdata[, attr(object, "Yfunc")]))
  }
  if(attr(object, "Timeflag"))
  {
    nTimes <- nlevels(as.factor(newdata[, attr(object, "time")]))
  }

  #Predict for each community, add each row to modelPreds (dataframe)
  form <- stats::delete.response(object[["terms"]])
  contr <- object$contrasts
  dataMod <- stats::model.frame(formula = form, data = newdata,
                                drop.unused.levels = TRUE, xlev = lapply(contr, rownames))
  N <- nrow(dataMod)
  if (length(all.vars(form)) > 0)
  {
    X <- stats::model.matrix(form, dataMod, contr)
  }
  else
  {
    X <- array(1, c(N, 1), list(row.names(dataMod), "(Intercept)"))
  }
  cf <- object$coefficients
  val <- c(X[, names(cf), drop = FALSE] %*% cf)
  lab <- "Predicted values"
  if (!is.null(aux <- attr(object, "units")$y))
  {
    lab <- paste(lab, aux)
  }
  modelPreds <- structure(val, label = lab)

  if(singleRow)
  {
    modelPreds <- modelPreds[1]
  }

  if(attr(object, "MVflag") & !attr(object, "Timeflag"))
  {
    modelPreds <- cbind.data.frame(newdata[[attr(object, "unitIDs")]], modelPreds, newdata[, attr(object, "Yfunc")])
    colnames(modelPreds) <- c(attr(object, "unitIDs"), "Yvalue", attr(object, "Yfunc"))
  }
  else if(attr(object, "Timeflag") & !attr(object, "MVflag"))
  {
    modelPreds <- cbind.data.frame(newdata[[attr(object, "unitIDs")]], modelPreds, newdata[, attr(object, "time")])
    colnames(modelPreds) <- c(attr(object, "unitIDs"), "Yvalue", attr(object, "time"))
  }
  else #both
  {
    modelPreds <- cbind.data.frame(newdata[[attr(object, "unitIDs")]], modelPreds)
    modelPreds$Ytype <- apply(newdata[, c(attr(object, "Yfunc"), attr(object, "time"))], 1, paste, collapse = ":")
    colnames(modelPreds) <- c(attr(object, "unitIDs"), "Yvalue", "Ytype")
  }

  predForm <- stats::as.formula(paste(attr(object, "unitIDs"), "~", colnames(modelPreds)[3]))

  if(!stacked)
  {
    modelPreds <- reshape2::dcast(data = modelPreds, formula = predForm, value.var = "Yvalue")
  }

  return(modelPreds)
}
