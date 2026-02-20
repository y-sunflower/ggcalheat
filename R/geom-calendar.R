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

validate_label_flag <- function(x, arg) {
  if (!is.logical(x) || length(x) != 1 || is.na(x)) {
    rlang::abort(
      paste0("`", arg, "` must be either TRUE or FALSE.")
    )
  }

  x
}

validate_numeric_scalar <- function(x, arg) {
  if (!is.numeric(x) || length(x) != 1 || is.na(x)) {
    rlang::abort(
      paste0("`", arg, "` must be a single numeric value.")
    )
  }

  x
}

extract_calendar_mapping <- function(mapping) {
  if (is.null(mapping)) {
    return(NULL)
  }

  keep <- intersect(names(mapping), c("date", "value"))
  if (length(keep) == 0) {
    return(NULL)
  }

  out <- mapping[keep]
  class(out) <- class(mapping)
  out
}

resolve_day_labels <- function(week_start = "sunday", day_labels = NULL) {
  if (is.null(day_labels)) {
    default_labels <- c("Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat")
    week_start_index <- canonicalize_week_start(week_start)
    if (week_start_index == 1L) {
      return(c(default_labels[2:7], default_labels[1]))
    }
    return(default_labels)
  }

  if (
    !is.character(day_labels) ||
      length(day_labels) != 7 ||
      anyNA(day_labels)
  ) {
    rlang::abort(
      paste0(
        "`day_labels` must be a character vector of length 7 ",
        "with no missing values."
      )
    )
  }

  day_labels
}

