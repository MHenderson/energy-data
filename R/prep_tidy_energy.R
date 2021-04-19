prep_tidy_energy <- function(energy) {
  energy %>%
    dplyr::filter(!is.na(electricity)) %>%
    dplyr::filter(!is.na(gas)) %>%
    simputation::impute_lm(gas ~ date) %>%
    simputation::impute_lm(electricity ~ date) %>%
    dplyr::arrange(date) %>%
    dplyr::rename(gas_kwh = gas, electricity_kwh = electricity) %>%
    dplyr::mutate(
      gas_cost = gas_kwh * gas_rate + gas_standing,
      electricity_cost = electricity_kwh * electricity_rate + electricity_standing
    ) %>%
    dplyr::mutate(
      gas_total = cumsum(gas_cost),
      electricity_total = cumsum(electricity_cost),
    ) %>%
    tidyr::pivot_longer(
      !c(date, supplier, tarrif_name),
      names_to = c("fuel", "var"),
      names_sep = "_"
    ) %>%
    dplyr::mutate(
      year = lubridate::year(date),
      month = lubridate::month(date)
    )
}
