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
})
