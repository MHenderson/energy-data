add_costs <- function(energy, tariffs) {

  energy_ <- energy %>%
    mutate(date = as.Date(date)) %>%
    mutate(tariff_id = list(tariffs$tariff_id)) %>%
    tidyr::unnest(cols = c(tariff_id)) %>%
    mutate(seq_id = tariff_id)

  energy__ <- left_join(energy_, tariffs, by = "tariff_id")

  tariffs_ <- tariffs %>%
    tariff_history() %>%
    left_join(energy)

  bind_rows(energy__, tariffs_) %>%
    dplyr::filter(!is.na(electricity)) %>%
    dplyr::filter(!is.na(gas)) %>%
    dplyr::arrange(date) %>%
    dplyr::rename(
              gas_kwh = gas,
      electricity_kwh = electricity
    ) %>%
    dplyr::mutate(
              gas_cost = (gas_kwh * gas_rate + gas_standing)/100,
      electricity_cost = (electricity_kwh * electricity_rate + electricity_standing)/100
    )
}
