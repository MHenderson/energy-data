library(dplyr)
library(here)

gas_kwh <- tidy_energy %>%
  filter(fuel == "gas", var == "kwh") %>%
  select(date, value) %>%
  mutate(date = as.Date(date))

write.csv(gas_kwh, here("data-raw", "gas_kwh.csv"), row.names = FALSE, quote = FALSE)
