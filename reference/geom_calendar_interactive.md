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

A ggplot2 layer using ggiraph interactive geometry.

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

{"x":{"html":"<?xml version=\"1.0\" encoding=\"UTF-8\"?>\n<svg xmlns='http://www.w3.org/2000/svg' xmlns:xlink='http://www.w3.org/1999/xlink' class='ggiraph-svg' role='graphics-document' id='svg_a15b670239e02917' viewBox='0 0 432 360'>\n <defs id='svg_a15b670239e02917_defs'>\n  <clipPath id='svg_a15b670239e02917_c1'>\n   <rect x='0' y='0' width='432' height='360'/>\n  <\/clipPath>\n  <clipPath id='svg_a15b670239e02917_c2'>\n   <rect x='16.01' y='5.48' width='358.55' height='335.87'/>\n  <\/clipPath>\n <\/defs>\n <g id='svg_a15b670239e02917_rootg' class='ggiraph-svg-rootg'>\n  <g clip-path='url(#svg_a15b670239e02917_c1)'>\n   <rect x='0' y='0' width='432' height='360' fill='#FFFFFF' fill-opacity='1' stroke='#FFFFFF' stroke-opacity='1' stroke-width='0.75' stroke-linejoin='round' stroke-linecap='round' class='ggiraph-svg-bg'/>\n   <rect x='0' y='0' width='432' height='360' fill='#FFFFFF' fill-opacity='1' stroke='#FFFFFF' stroke-opacity='1' stroke-width='1.07' stroke-linejoin='round' stroke-linecap='round'/>\n  <\/g>\n  <g clip-path='url(#svg_a15b670239e02917_c2)'>\n   <rect x='16.01' y='5.48' width='358.55' height='335.87' fill='#EBEBEB' fill-opacity='1' stroke='none'/>\n   <polyline points='16.01,305.21 374.56,305.21' fill='none' stroke='#FFFFFF' stroke-opacity='1' stroke-width='0.53' stroke-linejoin='round' stroke-linecap='butt'/>\n   <polyline points='16.01,217.34 374.56,217.34' fill='none' stroke='#FFFFFF' stroke-opacity='1' stroke-width='0.53' stroke-linejoin='round' stroke-linecap='butt'/>\n   <polyline points='16.01,129.48 374.56,129.48' fill='none' stroke='#FFFFFF' stroke-opacity='1' stroke-width='0.53' stroke-linejoin='round' stroke-linecap='butt'/>\n   <polyline points='16.01,41.61 374.56,41.61' fill='none' stroke='#FFFFFF' stroke-opacity='1' stroke-width='0.53' stroke-linejoin='round' stroke-linecap='butt'/>\n   <polyline points='30.66,341.35 30.66,5.48' fill='none' stroke='#FFFFFF' stroke-opacity='1' stroke-width='0.53' stroke-linejoin='round' stroke-linecap='butt'/>\n   <polyline points='96.51,341.35 96.51,5.48' fill='none' stroke='#FFFFFF' stroke-opacity='1' stroke-width='0.53' stroke-linejoin='round' stroke-linecap='butt'/>\n   <polyline points='162.36,341.35 162.36,5.48' fill='none' stroke='#FFFFFF' stroke-opacity='1' stroke-width='0.53' stroke-linejoin='round' stroke-linecap='butt'/>\n   <polyline points='228.21,341.35 228.21,5.48' fill='none' stroke='#FFFFFF' stroke-opacity='1' stroke-width='0.53' stroke-linejoin='round' stroke-linecap='butt'/>\n   <polyline points='294.06,341.35 294.06,5.48' fill='none' stroke='#FFFFFF' stroke-opacity='1' stroke-width='0.53' stroke-linejoin='round' stroke-linecap='butt'/>\n   <polyline points='359.91,341.35 359.91,5.48' fill='none' stroke='#FFFFFF' stroke-opacity='1' stroke-width='0.53' stroke-linejoin='round' stroke-linecap='butt'/>\n   <polyline points='16.01,261.28 374.56,261.28' fill='none' stroke='#FFFFFF' stroke-opacity='1' stroke-width='1.07' stroke-linejoin='round' stroke-linecap='butt'/>\n   <polyline points='16.01,173.41 374.56,173.41' fill='none' stroke='#FFFFFF' stroke-opacity='1' stroke-width='1.07' stroke-linejoin='round' stroke-linecap='butt'/>\n   <polyline points='16.01,85.55 374.56,85.55' fill='none' stroke='#FFFFFF' stroke-opacity='1' stroke-width='1.07' stroke-linejoin='round' stroke-linecap='butt'/>\n   <polyline points='63.58,341.35 63.58,5.48' fill='none' stroke='#FFFFFF' stroke-opacity='1' stroke-width='1.07' stroke-linejoin='round' stroke-linecap='butt'/>\n   <polyline points='129.43,341.35 129.43,5.48' fill='none' stroke='#FFFFFF' stroke-opacity='1' stroke-width='1.07' stroke-linejoin='round' stroke-linecap='butt'/>\n   <polyline points='195.28,341.35 195.28,5.48' fill='none' stroke='#FFFFFF' stroke-opacity='1' stroke-width='1.07' stroke-linejoin='round' stroke-linecap='butt'/>\n   <polyline points='261.13,341.35 261.13,5.48' fill='none' stroke='#FFFFFF' stroke-opacity='1' stroke-width='1.07' stroke-linejoin='round' stroke-linecap='butt'/>\n   <polyline points='326.98,341.35 326.98,5.48' fill='none' stroke='#FFFFFF' stroke-opacity='1' stroke-width='1.07' stroke-linejoin='round' stroke-linecap='butt'/>\n   <rect id='svg_a15b670239e02917_e1' x='32.3' y='152.54' width='62.56' height='41.74' fill='#8EAED1' fill-opacity='1' stroke='none' title='Date: 2025-01-01 &amp;lt;br/&amp;gt;Value: 5' data-id='2025-01-01'/>\n   <rect id='svg_a15b670239e02917_e2' x='32.3' y='196.48' width='62.56' height='41.74' fill='#739EC9' fill-opacity='1' stroke='none' title='Date: 2025-01-02 &amp;lt;br/&amp;gt;Value: 6' data-id='2025-01-02'/>\n   <rect id='svg_a15b670239e02917_e3' x='32.3' y='240.41' width='62.56' height='41.74' fill='#D9E1EA' fill-opacity='1' stroke='none' title='Date: 2025-01-03 &amp;lt;br/&amp;gt;Value: 2' data-id='2025-01-03'/>\n   <rect id='svg_a15b670239e02917_e4' x='32.3' y='284.34' width='62.56' height='41.74' fill='#8EAED1' fill-opacity='1' stroke='none' title='Date: 2025-01-04 &amp;lt;br/&amp;gt;Value: 5' data-id='2025-01-04'/>\n   <rect id='svg_a15b670239e02917_e5' x='98.15' y='20.75' width='62.56' height='41.74' fill='#C1D0E2' fill-opacity='1' stroke='none' title='Date: 2025-01-05 &amp;lt;br/&amp;gt;Value: 3' data-id='2025-01-05'/>\n   <rect id='svg_a15b670239e02917_e6' x='98.15' y='64.68' width='62.56' height='41.74' fill='#C1D0E2' fill-opacity='1' stroke='none' title='Date: 2025-01-06 &amp;lt;br/&amp;gt;Value: 3' data-id='2025-01-06'/>\n   <rect id='svg_a15b670239e02917_e7' x='98.15' y='108.61' width='62.56' height='41.74' fill='#A8BFD9' fill-opacity='1' stroke='none' title='Date: 2025-01-07 &amp;lt;br/&amp;gt;Value: 4' data-id='2025-01-07'/>\n   <rect id='svg_a15b670239e02917_e8' x='98.15' y='152.54' width='62.56' height='41.74' fill='#F2F2F2' fill-opacity='1' stroke='none' title='Date: 2025-01-08 &amp;lt;br/&amp;gt;Value: 1' data-id='2025-01-08'/>\n   <rect id='svg_a15b670239e02917_e9' x='98.15' y='196.48' width='62.56' height='41.74' fill='#A8BFD9' fill-opacity='1' stroke='none' title='Date: 2025-01-09 &amp;lt;br/&amp;gt;Value: 4' data-id='2025-01-09'/>\n   <rect id='svg_a15b670239e02917_e10' x='98.15' y='240.41' width='62.56' height='41.74' fill='#A8BFD9' fill-opacity='1' stroke='none' title='Date: 2025-01-10 &amp;lt;br/&amp;gt;Value: 4' data-id='2025-01-10'/>\n   <rect id='svg_a15b670239e02917_e11' x='98.15' y='284.34' width='62.56' height='41.74' fill='#C1D0E2' fill-opacity='1' stroke='none' title='Date: 2025-01-11 &amp;lt;br/&amp;gt;Value: 3' data-id='2025-01-11'/>\n   <rect id='svg_a15b670239e02917_e12' x='164' y='20.75' width='62.56' height='41.74' fill='#A8BFD9' fill-opacity='1' stroke='none' title='Date: 2025-01-12 &amp;lt;br/&amp;gt;Value: 4' data-id='2025-01-12'/>\n   <rect id='svg_a15b670239e02917_e13' x='164' y='64.68' width='62.56' height='41.74' fill='#739EC9' fill-opacity='1' stroke='none' title='Date: 2025-01-13 &amp;lt;br/&amp;gt;Value: 6' data-id='2025-01-13'/>\n   <rect id='svg_a15b670239e02917_e14' x='164' y='108.61' width='62.56' height='41.74' fill='#D9E1EA' fill-opacity='1' stroke='none' title='Date: 2025-01-14 &amp;lt;br/&amp;gt;Value: 2' data-id='2025-01-14'/>\n   <rect id='svg_a15b670239e02917_e15' x='164' y='152.54' width='62.56' height='41.74' fill='#C1D0E2' fill-opacity='1' stroke='none' title='Date: 2025-01-15 &amp;lt;br/&amp;gt;Value: 3' data-id='2025-01-15'/>\n   <rect id='svg_a15b670239e02917_e16' x='164' y='196.48' width='62.56' height='41.74' fill='#739EC9' fill-opacity='1' stroke='none' title='Date: 2025-01-16 &amp;lt;br/&amp;gt;Value: 6' data-id='2025-01-16'/>\n   <rect id='svg_a15b670239e02917_e17' x='164' y='240.41' width='62.56' height='41.74' fill='#548EC0' fill-opacity='1' stroke='none' title='Date: 2025-01-17 &amp;lt;br/&amp;gt;Value: 7' data-id='2025-01-17'/>\n   <rect id='svg_a15b670239e02917_e18' x='164' y='284.34' width='62.56' height='41.74' fill='#F2F2F2' fill-opacity='1' stroke='none' title='Date: 2025-01-18 &amp;lt;br/&amp;gt;Value: 1' data-id='2025-01-18'/>\n   <rect id='svg_a15b670239e02917_e19' x='229.85' y='20.75' width='62.56' height='41.74' fill='#C1D0E2' fill-opacity='1' stroke='none' title='Date: 2025-01-19 &amp;lt;br/&amp;gt;Value: 3' data-id='2025-01-19'/>\n   <rect id='svg_a15b670239e02917_e20' x='229.85' y='64.68' width='62.56' height='41.74' fill='#C1D0E2' fill-opacity='1' stroke='none' title='Date: 2025-01-20 &amp;lt;br/&amp;gt;Value: 3' data-id='2025-01-20'/>\n   <rect id='svg_a15b670239e02917_e21' x='229.85' y='108.61' width='62.56' height='41.74' fill='#8EAED1' fill-opacity='1' stroke='none' title='Date: 2025-01-21 &amp;lt;br/&amp;gt;Value: 5' data-id='2025-01-21'/>\n   <rect id='svg_a15b670239e02917_e22' x='229.85' y='152.54' width='62.56' height='41.74' fill='#F2F2F2' fill-opacity='1' stroke='none' title='Date: 2025-01-22 &amp;lt;br/&amp;gt;Value: 1' data-id='2025-01-22'/>\n   <rect id='svg_a15b670239e02917_e23' x='229.85' y='196.48' width='62.56' height='41.74' fill='#2C7FB8' fill-opacity='1' stroke='none' title='Date: 2025-01-23 &amp;lt;br/&amp;gt;Value: 8' data-id='2025-01-23'/>\n   <rect id='svg_a15b670239e02917_e24' x='229.85' y='240.41' width='62.56' height='41.74' fill='#739EC9' fill-opacity='1' stroke='none' title='Date: 2025-01-24 &amp;lt;br/&amp;gt;Value: 6' data-id='2025-01-24'/>\n   <rect id='svg_a15b670239e02917_e25' x='229.85' y='284.34' width='62.56' height='41.74' fill='#F2F2F2' fill-opacity='1' stroke='none' title='Date: 2025-01-25 &amp;lt;br/&amp;gt;Value: 1' data-id='2025-01-25'/>\n   <rect id='svg_a15b670239e02917_e26' x='295.7' y='20.75' width='62.56' height='41.74' fill='#C1D0E2' fill-opacity='1' stroke='none' title='Date: 2025-01-26 &amp;lt;br/&amp;gt;Value: 3' data-id='2025-01-26'/>\n   <rect id='svg_a15b670239e02917_e27' x='295.7' y='64.68' width='62.56' height='41.74' fill='#D9E1EA' fill-opacity='1' stroke='none' title='Date: 2025-01-27 &amp;lt;br/&amp;gt;Value: 2' data-id='2025-01-27'/>\n   <rect id='svg_a15b670239e02917_e28' x='295.7' y='108.61' width='62.56' height='41.74' fill='#8EAED1' fill-opacity='1' stroke='none' title='Date: 2025-01-28 &amp;lt;br/&amp;gt;Value: 5' data-id='2025-01-28'/>\n   <rect id='svg_a15b670239e02917_e29' x='295.7' y='152.54' width='62.56' height='41.74' fill='#C1D0E2' fill-opacity='1' stroke='none' title='Date: 2025-01-29 &amp;lt;br/&amp;gt;Value: 3' data-id='2025-01-29'/>\n   <rect id='svg_a15b670239e02917_e30' x='295.7' y='196.48' width='62.56' height='41.74' fill='#8EAED1' fill-opacity='1' stroke='none' title='Date: 2025-01-30 &amp;lt;br/&amp;gt;Value: 5' data-id='2025-01-30'/>\n   <rect id='svg_a15b670239e02917_e31' x='295.7' y='240.41' width='62.56' height='41.74' fill='#A8BFD9' fill-opacity='1' stroke='none' title='Date: 2025-01-31 &amp;lt;br/&amp;gt;Value: 4' data-id='2025-01-31'/>\n  <\/g>\n  <g clip-path='url(#svg_a15b670239e02917_c1)'>\n   <text x='5.48' y='264.49' font-size='6.6pt' font-family='DejaVu Sans' fill='#4D4D4D' fill-opacity='1'>2<\/text>\n   <text x='5.48' y='176.62' font-size='6.6pt' font-family='DejaVu Sans' fill='#4D4D4D' fill-opacity='1'>4<\/text>\n   <text x='5.48' y='88.75' font-size='6.6pt' font-family='DejaVu Sans' fill='#4D4D4D' fill-opacity='1'>6<\/text>\n   <polyline points='13.27,261.28 16.01,261.28' fill='none' stroke='#333333' stroke-opacity='1' stroke-width='1.07' stroke-linejoin='round' stroke-linecap='butt'/>\n   <polyline points='13.27,173.41 16.01,173.41' fill='none' stroke='#333333' stroke-opacity='1' stroke-width='1.07' stroke-linejoin='round' stroke-linecap='butt'/>\n   <polyline points='13.27,85.55 16.01,85.55' fill='none' stroke='#333333' stroke-opacity='1' stroke-width='1.07' stroke-linejoin='round' stroke-linecap='butt'/>\n   <polyline points='63.58,344.08 63.58,341.35' fill='none' stroke='#333333' stroke-opacity='1' stroke-width='1.07' stroke-linejoin='round' stroke-linecap='butt'/>\n   <polyline points='129.43,344.08 129.43,341.35' fill='none' stroke='#333333' stroke-opacity='1' stroke-width='1.07' stroke-linejoin='round' stroke-linecap='butt'/>\n   <polyline points='195.28,344.08 195.28,341.35' fill='none' stroke='#333333' stroke-opacity='1' stroke-width='1.07' stroke-linejoin='round' stroke-linecap='butt'/>\n   <polyline points='261.13,344.08 261.13,341.35' fill='none' stroke='#333333' stroke-opacity='1' stroke-width='1.07' stroke-linejoin='round' stroke-linecap='butt'/>\n   <polyline points='326.98,344.08 326.98,341.35' fill='none' stroke='#333333' stroke-opacity='1' stroke-width='1.07' stroke-linejoin='round' stroke-linecap='butt'/>\n   <text x='60.78' y='352.69' font-size='6.6pt' font-family='DejaVu Sans' fill='#4D4D4D' fill-opacity='1'>1<\/text>\n   <text x='126.63' y='352.69' font-size='6.6pt' font-family='DejaVu Sans' fill='#4D4D4D' fill-opacity='1'>2<\/text>\n   <text x='192.48' y='352.69' font-size='6.6pt' font-family='DejaVu Sans' fill='#4D4D4D' fill-opacity='1'>3<\/text>\n   <text x='258.33' y='352.69' font-size='6.6pt' font-family='DejaVu Sans' fill='#4D4D4D' fill-opacity='1'>4<\/text>\n   <text x='324.18' y='352.69' font-size='6.6pt' font-family='DejaVu Sans' fill='#4D4D4D' fill-opacity='1'>5<\/text>\n   <rect x='385.52' y='116.84' width='41' height='113.15' fill='#FFFFFF' fill-opacity='1' stroke='none'/>\n   <text x='391' y='131.48' font-size='8.25pt' font-family='DejaVu Sans'>value<\/text>\n   <image x='391' y='138.11' width='17.28' height='86.4' preserveAspectRatio='none' xlink:href='data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAAEAAAEsCAYAAAACUNnVAAAAo0lEQVQ4ja2TyxHCMAxEn1QPPdIW3cEBhljKrnEY36J50Xr143Z/PDOAjIBMgiEcvwR4h1HDg4ZQEQBIpmm4tA89W0N4Rnimlxr1v69efVzZZeqqP0RUler5ml6c5GnFCKDKp86SlfJLmgVdz4HWlz9A64sE1bOb9HbQZimBWUIFhh5Y4LpmBzoBP1dqAbQbvATsfRzAXtQCWNgcez3b57ajBy838wYsPcnfJAAAAABJRU5ErkJggg==' xmlns:xlink='http://www.w3.org/1999/xlink'/>\n   <polyline points='404.82,212.06 408.28,212.06' fill='none' stroke='#FFFFFF' stroke-opacity='1' stroke-width='0.37' stroke-linejoin='round' stroke-linecap='butt'/>\n   <polyline points='404.82,187.46 408.28,187.46' fill='none' stroke='#FFFFFF' stroke-opacity='1' stroke-width='0.37' stroke-linejoin='round' stroke-linecap='butt'/>\n   <polyline points='404.82,162.85 408.28,162.85' fill='none' stroke='#FFFFFF' stroke-opacity='1' stroke-width='0.37' stroke-linejoin='round' stroke-linecap='butt'/>\n   <polyline points='404.82,138.25 408.28,138.25' fill='none' stroke='#FFFFFF' stroke-opacity='1' stroke-width='0.37' stroke-linejoin='round' stroke-linecap='butt'/>\n   <polyline points='394.45,212.06 391.00,212.06' fill='none' stroke='#FFFFFF' stroke-opacity='1' stroke-width='0.37' stroke-linejoin='round' stroke-linecap='butt'/>\n   <polyline points='394.45,187.46 391.00,187.46' fill='none' stroke='#FFFFFF' stroke-opacity='1' stroke-width='0.37' stroke-linejoin='round' stroke-linecap='butt'/>\n   <polyline points='394.45,162.85 391.00,162.85' fill='none' stroke='#FFFFFF' stroke-opacity='1' stroke-width='0.37' stroke-linejoin='round' stroke-linecap='butt'/>\n   <polyline points='394.45,138.25 391.00,138.25' fill='none' stroke='#FFFFFF' stroke-opacity='1' stroke-width='0.37' stroke-linejoin='round' stroke-linecap='butt'/>\n   <text x='413.75' y='215.27' font-size='6.6pt' font-family='DejaVu Sans'>2<\/text>\n   <text x='413.75' y='190.67' font-size='6.6pt' font-family='DejaVu Sans'>4<\/text>\n   <text x='413.75' y='166.06' font-size='6.6pt' font-family='DejaVu Sans'>6<\/text>\n   <text x='413.75' y='141.46' font-size='6.6pt' font-family='DejaVu Sans'>8<\/text>\n  <\/g>\n <\/g>\n<\/svg>","js":null,"uid":"svg_a15b670239e02917","ratio":1.2,"settings":{"tooltip":{"css":".tooltip_SVGID_ { padding:5px;background:black;color:white;border-radius:2px;text-align:left; ; position:absolute;pointer-events:none;z-index:9999;}","placement":"doc","opacity":0.9,"offx":10,"offy":10,"use_cursor_pos":true,"use_fill":false,"use_stroke":false,"delay_over":200,"delay_out":500},"hover":{"css":".hover_data_SVGID_ { fill:orange;stroke:black;cursor:pointer; }\ntext.hover_data_SVGID_ { stroke:none;fill:orange; }\ncircle.hover_data_SVGID_ { fill:orange;stroke:black; }\nline.hover_data_SVGID_, polyline.hover_data_SVGID_ { fill:none;stroke:orange; }\nrect.hover_data_SVGID_, polygon.hover_data_SVGID_, path.hover_data_SVGID_ { fill:orange;stroke:none; }\nimage.hover_data_SVGID_ { stroke:orange; }","reactive":true,"nearest_distance":null},"hover_inv":{"css":""},"hover_key":{"css":".hover_key_SVGID_ { fill:orange;stroke:black;cursor:pointer; }\ntext.hover_key_SVGID_ { stroke:none;fill:orange; }\ncircle.hover_key_SVGID_ { fill:orange;stroke:black; }\nline.hover_key_SVGID_, polyline.hover_key_SVGID_ { fill:none;stroke:orange; }\nrect.hover_key_SVGID_, polygon.hover_key_SVGID_, path.hover_key_SVGID_ { fill:orange;stroke:none; }\nimage.hover_key_SVGID_ { stroke:orange; }","reactive":true},"hover_theme":{"css":".hover_theme_SVGID_ { fill:orange;stroke:black;cursor:pointer; }\ntext.hover_theme_SVGID_ { stroke:none;fill:orange; }\ncircle.hover_theme_SVGID_ { fill:orange;stroke:black; }\nline.hover_theme_SVGID_, polyline.hover_theme_SVGID_ { fill:none;stroke:orange; }\nrect.hover_theme_SVGID_, polygon.hover_theme_SVGID_, path.hover_theme_SVGID_ { fill:orange;stroke:none; }\nimage.hover_theme_SVGID_ { stroke:orange; }","reactive":true},"select":{"css":".select_data_SVGID_ { fill:red;stroke:black;cursor:pointer; }\ntext.select_data_SVGID_ { stroke:none;fill:red; }\ncircle.select_data_SVGID_ { fill:red;stroke:black; }\nline.select_data_SVGID_, polyline.select_data_SVGID_ { fill:none;stroke:red; }\nrect.select_data_SVGID_, polygon.select_data_SVGID_, path.select_data_SVGID_ { fill:red;stroke:none; }\nimage.select_data_SVGID_ { stroke:red; }","type":"multiple","only_shiny":true,"selected":[]},"select_inv":{"css":""},"select_key":{"css":".select_key_SVGID_ { fill:red;stroke:black;cursor:pointer; }\ntext.select_key_SVGID_ { stroke:none;fill:red; }\ncircle.select_key_SVGID_ { fill:red;stroke:black; }\nline.select_key_SVGID_, polyline.select_key_SVGID_ { fill:none;stroke:red; }\nrect.select_key_SVGID_, polygon.select_key_SVGID_, path.select_key_SVGID_ { fill:red;stroke:none; }\nimage.select_key_SVGID_ { stroke:red; }","type":"single","only_shiny":true,"selected":[]},"select_theme":{"css":".select_theme_SVGID_ { fill:red;stroke:black;cursor:pointer; }\ntext.select_theme_SVGID_ { stroke:none;fill:red; }\ncircle.select_theme_SVGID_ { fill:red;stroke:black; }\nline.select_theme_SVGID_, polyline.select_theme_SVGID_ { fill:none;stroke:red; }\nrect.select_theme_SVGID_, polygon.select_theme_SVGID_, path.select_theme_SVGID_ { fill:red;stroke:none; }\nimage.select_theme_SVGID_ { stroke:red; }","type":"single","only_shiny":true,"selected":[]},"zoom":{"min":1,"max":1,"duration":300,"default_on":false},"toolbar":{"position":"topright","pngname":"diagram","tooltips":null,"fixed":false,"hidden":[],"delay_over":200,"delay_out":500},"sizing":{"rescale":true,"width":1}}},"evals":[],"jsHooks":[]}
```
