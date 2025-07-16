# 📡 Fibre Optique et Développement Territorial : Impact Économique et Social

> Analyse économétrique des effets du déploiement de la fibre optique dans les communes rurales françaises  
> Mémoire de Master 2 - Economic Analysis | ESSEC Business School & CY Cergy Paris Université 

---

## 🎯 Objectif du projet

Ce dépôt contient l’ensemble des scripts, données, figures et analyses associés à mon mémoire de Master, qui étudie les effets du déploiement de la fibre optique sur plusieurs indicateurs locaux : revenu médian, création d'entreprises, chômage, densité, population et prix de l'immobilier.

L’approche repose sur une méthodologie économétrique en **données de panel long** avec une identification par **Diff-in-Diff**, à partir d’une variable de traitement `fibre_it` construite à la commune et à l’année.

---

## 🗂️ Arborescence des fichiers

### 📁 `data/`
Contient l’ensemble des données brutes nettoyées, organisées par thématique :
- `chomage/` : données DARES sur le taux de chômage communal
- `crea_entreprise/` : créations d’entreprises INSEE
- `densité/` : données de population et densité INSEE
- `fibre/` : fichiers ARCEP et variable `fibre_it` (version corrigée incluse)
- `immobilier/` : prix immobiliers par commune
- `revenu/` : revenu médian fiscal communal (INSEE)
- `panel final/` : jeu de données long final fusionné

### 📁 `script/`
Contient les scripts de traitement en **R** :
- `chomage.R`, `immobilier_2016_2023.R`, etc. : prétraitement par thème
- `final_panel/` : fusion des bases, gestion des lags, préparation du panel principal
- `test_verification/` : scripts de contrôle qualité

### 📁 `figures/`
Visualisations finales pour le rapport :
- Graphiques d'hétérogénéité (`hetero_*`)
- Graphiques placebo (`placebo_*`)
- Évolutions temporelles (`call_*`)

### 📁 `rapport/`
- `master_thesis_djamila_fares_fiber.pdf` : mémoire finalisé au format PDF

### 📁 `echantillon_2018_2021/`
Travail exploratoire réalisé sur un échantillon restreint avant le panel complet :
- Notebooks Jupyter (`.ipynb`)
- Premiers jeux de données intermédiaires
- Premières visualisations (PNG)

### 📄 Autres fichiers

- `.gitignore` : exclusion des fichiers géographiques lourds
- `Mémoire.Rproj` : projet RStudio complet
- `README_Fibre.md` : documentation spécifique à la variable `fibre_it`
- `README.md` : documentation générale (ce fichier)

---

## 📈 Méthodologie

L’analyse repose sur une approche **quasi-expérimentale** en **données de panel long (2016–2023)** à l’échelle communale.

### 🧩 Identification

- **Modèle utilisé** : Diff-in-Diff à traitement échelonné (*staggered adoption*)
- **Estimateur principal** : méthode de **Callaway & Sant’Anna (2021)**, via le package `did` sous R
  - Permet d’estimer des effets moyens de traitement spécifiques à chaque cohorte
  - Gère l’hétérogénéité temporelle et les biais d’agrégation des modèles DiD classiques

### 🛠 Données et traitement

- **Variable de traitement** : `fibre_it` (binaire)
- **Groupes de contrôle** : communes non fibrées ou fibrées tardivement
- **Variables analysées** :
  - Revenu médian fiscal
  - Taux de chômage
  - Création d’entreprises
  - Prix immobilier
  - Population et densité

### 🔁 Tests de robustesse

- Hétérogénéité des effets selon densité, revenu, ou statut urbain
- Tests placebo sur variables non impactées ou années précédant le traitement
- Traitements anticipés ou décalés dans le temps

---

## 💻 Logiciels utilisés

- **R** : pour le traitement des données, l’analyse économétrique et les graphiques
- **Excel** : pour les premières étapes de nettoyage manuel ou visualisation rapide
- **Jupyter Notebook** : pour l’exploration initiale (Python) et la construction de certains indicateurs

---

## 🧠 Variable `fibre_it`

- `fibre_it = 1` si la commune est couverte par la fibre l’année *t*, `0` sinon
- Données sources : fichiers ARCEP (2016–2024)
- Variante `fibre_it_corrigee` : si une commune est fibrée en 2018, elle est considérée fibrée dès 2016 (rétroactivation utile pour tests de robustesse)

---

## ⚠️ Données non incluses

Certains fichiers géographiques `.dbf`, `.shp`, `.shx` (>100 Mo) ne sont pas présents dans ce dépôt (limitations GitHub).  
Ils sont listés dans `.gitignore` et peuvent être fournis sur demande.

---

## 👩‍💻 Auteure

**Djamila Kamla Fares**  
Master 2 Economic Analysis — CY Cergy / ESSEC  
📧 faresdjamila@gmail.com  
📍 Île-de-France  

---

## 📌 Remarques finales

- Ce dépôt est conçu pour favoriser la transparence et la reproductibilité
- Il peut servir de base à d’autres recherches sur les politiques d’infrastructure numérique
- Toute suggestion, collaboration ou mise en relation avec des acteurs publics ou privés est bienvenue
