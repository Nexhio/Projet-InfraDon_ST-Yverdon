# Question 1 – Documenter le pipeline ELT déjà en place
Notre pipeline suit le pattern **ELT (Extract → Load → Transform)** en trois couches :

|**Étape**|**Ce qui se passe**|**Exemples dans le projet**|
|---|---|---|
|**Extract**|Lecture des sources brutes|`inventaire_mobilier.xlsx`, `incidents.xlsx`, `interventions.xlsx`, `fournisseurs.xlsx`|
|**Load**|Import brut dans le schéma `staging`|Tables `staging.inventaire`, `staging.incidents`, `staging.interventions`, `staging.fournisseurs` — tout en `TEXT`, sans contraintes|
|**Transform**|Nettoyage SQL dans la base, puis insertion dans les tables finales|`INSERT INTO mobilier SELECT ... FROM staging.inventaire` avec transformations|

C'est bien de l'ELT et non de l'ETL, car la transformation se fait à l'intérieur de PostgreSQL (avec du SQL), et non dans un outil externe. Les données brutes restent disponibles dans le schéma `staging`.

# Question 2 — Identifier les transformations réalisées à chaque étape
Voici les transformations appliquées lors du passage `staging → tables finales` :

## Normalisation des chaînes de caractères
- `LOWER(TRIM(type))` pour supprimer les espaces et uniformiser la casse (`"Banc Public"` → `"banc"`)
- `CASE WHEN` pour mapper les variantes vers des valeurs canoniques (`"banc public"` → `"banc"`)

## Conversion des dates (4 formats dans les sources)
- `CASE WHEN date LIKE '%.%.%' THEN TO_DATE(date, 'DD.MM.YYYY')` pour le format suisse
- `CASE WHEN date LIKE '____-__-__' THEN TO_DATE(date, 'YYYY-MM-DD')` pour le format ISO
- Et les deux autres formats (mois en français, etc.)

## Nettoyage des valeurs vides / nulles
- `NULLIF(TRIM(col), '')` → transforme les chaînes vides en `NULL`
- `COALESCE(statut, 'en_attente')` → valeur par défaut si `NULL`

## Conversion des types numériques
- `REGEXP_REPLACE(cout, '[^0-9]', '', 'g')::INT` pour extraire le nombre depuis `"CHF 120.-"`
- `NULLIF(latitude,'')::NUMERIC(9,6)` pour les coordonnées GPS

## Résolution des entités liées (FK)
- Les variantes de noms de techniciens (`"JM"`, `"Jean-Marc"`, `"Jean-Marc Bonvin"`) sont résolues via une table de correspondance → `technicien_id`

## Idempotence
- `ON CONFLICT (id) DO NOTHING` sur les `INSERT INTO ... SELECT`, ce qui permet de relancer le pipeline sans créer de doublons

# En résumé
La première étape **Load** ne fait aucune transformation, tout arrive en format `TEXT`, et à l'étape suivante **Transform** le nettoyage SQL se fait avant que les données soient intégrées aux tables de production, avec leurs types, leur **PK**, les **FK** et les contraites `CHECK`
