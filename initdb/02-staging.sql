
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