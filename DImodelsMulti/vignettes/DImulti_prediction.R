## ---- include = FALSE---------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)

options(crayon.enabled = TRUE)

ansi_aware_handler <- function(x, options)
{
  paste0(
    "<pre class=\"r-output\"><code>",
    fansi::sgr_to_html(x = x, warn = FALSE, term.cap = "256"),
    "</code></pre>"
  )
}

old_hooks <- fansi::set_knit_hooks(knitr::knit_hooks,
                                 which = c("output", "message", "error", "warning"))
knitr::knit_hooks$set(
  output = ansi_aware_handler,
  message = ansi_aware_handler,
  warning = ansi_aware_handler,
  error = ansi_aware_handler
)

## ----setup--------------------------------------------------------------------
library(DImodelsMulti)

