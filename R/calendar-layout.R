canonicalize_week_start <- function(week_start) {
  if (is.numeric(week_start) && length(week_start) == 1 && !is.na(week_start)) {
    week_start <- as.integer(week_start)
    if (week_start %in% c(0L, 1L)) {
      return(week_start)
    }
  }

  if (is.character(week_start) && length(week_start) == 1) {
    week_start <- tolower(trimws(week_start))
    if (week_start %in% c("sunday", "sun")) {
      return(0L)
    }
    if (week_start %in% c("monday", "mon")) {
      return(1L)
    }
  }

  rlang::abort(
    "`week_start` must be one of: \"sunday\", \"monday\", 0, or 1."
  )
}

coerce_date_vector <- function(x, arg = "date") {
  out <- tryCatch(
    as.Date(x),
    error = function(e) rep(as.Date(NA), length(x))
  )

  if (anyNA(out)) {
    rlang::abort(
      paste0("`", arg, "` must contain only date-like values.")
    )
  }

  out
}

coerce_date_arg <- function(x, arg) {
  out <- tryCatch(as.Date(x), error = function(e) as.Date(NA))
  if (length(out) != 1 || is.na(out)) {
    rlang::abort(
      paste0("`", arg, "` must be a single date or date-like value.")
    )
  }
  out
}

validate_calendar_inputs <- function(
  dates,
  values,
  week_start,
  start_date,
  end_date,
  na_value
) {
  if (length(dates) != length(values)) {
    rlang::abort("`date` and `value` must have the same length.")
  }

  if (length(dates) == 0) {
    rlang::abort("`date` and `value` cannot be empty.")
  }

  coerce_date_vector(dates)

  if (!is.numeric(values)) {
    rlang::abort("`value` must be numeric.")
  }

  if (anyNA(values)) {
    rlang::abort("`value` cannot contain missing values.")
  }

  if (!is.numeric(na_value) || length(na_value) != 1 || is.na(na_value)) {
    rlang::abort("`na_value` must be a single numeric value.")
  }

  canonicalize_week_start(week_start)

  if (!is.null(start_date)) {
    coerce_date_arg(start_date, "start_date")
  }

  if (!is.null(end_date)) {
    coerce_date_arg(end_date, "end_date")
  }

  invisible(TRUE)
}

compute_calendar_layout <- function(
  dates,
  values,
  week_start = "sunday",
  start_date = NULL,
  end_date = NULL,
  na_value = 0
) {
  validate_calendar_inputs(
    dates = dates,
    values = values,
    week_start = week_start,
    start_date = start_date,
    end_date = end_date,
    na_value = na_value
  )

  week_start_index <- canonicalize_week_start(week_start)
  parsed_dates <- coerce_date_vector(dates)
  values <- as.numeric(values)

  daily_values <- stats::aggregate(
    values,
    by = list(date = parsed_dates),
    FUN = sum
  )
  names(daily_values)[2] <- "value"

  min_date <- min(daily_values$date)
  max_date <- max(daily_values$date)
  start_date <- if (is.null(start_date)) {
    min_date
  } else {
    coerce_date_arg(
      start_date,
      "start_date"
    )
  }
  end_date <- if (is.null(end_date)) {
    max_date
  } else {
    coerce_date_arg(
      end_date,
      "end_date"
    )
  }

  if (start_date > end_date) {
    rlang::abort("`start_date` must be on or before `end_date`.")
  }

  all_dates <- data.frame(
    date = seq.Date(start_date, end_date, by = "day")
  )

  calendar_data <- merge(
    all_dates,
    daily_values,
    by = "date",
    all.x = TRUE,
    sort = TRUE
  )
  missing_idx <- is.na(calendar_data$value)
  calendar_data$value[missing_idx] <- na_value

  start_wday <- as.POSIXlt(start_date)$wday
  calendar_start <- start_date - ((start_wday - week_start_index + 7L) %% 7L)

  wday <- as.POSIXlt(calendar_data$date)$wday
  weekday <- (wday - week_start_index + 7L) %% 7L
  week <- as.integer((calendar_data$date - calendar_start) / 7L)

  calendar_data$week <- week
  calendar_data$weekday <- weekday
  calendar_data$x <- week + 1L
  calendar_data$y <- 7L - weekday
  calendar_data$month <- format(calendar_data$date, "%Y-%m")
  calendar_data$week_start <- week_start_index

  calendar_data
}
