library(dplyr)
panel_fibre <- read.csv("C:/Users/fares/OneDrive/Desktop/Mémoire/Fibre/panel_fibre_it_2018_2024.csv")

panel_fibre <- panel_fibre %>%
  arrange(INSEE_COM, annee) %>%
  group_by(INSEE_COM) %>%
  mutate(Fibre_it = cummax(Fibre_it)) %>%
  ungroup()

write.csv(panel_fibre, "C:/Users/fares/OneDrive/Desktop/Mémoire/Fibre/panel_fibre_it_corrige_2018_2024.csv", row.names = FALSE)
