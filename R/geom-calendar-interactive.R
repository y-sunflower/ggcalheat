#' Interactive calendar heatmap geometry for ggiraph
#'
#' `geom_calendar_interactive()` behaves like [geom_calendar()] but draws tiles
#' with ggiraph's interactive geometry.
#'
#' By default, each day has:
#' - `data_id = as.character(date)`
#' - `tooltip = paste0(date, ": ", value)`
#'
#' You can override these by mapping interactive aesthetics (`tooltip`,
#' `data_id`, `onclick`, etc.) inside [ggplot2::aes()].
#'
#' @inheritParams geom_calendar
#' @return A ggplot2 component using ggiraph interactive geometry. By default
#'   this includes [ggplot2::coord_fixed()] so day tiles stay square.
#' @export
#'
#' @examplesIf requireNamespace("ggiraph", quietly = TRUE)
#' library(ggplot2)
#' library(ggiraph)
#'
#' set.seed(42)
#' daily <- data.frame(
#'   date = seq.Date(as.Date("2025-01-01"), as.Date("2025-01-31"), by = "day"),
#'   value = rpois(31, lambda = 3)
#' )
#'
#' p <- ggplot(daily, aes(date = date, value = value)) +
#'   geom_calendar_interactive(
#'     aes(
#'       tooltip = paste("Date:", date, "\nValue:", value),
#'       data_id = date
#'     )
#'   ) +
#'   scale_fill_gradient(low = "grey95", high = "#2C7FB8")
#'
#' girafe(ggobj = p)
geom_calendar_interactive <- function(
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
) {
  square <- validate_square_flag(square, arg = "square")

  if (!requireNamespace("ggiraph", quietly = TRUE)) {
    rlang::abort(
      "Package `ggiraph` must be installed to use `geom_calendar_interactive()`."
    )
  }

  geom_interactive_tile <- getFromNamespace("GeomInteractiveTile", "ggiraph")

  layer <- ggplot2::layer(
    data = data,
    mapping = mapping,
    stat = StatCalendarInteractive,
    geom = geom_interactive_tile,
    position = "identity",
    show.legend = show.legend,
    inherit.aes = inherit.aes,
    params = list(
      week_start = week_start,
      start_date = start_date,
      end_date = end_date,
      na_value = na_value,
      width = cell_width,
      height = cell_height,
      colour = color,
      linewidth = linewidth,
      na.rm = na.rm,
      ...
    )
  )

  if (square) {
    return(list(layer, ggplot2::coord_fixed(ratio = 1)))
  }

  layer
}
