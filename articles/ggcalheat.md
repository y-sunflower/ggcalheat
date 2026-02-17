# ggcalheat: calendar heatmaps with ggplot2

`ggcalheat` provides
[`geom_calendar()`](https://y-sunflower.github.io/ggcalheat/reference/geom_calendar.md),
a calendar-heatmap layer for `ggplot2`. The interface is intentionally
simple: map `date` and `value`, and the calendar layout is computed for
you.

## 1 Setup

``` r
library(ggplot2)
library(ggcalheat)

set.seed(2026)

calendar_theme <- theme_minimal(base_size = 11) +
  theme(
    panel.grid = element_blank(),
    axis.title = element_blank(),
    axis.text = element_blank(),
    axis.ticks = element_blank()
  )
```

## 2 Build larger example data

This vignette uses a multi-year daily series (2022 to 2025) to show
calendar heatmaps on larger data.

``` r
all_dates <- seq.Date(as.Date("2022-01-01"), as.Date("2025-12-31"), by = "day")
n <- length(all_dates)

doy <- as.integer(format(all_dates, "%j"))
dow <- as.POSIXlt(all_dates)$wday
is_weekend <- dow %in% c(0, 6)

traffic <- data.frame(
  date = all_dates,
  value = pmax(
    0,
    round(
      24 +
        9 * sin(2 * pi * doy / 365.25) +
        ifelse(is_weekend, -8, 2) +
        rnorm(n, sd = 4)
    )
  )
)
traffic$year <- format(traffic$date, "%Y")

nrow(traffic)
#> [1] 1461
```

## 3 Basic usage on large daily series

``` r
ggplot(traffic, aes(date = date, value = value)) +
  geom_calendar() +
  facet_wrap(~year, ncol = 1, scales = "free_x") +
  scale_fill_gradient(low = "grey95", high = "#2C7FB8", name = "Traffic") +
  labs(title = "Daily traffic (2022-2025)") +
  calendar_theme
```

![](ggcalheat_files/figure-html/unnamed-chunk-3-1.png)

## 4 Signed data with a diverging scale

When values include both negative and positive values, use a diverging
fill scale with `midpoint = 0`.

``` r
anomaly <- data.frame(
  date = seq.Date(as.Date("2025-01-01"), as.Date("2025-12-31"), by = "day")
)

anomaly_doy <- as.integer(format(anomaly$date, "%j"))
anomaly$value <- round(
  2.5 * sin(2 * pi * anomaly_doy / 365.25) + rnorm(nrow(anomaly), sd = 1.8),
  2
)

ggplot(anomaly, aes(date = date, value = value)) +
  geom_calendar() +
  scale_fill_gradient2(
    low = "#B2182B",
    mid = "white",
    high = "#2166AC",
    midpoint = 0,
    name = "Anomaly"
  ) +
  labs(title = "Signed daily anomalies") +
  calendar_theme
```

![](ggcalheat_files/figure-html/unnamed-chunk-4-1.png)

## 5 Change week start to Monday

By default,
[`geom_calendar()`](https://y-sunflower.github.io/ggcalheat/reference/geom_calendar.md)
uses Sunday as the first day of week. You can switch to Monday.

``` r
q1_2025 <- traffic[
  traffic$date >= as.Date("2025-01-01") &
    traffic$date <= as.Date("2025-03-31"),
]

ggplot(q1_2025, aes(date = date, value = value)) +
  geom_calendar(week_start = "monday") +
  scale_fill_gradient(low = "grey95", high = "#1B9E77", name = "Traffic") +
  labs(title = "Q1 2025, Monday-first calendar") +
  calendar_theme
```

![](ggcalheat_files/figure-html/unnamed-chunk-5-1.png)

## 6 Sparse input + explicit date window

[`geom_calendar()`](https://y-sunflower.github.io/ggcalheat/reference/geom_calendar.md)
can fill missing dates in a larger display range using `na_value`.

``` r
sparse <- data.frame(
  date = sort(sample(
    seq.Date(as.Date("2025-01-01"), as.Date("2025-12-31"), by = "day"),
    120
  )),
  value = rpois(120, lambda = 6)
)

ggplot(sparse, aes(date = date, value = value)) +
  geom_calendar(
    start_date = as.Date("2024-11-01"),
    end_date = as.Date("2025-12-31"),
    na_value = 0
  ) +
  scale_fill_gradient(low = "grey95", high = "#D95F02", name = "Events") +
  labs(title = "Sparse data completed over an explicit window") +
  calendar_theme
```

![](ggcalheat_files/figure-html/unnamed-chunk-6-1.png)

## 7 Duplicate dates are summed automatically

If your source has multiple rows per day,
[`geom_calendar()`](https://y-sunflower.github.io/ggcalheat/reference/geom_calendar.md)
aggregates by day with `sum(value)`.

``` r
events <- data.frame(
  date = sample(
    seq.Date(as.Date("2025-01-01"), as.Date("2025-06-30"), by = "day"),
    size = 2500,
    replace = TRUE
  ),
  value = rgamma(2500, shape = 2.5, rate = 1 / 1.5)
)

ggplot(events, aes(date = date, value = value)) +
  geom_calendar() +
  scale_fill_gradient(low = "grey95", high = "#7570B3", name = "Sum/day") +
  labs(title = "Event-level rows aggregated per day") +
  calendar_theme
```

![](ggcalheat_files/figure-html/unnamed-chunk-7-1.png)

## 8 Style tile size and borders

You can control tile geometry and borders for a denser or lighter visual
style.

``` r
yr2024 <- traffic[traffic$year == "2024", ]

ggplot(yr2024, aes(date = date, value = value)) +
  geom_calendar(
    cell_width = 0.85,
    cell_height = 0.85,
    color = "white",
    linewidth = 0.25
  ) +
  scale_fill_gradient(low = "#F7FCF5", high = "#238B45", name = "Traffic") +
  labs(title = "2024 with tighter tiles and white borders") +
  calendar_theme
```

![](ggcalheat_files/figure-html/unnamed-chunk-8-1.png)

## 9 Facet by group

Calendar heatmaps can be faceted like regular `ggplot2` layers.

``` r
teams <- c("North", "Central", "South")
team_data <- do.call(
  rbind,
  lapply(seq_along(teams), function(i) {
    d <- seq.Date(as.Date("2025-01-01"), as.Date("2025-12-31"), by = "day")
    seasonal <- 20 + 7 * sin(2 * pi * as.integer(format(d, "%j")) / 365.25)
    data.frame(
      team = teams[i],
      date = d,
      value = pmax(0, round(seasonal + i * 3 + rnorm(length(d), sd = 3)))
    )
  })
)

ggplot(team_data, aes(date = date, value = value)) +
  geom_calendar() +
  facet_wrap(~team, ncol = 1) +
  scale_fill_gradient(low = "grey95", high = "#66A61E", name = "Value") +
  labs(title = "Team calendars") +
  calendar_theme
```

![](ggcalheat_files/figure-html/unnamed-chunk-9-1.png)

## 10 Interactive calendar heatmaps with ggiraph

[`geom_calendar_interactive()`](https://y-sunflower.github.io/ggcalheat/reference/geom_calendar_interactive.md)
uses ggiraph so tiles can expose tooltips and IDs.

``` r
library(ggiraph)

interactive_df <- traffic[traffic$year == "2025", ]

p_interactive <- ggplot(interactive_df, aes(date = date, value = value)) +
  geom_calendar_interactive(
    aes(
      tooltip = paste0("Date: ", date, "\nValue: ", value),
      data_id = as.character(date)
    ),
    color = "white",
    linewidth = 0.2
  ) +
  scale_fill_gradient(low = "grey95", high = "#2C7FB8", name = "Traffic") +
  labs(title = "Interactive 2025 calendar") +
  calendar_theme

girafe(ggobj = p_interactive)
```

## 11 Notes

- Required aesthetics are `date` and `value`.
- Continuous and diverging color behavior is controlled with standard
  `ggplot2` scales.
- Use
  [`geom_calendar_interactive()`](https://y-sunflower.github.io/ggcalheat/reference/geom_calendar_interactive.md)
  for ggiraph tooltips and clickable tiles.
- For production reports, consider fixed date windows (`start_date`,
  `end_date`) so plots are directly comparable.
