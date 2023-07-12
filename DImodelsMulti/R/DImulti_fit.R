###########################################################################################################################################################################################
#' DImulti
#'
#' @description A function to fit Diversity-Interactions models to data with multiple ecosystem functions and/or multiple time points
#'
#' @param y If the dataset is in a wide format, this argument is a vector of k column names identifying the ecosystem function values recorded from each experimental unit in the dataset. For example, if the ecosystem function columns are labelled Y1 to Y4, then \code{y = c("Y1","Y2","Y3","Y4")}. Alternatively, the column numbers can be specified, for example, \code{y = 8:11}, where ecosystem function values are in the 8th to 11th columns. \cr If the dataset is in the long/stacked format, this argument is the column name of the response value vector, for example, \code{y = "yield"}, alternatively, the column number can be supplied, \code{y = 8}
#' @param eco_func A vector of size two, with the first index holding the column name containing the character or factor indicator of which response was recorded (for use when stacked/long data passed through parameter y), otherwise it is the string \code{"NA"}, case insensitive. The second index should contain a string referring to the autocorrelation structure of the responses (for use in multivariate data case), options include \code{"un"} for unstructured/general and \code{"cs"} for compound symmetry. For example, \code{ecoFunc = c("Function", "cs")}, pertaining to multivariate data in a stacked format with a compound symmetry structure, or \code{ecoFunc = c("na", "un")}, meaning either univariate or wide multivariate data with an unstructured/general variance covariance matrix
#' @param time A vector of size two, with the first index holding the column name containing the repeated measures identifier (i.e., indicating which time point the corresponding response was recorded at), otherwise it is the string \code{"NA"}, case insensitive. The second index should contain a string referring to the autocorrelation structure of the repeated measures, options include \code{"un"} for unstructured/general, \code{"cs"} for compound symmetry, and \code{"ar1"} for an autoregressive model of order 1 (AR(1)). For example, \code{time = c("reading", "ar1")}, pertaining to repeated measures data with multiple readings on each unit with an AR(1) structure, or \code{time = c("na", "un")}, meaning multivariate data with no repeated measures (the correlation structure will be ignored)
#' @param unit_IDs A vector of columns names/indices containing identifiers for the experimental units from which the observations (either multiple readings of the same response or a single reading of multiple responses) are taken. Any number of identifiers can be included but they must be in nested order, from largest to smallest, e.g., \code{unitIDs = "Plot"} or \code{unitIDs = c("Plot", "ReplicateNo.")}
#' @param prop A vector of S column names identifying the species proportions in each community in the dataset. For example, if the species proportions columns are labelled p1 to p4, then \code{prop = c("p1","p2","p3","p4")}. Alternatively, the column numbers can be specified, for example, \code{prop = 4:7}, where species proportions are in the 4th to 7th columns
#' @param FG If species are classified by g functional groups, this argument takes a string vector (of length S) of the functional group to which each species referenced in the \code{prop} argument belongs. For example, for four grassland species with two grasses and two legumes: FG could be \code{FG = c("G","G","L","L")}, where G stands for grass and L stands for legume. This argument is optional but must be supplied if the \code{"FG"} interaction structure is specified in the \code{what} argument
#' @param data A dataframe or tibble containing all previously input columns
#' @param extra_fixed A formula expression for any additional fixed effect terms. For example,  \code{extraFixed = ~ Treatment} or \code{extraFixed = ~ Treatment + Density}
#' @param DImodel A vector of strings, referring to the interaction structure of model to be fit from the full list: \code{"STR", "ID", "FULL", "E", "AV", "ADD", "FG"}
#' @param estimate_theta By default, \eqn{\theta} (the power parameter on all \code{p_i * p_j} components of each interaction variable in the model) is set equal to one. Specify \code{estimate_theta = TRUE} to include the estimation of \eqn{\theta} in the specified model.
#' @param theta Users may specify a value of \eqn{\theta} different than 1 to fit the DI model. Note that if \code{estimate_theta = TRUE}, then \eqn{\theta} will be estimated via maximum profile log-likelihood and the value specified for \code{theta} will be overridden. Specify a vector of positive non-zero numerical values indicating the value for the non-linear parameter of the model for each ecosystem function (in alphabetical order, use \code{sort()} to find this) present in the dataset, or a single value to be used for all. For example, \code{theta = 0.5} or \code{theta = c(1, 0.5, 1)}
#' @param method The string \code{"REML"} or \code{"ML"}, referring to the estimation method to be used
#'
#' @return \code{DIMulti} - a custom class object containing a list of the models fit
#'
#' @details <here describe DI models etc. follow DImodels example> \cr
#'
#' @seealso
#' \code{\link[nlme]{gls}} which this function wraps \cr \cr
#' \code{\link[DImodels]{DImodels}} the parent package for use with data with a single ecosystem function at a single timepoint
#'
#' @export
#'
#' @examples
#' ## Recreation of Dooley et al. 2015 model
#' data(dataBEL)
#' m1 <- DImulti(prop = 2:5, y = c("Y"), eco_func = c("Var", "un"),
#'               FG=c("G", "G", "L", "L"), extra_fixed = ~ Density,
#'               unit_IDs = 1, theta = 1, DImodel = c("FG"), method = "REML",
#'               data = dataBEL)
#' summary(m1)
#'
#' ## Repeated Measures analysis of COST data
#' data(dataSWE)
#' m2 <- DImulti(...)


