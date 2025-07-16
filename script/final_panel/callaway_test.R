library(readr)
library(dplyr)
library(recipes)
library(did)
library(ggplot2)
library(tibble)
library(stats)

# 1. Charger et typer le panel rural
panel_rural <- read_csv(
  "C:/Users/fares/OneDrive/Desktop/Mémoire/panel_final_rural_2016_2024.csv",
  col_types = cols(
    INSEE_COM         = col_character(),
    annee             = col_integer(),
    Fibre_it          = col_integer(),
    population        = col_double(),
    niveau_densite    = col_integer(),
    nb_chomeurs       = col_double(),
    nb_creations      = col_double(),
    PrixMoyen         = col_double(),
    Prixm2Moyen       = col_double(),
    med_nivvie        = col_double(),
    log_taux_chomage  = col_double(),
    log_taux_creation = col_double()
  )
)

# 2. Construire gname = année de premier fibrage (vraie date, ≥2018)
panel_rural <- panel_rural %>%
  group_by(INSEE_COM) %>%
  mutate(
    gname = ifelse(
      any(Fibre_it == 1 & annee >= 2018, na.rm = TRUE),
      min(annee[Fibre_it == 1 & annee >= 2018], na.rm = TRUE),
      0L
    )
  ) %>%
  ungroup()

# 3. Déterminer la dernière cohorte utile (ici exclure 2024)
dernier_g  <- max(panel_rural$gname, na.rm = TRUE)
max_cohorte <- dernier_g - 1  # si dernier_g = 2024, max_cohorte = 2023

# 4. Filtrer le panel : conserver gname = 0 (jamais traités) et 2018–2023
panel_for_did <- panel_rural %>%
  filter(gname == 0 | (gname >= 2018 & gname <= max_cohorte))

# 5. Vérifier les cohortes retenues
print(table(panel_for_did$gname))

# 1. Générer un identifiant numérique pour chaque commune
panel_for_did <- panel_for_did %>%
  mutate(
    com_id = as.integer(factor(INSEE_COM))  # transforme INSEE_COM en 1,2,3…
  )

# 2. Vérifier
head(panel_for_did %>% select(INSEE_COM, com_id))


att_revenu   <- att_gt(
  yname   = "med_nivvie",
  gname   = "gname",
  idname  = "com_id",    # <- ici
  tname   = "annee",
  xformla = ~1,
  data    = panel_for_did,
  panel   = TRUE
)

att_chomage  <- att_gt(
  yname   = "log_taux_chomage",
  gname   = "gname",
  idname  = "com_id",
  tname   = "annee",
  xformla = ~1,
  data    = panel_for_did,
  panel   = TRUE
)

att_creation <- att_gt(
  yname   = "log_taux_creation",
  gname   = "gname",
  idname  = "com_id",
  tname   = "annee",
  xformla = ~1,
  data    = panel_for_did,
  panel   = TRUE
)

att_immo     <- att_gt(
  yname   = "Prixm2Moyen",
  gname   = "gname",
  idname  = "com_id",
  tname   = "annee",
  xformla = ~1,
  data    = panel_for_did,
  panel   = TRUE
)
att_population   <- att_gt(
  yname   = "population",
  gname   = "gname",
  idname  = "com_id",    # <- ici
  tname   = "annee",
  xformla = ~1,
  data    = panel_for_did,
  panel   = TRUE
)

# 4. Agréger et tracer
agg_revenu   <- aggte(att_revenu,   type = "dynamic")
agg_chomage  <- aggte(att_chomage,  type = "dynamic")
agg_creation <- aggte(att_creation, type = "dynamic")
agg_immo     <- aggte(att_immo,     type = "dynamic")
agg_population   <- aggte(att_population,   type = "dynamic")

ggdid(agg_revenu)   + ggtitle("Rural – Revenu médian")
ggdid(agg_chomage)  + ggtitle("Rural – Log‐taux de chômage")
ggdid(agg_creation) + ggtitle("Rural – Log‐taux de création")
ggdid(agg_immo)     + ggtitle("Rural – Prix immobilier (€/m²)")
ggdid(agg_population)   + ggtitle("Rural – Population")

##############################
######### TB ###############
#########################"

# Fonction générique pour extraire résumé depuis un objet aggte()
summarize_agg <- function(agg_obj) {
  tibble(
    event_time = agg_obj$egt,
    att        = agg_obj$att.egt,
    se         = agg_obj$se.egt
  ) %>%
    mutate(
      z_value = att / se,
      p_value = 2 * (1 - pnorm(abs(z_value)))
    )
}

# Construire les tableaux pour chaque variable
sum_revenu    <- summarize_agg(agg_revenu)    %>% mutate(variable = "Revenu médian")
sum_chomage   <- summarize_agg(agg_chomage)   %>% mutate(variable = "Log taux de chômage")
sum_creation  <- summarize_agg(agg_creation)  %>% mutate(variable = "Log taux de création")
sum_immo      <- summarize_agg(agg_immo)      %>% mutate(variable = "Prix immobilier")
sum_population<- summarize_agg(agg_population)%>% mutate(variable = "Population")

# Arrondir pour la présentation
tableau_revenu <- sum_revenu %>%
  mutate_at(vars(att, se, z_value, p_value), ~ round(., digits = 4))
tableau_chomage <- sum_chomage %>%
  mutate_at(vars(att, se, z_value, p_value), ~ round(., digits = 4))
tableau_creation <- sum_creation %>%
  mutate_at(vars(att, se, z_value, p_value), ~ round(., digits = 4))
tableau_immo <- sum_immo %>%
  mutate_at(vars(att, se, z_value, p_value), ~ round(., digits = 4))
tableau_population <- sum_population %>%
  mutate_at(vars(att, se, z_value, p_value), ~ round(., digits = 4))

write.csv(panel_for_did, "panel_final_did_2016_2024.csv", row.names = FALSE)

