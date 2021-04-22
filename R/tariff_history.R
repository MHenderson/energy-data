# given a data frame of tariffs and a data frame time-series of
# begin/end dates for tariffs, construct the time-series data
# frame of tariffs
tariff_history <- function(tariffs) {
  t4 <- tibble(
    date = seq(as.Date("2019-07-16"), as.Date("2019-09-01"), "days"),
    tariff_id = 4
  )

  t3 <- tibble(
    date = seq(as.Date("2019-09-02"), as.Date("2020-08-30"), "days"),
    tariff_id = 3
  )

  t2 <- tibble(
    date = seq(as.Date("2020-08-31"), as.Date("2020-12-05"), "days"),
    tariff_id = 2
  )

  t1 <- tibble(
    date = seq(as.Date("2020-12-06"), Sys.Date(), "days"),
    tariff_id = 1
  )

  bind_rows(t1, t2, t3, t4) %>%
    left_join(tariffs) %>%
    mutate(seq_id = 5)

}
