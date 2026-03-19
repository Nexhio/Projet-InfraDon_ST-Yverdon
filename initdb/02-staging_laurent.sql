--------------------------------------------------------------------------------
--  Étape 2 - Créer initdb/02-staging.sql
--------------------------------------------------------------------------------
CREATE SCHEMA IF NOT EXISTS staging;

CREATE TABLE staging.inventaire_mobilier (
    id TEXT, type TEXT, materiau TEXT, lieu TEXT,
    latitude TEXT, longitude TEXT,
    date_installation TEXT, etat TEXT, remarques TEXT
);

CREATE TABLE staging.signalements (
    date TEXT, signale_par TEXT, objet TEXT,
    description TEXT, urgence TEXT, statut TEXT
);

CREATE TABLE staging.interventions (
    date TEXT, objet TEXT, type_intervention TEXT,
    technicien TEXT, duree TEXT, cout_materiel TEXT, remarques TEXT
);

CREATE TABLE staging.fournisseurs_contacts (
    entreprise TEXT, contact TEXT, telephone TEXT,
    email TEXT, type_materiel TEXT, remarques TEXT
);


COPY staging.inventaire_mobilier
FROM '/data/inventaire_mobilier.csv'
WITH (FORMAT csv, HEADER true, DELIMITER ';', ENCODING 'UTF8');

COPY staging.interventions
FROM '/data/interventions.csv'
WITH (FORMAT csv, HEADER true, DELIMITER ';', ENCODING 'UTF8');

COPY staging.signalements
FROM '/data/signalements.csv'
WITH (FORMAT csv, HEADER true, DELIMITER ';', ENCODING 'UTF8');

COPY staging.fournisseurs_contacts
FROM '/data/fournisseurs_contacts.csv'
WITH (FORMAT csv, HEADER true, DELIMITER ';', ENCODING 'UTF8');



SELECT COUNT(*) FROM staging.inventaire_mobilier;  -- ~120
SELECT COUNT(*) FROM staging.signalements;         -- ~200
SELECT COUNT(*) FROM staging.interventions;        -- ~150
SELECT COUNT(*) FROM staging.fournisseurs_contacts;         -- ~15

--------------------------------------------------------------------------------
-- Étape 2 - Créer initdb/02-staging.sql## Étape 3 - Explorer les données brutes
-- Types de mobilier
SELECT type, COUNT(*) FROM staging.inventaire_mobilier GROUP BY type ORDER BY 2 DESC;
--------------------------------------------------------------------------------
-- Matériaux
SELECT materiau, COUNT(*) FROM staging.inventaire_mobilier GROUP BY materiau;

-- Formats de date
SELECT date_installation, COUNT(*)
FROM staging.inventaire_mobilier
GROUP BY date_installation ORDER BY 2 DESC LIMIT 20;

-- Coûts
SELECT cout_materiel, COUNT(*) FROM staging.interventions GROUP BY cout_materiel ORDER BY 2 DESC;

-- Durées
SELECT duree, COUNT(*) FROM staging.interventions GROUP BY duree;

-- Techniciens
SELECT technicien, COUNT(*) FROM staging.interventions GROUP BY technicien ORDER BY 2 DESC;

-- Doublons potentiels (même lieu + type)
SELECT lieu, type, COUNT(*) FROM staging.inventaire_mobilier
GROUP BY lieu, type HAVING COUNT(*) > 1;

--------------------------------------------------------------------------------
-- Étape 4 - Nettoyage SQL : les patterns à appliquer
--------------------------------------------------------------------------------


SELECT (
    CASE (technicien)
        WHEN 'JM' THEN 'Jean-Marc Bonvin'
        WHEN 'Jean-Marc' THEN 'Jean-Marc Bonvin'
        WHEN 'P. Alves' THEN 'Pedro Alves'
        WHEN 'Pedro' THEN 'Pedro Alves'
        WHEN 'Alves Pedro' THEN 'Pedro Alves'
        WHEN 'Koffi Marc' THEN 'Marc Koffi'
        WHEN 'stagiaire' THEN 'Stagiaire'
        ELSE technicien 
    END
)
AS technicien_trié, technicien
FROM interventions;
