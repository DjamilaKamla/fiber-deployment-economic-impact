library(readr)
library(dplyr)
library(purrr)
library(did)
library(ggplot2)
library(glue)

# 0) Définir vos variables d’intérêt
outcomes   <- c("med_nivvie", "log_taux_chomage", "log_taux_creation", "Prixm2Moyen", "population")
densities  <- sort(unique(panel_for_did$niveau_densite))  # devrait être 5,6,7

# 1) Fonction « hetero » qui retourne att, agg et plot pour une variable y et une densité d
run_het <- function(y, d) {
  sub <- panel_for_did %>% filter(niveau_densite == d)
  att_sub <- att_gt(
    yname   = y,
    gname   = "gname",
    idname  = "com_id",
    tname   = "annee",
    xformla = ~1,
    data    = sub,
    panel   = TRUE
  )
  agg_sub <- aggte(att_sub, type="dynamic", min_e=-6, max_e=6, na.rm=TRUE)
  p <- ggdid(agg_sub) +
    ggtitle(glue("{y} – densité {d}")) +
    xlab("Années depuis fibrage (τ)") + ylab("ATT moyen") +
    theme_minimal() +
    theme(legend.position="none")
  list(var    = y,
       densite= d,
       att    = att_sub,
       agg    = agg_sub,
       plot   = p)
}

# 2) Lancer pour chaque combinaison variable × densité
results_het <- cross2(outcomes, densities) %>% 
  map(~ run_het(.x[[1]], .x[[2]]))

# 3) Construire un grand tableau résumé
summary_tables <- map_dfr(
  results_het,
  ~ tibble(
    variable   = .x$var,
    densite    = .x$densite,
    event_time = .x$agg$egt,
    att        = .x$agg$att.egt,
    se         = .x$agg$se.egt
  ),
  .id = "grp"
) %>%
  mutate(
    z_value = att / se,
    p_value = 2*(1 - pnorm(abs(z_value))),
    signif  = case_when(
      p_value < 0.01 ~ "***",
      p_value < 0.05 ~ "**",
      p_value < 0.1  ~ "*",
      TRUE           ~ ""
    ),
    ci_low  = att - 1.96 * se,
    ci_high = att + 1.96 * se,
    densite = factor(densite)
  )

# 4) Pour chaque variable, tracer la comparaison 5 vs 6 vs 7
plots_by_var <- summary_tables %>%
  group_split(variable) %>%
  map(~ {
    df <- .
    ggplot(df, aes(x=event_time, y=att, color=densite, fill=densite)) +
      geom_ribbon(aes(ymin=ci_low, ymax=ci_high), alpha=0.2, color=NA) +
      geom_line(size=1) +
      geom_point(aes(shape=signif!=""), size=2) +
      scale_shape_manual(values = c(`TRUE`=16, `FALSE`=1), guide="none") +
      geom_vline(xintercept=-1, linetype="dashed") +
      labs(
        title    = glue("Hétérogénéité de l’effet fibre : {df$variable[1]}"),
        subtitle = "ATT moyen ± IC 95 % (points pleins si p<0.05)",
        x        = "Années depuis fibrage (τ)",
        y        = "ATT moyen",
        color    = "Densité",
        fill     = "Densité"
      ) +
      theme_minimal(base_size=13) +
      theme(legend.position="bottom")
  })

# 5) Afficher ou sauvegarder
# Pour afficher :
walk(plots_by_var, print)

# Pour accéder au tableau global :
print(summary_tables)

# (Optionnel) pour sauver tous les plots dans des fichiers PDF :
# walk2(plots_by_var, outcomes,
#       ~ ggsave(filename = glue("het_{.y}.pdf"), plot = .x, width=7, height=5))

