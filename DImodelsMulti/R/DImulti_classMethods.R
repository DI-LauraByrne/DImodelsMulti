#' print.DImulti
#' @method print DImulti
#'
#' @description Print details of the fitted DI models supplied
#'
#' @param x an object of class DImulti
#'
#' @return object x
#'
#' @seealso
#' \code{\link[base]{print}} which this function wraps.
#'
#' @export
#'
# @examples

print.DImulti <- function(x)
{

  #Print notes
  cat(crayon::bold("Make note that: \n"))
  cat(crayon::bold(paste(crayon::magenta("Method Used ="), crayon::underline(attr(x, "method")), "\n")))
  cat(crayon::bold(paste(crayon::magenta("Correlation Structure Used ="), crayon::underline(attr(x, "correlation")), "\n")))

  #Print Model Name
  cat(crayon::bold(crayon::green(attr(x, "name"))))
  #If an interaction model, print theta
  if(attr(x, "name") != "Intercept Only Model" & attr(x, "name") != "ID Model")
  {
    cat(crayon::bold(crayon::magenta("\nTheta estimates = ")))
    cat(crayon::bold(crayon::underline(formatC(attr(x, "thetas"), format = "f", digits=3))), sep = ", ")
  }

  cat("\n\n")
  print(x[[1]])
  cat("\n\n")

  invisible(x)
}


#' summary.DImulti
#' @method summary DImulti
#'
#' @description Print a summary of the fitted DI models supplied
#'
#' @param x an object inheriting from class DImulti, representing a list of generalized least squared fitted linear models using the Diversity-Interactions framework
#' @param verbose an optional logical value used to control the amount of output when the object is printed. Defaults to FALSE.
#'
#' @return object x <plus additional components (need to list, include DI notes)>
#'
#' @seealso
#' \code{\link[nlme]{summary.gls}} which this function wraps.
#'
#' @export
#'
# @examples

summary.DImulti <- function(x, verbose = FALSE)
{

  #Print notes
  cat(crayon::bold("Make note that: \n"))
  cat(crayon::bold(paste(crayon::magenta("Method Used ="), crayon::underline(attr(x, "method")), "\n")))
  cat(crayon::bold(paste(crayon::magenta("Correlation Structure Used ="), crayon::underline(attr(x, "correlation")), "\n")))


  #Print Model Name
  cat(crayon::bold(crayon::green(attr(x, "name"))))
  cat("\n")

  #If an interaction model, print theta
  if(attr(x, "name") != "Intercept Only Model" & attr(x, "name") != "ID Model")
  {
    cat(crayon::bold(crayon::magenta("\nTheta estimates = ")))
    cat(crayon::bold(crayon::underline(formatC(attr(x, "thetas"), format = "f", digits=3))), sep = ", ")
  }
  cat("\n\n")
  print(summary(x[[1]]))
  cat("\n\n")

  invisible(x)
}


#' predict.DImulti
#'
#' @method predict DImulti
#'
#' @description Predict from the DI models supplied
#'
#' @param object an object of class DImulti
#' @param newdata an optional dataframe containing the communities from which to predict
#'
#' @return The predictions from the supplied fitted DI models for the provided newdata, or the data used to fit the model if no newdata is supplied.
#'
#' @seealso
#' \code{\link[nlme]{predict.gls}} which this function wraps.
#'
#' @export
predict.DImulti <- function(object, newdata=NULL)
{
  if(is.null(newdata))
  {
    newdata <- attr(object, "data")
  }
  else if(attr(object, "MVflag"))
  {
    #If wide data, stack
    if(length(attr(object, "Yvalue")) != 1)
    {
      predictors <- setdiff(colnames(newdata), attr(object, "Yvalue"))

      newdata <- reshape2::melt(newdata,
                                id.vars = predictors,
                                variable.name = "func",
                                value.name = "value")
    }
    newdata <- newdata[order(newdata[[attr(object, "unitIDs")]], newdata[[attr(object, "Yfunc")]])]
  }
  else
  {
    newdata <- newdata[order(newdata[[attr(object, "unitIDs")]])]
  }

  modeldata <- newdata #Copy data to add columns as needed

  if((attr(object, "DImodel") != "STR") & (attr(object, "DImodel") != "ID"))
  {
#######################
    if(length(unique(attr(object, "thetas"))) == 1)
    {
      intCols <- DImodels::DI_data(prop = attr(object, "props"), FG = attr(object, "FG"), data = modeldata, theta = attr(object, "thetas")[1], what = attr(object, "DImodel"))
    }
    else
    {
      for(i in unique(modeldata[, attr(object, "Yfunc")]))
      {

      }
    }
    intCols <- DImodels::DI_data(prop = attr(object, "props"), FG = attr(object, "FG"), data = modeldata, theta = attr(object, "thetas"), what = attr(object, "DImodel"))
#######################

    #Fix column names need to move up into if/else (as in DImulti_fit.R)
    if(attr(object, "DImodel") == "FULL")
    {
      for(j in 1:ncol(intCols))
      {
        colnames(intCols)[j] <- paste0("FULL.", colnames(intCols)[j])
      }
    }
    #Fix column names
    if(attr(object, "DImodel") == "FG")
    {
      for(j in 1:ncol(intCols))
      {
        colnames(intCols)[j] <- paste0("FG.", colnames(intCols)[j])
      }
    }

    modeldata <- cbind(modeldata, data.frame(intCols))

    #Fix column names
    if(attr(object, "DImodel") %in% c("AV", "E"))
    {
      colnames(modeldata)[ncol(modeldata)] <- attr(object, "DImodel")
    }
  }


  #Number of responses to be predicted
  nFuncs <- 1
  nTimes <- 1

  if(attr(object, "MVflag"))
  {
    nFuncs <- nlevels(modeldata[, attr(object, "Yfunc")])
  }
  if(attr(object, "Timeflag"))
  {
    nTimes <- nlevels(modeldata[, attr(object, "time")])
  }



  #Predict for each community, add each row to modelPreds (dataframe)
  modelPreds <- predict(object[[1]], modeldata)
  modelPreds <- cbind.data.frame(split(modelPreds, rep(1:(nFuncs * nTimes), times = length(modelPreds) / (nFuncs * nTimes))), stringsAsFactors = TRUE)


  colNames <- list()
  if(attr(object, "MVflag") & !attr(object, "Timeflag"))
  {
    colNames <- levels(modeldata[, attr(object, "Yfunc")])
  }
  else if(attr(object, "Timeflag") & !attr(object, "MVflag"))
  {
    colNames <- levels(modeldata[, attr(object, "time")])
  }
  else
  {
      for(i in levels(modeldata[, attr(object, "Yfunc")]))
      {
        for(j in levels(modeldata[, attr(object, "time")]))
        {
          colNames <- append(colNames, paste(i, ":", j))
        }
      }
  }
  colnames(modelPreds) <- colNames

  modelPreds <- cbind(unique(modeldata[[attr(object, "unitIDs")]]), modelPreds)
  colnames(modelPreds)[1] <- attr(object, "unitIDs")

  return(modelPreds)
}



#' compare.DImulti
#'
