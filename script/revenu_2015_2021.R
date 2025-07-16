library(readxl)
library(dplyr)
library(stringr)
library(purrr)
##############################
# 1. Lire le fichier
df_rev2015 <- read_excel("C:/Users/fares/OneDrive/Desktop/Mémoire/Revenu/base-cc-filosofi-2015.xls", skip = 5)

df_rev2015_clean <- df_rev2015 %>%
  mutate(
    annee = 2015,
    INSEE_COM = str_pad(as.character(CODGEO), 5, pad = "0")
  ) %>%
  select(
    INSEE_COM, annee,
    med_nivvie = MED15,
    nb_menages = NBMENFISC15,
    nb_personnes = NBPERSMENFISC15,
    part_imposes = PIMP15
  )
#################
# 1. Lire le fichier
df_rev2016 <- read_excel("C:/Users/fares/OneDrive/Desktop/Mémoire/Revenu/base-cc-filosofi-2016.xls", skip = 5)

df_rev2016_clean <- df_rev2016 %>%
  mutate(
    annee = 2016,
    INSEE_COM = str_pad(as.character(CODGEO), 5, pad = "0")
  ) %>%
  select(
    INSEE_COM, annee,
    med_nivvie = MED16,
    nb_menages = NBMENFISC16,
    nb_personnes = NBPERSMENFISC16,
    part_imposes = PIMP16
  )

#################
df_rev2017 <- read_excel("C:/Users/fares/OneDrive/Desktop/Mémoire/Revenu/base-cc-filosofi-2017.xlsX", skip = 5)

df_rev2017_clean <- df_rev2017 %>%
  mutate(
    annee = 2017,
    INSEE_COM = str_pad(as.character(CODGEO), 5, pad = "0")
  ) %>%
  select(
    INSEE_COM, annee,
    med_nivvie = MED17,
    nb_menages = NBMENFISC17,
    nb_personnes = NBPERSMENFISC17,
    part_imposes = PIMP17
  )

##########
df_rev2018 <- read_excel("C:/Users/fares/OneDrive/Desktop/Mémoire/Revenu/base-cc-filosofi-2018-geo2021.xlsX", skip = 5)

df_rev2018_clean <- df_rev2018 %>%
  mutate(
    annee = 2018,
    INSEE_COM = str_pad(as.character(CODGEO), 5, pad = "0")
  ) %>%
  select(
    INSEE_COM, annee,
    med_nivvie = MED18,
    nb_menages = NBMENFISC18,
    nb_personnes = NBPERSMENFISC18,
    part_imposes = PIMP18
  )

##########
df_rev2019 <- read_excel("C:/Users/fares/OneDrive/Desktop/Mémoire/Revenu/base-cc-filosofi-2019-geo2022.xlsX", skip = 5)

df_rev2019_clean <- df_rev2019 %>%
  mutate(
    annee = 2019,
    INSEE_COM = str_pad(as.character(CODGEO), 5, pad = "0")
  ) %>%
  select(
    INSEE_COM, annee,
    med_nivvie = MED19,
    nb_menages = NBMENFISC19,
    nb_personnes = NBPERSMENFISC19,
    part_imposes = PIMP19
  )

##########
df_rev2020 <- read_excel("C:/Users/fares/OneDrive/Desktop/Mémoire/Revenu/base-cc-filosofi-2020-geo2023.xlsX", skip = 5)

df_rev2020_clean <- df_rev2020 %>%
  mutate(
    annee = 2020,
    INSEE_COM = str_pad(as.character(CODGEO), 5, pad = "0")
  ) %>%
  select(
    INSEE_COM, annee,
    med_nivvie = MED20,
    nb_menages = NBMENFISC20,
    nb_personnes = NBPERSMENFISC20,
    part_imposes = PIMP20
  )

##########
df_rev2021 <- read_excel("C:/Users/fares/OneDrive/Desktop/Mémoire/Revenu/base-cc-filosofi-2021-geo2024.xlsX", skip = 5)

df_rev2021_clean <- df_rev2021 %>%
  mutate(
    annee = 2021,
    INSEE_COM = str_pad(as.character(CODGEO), 5, pad = "0")
  ) %>%
  select(
    INSEE_COM, annee,
    med_nivvie = MED21,
    nb_menages = NBMENFISC21,
    nb_personnes = NBPERSMENFISC21,
    part_imposes = PIMP21
  )

####################
# Conversion sécurisée de toutes les colonnes concernées
colonnes_numeriques <- c("med_nivvie", "nb_menages", "nb_personnes", "part_imposes")

for (col in colonnes_numeriques) {
  df_rev2015_clean[[col]] <- as.numeric(df_rev2015_clean[[col]])
  df_rev2016_clean[[col]] <- as.numeric(df_rev2016_clean[[col]])
  df_rev2017_clean[[col]] <- as.numeric(df_rev2017_clean[[col]])
  df_rev2018_clean[[col]] <- as.numeric(df_rev2018_clean[[col]])
  df_rev2019_clean[[col]] <- as.numeric(df_rev2019_clean[[col]])
  df_rev2020_clean[[col]] <- as.numeric(df_rev2020_clean[[col]])
  df_rev2021_clean[[col]] <- as.numeric(df_rev2021_clean[[col]])
}

revenu_panel <- bind_rows(
  df_rev2015_clean,
  df_rev2016_clean,
  df_rev2017_clean,
  df_rev2018_clean,
  df_rev2019_clean,
  df_rev2020_clean,
  df_rev2021_clean
)

revenu_panel <- revenu_panel %>%
  arrange(INSEE_COM, annee)

write.csv(revenu_panel, "revenu_2015_2021.csv", row.names = FALSE)
