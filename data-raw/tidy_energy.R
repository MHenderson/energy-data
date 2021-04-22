## code to prepare `energy` dataset goes here

library(dplyr)
library(googlesheets4)

source("R/add_costs.R")
source("R/tariff_history.R")

gs4_deauth()

# should be a secret?
sheet_id <- "15nKk44UVxxex7OrhdV3bZRTD0NsniclZmfwtqL0ls18"

energy_2019 <- sheet_id %>%
  range_read("2019")

energy_2020 <- sheet_id %>%
  range_read("2020")

energy_2021 <- sheet_id %>%
  range_read("2021")

energy <- bind_rows(energy_2019, energy_2020, energy_2021)

bills <- sheet_id %>%
  range_read("bills")

readings <- sheet_id %>%
  range_read("readings")

tariffs <- sheet_id %>%
  range_read("tariffs")

energy <- add_costs(energy, tariffs)

tidy_energy <- energy %>%
  tidyr::pivot_longer(
    !c(date, supplier, tariff_name, tariff_id, seq_id),
    names_to = c("fuel", "var"),
    names_sep = "_"
  )

saveRDS(tidy_energy, file = "data/tidy_energy.rds")
saveRDS(bills, file = "data/bills.rds")
saveRDS(readings, file = "data/readings.rds")
saveRDS(tariffs, file = "data/tariffs.rds")
