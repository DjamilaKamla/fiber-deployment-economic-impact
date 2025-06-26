library(readxl)
library(dplyr)
library(stringr)

# 1. Charger le fichier Excel
df_chomage <- read_excel("C:/Users/fares/OneDrive/Desktop/Mémoire/chomage/dares_defm_communales-brutes.xlsx")

# 2. Garder seulement les totaux (sexe + tranche d'âge)
df_chomage_clean <- df_chomage %>%
  filter(Sexe == "Total", `Tranche d'âge` == "Total")

# 3. Extraire l’année depuis la variable "Date" (ex: "2016-T4" → 2016)
df_chomage_clean <- df_chomage_clean %>%
  mutate(annee = as.integer(str_sub(Date, 1, 4)))

# 4. Créer la variable INSEE_COM (code commune à 5 chiffres, format texte)
df_chomage_clean <- df_chomage_clean %>%
  mutate(INSEE_COM = str_pad(`Code commune`, width = 5, side = "left", pad = "0"))

# Supprimer les lignes parasites "Total"
df_chomage_clean <- df_chomage_clean %>%
  filter(INSEE_COM != "Total")
# 4. Créer la variable INSEE_COM (code commune à 5 chiffres, format texte)
df_chomage_clean <- df_chomage_clean %>%
  mutate(INSEE_COM = str_pad(`Code commune`, width = 5, side = "left", pad = "0")) %>%
  filter(INSEE_COM != "Total")

# 5. Garder les colonnes utiles uniquement
df_chomage_final <- df_chomage_clean %>%
  select(INSEE_COM, annee, `Nombre de demandeurs d'emploi`) %>%
  rename(nb_chomeurs = `Nombre de demandeurs d'emploi`)

# (Optionnel) Vérifier les doublons
duplicates <- df_chomage_final %>%
  count(INSEE_COM, annee) %>%
  filter(n > 1)

df_chomage_final <- df_chomage_final %>%
  arrange(INSEE_COM, annee)

# 6. Sauvegarder le fichier nettoyé
write.csv(df_chomage_final, "chomage_2015_2024.csv", row.names = FALSE)
