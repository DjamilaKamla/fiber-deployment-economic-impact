# Charger et typer ton panel complet
panel <- read_csv("C:/Users/fares/OneDrive/Desktop/Mémoire/panel final/panel_final_2016_2024.csv") %>%
  mutate(
    INSEE_COM        = as.character(INSEE_COM),
    annee            = as.integer(annee),
    niveau_densite   = as.integer(niveau_densite),
    Fibre_it         = as.integer(Fibre_it),
    population       = as.numeric(population),
    nb_chomeurs      = as.numeric(nb_chomeurs),
    nb_creations     = as.numeric(nb_creations),
    Prixm2Moyen      = as.numeric(Prixm2Moyen),
    med_nivvie       = as.numeric(med_nivvie),
    log_taux_chomage = as.numeric(log_taux_chomage),
    log_taux_creation= as.numeric(log_taux_creation))


# Extraire le sous-panel rural (niveaux 5,6,7)
panel_rural <- panel %>%
  filter(niveau_densite %in% 5:7)

# Vérification rapide
panel_rural %>% 
  count(niveau_densite) 

write.csv(panel_rural, "panel_final_rural_2016_2024.csv", row.names = FALSE)
