library(dplyr)

##### Etendre Fibre_it
# Supposons que panel_fibre_it_corrige contient INSEE_COM, annee, Fibre_it pour 2018–2024
pf <- panel_fibre_it_corrige_2018_2024

# 1. Extraire la valeur de Fibre_it en 2018 pour chaque commune
fib18 <- pf %>% 
  filter(annee == 2018) %>% 
  select(INSEE_COM, Fibre2018 = Fibre_it)

# 2. Construire la grille complète 2016–2024
communes <- unique(pf$INSEE_COM)
annees   <- 2016:2024
full_grid <- tidyr::expand_grid(INSEE_COM = communes, annee = annees)

# 3. Joindre le panel observé et la Fibre2018
panel_full <- full_grid %>%
  left_join(pf,    by = c("INSEE_COM","annee")) %>%   # rameuter 2018–2024
  left_join(fib18, by = "INSEE_COM")                  # ramener Fibre2018

# 4. Remplir 2016–2017 avec la valeur de 2018, sans toucher aux années >2018
panel_full <- panel_full %>%
  mutate(
    Fibre_it = case_when(
      annee < 2018 ~ Fibre2018,  # applique le même flag qu’en 2018
      TRUE         ~ Fibre_it    # sinon conserve la valeur observée
    )
  ) %>%
  select(-Fibre2018)             # on n’a plus besoin de ce drapeau intermédiaire

# 5. Vérification (prendre un exemple de commune)
panel_full %>%
  filter(INSEE_COM=="01001") %>%
  arrange(annee) %>%
  print(n=10)

########## immo
immobilier_2016_2023 <- immobilier_2016_2023 %>%
  rename(annee = Annee)

######### panel final

panel_final <- panel_full %>%
  left_join(densité_population_2015_2024,           by = c("INSEE_COM", "annee")) %>%
  left_join(chomage_2015_2024,                      by = c("INSEE_COM", "annee")) %>%
  left_join(creations_entreprises_2012_2023,        by = c("INSEE_COM", "annee")) %>%
  left_join(immobilier_2016_2023,                   by = c("INSEE_COM", "annee")) %>%
  left_join(revenu_2015_2021,                       by = c("INSEE_COM", "annee"))

panel_final <- panel_final %>%
  mutate(
    base_pop = ifelse(!is.na(nb_personnes), nb_personnes, population),
    
    taux_chomage = nb_chomeurs / base_pop,
    taux_creation = nb_creations / population,  # ici on garde population car nb_personnes ne concerne pas les créations
    
    log_taux_chomage = log1p(taux_chomage),
    log_taux_creation = log1p(taux_creation)
  )

write.csv(panel_final, "panel_final_2016_2024.csv", row.names = FALSE)