format_month_labels <- function(month_dates, month_labels) {
  if (is.function(month_labels)) {
    out <- month_labels(month_dates)
  } else if (
    is.character(month_labels) &&
      length(month_labels) == 1 &&
      !is.na(month_labels)
  ) {
    out <- format(month_dates, month_labels)
  } else {
    rlang::abort(
      paste0(
        "`month_labels` must be either a single date format string ",
        "or a function."
      )
    )
  }

  if (length(out) != length(month_dates) || anyNA(out)) {
    rlang::abort(
      paste0(
        "`month_labels` must return one non-missing label per displayed month."
      )
    )
  }

  as.character(out)
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

compute_calendar_month_label_data <- function(
  data,
  week_start = "sunday",
  start_date = NULL,
  end_date = NULL,
  na_value = 0,
  month_labels = "%b",
  y = 0.35
) {
  calendar_data <- compute_calendar_panel_data(
    data = data,
    week_start = week_start,
    start_date = start_date,
    end_date = end_date,
    na_value = na_value
  )

  month_idx <- split(seq_len(nrow(calendar_data)), calendar_data$month)
  month_ids <- names(month_idx)
  month_dates <- as.Date(paste0(month_ids, "-01"))
  labels <- format_month_labels(month_dates, month_labels)

  x_positions <- vapply(
    month_idx,
    FUN = function(idx) mean(range(calendar_data$x[idx])),
    FUN.VALUE = numeric(1)
  )

  data.frame(
    x = as.numeric(x_positions),
    y = rep(y, length(x_positions)),
    label = labels,
    group = seq_along(x_positions),
    stringsAsFactors = FALSE
  )
}

StatCalendarMonthLabels <- ggplot2::ggproto(
  "StatCalendarMonthLabels",
  ggplot2::Stat,
  required_aes = c("date", "value"),
  default_aes = ggplot2::aes(label = ggplot2::after_stat(label)),
  compute_panel = function(
    data,
    scales,
    week_start = "sunday",
    start_date = NULL,
    end_date = NULL,
    na_value = 0,
    month_labels = "%b",
    y = 0.35
  ) {
    compute_calendar_month_label_data(
      data = data,
      week_start = week_start,
      start_date = start_date,
      end_date = end_date,
      na_value = na_value,
      month_labels = month_labels,
      y = y
    )
  }
)

build_calendar_axis_components <- function(
  data = NULL,
  mapping = NULL,
  week_start = "sunday",
  start_date = NULL,
  end_date = NULL,
  na_value = 0,
  show_month_labels = TRUE,
  month_labels = "%b",
  month_label_y = 0.35,
  month_label_size = 2.5,
  month_label_color = "grey20",
  month_label_vjust = 1,
  show_day_labels = TRUE,
  day_labels = NULL,
  inherit.aes = TRUE
) {
  show_month_labels <- validate_label_flag(
    show_month_labels,
    "show_month_labels"
  )
  show_day_labels <- validate_label_flag(show_day_labels, "show_day_labels")

  y_scale <- if (show_day_labels) {
    ggplot2::scale_y_continuous(
      breaks = 7:1,
      labels = resolve_day_labels(
        week_start = week_start,
        day_labels = day_labels
      )
    )
  } else {
    ggplot2::scale_y_continuous(
      breaks = NULL,
      labels = NULL
    )
  }

  components <- list(
    ggplot2::scale_x_continuous(
      breaks = NULL,
      labels = NULL,
      minor_breaks = NULL
    ),
    y_scale
  )

  if (!show_month_labels) {
    return(components)
  }

  validate_numeric_scalar(month_label_y, "month_label_y")
  validate_numeric_scalar(month_label_size, "month_label_size")
  validate_numeric_scalar(month_label_vjust, "month_label_vjust")

  if (
    !is.character(month_label_color) ||
      length(month_label_color) != 1 ||
      is.na(month_label_color)
  ) {
    rlang::abort("`month_label_color` must be a single character value.")
  }

  month_layer <- ggplot2::layer(
    data = data,
    mapping = extract_calendar_mapping(mapping),
    stat = StatCalendarMonthLabels,
    geom = ggplot2::GeomText,
    position = "identity",
    show.legend = FALSE,
    inherit.aes = inherit.aes,
    params = list(
      week_start = week_start,
      start_date = start_date,
      end_date = end_date,
      na_value = na_value,
      month_labels = month_labels,
      y = month_label_y,
      na.rm = TRUE,
      size = month_label_size,
      colour = month_label_color,
      vjust = month_label_vjust
    )
  )

  c(components, list(month_layer))
}

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
#' @param show_month_labels If `TRUE`, draws month labels below the calendar
#'   using abbreviated names by default.
#' @param month_labels Month label formatter. Use a single date format string
#'   (default `"%b"`) or a function that takes month-start dates and returns
#'   labels.
#' @param month_label_y Vertical position for month labels (in calendar y units).
#' @param month_label_size Text size for month labels.
#' @param month_label_color Text color for month labels.
#' @param month_label_vjust Vertical justification for month labels.
#' @param show_day_labels If `TRUE`, shows weekday labels on the y-axis.
#' @param day_labels Optional custom weekday labels (character vector of length
#'   7, top to bottom).
#' @param square If `TRUE`, adds [ggplot2::coord_fixed()] (`ratio = 1`) so day
#'   cells render as squares by default.
#' @param color Tile border color.
#' @param linewidth Tile border line width.
#' @param na.rm Passed to [ggplot2::geom_tile()] to control NA handling.
#' @param show.legend Should this layer be included in legends?
#' @param inherit.aes If `FALSE`, overrides global aesthetics.
#'
#' @return A ggplot2 component. By default this includes calendar tiles, hidden
#'   x ticks, weekday labels on y, month labels below the heatmap, and
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

  axis_components <- build_calendar_axis_components(
    data = data,
    mapping = mapping,
    week_start = week_start,
    start_date = start_date,
    end_date = end_date,
    na_value = na_value,
    show_month_labels = show_month_labels,
    month_labels = month_labels,
    month_label_y = month_label_y,
    month_label_size = month_label_size,
    month_label_color = month_label_color,
    month_label_vjust = month_label_vjust,
    show_day_labels = show_day_labels,
    day_labels = day_labels,
    inherit.aes = inherit.aes
  )

  components <- c(list(layer), axis_components)

  if (square) {
    return(c(components, list(ggplot2::coord_fixed(ratio = 1))))
  }

  components
}
