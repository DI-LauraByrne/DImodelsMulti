###########################################################################################################################################################################################
#Internal Modelling Functions for use in DImulti_fit, DImulti_Vcov, and DImulti_theta
#' @keywords internal
#' @noRd

fit_Intercept <- function(MVflag, Timeflag, Yfunc, Yvalue, timeCol, formulaEnd, weightGen, corr, method, data)
{
  if(formulaEnd == " ) )")
  {
    formulaEndSTR <- ""
  }
  else
  {
    formulaEndSTR <- sub(".", "", formulaEnd)
    formulaEndSTR <- paste0(":((", formulaEndSTR)
  }

  if(MVflag && Timeflag)
  {
    formulaSTR <- paste0(Yvalue, "~ 0 +", Yfunc, ":", timeCol, formulaEndSTR)
  }
  else if(MVflag)
  {
    formulaSTR <- paste0(Yvalue, "~ 0 +", Yfunc, formulaEndSTR)
  }
  else
  {
    formulaSTR <- paste0(Yvalue, "~ 0 + ", timeCol, formulaEndSTR)
  }
  print(formulaSTR)
  formulaSTR <- as.formula(formulaSTR)
  print(formulaSTR)
  modelSTR <- eval(bquote( nlme::gls(.(formulaSTR), weights = .(weightGen), correlation = .(corr), method = .(method), data = data) ))
  return(list(formulaSTR, list(modelSTR)))
}


fit_ID <- function(formulaStart, formulaEnd, prop, weightGen, corr, method, data)
{
  formula <- formulaStart

  #IDs
  formula <- paste0(formula, paste(prop, collapse = "+"), formulaEnd)

  formulaID <- as.formula(formula)
  modelID <- eval(bquote( nlme::gls(.(formulaID), weights = .(weightGen), correlation = .(corr), method = .(method), control = nlme::glsControl(msMaxIter = 50000, opt = "optim"), data = data) ))
  return(list(formulaID, list(modelID)))
}


fit_FULL <- function(formulaStart, formulaEnd, prop, weightGen, corr, method, data)
{
  formula <- formulaStart

  #IDs + Pairs
  formula <- paste0(formula, paste(prop, collapse = "+"), "+", paste(colnames(dplyr::select(data, starts_with("FULL."))), collapse = "+"), formulaEnd)

  formulaPair <- as.formula(formula)

  modelPair <- eval(bquote( nlme::gls(.(formulaPair), weights = .(weightGen), correlation = .(corr), method = .(method), control = nlme::glsControl(msMaxIter = 50000, opt = "optim"), data = data) ))

  return(list(formulaPair, list(modelPair)))
}


fit_E <- function(formulaStart, formulaEnd, prop, weightGen, corr, method, data)
{
  formula <- formulaStart

  #IDs + E
  formula <- paste0(formula, paste(prop, collapse = "+"), " + E", formulaEnd)

  formulaE <- as.formula(formula)
  modelE <- eval(bquote( nlme::gls(.(formulaE), weights = .(weightGen), correlation = .(corr), method = .(method), control = nlme::glsControl(msMaxIter = 50000, opt = "optim"), data = data) ))

  return(list(formulaE, list(modelE)))
}


fit_AV <- function(formulaStart, formulaEnd, prop, weightGen, corr, method, data)
{
  formula <- formulaStart

  #IDs + AV
  formula <- paste0(formula, paste(prop, collapse = "+"), " + AV", formulaEnd)

  formulaAV <- as.formula(formula)
  modelAV <- eval(bquote( nlme::gls(.(formulaAV), weights = .(weightGen), correlation = .(corr), method = .(method), control = nlme::glsControl(msMaxIter = 50000, opt = "optim"), data = data) ))

  return(list(formulaAV, list(modelAV)))
}


fit_ADD <- function(formulaStart, formulaEnd, prop, weightGen, corr, method, data)
{
  formula <- formulaStart

  #IDs + ADDs
  formula <- paste0(formula, paste(prop, collapse = "+"), "+", paste(colnames(dplyr::select(data, ends_with("_add"))), collapse = "+"), formulaEnd)

  formulaADD <- as.formula(formula)

  modelADD <- eval(bquote( nlme::gls(.(formulaADD), weights = .(weightGen), correlation = .(corr), method = .(method), control = nlme::glsControl(msMaxIter = 50000, opt = "optim"), data = data) ))

  return(list(formulaADD, list(modelADD)))
}


fit_FG <- function(formulaStart, formulaEnd, prop, weightGen, corr, method, data)
{
  formula <- formulaStart

  #IDs + FGs
  formula <- paste0(formula, paste(prop, collapse = "+"), "+", paste(colnames(dplyr::select(data, starts_with("FG."))), collapse = "+"), formulaEnd)

  formulaFG <- as.formula(formula)

  modelFG <- eval(bquote( nlme::gls(.(formulaFG), weights = .(weightGen), correlation = .(corr), method = .(method), control = nlme::glsControl(msMaxIter = 50000, opt = "optim"), data = data) ))

  return(list(formulaFG, list(modelFG)))
}
