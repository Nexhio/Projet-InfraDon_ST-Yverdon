# Contexte & périmètre

## Contexte
Le Service technique communal d'Yverdon-les-Bains gère depuis 2018 son mobilier urbain dans des fichiers Excel : bancs, lampadaires, fontaines, poubelles et bornes de recharge électrique répartis sur le territoire communal. Ces fichiers constituent la source opérationnelle de signalements incidents, d'interventions de maintenance et de contacts fournisseurs. L'objectif du projet est de transformer cette collection de fichiers en une infrastructure de données relationnelle, fiable et exploitable.

## Sources de données
Quatre fichiers Excel ont été fournis par l'enseignante, représentant ~500 lignes au total :

- **INVENTAIRE_MOBILIER** — ~120 objets avec positions GPS
- **SIGNALEMENTS** — ~200 signalements (population + patrouilles), dates, urgence, statut
- **INTERVENTIONS** — ~150 interventions, techniciens, durées, coûts
- **FOURNISSEURS_CONTACTS** — ~15 fournisseurs régionaux

Les données sont fictives mais volontairement imparfaites, à l'image de vrais fichiers saisis à la main.

## Contraintes identifiées
Les fichiers présentent des problèmes structurels typiques d'une saisie humaine sans contraintes sur de longues périodes :
- **Formats de dates hétérogènes** : 12.03.2022, 2022-03-12, mars 2022, 2022
- **Identifiants incohérents** : B-001 (avant 2020), B_1 (2021), 1001 (2022+)
- **Noms de techniciens saisis librement** : Jean-Marc, JM, Jean-Marc Bonvin
- **Coûts et durées non structurés** : CHF 120.-, 120, gratuit, (vide) / 1h30, une matinée
- **Coordonnées GPS** : ~8% de valeurs NULL, précision insuffisante (2 décimales)
- **Doublons partiels** : entre fichiers, liens inter-tables exprimés en texte libre

Ces contraintes rendent impossible un import direct en base relationnelle : elles nécessitent une couche de staging et un nettoyage explicite avant toute exploitation.

## Périmètre
Périmètre
Le projet se limite au territoire communal d'Yverdon-les-Bains et aux données produites par le Service technique depuis 2018. Les quatre fichiers fournis constituent l'unique source de données — aucune donnée externe, temps réel ou API n'est intégrée.
L'angle d'analyse retenu est le brief C — Remplacement des lampadaires : pour chaque lampadaire de l'inventaire, produire une fiche de priorité calculée à partir du nombre de pannes, de l'âge et du coût des interventions, puis sélectionner les candidats au remplacement dans une enveloppe budgétaire de CHF 50'000.-.
Cela implique concrètement que :

- les requêtes métier ciblent en priorité les objets de type lampadaire dans INVENTAIRE_MOBILIER
- les jointures entre INVENTAIRE_MOBILIER, SIGNALEMENTS et INTERVENTIONS sont au cœur du modèle
- FOURNISSEURS_CONTACTS est en scope mais secondaire (fournisseurs de lampadaires)
- les autres types de mobilier (bancs, fontaines, poubelles, bornes EV) sont hors périmètre d'analyse, même s'ils sont présents dans les tables