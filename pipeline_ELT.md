# Documenter le pipeline ELT déjà en place (sources Excel, tables staging, tables finales) ?
Notre pipeline suit le pattern ELT (Extract → Load → Transform) en trois couches :

|Étape|Ce qui se passe|Exemples dans le projet|
|---|---|---|
|Extract|Lecture des sources brutes|inventaire_mobilier.xlsx, incidents.xlsx, interventions.xlsx, fournisseurs.xlsx|
|Load|Import brut dans le schéma `staging`|Tables staging.inventaire, staging.incidents, staging.interventions, staging.fournisseurs — tout en TEXT, sans contraintes|
|Transform|Nettoyage SQL dans la base, puis insertion dans les tables finales|INSERT INTO mobilier SELECT ... FROM staging.inventaire avec transformations|

C'est bien de l'ELT et non de l'ETL, car la transformation se fait à l'intérieur de PostgreSQL (avec du SQL), et non dans un outil externe. Les données brutes restent disponibles dans le schéma `staging`.
