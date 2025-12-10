# predict.DImulti

Predict from a multivariate repeated measures DI model

## Usage

``` r
# S3 method for class 'DImulti'
predict(object, newdata = NULL, stacked = TRUE, ...)
```

## Arguments

- object:

  an object of class DImulti

- newdata:

  an optional dataframe containing the communities from which to
  predict. If data is multivariate and in a wide format, to predict from
  a subset of ecosystem functions, as opposed to all, please include a
  column for each function with any numerical value, e.g.
  `newdata$Y2 <- 0`. If predicting from all functions, these columns may
  be included or left out.

- stacked:

  a logical value used to determine whether the output is in a wide or
  stacked format. Defaults to TRUE, meaning output is stacked/long.  
  If set to FALSE, non-unique groups of unit_IDs, ecosystem function,
  and time points will be aggregated upon widening using the mean
  function, please use unique unit_IDs values through newdata to avoid
  aggregation.

- ...:

  some methods for this generic function require additional arguments.
  None are used in this method.

## Value

The predictions from the supplied fitted DI models for the provided
'newdata', or the data used to fit the model if no 'newdata' is
supplied. Predictions are returned in either a stacked or wide dataframe
format.

## See also

[`predict.gls`](https://rdrr.io/pkg/nlme/man/predict.gls.html) which
this function wraps.
