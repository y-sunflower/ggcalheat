# ggcalheat

`ggcalheat` provides calendar heatmaps for `ggplot2` with a simple API: map
`date` and `value`, then call `geom_calendar()`.

## Installation

CRAN installation (when available):

```r
install.packages("ggcalheat")
```

Install the development version from GitHub:

```r
remotes::install_github("y-sunflower/ggcalheat")
```

## Quick start

```r
library(ggplot2)
library(ggcalheat)

set.seed(1)
df <- data.frame(
  date = seq.Date(as.Date("2025-01-01"), as.Date("2025-03-31"), by = "day"),
  value = rpois(90, lambda = 3)
)

ggplot(df, aes(date = date, value = value)) +
  geom_calendar() +
  scale_fill_gradient(low = "grey95", high = "#2C7FB8")
```

Signed values are supported directly with standard continuous scales:

```r
df_signed <- data.frame(
  date = seq.Date(as.Date("2025-01-01"), as.Date("2025-02-28"), by = "day"),
  value = rnorm(59, mean = 0, sd = 2)
)

ggplot(df_signed, aes(date = date, value = value)) +
  geom_calendar() +
  scale_fill_gradient2(
    low = "#B2182B",
    mid = "white",
    high = "#2166AC",
    midpoint = 0
  )
```

## Documentation

Full reference documentation: <https://y-sunflower.github.io/ggcalheat/>
