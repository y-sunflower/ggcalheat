# ggcalheat

`ggcalheat` provides calendar heatmaps for `ggplot2` with a simple API:
map `date` and `value`, then call
[`geom_calendar()`](https://y-sunflower.github.io/ggcalheat/reference/geom_calendar.md).

  

## Installation

``` r
remotes::install_github("y-sunflower/ggcalheat")
```

  

## Quick start

``` r
library(ggplot2)
library(ggcalheat)

df <- data.frame(
  date = seq.Date(as.Date("2025-01-01"), as.Date("2025-12-31"), by = "day"),
  value = rpois(365, lambda = 3)
)

ggplot(df, aes(date = date, value = value)) +
  geom_calendar() +
  scale_fill_gradient(low = "grey95", high = "#2C7FB8") +
  theme_minimal()
```

![](./articles/img/example-1.png)

  

- Axis labels are calendar-aware by default (month abbreviations below
  the grid, weekday abbreviations on y). They are easy to customize:

``` r
ggplot(df, aes(date = date, value = value)) +
  geom_calendar(
    week_start = "monday",
    day_labels = c("Mo", "Tu", "We", "Th", "Fr", "Sa", "Su"),
    month_labels = "%b"
  ) +
  scale_fill_gradient(low = "grey95", high = "#2C7FB8")
```

  

- Signed values are supported directly with standard continuous scales:

``` r
df <- data.frame(
  date = seq.Date(as.Date("2025-01-01"), as.Date("2025-12-31"), by = "day"),
  value = rnorm(365, mean = 0, sd = 2)
)

ggplot(df, aes(date = date, value = value)) +
  geom_calendar() +
  scale_fill_gradient2(
    low = "#B2182B",
    mid = "white",
    high = "#2166AC",
    midpoint = 0
  ) +
  theme_minimal()
```

![](./articles/img/example-2.png)

  

- Interactive with ggiraph

``` r
library(ggplot2)
library(ggcalheat)
library(ggiraph)

gg <- ggplot(df, aes(date = date, value = value)) +
  geom_calendar_interactive(aes(
    tooltip = paste("Date:", date, "\nValue:", round(value, 1)),
    data_id = as.character(date)
  )) +
  scale_fill_gradient(low = "white", high = "purple") +
  theme_minimal()

girafe(ggobj = gg)
```

![](./articles/img/example-3.png)

[See more examples](https://y-sunflower.github.io/ggcalheat/)