###########################################################################################################################################################################################

#Need to add STR back to 'what'
DImulti <- function(y, eco_func = c("NA", "NA"), time = c("NA", "NA"), unit_IDs, prop, data, DImodel, FG = NULL, extra_fixed = NULL, estimate_theta = FALSE, theta = 1, method = "REML")
{

  ##Change Snake to Camel Case to match my coding style ###################################################################################################################################

  ecoFunc <- eco_func
  unitIDs <- unit_IDs
  extraFixed <- extra_fixed
  estimateTheta <- estimate_theta

  #########################################################################################################################################################################################

  ##Errors#################################################################################################################################################################################

  ##data
  if(missing(data))
  {
    stop(crayon::bold(crayon::red("You must supply a dataframe through the argument 'data'.\n")))
  }
  if(inherits(data, 'tbl_df'))
  {
    data <- as.data.frame(data)
  }
  if(any(c("AV", "E", "NULL", "NA") %in% colnames(data)))
  {
    stop(crayon::bold(crayon::red("You must not have any columns named \"AV\" or \"E\", \"NA\" or \"NULL\" in your dataset provided through the parameter 'data'")))
  }
  if(any(startsWith(colnames(data), c("FULL.", "FG."))))
  {
    stop(crayon::bold(crayon::red("You must not have any column names beginning with \"FULL.\" or \"FG.\" in your dataset provided through the parameter 'data'")))
  }
  if(any(endsWith(colnames(data), c("_add"))))
  {
    stop(crayon::bold(crayon::red("You must not have any column names ending with \"_add\" in your dataset provided through the parameter 'data'")))
  }
  #################

  ##prop
  if(missing(prop))
  {
    stop(crayon::bold(crayon::red("You must supply species proporion variable names or column indices through the argument 'prop'.\n")))
  }
  if(length(prop) < 2)
  {
    stop(crayon::bold(crayon::red("You must supply multiple species proporion variable names or column indices through the argument 'prop'.\n")))
  }
  #If positions are passed, change to names
  if(is.numeric(prop[1]))
  {
    prop <- colnames(data)[prop]
  }
  #Check names are in dataset
  if(!all(prop %in% colnames(data)))
  {
    stop(crayon::bold(crayon::red("One or more of the columns referenced in the parameter 'prop' do not exist in the dataset specified through the 'data' parameter.\n")))
  }

  pi_sums <- apply(data[, prop], 1, sum)
  if(any(pi_sums > 1.0001) | any(pi_sums < 0.9999) & !is.null(extraFixed))
  {
    warning(crayon::bold(crayon::red("One or more rows have species proportions that do not sum to 1. It is assumed that this is by design with the missing proportions specified through the parameter 'extraFixed', but please ensure this.\n")))
  }
  else if(any(pi_sums > 1.0001) | any(pi_sums < 0.9999) & is.null(extraFixed))
  {
    stop(crayon::bold(crayon::red("One or more rows have species proportions that do not sum to 1. Please correct this prior to analysis.\n")))
  }
  else if(any(pi_sums < 1 & pi_sums > 0.9999) | any(pi_sums > 1 & pi_sums < 1.0001))
  {
    Pi_sums <- apply(data[, prop], 1, sum)
    Pi_sums <- ifelse(Pi_sums == 0, 1, Pi_sums)
    data[, prop] <- data[, prop] / Pi_sums
    warning(crayon::italic(crayon::red("One or more rows have species proportions that sum to approximately 1, but not exactly 1. This is typically a rounding issue, and has been corrected internally prior to analysis.\n")))
  }
  #####################

  ##FG
  if(!is.null(FG))
  {
    cond0  <- length(FG)!= length(prop)
    cond1  <- length(grep(":", FG)) > 0
    cond2  <- any(FG == "_")
    cond3  <- any(FG == "i")
    cond4  <- any(FG == "n")
    cond5  <- any(FG == "f")
    cond6  <- any(FG == "g")
    cond7  <- any(FG == "_i")
    cond8  <- any(FG == "in")
    cond9  <- any(FG == "nf")
    cond10 <- any(FG == "fg")
    cond11 <- any(FG == "g_")
    cond12 <- any(FG == "_in")
    cond13 <- any(FG == "inf")
    cond14 <- any(FG == "nfg")
    cond15 <- any(FG == "fg_")
    cond16 <- any(FG == "_inf")
    cond17 <- any(FG == "infg")
    cond18 <- any(FG == "nfg_")
    cond19 <- any(FG == "_infg")
    cond20 <- any(FG == "infg_")
    cond21 <- any(FG == "_infg_")

    if(cond1 | cond2 | cond3 | cond4 | cond5 | cond6 | cond7 |
        cond8 | cond9 | cond10 | cond11 | cond12 | cond13 | cond14 |
        cond15 | cond16 | cond17 | cond18 | cond19 | cond20 |
        cond21)
    {
      stop(crayon::bold(crayon::red("Please give your functional groups a different name.",
           " Names should not include colons (':'), or any single or multiple",
           " character combination of the expression '_infg_'.",
           " This expression is reserved for computing functional groups internally.")))
    }
    if(cond0)
    {
      stop(crayon::bold(crayon::red("The number of Functional Groups supplied does not match the number of species suuplied through 'prop'")))
    }
  }
  #################

  ##extra_fixed
  if(!plyr::is.formula(extraFixed))
  {
    stop(crayon::bold(crayon::red("You must supply a formula through the argument 'extra_fixed'\n")))
  }

  #change to string for concatenation
  extraFixed <- paste0("+", substring(deparse(extraFixed), 2))

  #################

  ##y, eco_func, & time
  if(missing(y))
  {
    stop(crayon::bold(crayon::red("You must supply response variable names or column indices through the argument 'y'.\n")))
  }
  #If positions are passed, change to names
  if(is.numeric(y[1]))
  {
    y <- colnames(data)[y]
  }
  #Check names are in dataset
  if (!all(y %in% colnames(data)))
  {
    stop(crayon::bold(crayon::red("One or more of the columns referenced in the parameter 'y' do not exist in the dataset specified through the 'data' parameter.\n")))
  }
  if (!(ecoFunc[1] %in% colnames(data)) & toupper(ecoFunc[1]) != "NA")
  {
    stop(crayon::bold(crayon::red("The column referenced in the parameter 'eco_func' does not exist in the dataset specified through the 'data' parameter.\n")))
  }
  if (!(time[1] %in% colnames(data)) & toupper(time[1]) != "NA")
  {
    stop(crayon::bold(crayon::red("The column referenced in the parameter 'time' does not exist in the dataset specified through the 'data' parameter.\n")))
  }

  if (!all(is.numeric(as.matrix(data[, y]))))
  {
    stop(crayon::bold(crayon::red("You must supply numerical response variable column names or indices through the argument 'y'.\n")))
  }

  #Ensure strings are passed
  if (!is.character(ecoFunc[1]))
  {
    stop(crayon::bold(crayon::red("You must either enter the column name for your ecosystem function response indicator as a string or \"NA\" for the first position in the vector parameter 'eco_func'")))
  }
  if (!is.character(time[1]))
  {
    stop(crayon::bold(crayon::red("You must either enter the column name for your time indicator as a string or \"NA\" for the first position in the vector parameter 'time'")))
  }


  if(length(ecoFunc) != 2)
  {
    stop(crayon::bold(crayon::red("You must supply a vector of length 2 to the argument 'eco_func'.\n")))
  }

  if(length(time) != 2)
  {
    stop(crayon::bold(crayon::red("You must supply a vector of length 2 to the argument 'time'.\n")))
  }

  if(length(y) > 1 & toupper(ecoFunc[1]) != "NA")
  {
    stop(crayon::bold(crayon::red("You specified that data is both long and wide. You must supply either multiple response variable names or column indices through the argument 'y' (wide data) OR a single response value column through the parameter 'y' and a single response indicator column through the parameter 'eco_func' (long/stacked data)\n")))
  }

  if(length(y) < 2 & toupper(ecoFunc[1]) == "NA" & toupper(time[1]) == "NA")
  {
    stop(crayon::bold(crayon::red("You must supply either multiple response variable names or column indices through the argument 'y' (wide data), a single response value column through the parameter 'y' and a single character/factor response indicator column through the parameter 'eco_func' (long/stacked data), or a repeated measure indicator column through the 'time' parameter.\n")))
  }

  if(toupper(ecoFunc[2]) != "NA" & length(y) < 2 & toupper(ecoFunc[1]) == "NA")
  {
    warning(crayon::bold(crayon::red("You supplied a response correlation structure with only a single response, the correlation structure will be ignored.\n")))
  }

  if(toupper(time[2]) != "NA" & toupper(time[1]) == "NA")
  {
    warning(crayon::bold(crayon::red("You supplied a time correlation structure with no repeated measure specified, the correlation structure will be ignored.\n")))
  }
  #################

  ##unitIDs
  if(missing(unitIDs))
  {
    stop(crayon::bold(crayon::red("You must either supply an ID variable name or column index through the argument 'unit_IDs'.\n")))
  }
  #If positions are passed, change to names
  if(is.numeric(unitIDs[1]))
  {
    unitIDs <- colnames(data)[unitIDs]
  }
  #Check names are in dataset
  if(!all(unitIDs %in% colnames(data)))
  {
    stop(crayon::bold(crayon::red("One or more of the columns referenced in the parameter 'unit_IDs' do not exist in the dataset specified through the 'data' parameter.\n")))
  }

  #################

  ##DImodel
  if(length(DImodel) != 1)
  {
    stop(crayon::bold(crayon::red("You must enter a single model type through the parameter 'DImodel")))
  }
  if(!(DImodel %in% c("STR", "ID", "FULL", "E", "AV", "ADD", "FG")))
  {
    stop(crayon::bold(crayon::red("You have entered an unknown argument through the 'DImodel' parameter. \nThe options for the 'DImodel' parameter are: \"STR\", \"ID\", \"FULL\", \"E\", \"AV\", \"ADD\", \"FG\"")))
  }
  ###################

  ##theta (vector)
  if(all(is.numeric(theta)) && (all(theta < 0) || all(theta == 0)))
  {
    stop(crayon::bold(crayon::red("Please supply positive non-zero values for the parameter 'theta'")))
  }
  if(!all(is.numeric(theta)))
  {
    stop(crayon::bold(crayon::red("You must enter numeric values for theta")))
  }

  #estimate_theta
  if(!is.logical(estimateTheta))
  {
    stop(crayon::bold(crayon::red("You must supply a logical value or TRUE or FALSE through the argument estimate_theta")))
  }

  if(estimateTheta && (all(theta != 1)))
  {
    warning(crayon::bold(crayon::red("You have supplied values for theta while estimate_theta is set to TRUE, theta will be estimated and the theta values given will be overridden")))
  }

  #####################

  ##method
  if(method != "REML" && method != "ML")
  {
    stop(crayon::bold(crayon::red("You must either enter \"REML\" or \"ML\" as a string for the parameter 'method'")))
  }
  #####################

  #########################################################################################################################################################################################

  ##Prepare Data to Fit Later##############################################################################################################################################################

  #Create flags to quickly tell if something is present
  MVflag <- if(length(y) > 1 | (length(y) == 1 & toupper(ecoFunc[1]) != "NA")) TRUE else FALSE
  Stackedflag <- if(length(y) == 1 & toupper(ecoFunc[1]) != "NA") TRUE else FALSE
  Timeflag <- if(toupper(time[1]) != "NA") TRUE else FALSE
  Thetaflag <- if(estimateTheta){ TRUE; theta <- 1} else FALSE
  exFixflag <- if (!is.null(extraFixed)) TRUE else FALSE


  #Check theta length matches length of ecoFuncs
  if(!MVflag && length(theta) != 1)
  {
    stop("Unless the data supplied is multivariate, please only supply one value for theta")
  }
  else if(Stackedflag)
  {
    if(length(theta) == 1)
    {
      theta <- rep(theta, length(unique(data[[ecoFunc[1]]]))) # use same theta for each EF
    }
    else if((length(theta) != 1) && (length(theta) != length(unique(data[[ecoFunc[1]]]))))
    {
      stop("You must suppy a value of theta for each ecosystem function (ecoFunc), or a single value of theta to use for all ecosystem functions")
    }
  }
  else # (MVflag && !Stackedflag)
  {
    if(Thetaflag && length(theta) == 1)
    {
      theta <- rep(theta, length(y)) # use same theta for each EF
    }
    else if((length(theta) != 1) && (length(theta) != length(y)))
    {
      stop("You must suppy a value of theta for each ecosystem function (y), or a single value of theta to use for all ecosystem functions")
    }
  }


  #Placeholders
  Yfunc <- "NA"
  Yvalue <- "NA"

  #Convert characters to factors
  if(Stackedflag)
  {
    if(is.character(data[, ecoFunc[1]]) | is.numeric(data[, ecoFunc[1]]))
    {
      data[, ecoFunc[1]] <- as.factor(data[, ecoFunc[1]])
    }

    Yfunc <- ecoFunc[1]
    Yvalue <- y[1]
  }


  #DImodel parameter checks
  STRflag  <- if("STR"  %in% DImodel) TRUE else FALSE
  IDflag   <- if("ID"   %in% DImodel) TRUE else FALSE
  FULLflag <- if("FULL" %in% DImodel) TRUE else FALSE
  Eflag    <- if("E"    %in% DImodel) TRUE else FALSE
  AVflag   <- if("AV"   %in% DImodel) TRUE else FALSE
  ADDflag  <- if("ADD"  %in% DImodel) TRUE else FALSE
  FGflag   <- if("FG"   %in% DImodel) TRUE else FALSE

  #Conditions checks
  Econdflag   <- if(length(prop) > 2) TRUE else FALSE
  AVcondflag  <- if(length(prop) > 2) TRUE else FALSE
  ADDcondflag <- if(length(prop) > 3) TRUE else FALSE
  FGcondflag  <- if (!is.null(FG))    TRUE else FALSE


  #Match conditions with DImodel
  if(Eflag && !Econdflag)
  {
    stop(crayon::bold(crayon::red("Less than 3 species present, E model will not be produced as it is uninformative\n")))
  }
  else if(AVflag && !AVcondflag)
  {
    stop(crayon::bold(crayon::red("Less than 3 species present, AV model will not be produced as it is uninformative\n")))
  }
  else if(ADDflag && !ADDcondflag)
  {
    stop(crayon::bold(crayon::red("Less than 4 species present, ADD model will not be produced as it is uninformative\n")))
  }
  else if(FGflag && !FGcondflag)
  {
    stop(crayon::bold(crayon::red("No functional groups given, FG model will not be produced\n")))
  }
  else if(FGflag & any(!is.character(FG)))
  {
    stop(crayon::bold(crayon::red("FG argument takes character strings with functional",
                                  " group names referring to each species, in order")))
  }

  #Separate response/structure and time/structure
  timeCol <-  time[1]
  timeCorr <- time[2]

  funcCorr <- ecoFunc[2]


  #If multivariate and wide, melt data (change to stacked/long)
  if(MVflag & !Stackedflag)
  {
    #Get names of non response columns
    predictors <- setdiff(colnames(data), y)

    data <- reshape2::melt(data,
                           id.vars = predictors,
                           variable.name = "func",
                           value.name = "value")

    Yfunc <- "func"
    Yvalue <- "value"
  }

  if(MVflag)
  {
    data <- data[order(data[[unitIDs]], data[[Yfunc]]), ]
  }
  else
  {
    data <- data[order(data[[unitIDs]]), ]

    Yvalue <- y
  }


## Interaction Columns & Theta ############################################################################################################################################################

  if(DImodel != "STR" & DImodel != "ID") # Interactions?
  {

    if(estimateTheta)
    {
      if(!MVflag) #single value
      {
        tempModel <- DImodels::DI(y = Yvalue, prop = prop, FG = FG, DImodel = DImodel, extra_formula = extraFixed, data = data, estimate_theta = TRUE)

        theta <- tempModel$coefficients[["theta"]]
      }
      else #split by ecosystem function
      {
        iCount <- 1

        #Remove any mention of ecosystem functions from extraFixed
        extraTemp <- gsub(paste0(Yfunc, "\\s*[:|\\*]"), "", extraFixed)
        extraTemp <- gsub(paste0("[:|\\*]\\s*", Yfunc), "", extraTemp)
        extraTemp <- gsub(paste0("\\+\\s*", Yfunc), "", extraTemp)

        for(i in unique(data[, Yfunc]))
        {
          tempModel <- DImodels::DI(y = Yvalue, prop = prop, FG = FG, DImodel = DImodel, extra_formula = extraTemp, data = data[which(data[, Yfunc] == i), ], estimate_theta = TRUE)

          theta[iCount] <- tempModel$coefficients[["theta"]]

          iCount <- iCount + 1
        }
      }
    }


    if(length(unique(theta)) == 1) # All the same theta value
    {
      intCols <- DImodels::DI_data(prop = prop, FG = FG, data = data, theta = theta[1], what = DImodel)

      #Change new column names
      if(FULLflag)
      {
        for(i in 1:ncol(intCols))
        {
          colnames(intCols)[i] <- paste0("FULL.", colnames(intCols)[i])
        }
        data <- cbind(data, data.frame(intCols))
      }
      else if(FGflag)
      {
        for(i in 1:ncol(intCols))
        {
          colnames(intCols)[i] <- paste0("FG.", colnames(intCols)[i])
        }
        data <- cbind(data, data.frame(intCols))
      }
      else if(AVflag | Eflag)
      {
        data <- cbind(data, data.frame(intCols))

        colnames(data)[ncol(data)] <- DImodel
      }
      else if(ADDflag)
      {
        data <- cbind(data, data.frame(intCols))
      }
    }

    else if(length(theta > 1) && !all(theta == 1)) # Differing theta values
    {
      dataTemp <- data.frame()
      iCount <- 1

      #need to divide up dataset by EF and apply each theta in loop
      for(i in unique(data[, Yfunc]))
      {
        intCols <- DImodels::DI_data(prop = prop, FG = FG, data = data[which(data[, Yfunc] == i), ], theta = theta[iCount], what = DImodel)

        #Change new column names
        if(FULLflag)
        {
          for(j in 1:ncol(intCols))
          {
            colnames(intCols)[j] <- paste0("FULL.", gsub(":", ".", colnames(intCols)[j]))
          }
        }
        else if(FGflag)
        {
          for(j in 1:ncol(intCols))
          {
            colnames(intCols)[j] <- paste0("FG.", colnames(intCols)[j])
          }
        }

        dataTemp <- rbind(dataTemp, cbind(data[which(data[, Yfunc] == i), ], intCols))

        iCount <- iCount + 1
      }
      data <- dataTemp

      if(AVflag | Eflag)
      {
        colnames(data)[ncol(data)] <- DImodel
      }

      data <- data[order(data[[unitIDs]], data[[Yfunc]]), ]
    }

  }
  else if((DImodel == "STR" | DImodel == "ID") & (estimateTheta | !all(theta == 1)))
  {
    warning(crayon::italic(crayon::red("You specified for theta to be estimated or supplied values for theta but selected a DI mdoel type with no interactions, this will be ignored.")))
  }


  #########################################################################################################################################################################################

  ##Prepare Generic Parts of 'formula'#####################################################################################################################################################

  #Initialise strings for formula storage
  formulaStart <- ""
  formulaEnd <- ""

  if(MVflag && tolower(funcCorr) == "un" & !Timeflag)
  {
    MVform <- as.formula(paste0("~ 0 | ", Yfunc))
    weightGen <- nlme::varIdent(form = MVform)

  }
  else if(Timeflag && tolower(timeCorr) == "un" & !MVflag)
  {
    timeform <- as.formula(paste0("~ 0 | ", timeCol))
    weightGen <- nlme::varIdent(form = timeform)

  }
  else if(Timeflag && tolower(timeCorr) == "un" & MVflag && tolower(funcCorr) == "un")
  {
    weightGen <- nlme::varIdent(form = as.formula(paste0("~ 0 |", Yfunc, "*", timeCol)))
    #weightGen <- nlme::varComb(nlme::varIdent(form = ~ 0 | func), nlme::varIdent(form = paste("~ 0 |", timeCol)))
  }
  else
  {
    weightGen <- NULL
  }


  if(MVflag && Timeflag)
  {
    formulaStart <- paste0(formulaStart, Yvalue, " ~ 0 + ", Yfunc, ":", timeCol, ":((")
  }
  else if(MVflag)
  {
    formulaStart <- paste0(formulaStart, Yvalue, " ~ 0 +", Yfunc, ":((")
  }
  else
  {
    formulaStart <- paste0(formulaStart, y, " ~ 0 + ", timeCol, ":((")
  }

  formulaEnd <- paste0(formulaEnd, ")")

  if(exFixflag)
  {
    formulaEnd <- paste0(" )", extraFixed, formulaEnd)
  }
  else
  {
    formulaEnd <- paste0(" )", formulaEnd)
  }


  #########################################################################################################################################################################################

  ##Fit models#############################################################################################################################################################################

  ##Intercept Only Model
  if(STRflag)
  {
    #Format Correlation Structure
    corr <- DI_vcov("STR", MVflag, Timeflag, funcCorr, timeCorr, formulaStart, formulaEnd, prop, Yfunc, Yvalue, unitIDs, method, timeCol, data)

    #Call fit
    fitReturn <- fit_Intercept(MVflag, Timeflag, Yfunc, Yvalue, timeCol, formulaEnd, weightGen, corr, method, data)
    formula <- fitReturn[[1]]
    model <- fitReturn[[2]]
    name <- "Structure Model"
  }



  ##ID Model
  else if(IDflag)
  {
    #Format Correlation Structure
    corr <- DI_vcov("ID", MVflag, Timeflag, funcCorr, timeCorr, formulaStart, formulaEnd, prop, Yfunc, Yvalue, unitIDs, method, timeCol, data)
    corrform <- corr[[2]]
    corr <- corr[[1]]

    #Call fit
    fitReturn <- fit_ID(formulaStart, formulaEnd, prop, weightGen, corr, method, data)
    formula <- fitReturn[[1]]
    model <- fitReturn[[2]]
    name <- "Identity Model"
  }



  ##Pairwise Model
  else if(FULLflag)
  {
    #Format Correlation Structure
    corr <- DI_vcov("FULL", MVflag, Timeflag, funcCorr, timeCorr, formulaStart, formulaEnd, prop, Yfunc, Yvalue, unitIDs, method, timeCol, data)
    corrform <- corr[[2]]
    corr <- corr[[1]]

    #Call fit
    fitReturn <- fit_FULL(formulaStart, formulaEnd, prop, weightGen, corr, method, data)
    formula <- fitReturn[[1]]
    model <- fitReturn[[2]]
    name <- "Full Pairwise Model"
  }



  ##E Model
  else if(Eflag)
  {
    #Format Correlation Structure
    corr <- DI_vcov("E", MVflag, Timeflag, funcCorr, timeCorr, formulaStart, formulaEnd, prop, Yfunc, Yvalue, unitIDs, method, timeCol, data)
    corrform <- corr[[2]]
    corr <- corr[[1]]

    #Call fit
    fitReturn <- fit_E(formulaStart, formulaEnd, prop, weightGen, corr, method, data)
    formula <- fitReturn[[1]]
    model <- fitReturn[[2]]
    name <- "Evenness Term Model"
  }


  ##AV Model
  else if(AVflag)
  {
    #Format Correlation Structure
    corr <- DI_vcov("AV", MVflag, Timeflag, funcCorr, timeCorr, formulaStart, formulaEnd, prop, Yfunc, Yvalue, unitIDs, method, timeCol, data)
    corrform <- corr[[2]]
    corr <- corr[[1]]

    #Call fit
    fitReturn <- fit_AV(formulaStart, formulaEnd, prop, weightGen, corr, method, data)
    formula <- fitReturn[[1]]
    model <- fitReturn[[2]]
    name <- "Average Term Model"
  }



  ##ADD Model
  else if(ADDflag)
  {
    #Format Correlation Structure
    corr <- DI_vcov("ADD", MVflag, Timeflag, funcCorr, timeCorr, formulaStart, formulaEnd, prop, Yfunc, Yvalue, unitIDs, method, timeCol, data)
    corrform <- corr[[2]]
    corr <- corr[[1]]

    #Call fit
    fitReturn <- fit_ADD(formulaStart, formulaEnd, prop, weightGen, corr, method, data)
    formula <- fitReturn[[1]]
    model <- fitReturn[[2]]
    name <- "Additive Interactions Model"
  }



  ##FG Model
  else if(FGflag)
  {
    #Format Correlation Structure
    corr <- DI_vcov("FG", MVflag, Timeflag, funcCorr, timeCorr, formulaStart, formulaEnd, prop, Yfunc, Yvalue, unitIDs, method, timeCol, data)
    corrform <- corr[[2]]
    corr <- corr[[1]]

    #Call fit
    fitReturn <- fit_FG(formulaStart, formulaEnd, prop, weightGen, corr, method, data)
    formula <- fitReturn[[1]]
    model <- fitReturn[[2]]
    name <- "Functional Group Model"
  }

  #########################################################################################################################################################################################

  ##Print Output###########################################################################################################################################################################

  cat(crayon::bold("Make note that: \n"))
  cat(crayon::bold(paste(crayon::magenta("Method Used ="), crayon::underline(method), "\n")))
  cat(crayon::bold(paste(crayon::magenta("Correlation Structure Used ="), crayon::underline(corrform), "\n")))

  #Print Model Name
  cat(crayon::bold(crayon::green(name)))

  #If an interaction model, print theta
  if(name != "Intercept Only Model" & name != "ID Model")
  {
    cat(crayon::bold(crayon::magenta("\nTheta estimates = ")))
    cat(crayon::bold(crayon::underline(formatC(theta, format = "f", digits=3))), sep = ", ")
  }

  #########################################################################################################################################################################################

  ##Return Models##########################################################################################################################################################################

  attr(model, "thetas")        <- theta
  attr(model, "method")        <- method
  attr(model, "correlation")   <- corrform
  attr(model, "DImodel")       <- DImodel
  attr(model, "name")          <- name
  attr(model, "unitIDs")       <- unitIDs
  attr(model, "props")         <- prop
  attr(model, "FG")            <- FG
  attr(model, "Timeflag")      <- Timeflag
  attr(model, "time")          <- time[1]
  attr(model, "MVflag")        <- MVflag
  attr(model, "Yfunc")         <- Yfunc
  attr(model, "Yvalue")        <- Yvalue
  attr(model, "data")          <- data

  class(model) <- "DImulti"

  invisible(model)

  #########################################################################################################################################################################################
}
###########################################################################################################################################################################################


