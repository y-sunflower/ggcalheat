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
includes
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

{"x":{"html":"<?xml version=\"1.0\" encoding=\"UTF-8\"?>\n<svg xmlns='http://www.w3.org/2000/svg' xmlns:xlink='http://www.w3.org/1999/xlink' class='ggiraph-svg' role='graphics-document' id='svg_a15b670239e02917' viewBox='0 0 432 360'>\n <defs id='svg_a15b670239e02917_defs'>\n  <clipPath id='svg_a15b670239e02917_c1'>\n   <rect x='0' y='0' width='432' height='360'/>\n  <\/clipPath>\n  <clipPath id='svg_a15b670239e02917_c2'>\n   <rect x='61.09' y='0' width='309.83' height='360'/>\n  <\/clipPath>\n  <clipPath id='svg_a15b670239e02917_c3'>\n   <rect x='76.39' y='5.48' width='239.47' height='336.23'/>\n  <\/clipPath>\n <\/defs>\n <g id='svg_a15b670239e02917_rootg' class='ggiraph-svg-rootg'>\n  <g clip-path='url(#svg_a15b670239e02917_c1)'>\n   <rect x='0' y='0' width='432' height='360' fill='#FFFFFF' fill-opacity='1' stroke='#FFFFFF' stroke-opacity='1' stroke-width='0.75' stroke-linejoin='round' stroke-linecap='round' class='ggiraph-svg-bg'/>\n  <\/g>\n  <g clip-path='url(#svg_a15b670239e02917_c2)'>\n   <rect x='61.09' y='0' width='309.83' height='360' fill='#FFFFFF' fill-opacity='1' stroke='#FFFFFF' stroke-opacity='1' stroke-width='1.07' stroke-linejoin='round' stroke-linecap='round'/>\n  <\/g>\n  <g clip-path='url(#svg_a15b670239e02917_c3)'>\n   <rect x='76.39' y='5.48' width='239.47' height='336.23' fill='#EBEBEB' fill-opacity='1' stroke='none'/>\n   <polyline points='76.39,305.53 315.86,305.53' fill='none' stroke='#FFFFFF' stroke-opacity='1' stroke-width='0.53' stroke-linejoin='round' stroke-linecap='butt'/>\n   <polyline points='76.39,217.57 315.86,217.57' fill='none' stroke='#FFFFFF' stroke-opacity='1' stroke-width='0.53' stroke-linejoin='round' stroke-linecap='butt'/>\n   <polyline points='76.39,129.61 315.86,129.61' fill='none' stroke='#FFFFFF' stroke-opacity='1' stroke-width='0.53' stroke-linejoin='round' stroke-linecap='butt'/>\n   <polyline points='76.39,41.65 315.86,41.65' fill='none' stroke='#FFFFFF' stroke-opacity='1' stroke-width='0.53' stroke-linejoin='round' stroke-linecap='butt'/>\n   <polyline points='86.18,341.71 86.18,5.48' fill='none' stroke='#FFFFFF' stroke-opacity='1' stroke-width='0.53' stroke-linejoin='round' stroke-linecap='butt'/>\n   <polyline points='130.16,341.71 130.16,5.48' fill='none' stroke='#FFFFFF' stroke-opacity='1' stroke-width='0.53' stroke-linejoin='round' stroke-linecap='butt'/>\n   <polyline points='174.14,341.71 174.14,5.48' fill='none' stroke='#FFFFFF' stroke-opacity='1' stroke-width='0.53' stroke-linejoin='round' stroke-linecap='butt'/>\n   <polyline points='218.12,341.71 218.12,5.48' fill='none' stroke='#FFFFFF' stroke-opacity='1' stroke-width='0.53' stroke-linejoin='round' stroke-linecap='butt'/>\n   <polyline points='262.10,341.71 262.10,5.48' fill='none' stroke='#FFFFFF' stroke-opacity='1' stroke-width='0.53' stroke-linejoin='round' stroke-linecap='butt'/>\n   <polyline points='306.08,341.71 306.08,5.48' fill='none' stroke='#FFFFFF' stroke-opacity='1' stroke-width='0.53' stroke-linejoin='round' stroke-linecap='butt'/>\n   <polyline points='76.39,261.55 315.86,261.55' fill='none' stroke='#FFFFFF' stroke-opacity='1' stroke-width='1.07' stroke-linejoin='round' stroke-linecap='butt'/>\n   <polyline points='76.39,173.59 315.86,173.59' fill='none' stroke='#FFFFFF' stroke-opacity='1' stroke-width='1.07' stroke-linejoin='round' stroke-linecap='butt'/>\n   <polyline points='76.39,85.63 315.86,85.63' fill='none' stroke='#FFFFFF' stroke-opacity='1' stroke-width='1.07' stroke-linejoin='round' stroke-linecap='butt'/>\n   <polyline points='108.17,341.71 108.17,5.48' fill='none' stroke='#FFFFFF' stroke-opacity='1' stroke-width='1.07' stroke-linejoin='round' stroke-linecap='butt'/>\n   <polyline points='152.15,341.71 152.15,5.48' fill='none' stroke='#FFFFFF' stroke-opacity='1' stroke-width='1.07' stroke-linejoin='round' stroke-linecap='butt'/>\n   <polyline points='196.13,341.71 196.13,5.48' fill='none' stroke='#FFFFFF' stroke-opacity='1' stroke-width='1.07' stroke-linejoin='round' stroke-linecap='butt'/>\n   <polyline points='240.11,341.71 240.11,5.48' fill='none' stroke='#FFFFFF' stroke-opacity='1' stroke-width='1.07' stroke-linejoin='round' stroke-linecap='butt'/>\n   <polyline points='284.09,341.71 284.09,5.48' fill='none' stroke='#FFFFFF' stroke-opacity='1' stroke-width='1.07' stroke-linejoin='round' stroke-linecap='butt'/>\n   <rect id='svg_a15b670239e02917_e1' x='87.28' y='152.7' width='41.78' height='41.78' fill='#8EAED1' fill-opacity='1' stroke='none' title='Date: 2025-01-01 &amp;lt;br/&amp;gt;Value: 5' data-id='2025-01-01'/>\n   <rect id='svg_a15b670239e02917_e2' x='87.28' y='196.68' width='41.78' height='41.78' fill='#739EC9' fill-opacity='1' stroke='none' title='Date: 2025-01-02 &amp;lt;br/&amp;gt;Value: 6' data-id='2025-01-02'/>\n   <rect id='svg_a15b670239e02917_e3' x='87.28' y='240.66' width='41.78' height='41.78' fill='#D9E1EA' fill-opacity='1' stroke='none' title='Date: 2025-01-03 &amp;lt;br/&amp;gt;Value: 2' data-id='2025-01-03'/>\n   <rect id='svg_a15b670239e02917_e4' x='87.28' y='284.64' width='41.78' height='41.78' fill='#8EAED1' fill-opacity='1' stroke='none' title='Date: 2025-01-04 &amp;lt;br/&amp;gt;Value: 5' data-id='2025-01-04'/>\n   <rect id='svg_a15b670239e02917_e5' x='131.26' y='20.76' width='41.78' height='41.78' fill='#C1D0E2' fill-opacity='1' stroke='none' title='Date: 2025-01-05 &amp;lt;br/&amp;gt;Value: 3' data-id='2025-01-05'/>\n   <rect id='svg_a15b670239e02917_e6' x='131.26' y='64.74' width='41.78' height='41.78' fill='#C1D0E2' fill-opacity='1' stroke='none' title='Date: 2025-01-06 &amp;lt;br/&amp;gt;Value: 3' data-id='2025-01-06'/>\n   <rect id='svg_a15b670239e02917_e7' x='131.26' y='108.72' width='41.78' height='41.78' fill='#A8BFD9' fill-opacity='1' stroke='none' title='Date: 2025-01-07 &amp;lt;br/&amp;gt;Value: 4' data-id='2025-01-07'/>\n   <rect id='svg_a15b670239e02917_e8' x='131.26' y='152.7' width='41.78' height='41.78' fill='#F2F2F2' fill-opacity='1' stroke='none' title='Date: 2025-01-08 &amp;lt;br/&amp;gt;Value: 1' data-id='2025-01-08'/>\n   <rect id='svg_a15b670239e02917_e9' x='131.26' y='196.68' width='41.78' height='41.78' fill='#A8BFD9' fill-opacity='1' stroke='none' title='Date: 2025-01-09 &amp;lt;br/&amp;gt;Value: 4' data-id='2025-01-09'/>\n   <rect id='svg_a15b670239e02917_e10' x='131.26' y='240.66' width='41.78' height='41.78' fill='#A8BFD9' fill-opacity='1' stroke='none' title='Date: 2025-01-10 &amp;lt;br/&amp;gt;Value: 4' data-id='2025-01-10'/>\n   <rect id='svg_a15b670239e02917_e11' x='131.26' y='284.64' width='41.78' height='41.78' fill='#C1D0E2' fill-opacity='1' stroke='none' title='Date: 2025-01-11 &amp;lt;br/&amp;gt;Value: 3' data-id='2025-01-11'/>\n   <rect id='svg_a15b670239e02917_e12' x='175.24' y='20.76' width='41.78' height='41.78' fill='#A8BFD9' fill-opacity='1' stroke='none' title='Date: 2025-01-12 &amp;lt;br/&amp;gt;Value: 4' data-id='2025-01-12'/>\n   <rect id='svg_a15b670239e02917_e13' x='175.24' y='64.74' width='41.78' height='41.78' fill='#739EC9' fill-opacity='1' stroke='none' title='Date: 2025-01-13 &amp;lt;br/&amp;gt;Value: 6' data-id='2025-01-13'/>\n   <rect id='svg_a15b670239e02917_e14' x='175.24' y='108.72' width='41.78' height='41.78' fill='#D9E1EA' fill-opacity='1' stroke='none' title='Date: 2025-01-14 &amp;lt;br/&amp;gt;Value: 2' data-id='2025-01-14'/>\n   <rect id='svg_a15b670239e02917_e15' x='175.24' y='152.7' width='41.78' height='41.78' fill='#C1D0E2' fill-opacity='1' stroke='none' title='Date: 2025-01-15 &amp;lt;br/&amp;gt;Value: 3' data-id='2025-01-15'/>\n   <rect id='svg_a15b670239e02917_e16' x='175.24' y='196.68' width='41.78' height='41.78' fill='#739EC9' fill-opacity='1' stroke='none' title='Date: 2025-01-16 &amp;lt;br/&amp;gt;Value: 6' data-id='2025-01-16'/>\n   <rect id='svg_a15b670239e02917_e17' x='175.24' y='240.66' width='41.78' height='41.78' fill='#548EC0' fill-opacity='1' stroke='none' title='Date: 2025-01-17 &amp;lt;br/&amp;gt;Value: 7' data-id='2025-01-17'/>\n   <rect id='svg_a15b670239e02917_e18' x='175.24' y='284.64' width='41.78' height='41.78' fill='#F2F2F2' fill-opacity='1' stroke='none' title='Date: 2025-01-18 &amp;lt;br/&amp;gt;Value: 1' data-id='2025-01-18'/>\n   <rect id='svg_a15b670239e02917_e19' x='219.22' y='20.76' width='41.78' height='41.78' fill='#C1D0E2' fill-opacity='1' stroke='none' title='Date: 2025-01-19 &amp;lt;br/&amp;gt;Value: 3' data-id='2025-01-19'/>\n   <rect id='svg_a15b670239e02917_e20' x='219.22' y='64.74' width='41.78' height='41.78' fill='#C1D0E2' fill-opacity='1' stroke='none' title='Date: 2025-01-20 &amp;lt;br/&amp;gt;Value: 3' data-id='2025-01-20'/>\n   <rect id='svg_a15b670239e02917_e21' x='219.22' y='108.72' width='41.78' height='41.78' fill='#8EAED1' fill-opacity='1' stroke='none' title='Date: 2025-01-21 &amp;lt;br/&amp;gt;Value: 5' data-id='2025-01-21'/>\n   <rect id='svg_a15b670239e02917_e22' x='219.22' y='152.7' width='41.78' height='41.78' fill='#F2F2F2' fill-opacity='1' stroke='none' title='Date: 2025-01-22 &amp;lt;br/&amp;gt;Value: 1' data-id='2025-01-22'/>\n   <rect id='svg_a15b670239e02917_e23' x='219.22' y='196.68' width='41.78' height='41.78' fill='#2C7FB8' fill-opacity='1' stroke='none' title='Date: 2025-01-23 &amp;lt;br/&amp;gt;Value: 8' data-id='2025-01-23'/>\n   <rect id='svg_a15b670239e02917_e24' x='219.22' y='240.66' width='41.78' height='41.78' fill='#739EC9' fill-opacity='1' stroke='none' title='Date: 2025-01-24 &amp;lt;br/&amp;gt;Value: 6' data-id='2025-01-24'/>\n   <rect id='svg_a15b670239e02917_e25' x='219.22' y='284.64' width='41.78' height='41.78' fill='#F2F2F2' fill-opacity='1' stroke='none' title='Date: 2025-01-25 &amp;lt;br/&amp;gt;Value: 1' data-id='2025-01-25'/>\n   <rect id='svg_a15b670239e02917_e26' x='263.2' y='20.76' width='41.78' height='41.78' fill='#C1D0E2' fill-opacity='1' stroke='none' title='Date: 2025-01-26 &amp;lt;br/&amp;gt;Value: 3' data-id='2025-01-26'/>\n   <rect id='svg_a15b670239e02917_e27' x='263.2' y='64.74' width='41.78' height='41.78' fill='#D9E1EA' fill-opacity='1' stroke='none' title='Date: 2025-01-27 &amp;lt;br/&amp;gt;Value: 2' data-id='2025-01-27'/>\n   <rect id='svg_a15b670239e02917_e28' x='263.2' y='108.72' width='41.78' height='41.78' fill='#8EAED1' fill-opacity='1' stroke='none' title='Date: 2025-01-28 &amp;lt;br/&amp;gt;Value: 5' data-id='2025-01-28'/>\n   <rect id='svg_a15b670239e02917_e29' x='263.2' y='152.7' width='41.78' height='41.78' fill='#C1D0E2' fill-opacity='1' stroke='none' title='Date: 2025-01-29 &amp;lt;br/&amp;gt;Value: 3' data-id='2025-01-29'/>\n   <rect id='svg_a15b670239e02917_e30' x='263.2' y='196.68' width='41.78' height='41.78' fill='#8EAED1' fill-opacity='1' stroke='none' title='Date: 2025-01-30 &amp;lt;br/&amp;gt;Value: 5' data-id='2025-01-30'/>\n   <rect id='svg_a15b670239e02917_e31' x='263.2' y='240.66' width='41.78' height='41.78' fill='#A8BFD9' fill-opacity='1' stroke='none' title='Date: 2025-01-31 &amp;lt;br/&amp;gt;Value: 4' data-id='2025-01-31'/>\n  <\/g>\n  <g clip-path='url(#svg_a15b670239e02917_c1)'>\n   <text x='66.56' y='264.58' font-size='6.6pt' font-family='Liberation Sans' fill='#4D4D4D' fill-opacity='1'>2<\/text>\n   <text x='66.56' y='176.62' font-size='6.6pt' font-family='Liberation Sans' fill='#4D4D4D' fill-opacity='1'>4<\/text>\n   <text x='66.56' y='88.66' font-size='6.6pt' font-family='Liberation Sans' fill='#4D4D4D' fill-opacity='1'>6<\/text>\n   <polyline points='73.65,261.55 76.39,261.55' fill='none' stroke='#333333' stroke-opacity='1' stroke-width='1.07' stroke-linejoin='round' stroke-linecap='butt'/>\n   <polyline points='73.65,173.59 76.39,173.59' fill='none' stroke='#333333' stroke-opacity='1' stroke-width='1.07' stroke-linejoin='round' stroke-linecap='butt'/>\n   <polyline points='73.65,85.63 76.39,85.63' fill='none' stroke='#333333' stroke-opacity='1' stroke-width='1.07' stroke-linejoin='round' stroke-linecap='butt'/>\n   <polyline points='108.17,344.44 108.17,341.71' fill='none' stroke='#333333' stroke-opacity='1' stroke-width='1.07' stroke-linejoin='round' stroke-linecap='butt'/>\n   <polyline points='152.15,344.44 152.15,341.71' fill='none' stroke='#333333' stroke-opacity='1' stroke-width='1.07' stroke-linejoin='round' stroke-linecap='butt'/>\n   <polyline points='196.13,344.44 196.13,341.71' fill='none' stroke='#333333' stroke-opacity='1' stroke-width='1.07' stroke-linejoin='round' stroke-linecap='butt'/>\n   <polyline points='240.11,344.44 240.11,341.71' fill='none' stroke='#333333' stroke-opacity='1' stroke-width='1.07' stroke-linejoin='round' stroke-linecap='butt'/>\n   <polyline points='284.09,344.44 284.09,341.71' fill='none' stroke='#333333' stroke-opacity='1' stroke-width='1.07' stroke-linejoin='round' stroke-linecap='butt'/>\n   <text x='105.72' y='352.69' font-size='6.6pt' font-family='Liberation Sans' fill='#4D4D4D' fill-opacity='1'>1<\/text>\n   <text x='149.7' y='352.69' font-size='6.6pt' font-family='Liberation Sans' fill='#4D4D4D' fill-opacity='1'>2<\/text>\n   <text x='193.68' y='352.69' font-size='6.6pt' font-family='Liberation Sans' fill='#4D4D4D' fill-opacity='1'>3<\/text>\n   <text x='237.66' y='352.69' font-size='6.6pt' font-family='Liberation Sans' fill='#4D4D4D' fill-opacity='1'>4<\/text>\n   <text x='281.64' y='352.69' font-size='6.6pt' font-family='Liberation Sans' fill='#4D4D4D' fill-opacity='1'>5<\/text>\n   <rect x='326.82' y='117.25' width='38.61' height='112.69' fill='#FFFFFF' fill-opacity='1' stroke='none'/>\n   <text x='332.3' y='131.44' font-size='8.25pt' font-family='Liberation Sans'>value<\/text>\n   <image x='332.3' y='138.06' width='17.28' height='86.4' preserveAspectRatio='none' xlink:href='data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAAEAAAEsCAYAAAACUNnVAAAAo0lEQVQ4ja2TyxHCMAxEn1QPPdIW3cEBhljKrnEY36J50Xr143Z/PDOAjIBMgiEcvwR4h1HDg4ZQEQBIpmm4tA89W0N4Rnimlxr1v69efVzZZeqqP0RUler5ml6c5GnFCKDKp86SlfJLmgVdz4HWlz9A64sE1bOb9HbQZimBWUIFhh5Y4LpmBzoBP1dqAbQbvATsfRzAXtQCWNgcez3b57ajBy838wYsPcnfJAAAAABJRU5ErkJggg==' xmlns:xlink='http://www.w3.org/1999/xlink'/>\n   <polyline points='346.12,212.01 349.58,212.01' fill='none' stroke='#FFFFFF' stroke-opacity='1' stroke-width='0.37' stroke-linejoin='round' stroke-linecap='butt'/>\n   <polyline points='346.12,187.41 349.58,187.41' fill='none' stroke='#FFFFFF' stroke-opacity='1' stroke-width='0.37' stroke-linejoin='round' stroke-linecap='butt'/>\n   <polyline points='346.12,162.80 349.58,162.80' fill='none' stroke='#FFFFFF' stroke-opacity='1' stroke-width='0.37' stroke-linejoin='round' stroke-linecap='butt'/>\n   <polyline points='346.12,138.20 349.58,138.20' fill='none' stroke='#FFFFFF' stroke-opacity='1' stroke-width='0.37' stroke-linejoin='round' stroke-linecap='butt'/>\n   <polyline points='335.76,212.01 332.30,212.01' fill='none' stroke='#FFFFFF' stroke-opacity='1' stroke-width='0.37' stroke-linejoin='round' stroke-linecap='butt'/>\n   <polyline points='335.76,187.41 332.30,187.41' fill='none' stroke='#FFFFFF' stroke-opacity='1' stroke-width='0.37' stroke-linejoin='round' stroke-linecap='butt'/>\n   <polyline points='335.76,162.80 332.30,162.80' fill='none' stroke='#FFFFFF' stroke-opacity='1' stroke-width='0.37' stroke-linejoin='round' stroke-linecap='butt'/>\n   <polyline points='335.76,138.20 332.30,138.20' fill='none' stroke='#FFFFFF' stroke-opacity='1' stroke-width='0.37' stroke-linejoin='round' stroke-linecap='butt'/>\n   <text x='355.06' y='215.04' font-size='6.6pt' font-family='Liberation Sans'>2<\/text>\n   <text x='355.06' y='190.44' font-size='6.6pt' font-family='Liberation Sans'>4<\/text>\n   <text x='355.06' y='165.83' font-size='6.6pt' font-family='Liberation Sans'>6<\/text>\n   <text x='355.06' y='141.23' font-size='6.6pt' font-family='Liberation Sans'>8<\/text>\n  <\/g>\n <\/g>\n<\/svg>","js":null,"uid":"svg_a15b670239e02917","ratio":1.2,"settings":{"tooltip":{"css":".tooltip_SVGID_ { padding:5px;background:black;color:white;border-radius:2px;text-align:left; ; position:absolute;pointer-events:none;z-index:9999;}","placement":"doc","opacity":0.9,"offx":10,"offy":10,"use_cursor_pos":true,"use_fill":false,"use_stroke":false,"delay_over":200,"delay_out":500},"hover":{"css":".hover_data_SVGID_ { fill:orange;stroke:black;cursor:pointer; }\ntext.hover_data_SVGID_ { stroke:none;fill:orange; }\ncircle.hover_data_SVGID_ { fill:orange;stroke:black; }\nline.hover_data_SVGID_, polyline.hover_data_SVGID_ { fill:none;stroke:orange; }\nrect.hover_data_SVGID_, polygon.hover_data_SVGID_, path.hover_data_SVGID_ { fill:orange;stroke:none; }\nimage.hover_data_SVGID_ { stroke:orange; }","reactive":true,"nearest_distance":null,"linked":false},"hover_inv":{"css":""},"hover_key":{"css":".hover_key_SVGID_ { fill:orange;stroke:black;cursor:pointer; }\ntext.hover_key_SVGID_ { stroke:none;fill:orange; }\ncircle.hover_key_SVGID_ { fill:orange;stroke:black; }\nline.hover_key_SVGID_, polyline.hover_key_SVGID_ { fill:none;stroke:orange; }\nrect.hover_key_SVGID_, polygon.hover_key_SVGID_, path.hover_key_SVGID_ { fill:orange;stroke:none; }\nimage.hover_key_SVGID_ { stroke:orange; }","reactive":true},"hover_theme":{"css":".hover_theme_SVGID_ { fill:orange;stroke:black;cursor:pointer; }\ntext.hover_theme_SVGID_ { stroke:none;fill:orange; }\ncircle.hover_theme_SVGID_ { fill:orange;stroke:black; }\nline.hover_theme_SVGID_, polyline.hover_theme_SVGID_ { fill:none;stroke:orange; }\nrect.hover_theme_SVGID_, polygon.hover_theme_SVGID_, path.hover_theme_SVGID_ { fill:orange;stroke:none; }\nimage.hover_theme_SVGID_ { stroke:orange; }","reactive":true},"select":{"css":".select_data_SVGID_ { fill:red;stroke:black;cursor:pointer; }\ntext.select_data_SVGID_ { stroke:none;fill:red; }\ncircle.select_data_SVGID_ { fill:red;stroke:black; }\nline.select_data_SVGID_, polyline.select_data_SVGID_ { fill:none;stroke:red; }\nrect.select_data_SVGID_, polygon.select_data_SVGID_, path.select_data_SVGID_ { fill:red;stroke:none; }\nimage.select_data_SVGID_ { stroke:red; }","type":"multiple","only_shiny":true,"selected":[],"linked":false},"select_inv":{"css":""},"select_key":{"css":".select_key_SVGID_ { fill:red;stroke:black;cursor:pointer; }\ntext.select_key_SVGID_ { stroke:none;fill:red; }\ncircle.select_key_SVGID_ { fill:red;stroke:black; }\nline.select_key_SVGID_, polyline.select_key_SVGID_ { fill:none;stroke:red; }\nrect.select_key_SVGID_, polygon.select_key_SVGID_, path.select_key_SVGID_ { fill:red;stroke:none; }\nimage.select_key_SVGID_ { stroke:red; }","type":"single","only_shiny":true,"selected":[]},"select_theme":{"css":".select_theme_SVGID_ { fill:red;stroke:black;cursor:pointer; }\ntext.select_theme_SVGID_ { stroke:none;fill:red; }\ncircle.select_theme_SVGID_ { fill:red;stroke:black; }\nline.select_theme_SVGID_, polyline.select_theme_SVGID_ { fill:none;stroke:red; }\nrect.select_theme_SVGID_, polygon.select_theme_SVGID_, path.select_theme_SVGID_ { fill:red;stroke:none; }\nimage.select_theme_SVGID_ { stroke:red; }","type":"single","only_shiny":true,"selected":[]},"zoom":{"min":1,"max":1,"duration":300,"default_on":false},"toolbar":{"position":"topright","pngname":"diagram","tooltips":null,"fixed":false,"hidden":[],"delay_over":200,"delay_out":500},"sizing":{"rescale":true,"width":1}}},"evals":[],"jsHooks":[]}
```
