# given a data frame of tariffs and a data frame time-series of
# begin/end dates for tariffs, construct the time-series data
# frame of tariffs
tariff_series <- function(tariffs, tariff_history) {

  f <- function(id, begin, end) {
    tibble(
      date = seq(begin, end, "days"),
      tariff_id = id
    )
  }

  list(
    id = tariff_history$tariff_id,
    begin = tariff_history$begin,
    end = tariff_history$end
  ) %>%
    pmap_dfr(f) %>%
    left_join(tariffs) %>%
    mutate(seq_id = 5)

}
