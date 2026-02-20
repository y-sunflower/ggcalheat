test_that("duplicate dates are aggregated with sum", {
  dates <- as.Date(c("2025-01-01", "2025-01-01", "2025-01-02"))
  values <- c(2, 3, 4)

  out <- ggcalheat:::compute_calendar_layout(dates, values)

  expect_equal(out$value[out$date == as.Date("2025-01-01")], 5)
  expect_equal(out$value[out$date == as.Date("2025-01-02")], 4)
})

test_that("missing dates are completed with na_value", {
  dates <- as.Date(c("2025-01-01", "2025-01-03"))
  values <- c(1, 3)

  out <- ggcalheat:::compute_calendar_layout(
    dates = dates,
    values = values,
    start_date = as.Date("2025-01-01"),
    end_date = as.Date("2025-01-03"),
    na_value = 0
  )

  expect_equal(nrow(out), 3)
  expect_equal(out$value[out$date == as.Date("2025-01-02")], 0)
})

test_that("default range uses min and max input dates", {
  dates <- as.Date(c("2025-02-01", "2025-02-03"))
  values <- c(1, 2)

  out <- ggcalheat:::compute_calendar_layout(dates, values)

  expect_equal(min(out$date), as.Date("2025-02-01"))
  expect_equal(max(out$date), as.Date("2025-02-03"))
  expect_equal(nrow(out), 3)
})

test_that("explicit start_date and end_date define display window", {
  dates <- as.Date(c("2025-02-01", "2025-02-03"))
  values <- c(10, 20)

  out <- ggcalheat:::compute_calendar_layout(
    dates = dates,
    values = values,
    start_date = as.Date("2025-01-30"),
    end_date = as.Date("2025-02-04"),
    na_value = 0
  )

  expect_equal(min(out$date), as.Date("2025-01-30"))
  expect_equal(max(out$date), as.Date("2025-02-04"))
  expect_equal(nrow(out), 6)
})

test_that("weekday mapping changes with week_start", {
  dates <- as.Date("2025-01-05") # Sunday
  values <- 1

  sunday <- ggcalheat:::compute_calendar_layout(
    dates = dates,
    values = values,
    week_start = "sunday"
  )
  monday <- ggcalheat:::compute_calendar_layout(
    dates = dates,
    values = values,
    week_start = "monday"
  )

  expect_equal(sunday$weekday, 0)
  expect_equal(monday$weekday, 6)
})

test_that("signed values are preserved as numeric fill values", {
  dates <- as.Date(c("2025-01-01", "2025-01-02"))
  values <- c(-2, 4)

  out <- ggcalheat:::compute_calendar_layout(dates, values)

  expect_type(out$value, "double")
  expect_equal(sort(unique(out$value)), c(-2, 4))
})

test_that("invalid inputs fail with clear errors", {
  expect_error(
    ggcalheat:::compute_calendar_layout(
      dates = as.Date("2025-01-01"),
      values = 1,
      week_start = "tuesday"
    ),
    "week_start"
  )

  expect_error(
    ggcalheat:::compute_calendar_layout(
      dates = "not-a-date",
      values = 1
    ),
    "date"
  )

  expect_error(
    ggcalheat:::compute_calendar_layout(
      dates = as.Date("2025-01-01"),
      values = "x"
    ),
    "numeric"
  )
})

test_that("geom_calendar returns a working ggplot layer", {
  skip_if_not_installed("ggplot2")

  df <- data.frame(
    date = as.Date(c("2025-01-01", "2025-01-03")),
    value = c(1, 3)
  )

  plot <- ggplot2::ggplot(df, ggplot2::aes(date = date, value = value)) +
    geom_calendar()

  expect_s3_class(plot$layers[[1]], "LayerInstance")
  expect_no_error(ggplot2::ggplot_build(plot))

  built <- ggplot2::ggplot_build(plot)
  expect_equal(nrow(built$data[[1]]), 3)
  expect_false(plot$coordinates$default)
  expect_equal(plot$coordinates$ratio, 1)
})

