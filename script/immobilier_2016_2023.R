library(readxl)
library(dplyr)
library(stringr)
library(purrr)

# 1. Charger le fichier avec le bon séparateur
df_dvf2016 <- read_csv("C:/Users/fares/OneDrive/Desktop/Mémoire/immobibilier/dvf2016.csv")

# 2. Garder uniquement les colonnes utiles
df_dvf2016_clean <- df_dvf2016 %>%
  select(INSEE_COM, Annee, Nb_mutations, PrixMoyen, Prixm2Moyen) %>%
  mutate(
    INSEE_COM = str_pad(as.character(INSEE_COM), width = 5, pad = "0"),
    Annee = as.integer(Annee),
    Nb_mutations = as.numeric(Nb_mutations),
    PrixMoyen = as.numeric(PrixMoyen),
    Prixm2Moyen = as.numeric(Prixm2Moyen)
  ) %>%
  arrange(INSEE_COM, Annee)
####################################
# 1. Charger le fichier avec le bon séparateur
df_dvf2017 <- read_csv("C:/Users/fares/OneDrive/Desktop/Mémoire/immobibilier/dvf2017.csv")

# 2. Garder uniquement les colonnes utiles
df_dvf2017_clean <- df_dvf2017 %>%
  select(INSEE_COM, Annee, Nb_mutations, PrixMoyen, Prixm2Moyen) %>%
  mutate(
    INSEE_COM = str_pad(as.character(INSEE_COM), width = 5, pad = "0"),
    Annee = as.integer(Annee),
    Nb_mutations = as.numeric(Nb_mutations),
    PrixMoyen = as.numeric(PrixMoyen),
    Prixm2Moyen = as.numeric(Prixm2Moyen)
  ) %>%
  arrange(INSEE_COM, Annee)
###############################
# 1. Charger le fichier avec le bon séparateur
df_dvf2018 <- read_csv("C:/Users/fares/OneDrive/Desktop/Mémoire/immobibilier/dvf2018.csv")

# 2. Garder uniquement les colonnes utiles
df_dvf2018_clean <- df_dvf2018 %>%
  select(INSEE_COM, Annee, Nb_mutations, PrixMoyen, Prixm2Moyen) %>%
  mutate(
    INSEE_COM = str_pad(as.character(INSEE_COM), width = 5, pad = "0"),
    Annee = as.integer(Annee),
    Nb_mutations = as.numeric(Nb_mutations),
    PrixMoyen = as.numeric(PrixMoyen),
    Prixm2Moyen = as.numeric(Prixm2Moyen)
  ) %>%
  arrange(INSEE_COM, Annee)
################################
# 1. Charger le fichier avec le bon séparateur
df_dvf2019 <- read_csv("C:/Users/fares/OneDrive/Desktop/Mémoire/immobibilier/dvf2019.csv")

# 2. Garder uniquement les colonnes utiles
df_dvf2019_clean <- df_dvf2019 %>%
  select(INSEE_COM, Annee, Nb_mutations, PrixMoyen, Prixm2Moyen) %>%
  mutate(
    INSEE_COM = str_pad(as.character(INSEE_COM), width = 5, pad = "0"),
    Annee = as.integer(Annee),
    Nb_mutations = as.numeric(Nb_mutations),
    PrixMoyen = as.numeric(PrixMoyen),
    Prixm2Moyen = as.numeric(Prixm2Moyen)
  ) %>%
  arrange(INSEE_COM, Annee)


df_dvf2020 <- read_csv("C:/Users/fares/OneDrive/Desktop/Mémoire/immobibilier/dvf2020.csv")

# 2. Garder uniquement les colonnes utiles
df_dvf2020_clean <- df_dvf2020 %>%
  select(INSEE_COM, Annee, Nb_mutations, PrixMoyen, Prixm2Moyen) %>%
  mutate(
    INSEE_COM = str_pad(as.character(INSEE_COM), width = 5, pad = "0"),
    Annee = as.integer(Annee),
    Nb_mutations = as.numeric(Nb_mutations),
    PrixMoyen = as.numeric(PrixMoyen),
    Prixm2Moyen = as.numeric(Prixm2Moyen)
  ) %>%
  arrange(INSEE_COM, Annee)

df_dvf2021 <- read_csv("C:/Users/fares/OneDrive/Desktop/Mémoire/immobibilier/dvf2021.csv")

# 2. Garder uniquement les colonnes utiles
df_dvf2021_clean <- df_dvf2021 %>%
  select(INSEE_COM, Annee, Nb_mutations, PrixMoyen, Prixm2Moyen) %>%
  mutate(
    INSEE_COM = str_pad(as.character(INSEE_COM), width = 5, pad = "0"),
    Annee = as.integer(Annee),
    Nb_mutations = as.numeric(Nb_mutations),
    PrixMoyen = as.numeric(PrixMoyen),
    Prixm2Moyen = as.numeric(Prixm2Moyen)
  ) %>%
  arrange(INSEE_COM, Annee)

df_dvf2022 <- read_csv("C:/Users/fares/OneDrive/Desktop/Mémoire/immobibilier/dvf2022.csv")

# 2. Garder uniquement les colonnes utiles
df_dvf2022_clean <- df_dvf2022 %>%
  select(INSEE_COM, Annee, Nb_mutations, PrixMoyen, Prixm2Moyen) %>%
  mutate(
    INSEE_COM = str_pad(as.character(INSEE_COM), width = 5, pad = "0"),
    Annee = as.integer(Annee),
    Nb_mutations = as.numeric(Nb_mutations),
    PrixMoyen = as.numeric(PrixMoyen),
    Prixm2Moyen = as.numeric(Prixm2Moyen)
  ) %>%
  arrange(INSEE_COM, Annee)

df_dvf2023 <- read_csv("C:/Users/fares/OneDrive/Desktop/Mémoire/immobibilier/dvf2023.csv")

# 2. Garder uniquement les colonnes utiles
df_dvf2023_clean <- df_dvf2023 %>%
  select(INSEE_COM, Annee, Nb_mutations, PrixMoyen, Prixm2Moyen) %>%
  mutate(
    INSEE_COM = str_pad(as.character(INSEE_COM), width = 5, pad = "0"),
    Annee = as.integer(Annee),
    Nb_mutations = as.numeric(Nb_mutations),
    PrixMoyen = as.numeric(PrixMoyen),
    Prixm2Moyen = as.numeric(Prixm2Moyen)
  ) %>%
  arrange(INSEE_COM, Annee)
###################################
# Fusion verticale des tables population (elles ont toutes les colonnes INSEE_COM + annee + population + niveau_densite)
immobilier_panel <- bind_rows(
  df_dvf2023_clean, df_dvf2022_clean, df_dvf2021_clean, df_dvf2020_clean, df_dvf2019_clean,
  df_dvf2018_clean, df_dvf2017_clean, df_dvf2016_clean
)
immobilier_panel <- immobilier_panel %>%
  arrange(INSEE_COM, Annee)

write.csv(immobilier_panel, "immobilier_2016_2023.csv", row.names = FALSE)
