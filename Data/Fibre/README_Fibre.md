# 📁 Dossier `data/fibre/`

Ce dossier contient les données relatives à l’installation progressive de la fibre optique en France (2018–2024), issues de l’ARCEP.

---

## 📦 Contenu du dossier

### `raw/` — Données brutes :
- `fibre_it_YYYY.csv` : fichiers annuels contenant la couverture fibre par commune
- `panel_fibre_it_2018_2024.csv` : panel consolidé avec variable `fibre_it` binaire

### `notebook/` — Script de traitement :
- `Fibre_it.ipynb` : script Jupyter de construction de la variable `fibre_it`

---

## 🧠 Variable `fibre_it`

- Variable binaire : `fibre_it = 1` si la commune est couverte par la fibre l’année *t*, `0` sinon.
- Calculée à partir des fichiers ARCEP annuels.
- Sert de variable de traitement pour l’approche Diff-in-Diff.

---

## ⚠️ Fichiers lourds exclus

Certains fichiers géographiques `.dbf` dépassant 100 Mo ont été exclus du dépôt GitHub pour respecter les limitations de taille. Ils sont conservés localement et peuvent être partagés via un lien externe.

---

## 📌 Remarques

- Les fichiers `.shp` et associés sont nécessaires uniquement pour la cartographie.
- Les fichiers présents dans ce dossier sont suffisants pour produire la variable de traitement utilisée dans l’analyse principale.