test_that("geom_calendar can disable square rendering", {
  skip_if_not_installed("ggplot2")

  df <- data.frame(
    date = as.Date(c("2025-01-01", "2025-01-03")),
    value = c(1, 3)
  )

  plot <- ggplot2::ggplot(df, ggplot2::aes(date = date, value = value)) +
    geom_calendar(square = FALSE)

  expect_true(plot$coordinates$default)
  expect_null(plot$coordinates$ratio)
})

test_that("geom_calendar adds weekday and month labels by default", {
  skip_if_not_installed("ggplot2")

  df <- data.frame(
    date = seq.Date(as.Date("2025-01-01"), as.Date("2025-02-28"), by = "day"),
    value = seq_len(59)
  )

  plot <- ggplot2::ggplot(df, ggplot2::aes(date = date, value = value)) +
    geom_calendar()

  x_scale <- plot$scales$get_scales("x")
  y_scale <- plot$scales$get_scales("y")

  expect_null(x_scale$breaks)
  expect_equal(y_scale$breaks, 7:1)
  expect_equal(
    y_scale$labels,
    c("Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat")
  )

  built <- ggplot2::ggplot_build(plot)
  month_data <- built$data[[2]]
  expect_true(all(month_data$label %in% c("Jan", "Feb")))
  expect_true(all(month_data$y == 0.35))
})

test_that("geom_calendar label customization is respected", {
  skip_if_not_installed("ggplot2")

  df <- data.frame(
    date = seq.Date(as.Date("2025-01-01"), as.Date("2025-01-31"), by = "day"),
    value = seq_len(31)
  )

  custom_day_labels <- c("Mo", "Tu", "We", "Th", "Fr", "Sa", "Su")

  plot <- ggplot2::ggplot(df, ggplot2::aes(date = date, value = value)) +
    geom_calendar(
      week_start = "monday",
      day_labels = custom_day_labels,
      month_labels = function(x) toupper(format(x, "%b")),
      month_label_y = 0.2,
      month_label_color = "red"
    )

  y_scale <- plot$scales$get_scales("y")
  expect_equal(y_scale$labels, custom_day_labels)

  built <- ggplot2::ggplot_build(plot)
  month_data <- built$data[[2]]
  expect_equal(unique(month_data$label), "JAN")
  expect_true(all(month_data$y == 0.2))
  expect_true(all(month_data$colour == "red"))
})

test_that("geom_calendar_interactive works with ggiraph", {
  skip_if_not_installed("ggplot2")
  skip_if_not_installed("ggiraph")

  df <- data.frame(
    date = as.Date(c("2025-01-01", "2025-01-03")),
    value = c(1, 3),
    label = c("first", "second")
  )

  plot <- ggplot2::ggplot(df, ggplot2::aes(date = date, value = value)) +
    geom_calendar_interactive(
      ggplot2::aes(
        tooltip = paste("Date:", date, "| Label:", label),
        data_id = as.character(date)
      )
    )

  expect_s3_class(plot$layers[[1]], "LayerInstance")
  expect_no_error(ggplot2::ggplot_build(plot))

  built <- ggplot2::ggplot_build(plot)
  expect_equal(nrow(built$data[[1]]), 3)
  expect_true(any(!is.na(built$data[[1]]$tooltip)))
  expect_false(plot$coordinates$default)
  expect_equal(plot$coordinates$ratio, 1)
})

test_that("geom_calendar_interactive can disable square rendering", {
  skip_if_not_installed("ggplot2")
  skip_if_not_installed("ggiraph")

  df <- data.frame(
    date = as.Date(c("2025-01-01", "2025-01-03")),
    value = c(1, 3)
  )

  plot <- ggplot2::ggplot(df, ggplot2::aes(date = date, value = value)) +
    geom_calendar_interactive(square = FALSE)

  expect_true(plot$coordinates$default)
  expect_null(plot$coordinates$ratio)
})
