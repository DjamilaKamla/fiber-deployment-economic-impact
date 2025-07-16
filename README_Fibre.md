## 📦 fibre

### Données disponibles dans`data/` — :
- fibre_it_YYYY.csv : fichiers annuels de couverture fibre par commune (ARCEP)
- panel_fibre_it_2018_2024.csv : panel consolidé avec variable binaire fibre_it
- panel_fibre_it_corrigee_2016_2024.csv : version ajustée avec anticipation de la couverture fibre dès 2016

### Scripts disponibles dans`script/` — :
- Fibre_it.ipynb : script principal de construction de la variable fibre_it binaire à partir des données annuelles
- fibre_it_corrigee.ipynb : même logique que Fibre_it.ipynb, mais avec correction :
si une commune est fibrée en 2018, elle est considérée comme l'étant aussi en 2017 et 2016 (anticipation de la date de fibrage pour analyse plus large)

---

## 🧠 Variable `fibre_it`

- Variable binaire : fibre_it = 1 si la commune est couverte par la fibre l’année t, 0 sinon.
- Calculée à partir des fichiers publiés par l’ARCEP.
- Sert de variable de traitement dans le cadre d’une approche économétrique de type Diff-in-Diff.

---

## ⚠️ Fichiers lourds exclus dans `data/` — 

Certains fichiers géographiques `.dbf` dépassant 100 Mo ont été exclus du dépôt GitHub pour respecter les limitations de taille. Ils sont conservés localement et peuvent être partagés via un lien externe.

---

## 📌 Remarques

- Les fichiers `.shp` et associés sont nécessaires uniquement pour la cartographie.
- Les fichiers présents dans ce dossier sont suffisants pour produire la variable de traitement utilisée dans l’analyse principale.

