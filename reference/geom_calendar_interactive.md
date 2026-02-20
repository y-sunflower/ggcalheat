# Interactive calendar heatmap geometry for ggiraph

`geom_calendar_interactive()` behaves like
[`geom_calendar()`](https://y-sunflower.github.io/ggcalheat/reference/geom_calendar.md)
but draws tiles with ggiraph's interactive geometry.

## Usage

``` r
geom_calendar_interactive(
  mapping = NULL,
  data = NULL,
  ...,
  week_start = "sunday",
  start_date = NULL,
  end_date = NULL,
  na_value = 0,
  cell_width = 0.95,
  cell_height = 0.95,
  show_month_labels = TRUE,
  month_labels = "%b",
  month_label_y = 0.35,
  month_label_size = 3.5,
  month_label_color = "grey20",
  month_label_vjust = 1,
  show_day_labels = TRUE,
  day_labels = NULL,
  square = TRUE,
  color = NA,
  linewidth = 0,
  na.rm = FALSE,
  show.legend = NA,
  inherit.aes = TRUE
)
```

## Arguments

- mapping:

  Set of aesthetic mappings created by
  [`ggplot2::aes()`](https://ggplot2.tidyverse.org/reference/aes.html).
  Must include `date` and `value`.

- data:

  A data frame.

- ...:

  Additional parameters passed on to
  [`ggplot2::layer()`](https://ggplot2.tidyverse.org/reference/layer.html).

- week_start:

  First day of week. One of `"sunday"`, `"monday"`, `0`, or `1`.

- start_date:

  Optional lower date bound for the displayed range.

- end_date:

  Optional upper date bound for the displayed range.

- na_value:

  Value assigned to dates that are missing from input data.

- cell_width:

  Width of each day tile.

- cell_height:

  Height of each day tile.

- show_month_labels:

  If `TRUE`, draws month labels below the calendar using abbreviated
  names by default.

- month_labels:

  Month label formatter. Use a single date format string (default
  `"%b"`) or a function that takes month-start dates and returns labels.

- month_label_y:

  Vertical position for month labels (in calendar y units).

- month_label_size:

  Text size for month labels.

- month_label_color:

  Text color for month labels.

- month_label_vjust:

  Vertical justification for month labels.

- show_day_labels:

  If `TRUE`, shows weekday labels on the y-axis.

- day_labels:

  Optional custom weekday labels (character vector of length 7, top to
  bottom).

- square:

  If `TRUE`, adds
  [`ggplot2::coord_fixed()`](https://ggplot2.tidyverse.org/reference/coord_fixed.html)
  (`ratio = 1`) so day cells render as squares by default.

- color:

  Tile border color.

- linewidth:

  Tile border line width.

- na.rm:

  Passed to
  [`ggplot2::geom_tile()`](https://ggplot2.tidyverse.org/reference/geom_tile.html)
  to control NA handling.

- show.legend:

  Should this layer be included in legends?

- inherit.aes:

  If `FALSE`, overrides global aesthetics.

## Value

A ggplot2 component using ggiraph interactive geometry. By default this
includes calendar tiles, hidden x ticks, weekday labels on y, month
labels below the heatmap, and
[`ggplot2::coord_fixed()`](https://ggplot2.tidyverse.org/reference/coord_fixed.html)
so day tiles stay square.

## Details

By default, each day has:

- `data_id = as.character(date)`

- `tooltip = paste0(date, ": ", value)`

You can override these by mapping interactive aesthetics (`tooltip`,
`data_id`, `onclick`, etc.) inside
[`ggplot2::aes()`](https://ggplot2.tidyverse.org/reference/aes.html).

## Examples

``` r
library(ggplot2)
library(ggiraph)

set.seed(42)
daily <- data.frame(
  date = seq.Date(as.Date("2025-01-01"), as.Date("2025-01-31"), by = "day"),
  value = rpois(31, lambda = 3)
)

p <- ggplot(daily, aes(date = date, value = value)) +
  geom_calendar_interactive(
    aes(
      tooltip = paste("Date:", date, "\nValue:", value),
      data_id = date
    )
  ) +
  scale_fill_gradient(low = "grey95", high = "#2C7FB8")

girafe(ggobj = p)

{"x":{"html":"<?xml version=\"1.0\" encoding=\"UTF-8\"?>\n<svg xmlns='http://www.w3.org/2000/svg' xmlns:xlink='http://www.w3.org/1999/xlink' class='ggiraph-svg' role='graphics-document' id='svg_a15b670239e02917' viewBox='0 0 432 360'>\n <defs id='svg_a15b670239e02917_defs'>\n  <clipPath id='svg_a15b670239e02917_c1'>\n   <rect x='0' y='0' width='432' height='360'/>\n  <\/clipPath>\n  <clipPath id='svg_a15b670239e02917_c2'>\n   <rect x='53.05' y='0' width='325.89' height='360'/>\n  <\/clipPath>\n  <clipPath id='svg_a15b670239e02917_c3'>\n   <rect x='81.4' y='5.48' width='242.49' height='349.04'/>\n  <\/clipPath>\n <\/defs>\n <g id='svg_a15b670239e02917_rootg' class='ggiraph-svg-rootg'>\n  <g clip-path='url(#svg_a15b670239e02917_c1)'>\n   <rect x='0' y='0' width='432' height='360' fill='#FFFFFF' fill-opacity='1' stroke='#FFFFFF' stroke-opacity='1' stroke-width='0.75' stroke-linejoin='round' stroke-linecap='round' class='ggiraph-svg-bg'/>\n  <\/g>\n  <g clip-path='url(#svg_a15b670239e02917_c2)'>\n   <rect x='53.05' y='0' width='325.89' height='360' fill='#FFFFFF' fill-opacity='1' stroke='#FFFFFF' stroke-opacity='1' stroke-width='1.07' stroke-linejoin='round' stroke-linecap='round'/>\n  <\/g>\n  <g clip-path='url(#svg_a15b670239e02917_c3)'>\n   <rect x='81.4' y='5.48' width='242.49' height='349.04' fill='#EBEBEB' fill-opacity='1' stroke='none'/>\n   <polyline points='81.40,20.23 323.89,20.23' fill='none' stroke='#FFFFFF' stroke-opacity='1' stroke-width='0.53' stroke-linejoin='round' stroke-linecap='butt'/>\n   <polyline points='81.40,64.77 323.89,64.77' fill='none' stroke='#FFFFFF' stroke-opacity='1' stroke-width='0.53' stroke-linejoin='round' stroke-linecap='butt'/>\n   <polyline points='81.40,109.30 323.89,109.30' fill='none' stroke='#FFFFFF' stroke-opacity='1' stroke-width='0.53' stroke-linejoin='round' stroke-linecap='butt'/>\n   <polyline points='81.40,153.84 323.89,153.84' fill='none' stroke='#FFFFFF' stroke-opacity='1' stroke-width='0.53' stroke-linejoin='round' stroke-linecap='butt'/>\n   <polyline points='81.40,198.37 323.89,198.37' fill='none' stroke='#FFFFFF' stroke-opacity='1' stroke-width='0.53' stroke-linejoin='round' stroke-linecap='butt'/>\n   <polyline points='81.40,242.91 323.89,242.91' fill='none' stroke='#FFFFFF' stroke-opacity='1' stroke-width='0.53' stroke-linejoin='round' stroke-linecap='butt'/>\n   <polyline points='81.40,287.44 323.89,287.44' fill='none' stroke='#FFFFFF' stroke-opacity='1' stroke-width='0.53' stroke-linejoin='round' stroke-linecap='butt'/>\n   <polyline points='81.40,42.50 323.89,42.50' fill='none' stroke='#FFFFFF' stroke-opacity='1' stroke-width='1.07' stroke-linejoin='round' stroke-linecap='butt'/>\n   <polyline points='81.40,87.03 323.89,87.03' fill='none' stroke='#FFFFFF' stroke-opacity='1' stroke-width='1.07' stroke-linejoin='round' stroke-linecap='butt'/>\n   <polyline points='81.40,131.57 323.89,131.57' fill='none' stroke='#FFFFFF' stroke-opacity='1' stroke-width='1.07' stroke-linejoin='round' stroke-linecap='butt'/>\n   <polyline points='81.40,176.10 323.89,176.10' fill='none' stroke='#FFFFFF' stroke-opacity='1' stroke-width='1.07' stroke-linejoin='round' stroke-linecap='butt'/>\n   <polyline points='81.40,220.64 323.89,220.64' fill='none' stroke='#FFFFFF' stroke-opacity='1' stroke-width='1.07' stroke-linejoin='round' stroke-linecap='butt'/>\n   <polyline points='81.40,265.17 323.89,265.17' fill='none' stroke='#FFFFFF' stroke-opacity='1' stroke-width='1.07' stroke-linejoin='round' stroke-linecap='butt'/>\n   <polyline points='81.40,309.71 323.89,309.71' fill='none' stroke='#FFFFFF' stroke-opacity='1' stroke-width='1.07' stroke-linejoin='round' stroke-linecap='butt'/>\n   <rect id='svg_a15b670239e02917_e1' x='92.42' y='154.95' width='42.31' height='42.31' fill='#8EAED1' fill-opacity='1' stroke='none' title='Date: 2025-01-01 &amp;lt;br/&amp;gt;Value: 5' data-id='2025-01-01'/>\n   <rect id='svg_a15b670239e02917_e2' x='92.42' y='199.48' width='42.31' height='42.31' fill='#739EC9' fill-opacity='1' stroke='none' title='Date: 2025-01-02 &amp;lt;br/&amp;gt;Value: 6' data-id='2025-01-02'/>\n   <rect id='svg_a15b670239e02917_e3' x='92.42' y='244.02' width='42.31' height='42.31' fill='#D9E1EA' fill-opacity='1' stroke='none' title='Date: 2025-01-03 &amp;lt;br/&amp;gt;Value: 2' data-id='2025-01-03'/>\n   <rect id='svg_a15b670239e02917_e4' x='92.42' y='288.55' width='42.31' height='42.31' fill='#8EAED1' fill-opacity='1' stroke='none' title='Date: 2025-01-04 &amp;lt;br/&amp;gt;Value: 5' data-id='2025-01-04'/>\n   <rect id='svg_a15b670239e02917_e5' x='136.96' y='21.34' width='42.31' height='42.31' fill='#C1D0E2' fill-opacity='1' stroke='none' title='Date: 2025-01-05 &amp;lt;br/&amp;gt;Value: 3' data-id='2025-01-05'/>\n   <rect id='svg_a15b670239e02917_e6' x='136.96' y='65.88' width='42.31' height='42.31' fill='#C1D0E2' fill-opacity='1' stroke='none' title='Date: 2025-01-06 &amp;lt;br/&amp;gt;Value: 3' data-id='2025-01-06'/>\n   <rect id='svg_a15b670239e02917_e7' x='136.96' y='110.41' width='42.31' height='42.31' fill='#A8BFD9' fill-opacity='1' stroke='none' title='Date: 2025-01-07 &amp;lt;br/&amp;gt;Value: 4' data-id='2025-01-07'/>\n   <rect id='svg_a15b670239e02917_e8' x='136.96' y='154.95' width='42.31' height='42.31' fill='#F2F2F2' fill-opacity='1' stroke='none' title='Date: 2025-01-08 &amp;lt;br/&amp;gt;Value: 1' data-id='2025-01-08'/>\n   <rect id='svg_a15b670239e02917_e9' x='136.96' y='199.48' width='42.31' height='42.31' fill='#A8BFD9' fill-opacity='1' stroke='none' title='Date: 2025-01-09 &amp;lt;br/&amp;gt;Value: 4' data-id='2025-01-09'/>\n   <rect id='svg_a15b670239e02917_e10' x='136.96' y='244.02' width='42.31' height='42.31' fill='#A8BFD9' fill-opacity='1' stroke='none' title='Date: 2025-01-10 &amp;lt;br/&amp;gt;Value: 4' data-id='2025-01-10'/>\n   <rect id='svg_a15b670239e02917_e11' x='136.96' y='288.55' width='42.31' height='42.31' fill='#C1D0E2' fill-opacity='1' stroke='none' title='Date: 2025-01-11 &amp;lt;br/&amp;gt;Value: 3' data-id='2025-01-11'/>\n   <rect id='svg_a15b670239e02917_e12' x='181.49' y='21.34' width='42.31' height='42.31' fill='#A8BFD9' fill-opacity='1' stroke='none' title='Date: 2025-01-12 &amp;lt;br/&amp;gt;Value: 4' data-id='2025-01-12'/>\n   <rect id='svg_a15b670239e02917_e13' x='181.49' y='65.88' width='42.31' height='42.31' fill='#739EC9' fill-opacity='1' stroke='none' title='Date: 2025-01-13 &amp;lt;br/&amp;gt;Value: 6' data-id='2025-01-13'/>\n   <rect id='svg_a15b670239e02917_e14' x='181.49' y='110.41' width='42.31' height='42.31' fill='#D9E1EA' fill-opacity='1' stroke='none' title='Date: 2025-01-14 &amp;lt;br/&amp;gt;Value: 2' data-id='2025-01-14'/>\n   <rect id='svg_a15b670239e02917_e15' x='181.49' y='154.95' width='42.31' height='42.31' fill='#C1D0E2' fill-opacity='1' stroke='none' title='Date: 2025-01-15 &amp;lt;br/&amp;gt;Value: 3' data-id='2025-01-15'/>\n   <rect id='svg_a15b670239e02917_e16' x='181.49' y='199.48' width='42.31' height='42.31' fill='#739EC9' fill-opacity='1' stroke='none' title='Date: 2025-01-16 &amp;lt;br/&amp;gt;Value: 6' data-id='2025-01-16'/>\n   <rect id='svg_a15b670239e02917_e17' x='181.49' y='244.02' width='42.31' height='42.31' fill='#548EC0' fill-opacity='1' stroke='none' title='Date: 2025-01-17 &amp;lt;br/&amp;gt;Value: 7' data-id='2025-01-17'/>\n   <rect id='svg_a15b670239e02917_e18' x='181.49' y='288.55' width='42.31' height='42.31' fill='#F2F2F2' fill-opacity='1' stroke='none' title='Date: 2025-01-18 &amp;lt;br/&amp;gt;Value: 1' data-id='2025-01-18'/>\n   <rect id='svg_a15b670239e02917_e19' x='226.03' y='21.34' width='42.31' height='42.31' fill='#C1D0E2' fill-opacity='1' stroke='none' title='Date: 2025-01-19 &amp;lt;br/&amp;gt;Value: 3' data-id='2025-01-19'/>\n   <rect id='svg_a15b670239e02917_e20' x='226.03' y='65.88' width='42.31' height='42.31' fill='#C1D0E2' fill-opacity='1' stroke='none' title='Date: 2025-01-20 &amp;lt;br/&amp;gt;Value: 3' data-id='2025-01-20'/>\n   <rect id='svg_a15b670239e02917_e21' x='226.03' y='110.41' width='42.31' height='42.31' fill='#8EAED1' fill-opacity='1' stroke='none' title='Date: 2025-01-21 &amp;lt;br/&amp;gt;Value: 5' data-id='2025-01-21'/>\n   <rect id='svg_a15b670239e02917_e22' x='226.03' y='154.95' width='42.31' height='42.31' fill='#F2F2F2' fill-opacity='1' stroke='none' title='Date: 2025-01-22 &amp;lt;br/&amp;gt;Value: 1' data-id='2025-01-22'/>\n   <rect id='svg_a15b670239e02917_e23' x='226.03' y='199.48' width='42.31' height='42.31' fill='#2C7FB8' fill-opacity='1' stroke='none' title='Date: 2025-01-23 &amp;lt;br/&amp;gt;Value: 8' data-id='2025-01-23'/>\n   <rect id='svg_a15b670239e02917_e24' x='226.03' y='244.02' width='42.31' height='42.31' fill='#739EC9' fill-opacity='1' stroke='none' title='Date: 2025-01-24 &amp;lt;br/&amp;gt;Value: 6' data-id='2025-01-24'/>\n   <rect id='svg_a15b670239e02917_e25' x='226.03' y='288.55' width='42.31' height='42.31' fill='#F2F2F2' fill-opacity='1' stroke='none' title='Date: 2025-01-25 &amp;lt;br/&amp;gt;Value: 1' data-id='2025-01-25'/>\n   <rect id='svg_a15b670239e02917_e26' x='270.56' y='21.34' width='42.31' height='42.31' fill='#C1D0E2' fill-opacity='1' stroke='none' title='Date: 2025-01-26 &amp;lt;br/&amp;gt;Value: 3' data-id='2025-01-26'/>\n   <rect id='svg_a15b670239e02917_e27' x='270.56' y='65.88' width='42.31' height='42.31' fill='#D9E1EA' fill-opacity='1' stroke='none' title='Date: 2025-01-27 &amp;lt;br/&amp;gt;Value: 2' data-id='2025-01-27'/>\n   <rect id='svg_a15b670239e02917_e28' x='270.56' y='110.41' width='42.31' height='42.31' fill='#8EAED1' fill-opacity='1' stroke='none' title='Date: 2025-01-28 &amp;lt;br/&amp;gt;Value: 5' data-id='2025-01-28'/>\n   <rect id='svg_a15b670239e02917_e29' x='270.56' y='154.95' width='42.31' height='42.31' fill='#C1D0E2' fill-opacity='1' stroke='none' title='Date: 2025-01-29 &amp;lt;br/&amp;gt;Value: 3' data-id='2025-01-29'/>\n   <rect id='svg_a15b670239e02917_e30' x='270.56' y='199.48' width='42.31' height='42.31' fill='#8EAED1' fill-opacity='1' stroke='none' title='Date: 2025-01-30 &amp;lt;br/&amp;gt;Value: 5' data-id='2025-01-30'/>\n   <rect id='svg_a15b670239e02917_e31' x='270.56' y='244.02' width='42.31' height='42.31' fill='#A8BFD9' fill-opacity='1' stroke='none' title='Date: 2025-01-31 &amp;lt;br/&amp;gt;Value: 4' data-id='2025-01-31'/>\n   <text x='194.62' y='345.5' font-size='7.47pt' font-family='Liberation Sans' fill='#333333' fill-opacity='1'>Jan<\/text>\n  <\/g>\n  <g clip-path='url(#svg_a15b670239e02917_c1)'>\n   <text x='60.81' y='45.53' font-size='6.6pt' font-family='Liberation Sans' fill='#4D4D4D' fill-opacity='1'>Sun<\/text>\n   <text x='59.35' y='90.06' font-size='6.6pt' font-family='Liberation Sans' fill='#4D4D4D' fill-opacity='1'>Mon<\/text>\n   <text x='61.63' y='134.6' font-size='6.6pt' font-family='Liberation Sans' fill='#4D4D4D' fill-opacity='1'>Tue<\/text>\n   <text x='58.53' y='179.13' font-size='6.6pt' font-family='Liberation Sans' fill='#4D4D4D' fill-opacity='1'>Wed<\/text>\n   <text x='61.31' y='223.67' font-size='6.6pt' font-family='Liberation Sans' fill='#4D4D4D' fill-opacity='1'>Thu<\/text>\n   <text x='66.22' y='268.2' font-size='6.6pt' font-family='Liberation Sans' fill='#4D4D4D' fill-opacity='1'>Fri<\/text>\n   <text x='63.26' y='312.74' font-size='6.6pt' font-family='Liberation Sans' fill='#4D4D4D' fill-opacity='1'>Sat<\/text>\n   <polyline points='78.66,42.50 81.40,42.50' fill='none' stroke='#333333' stroke-opacity='1' stroke-width='1.07' stroke-linejoin='round' stroke-linecap='butt'/>\n   <polyline points='78.66,87.03 81.40,87.03' fill='none' stroke='#333333' stroke-opacity='1' stroke-width='1.07' stroke-linejoin='round' stroke-linecap='butt'/>\n   <polyline points='78.66,131.57 81.40,131.57' fill='none' stroke='#333333' stroke-opacity='1' stroke-width='1.07' stroke-linejoin='round' stroke-linecap='butt'/>\n   <polyline points='78.66,176.10 81.40,176.10' fill='none' stroke='#333333' stroke-opacity='1' stroke-width='1.07' stroke-linejoin='round' stroke-linecap='butt'/>\n   <polyline points='78.66,220.64 81.40,220.64' fill='none' stroke='#333333' stroke-opacity='1' stroke-width='1.07' stroke-linejoin='round' stroke-linecap='butt'/>\n   <polyline points='78.66,265.17 81.40,265.17' fill='none' stroke='#333333' stroke-opacity='1' stroke-width='1.07' stroke-linejoin='round' stroke-linecap='butt'/>\n   <polyline points='78.66,309.71 81.40,309.71' fill='none' stroke='#333333' stroke-opacity='1' stroke-width='1.07' stroke-linejoin='round' stroke-linecap='butt'/>\n   <rect x='334.85' y='123.66' width='38.61' height='112.69' fill='#FFFFFF' fill-opacity='1' stroke='none'/>\n   <text x='340.33' y='137.84' font-size='8.25pt' font-family='Liberation Sans'>value<\/text>\n   <image x='340.33' y='144.46' width='17.28' height='86.4' preserveAspectRatio='none' xlink:href='data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAAEAAAEsCAYAAAACUNnVAAAAo0lEQVQ4ja2TyxHCMAxEn1QPPdIW3cEBhljKrnEY36J50Xr143Z/PDOAjIBMgiEcvwR4h1HDg4ZQEQBIpmm4tA89W0N4Rnimlxr1v69efVzZZeqqP0RUler5ml6c5GnFCKDKp86SlfJLmgVdz4HWlz9A64sE1bOb9HbQZimBWUIFhh5Y4LpmBzoBP1dqAbQbvATsfRzAXtQCWNgcez3b57ajBy838wYsPcnfJAAAAABJRU5ErkJggg==' xmlns:xlink='http://www.w3.org/1999/xlink'/>\n   <polyline points='354.15,218.42 357.61,218.42' fill='none' stroke='#FFFFFF' stroke-opacity='1' stroke-width='0.37' stroke-linejoin='round' stroke-linecap='butt'/>\n   <polyline points='354.15,193.82 357.61,193.82' fill='none' stroke='#FFFFFF' stroke-opacity='1' stroke-width='0.37' stroke-linejoin='round' stroke-linecap='butt'/>\n   <polyline points='354.15,169.21 357.61,169.21' fill='none' stroke='#FFFFFF' stroke-opacity='1' stroke-width='0.37' stroke-linejoin='round' stroke-linecap='butt'/>\n   <polyline points='354.15,144.61 357.61,144.61' fill='none' stroke='#FFFFFF' stroke-opacity='1' stroke-width='0.37' stroke-linejoin='round' stroke-linecap='butt'/>\n   <polyline points='343.79,218.42 340.33,218.42' fill='none' stroke='#FFFFFF' stroke-opacity='1' stroke-width='0.37' stroke-linejoin='round' stroke-linecap='butt'/>\n   <polyline points='343.79,193.82 340.33,193.82' fill='none' stroke='#FFFFFF' stroke-opacity='1' stroke-width='0.37' stroke-linejoin='round' stroke-linecap='butt'/>\n   <polyline points='343.79,169.21 340.33,169.21' fill='none' stroke='#FFFFFF' stroke-opacity='1' stroke-width='0.37' stroke-linejoin='round' stroke-linecap='butt'/>\n   <polyline points='343.79,144.61 340.33,144.61' fill='none' stroke='#FFFFFF' stroke-opacity='1' stroke-width='0.37' stroke-linejoin='round' stroke-linecap='butt'/>\n   <text x='363.09' y='221.45' font-size='6.6pt' font-family='Liberation Sans'>2<\/text>\n   <text x='363.09' y='196.84' font-size='6.6pt' font-family='Liberation Sans'>4<\/text>\n   <text x='363.09' y='172.24' font-size='6.6pt' font-family='Liberation Sans'>6<\/text>\n   <text x='363.09' y='147.64' font-size='6.6pt' font-family='Liberation Sans'>8<\/text>\n  <\/g>\n <\/g>\n<\/svg>","js":null,"uid":"svg_a15b670239e02917","ratio":1.2,"settings":{"tooltip":{"css":".tooltip_SVGID_ { padding:5px;background:black;color:white;border-radius:2px;text-align:left; ; position:absolute;pointer-events:none;z-index:9999;}","placement":"doc","opacity":0.9,"offx":10,"offy":10,"use_cursor_pos":true,"use_fill":false,"use_stroke":false,"delay_over":200,"delay_out":500},"hover":{"css":".hover_data_SVGID_ { fill:orange;stroke:black;cursor:pointer; }\ntext.hover_data_SVGID_ { stroke:none;fill:orange; }\ncircle.hover_data_SVGID_ { fill:orange;stroke:black; }\nline.hover_data_SVGID_, polyline.hover_data_SVGID_ { fill:none;stroke:orange; }\nrect.hover_data_SVGID_, polygon.hover_data_SVGID_, path.hover_data_SVGID_ { fill:orange;stroke:none; }\nimage.hover_data_SVGID_ { stroke:orange; }","reactive":true,"nearest_distance":null,"linked":false},"hover_inv":{"css":""},"hover_key":{"css":".hover_key_SVGID_ { fill:orange;stroke:black;cursor:pointer; }\ntext.hover_key_SVGID_ { stroke:none;fill:orange; }\ncircle.hover_key_SVGID_ { fill:orange;stroke:black; }\nline.hover_key_SVGID_, polyline.hover_key_SVGID_ { fill:none;stroke:orange; }\nrect.hover_key_SVGID_, polygon.hover_key_SVGID_, path.hover_key_SVGID_ { fill:orange;stroke:none; }\nimage.hover_key_SVGID_ { stroke:orange; }","reactive":true},"hover_theme":{"css":".hover_theme_SVGID_ { fill:orange;stroke:black;cursor:pointer; }\ntext.hover_theme_SVGID_ { stroke:none;fill:orange; }\ncircle.hover_theme_SVGID_ { fill:orange;stroke:black; }\nline.hover_theme_SVGID_, polyline.hover_theme_SVGID_ { fill:none;stroke:orange; }\nrect.hover_theme_SVGID_, polygon.hover_theme_SVGID_, path.hover_theme_SVGID_ { fill:orange;stroke:none; }\nimage.hover_theme_SVGID_ { stroke:orange; }","reactive":true},"select":{"css":".select_data_SVGID_ { fill:red;stroke:black;cursor:pointer; }\ntext.select_data_SVGID_ { stroke:none;fill:red; }\ncircle.select_data_SVGID_ { fill:red;stroke:black; }\nline.select_data_SVGID_, polyline.select_data_SVGID_ { fill:none;stroke:red; }\nrect.select_data_SVGID_, polygon.select_data_SVGID_, path.select_data_SVGID_ { fill:red;stroke:none; }\nimage.select_data_SVGID_ { stroke:red; }","type":"multiple","only_shiny":true,"selected":[],"linked":false},"select_inv":{"css":""},"select_key":{"css":".select_key_SVGID_ { fill:red;stroke:black;cursor:pointer; }\ntext.select_key_SVGID_ { stroke:none;fill:red; }\ncircle.select_key_SVGID_ { fill:red;stroke:black; }\nline.select_key_SVGID_, polyline.select_key_SVGID_ { fill:none;stroke:red; }\nrect.select_key_SVGID_, polygon.select_key_SVGID_, path.select_key_SVGID_ { fill:red;stroke:none; }\nimage.select_key_SVGID_ { stroke:red; }","type":"single","only_shiny":true,"selected":[]},"select_theme":{"css":".select_theme_SVGID_ { fill:red;stroke:black;cursor:pointer; }\ntext.select_theme_SVGID_ { stroke:none;fill:red; }\ncircle.select_theme_SVGID_ { fill:red;stroke:black; }\nline.select_theme_SVGID_, polyline.select_theme_SVGID_ { fill:none;stroke:red; }\nrect.select_theme_SVGID_, polygon.select_theme_SVGID_, path.select_theme_SVGID_ { fill:red;stroke:none; }\nimage.select_theme_SVGID_ { stroke:red; }","type":"single","only_shiny":true,"selected":[]},"zoom":{"min":1,"max":1,"duration":300,"default_on":false},"toolbar":{"position":"topright","pngname":"diagram","tooltips":null,"fixed":false,"hidden":[],"delay_over":200,"delay_out":500},"sizing":{"rescale":true,"width":1}}},"evals":[],"jsHooks":[]}
```
