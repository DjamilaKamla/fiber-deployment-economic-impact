library(readxl)
library(dplyr)
library(tidyr)
library(stringr)


# 1. Charger la feuille "COM"
df_crea <- read_excel("C:/Users/fares/OneDrive/Desktop/Mémoire/Ent/TAB_SIDE_CREA_ENT_COM_HISTO_fr.xlsx", sheet = "COM", skip = 3)


df_crea_long <- df_crea %>%
  rename(INSEE_COM = 1) %>%
  select(-2) %>%  # Supprimer la colonne du nom de commune (inutile ici)
  pivot_longer(
    cols = everything()[-1],
    names_to = "annee",
    values_to = "nb_creations"
  ) %>%
  mutate(
    INSEE_COM = str_pad(as.character(INSEE_COM), 5, pad = "0"),
    annee = as.integer(annee),
    nb_creations = as.numeric(nb_creations)
  ) %>%
  arrange(INSEE_COM, annee)

write.csv(df_crea_long, "creations_entreprises.csv", row.names = FALSE)
