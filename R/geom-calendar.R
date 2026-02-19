first_non_missing <- function(x) {
  idx <- which(!is.na(x))
  if (length(idx) == 0) {
    return(NA)
  }
  x[[idx[[1]]]]
}

validate_square_flag <- function(square, arg = "square") {
  if (!is.logical(square) || length(square) != 1 || is.na(square)) {
    rlang::abort(
      paste0("`", arg, "` must be either TRUE or FALSE.")
    )
  }

  square
}

compute_calendar_panel_data <- function(
  data,
  week_start = "sunday",
  start_date = NULL,
  end_date = NULL,
  na_value = 0
) {
  calendar_data <- compute_calendar_layout(
    dates = data$date,
    values = data$value,
    week_start = week_start,
    start_date = start_date,
    end_date = end_date,
    na_value = na_value
  )

  excluded <- c(
    "date",
    "value",
    "PANEL",
    "group",
    "x",
    "y",
    "week",
    "weekday",
    "month",
    "week_start"
  )
  metadata_cols <- setdiff(names(data), excluded)
  if (length(metadata_cols) == 0) {
    return(calendar_data)
  }

  metadata <- stats::aggregate(
    data[metadata_cols],
    by = list(date = coerce_date_vector(data$date)),
    FUN = first_non_missing
  )

  merge(
    calendar_data,
    metadata,
    by = "date",
    all.x = TRUE,
    sort = TRUE
  )
}

StatCalendar <- ggplot2::ggproto(
  "StatCalendar",
  ggplot2::Stat,
  required_aes = c("date", "value"),
  default_aes = ggplot2::aes(fill = ggplot2::after_stat(value)),
  compute_panel = function(
    data,
    scales,
    week_start = "sunday",
    start_date = NULL,
    end_date = NULL,
    na_value = 0
  ) {
    compute_calendar_panel_data(
      data = data,
      week_start = week_start,
      start_date = start_date,
      end_date = end_date,
      na_value = na_value
    )
  }
)

StatCalendarInteractive <- ggplot2::ggproto(
  "StatCalendarInteractive",
  ggplot2::Stat,
  required_aes = c("date", "value"),
  default_aes = ggplot2::aes(
    fill = ggplot2::after_stat(value),
    data_id = ggplot2::after_stat(as.character(date)),
    tooltip = ggplot2::after_stat(paste0(as.character(date), ": ", value))
  ),
  compute_panel = function(
    data,
    scales,
    week_start = "sunday",
    start_date = NULL,
    end_date = NULL,
    na_value = 0
  ) {
    compute_calendar_panel_data(
      data = data,
      week_start = week_start,
      start_date = start_date,
      end_date = end_date,
      na_value = na_value
    )
  }
)

#' Calendar heatmap geometry
#'
#' `geom_calendar()` draws one tile per day and computes calendar positions from
#' the input data. Users only need to map `date` and `value`; week/day placement
#' is handled internally.
#'
#' Duplicate dates are aggregated by summing values before plotting.
#'
#' @param mapping Set of aesthetic mappings created by [ggplot2::aes()]. Must
#'   include `date` and `value`.
#' @param data A data frame.
#' @param ... Additional parameters passed on to [ggplot2::layer()].
#' @param week_start First day of week. One of `"sunday"`, `"monday"`, `0`, or
#'   `1`.
#' @param start_date Optional lower date bound for the displayed range.
#' @param end_date Optional upper date bound for the displayed range.
#' @param na_value Value assigned to dates that are missing from input data.
#' @param cell_width Width of each day tile.
#' @param cell_height Height of each day tile.
#' @param square If `TRUE`, adds [ggplot2::coord_fixed()] (`ratio = 1`) so day
#'   cells render as squares by default.
#' @param color Tile border color.
#' @param linewidth Tile border line width.
#' @param na.rm Passed to [ggplot2::geom_tile()] to control NA handling.
#' @param show.legend Should this layer be included in legends?
#' @param inherit.aes If `FALSE`, overrides global aesthetics.
#'
#' @return A ggplot2 component. By default this includes the calendar layer plus
#'   [ggplot2::coord_fixed()] so day tiles stay square.
#' @export
#'
#' @examples
#' library(ggplot2)
#'
#' set.seed(1)
#' daily <- data.frame(
#'   date = seq.Date(as.Date("2025-01-01"), as.Date("2025-03-31"), by = "day"),
#'   value = rpois(90, lambda = 3)
#' )
#'
#' ggplot(daily, aes(date = date, value = value)) +
#'   geom_calendar() +
#'   scale_fill_gradient(low = "grey95", high = "#2C7FB8")
#'
#' signed_values <- data.frame(
#'   date = seq.Date(as.Date("2025-01-01"), as.Date("2025-02-28"), by = "day"),
#'   value = rnorm(59, mean = 0, sd = 2)
#' )
#'
#' ggplot(signed_values, aes(date = date, value = value)) +
#'   geom_calendar() +
#'   scale_fill_gradient2(
#'     low = "#B2182B",
#'     mid = "white",
#'     high = "#2166AC"
#'   )
geom_calendar <- function(
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

  layer <- ggplot2::layer(
    data = data,
    mapping = mapping,
    stat = StatCalendar,
    geom = ggplot2::GeomTile,
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
