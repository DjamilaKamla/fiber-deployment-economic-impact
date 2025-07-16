###############################
########## PLacebo test ##########
##############################

panel_placebo <- panel_for_did %>%
  mutate(
    # 0 = jamais fibrée (vrai contrôle), 
    # 2021 = traitement fictif pour les autres
    g_placebo = if_else(gname == 0, 0L, 2021L),
    com_id     = as.integer(factor(INSEE_COM))
  )
library(glue)  # pour glue::glue()

outcomes <- c(
  "med_nivvie",
  "log_taux_chomage",
  "log_taux_creation",
  "Prixm2Moyen",
  "population"
)

run_placebo <- function(y) {
  att <- att_gt(
    yname   = y,
    gname   = "g_placebo",
    idname  = "com_id",
    tname   = "annee",
    xformla = ~1,
    data    = panel_placebo,
    panel   = TRUE
  )
  agg <- aggte(att, type = "dynamic", min_e = -3, max_e = +3, na.rm = TRUE)
  ggdid(agg) +
    ggtitle(glue("Placebo – {y} (faux fibrage 2021)")) +
    xlab("τ (années depuis fibrage fictif)") +
    ylab("ATT moyen")
}

# Exécution
placebo_results <- lapply(outcomes, run_placebo)

print (placebo_results)
