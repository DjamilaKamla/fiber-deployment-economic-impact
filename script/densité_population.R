library(readxl)
library(dplyr)
library(stringr)
library(purrr)
####################
df_pop15 <-read_excel("C:/Users/fares/OneDrive/Desktop/Mémoire/densité/grille_densite_7_niveaux_2015.xlsx", skip = 4) 

df_pop15 <- df_pop15 %>%
  mutate(
    annee = 2015,
    INSEE_COM = str_pad(as.character(CODGEO), 5, pad = "0"),
    population = as.numeric(PMUN13),
    niveau_densite = as.numeric(DENS)
  ) %>%
  select(INSEE_COM, annee, population, niveau_densite)
########################
df_pop16 <-read_excel("C:/Users/fares/OneDrive/Desktop/Mémoire/densité/grille_densite_7_niveaux_2016.xlsx", skip = 4) 

df_pop16 <- df_pop16 %>%
  mutate(
    annee = 2016,
    INSEE_COM = str_pad(as.character(CODGEO), 5, pad = "0"),
    population = as.numeric(PMUN14),
    niveau_densite = as.numeric(DENS)
  ) %>%
  select(INSEE_COM, annee, population, niveau_densite)
#######################
df_pop17 <-read_excel("C:/Users/fares/OneDrive/Desktop/Mémoire/densité/grille_densite_7_niveaux_2017.xlsx", skip = 4) 

df_pop17 <- df_pop17 %>%
  mutate(
    annee = 2017,
    INSEE_COM = str_pad(as.character(CODGEO), 5, pad = "0"),
    population = as.numeric(PMUN15),
    niveau_densite = as.numeric(DENS)
  ) %>%
  select(INSEE_COM, annee, population, niveau_densite)
#########################
df_pop18 <-read_excel("C:/Users/fares/OneDrive/Desktop/Mémoire/densité/grille_densite_7_niveaux_2018.xlsx", skip = 4) 

df_pop18 <- df_pop18 %>%
  mutate(
    annee = 2018,
    INSEE_COM = str_pad(as.character(CODGEO), 5, pad = "0"),
    population = as.numeric(PMUN16),
    niveau_densite = as.numeric(DENS)
  ) %>%
  select(INSEE_COM, annee, population, niveau_densite)
#################################
df_pop19 <-read_excel("C:/Users/fares/OneDrive/Desktop/Mémoire/densité/grille_densite_7_niveaux_2019.xlsx", skip = 4) 

df_pop19 <- df_pop19 %>%
  mutate(
    annee = 2019,
    INSEE_COM = str_pad(as.character(CODGEO), 5, pad = "0"),
    population = as.numeric(PMUN17),
    niveau_densite = as.numeric(DENS)
  ) %>%
  select(INSEE_COM, annee, population, niveau_densite)
############################
df_pop20 <-read_excel("C:/Users/fares/OneDrive/Desktop/Mémoire/densité/grille_densite_7_niveaux_2020.xlsx", skip = 4) 

df_pop20 <- df_pop20 %>%
  mutate(
    annee = 2020,
    INSEE_COM = str_pad(as.character(CODGEO), 5, pad = "0"),
    population = as.numeric(PMUN17),
    niveau_densite = as.numeric(DENS)
  ) %>%
  select(INSEE_COM, annee, population, niveau_densite)
########################################
df_pop21 <-read_excel("C:/Users/fares/OneDrive/Desktop/Mémoire/densité/grille_densite_7_niveaux_2021.xlsx", skip = 4) 

df_pop21 <- df_pop21 %>%
  mutate(
    annee = 2021,
    INSEE_COM = str_pad(as.character(CODGEO), 5, pad = "0"),
    population = as.numeric(PMUN18),
    niveau_densite = as.numeric(DENS)
  ) %>%
  select(INSEE_COM, annee, population, niveau_densite)
##########################################
df_pop22 <-read_excel("C:/Users/fares/OneDrive/Desktop/Mémoire/densité/grille_densite_7_niveaux_2022.xlsx", skip = 4) 

df_pop22 <- df_pop22 %>%
  mutate(
    annee = 2022,
    INSEE_COM = str_pad(as.character(CODGEO), 5, pad = "0"),
    population = as.numeric(PMUN19),
    niveau_densite = as.numeric(DENS)
  ) %>%
  select(INSEE_COM, annee, population, niveau_densite)
##################################
df_pop23 <-read_excel("C:/Users/fares/OneDrive/Desktop/Mémoire/densité/grille_densite_7_niveaux_2023.xlsx", skip = 4) 

df_pop23 <- df_pop23 %>%
  mutate(
    annee = 2023,
    INSEE_COM = str_pad(as.character(CODGEO), 5, pad = "0"),
    population = as.numeric(PMUN20),
    niveau_densite = as.numeric(DENS)
  ) %>%
  select(INSEE_COM, annee, population, niveau_densite)
######################################
df_pop24 <-read_excel("C:/Users/fares/OneDrive/Desktop/Mémoire/densité/grille_densite_7_niveaux_2024.xlsx", skip = 4) 

df_pop24 <- df_pop24 %>%
  mutate(
    annee = 2024,
    INSEE_COM = str_pad(as.character(CODGEO), 5, pad = "0"),
    population = as.numeric(PMUN21),
    niveau_densite = as.numeric(DENS)
  ) %>%
  select(INSEE_COM, annee, population, niveau_densite)
########################
# Fusion verticale des tables population (elles ont toutes les colonnes INSEE_COM + annee + population + niveau_densite)
df_population_panel <- bind_rows(
  df_pop15, df_pop16, df_pop17, df_pop18, df_pop19,
  df_pop20, df_pop21, df_pop22, df_pop23, df_pop24
)
df_population_panel <- df_population_panel %>%
  arrange(INSEE_COM, annee)

write.csv(df_population_panel, "densité_population_2015_2024.csv", row.names = FALSE)

