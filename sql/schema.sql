

-- ////////////// Tables de référence (sans FK) en premier //////////////////////////////

CREATE TABLE type_mobilier (
    id SERIAL PRIMARY KEY,
    type VARCHAR(100) NOT NULL
);

CREATE TABLE materiaux (
    id SERIAL PRIMARY KEY,
    materiaux VARCHAR(100) NOT NULL
);

CREATE TABLE etat (
    id SERIAL PRIMARY KEY,
    etat VARCHAR(100) NOT NULL
);

CREATE TABLE urgence (
    id SERIAL PRIMARY KEY,
    urgence VARCHAR(100) NOT NULL
);

CREATE TABLE statut (
    id SERIAL PRIMARY KEY,
    statut VARCHAR(100) NOT NULL
);

CREATE TABLE type_intervention (
    id SERIAL PRIMARY KEY,
    type VARCHAR(100) NOT NULL
);

CREATE TABLE technicien (
    id SERIAL PRIMARY KEY,
    nom VARCHAR(100) NOT NULL,
    prenom VARCHAR(100) NOT NULL
);

CREATE TABLE signale_par (
    id SERIAL PRIMARY KEY,
    nom VARCHAR(100),
    prenom VARCHAR(100)
);

CREATE TABLE entreprise (
    id SERIAL PRIMARY KEY,
    entreprise VARCHAR(150) NOT NULL,
    contact VARCHAR(100),
    telephone VARCHAR(20),
    email VARCHAR(150)
);

-- ////////////////////////// Tables avec FK /////////////////////////////////////////////////////////////////////

CREATE TABLE fournisseur (
    id SERIAL PRIMARY KEY,
    id_entreprise INT NOT NULL,
    remarques TEXT,
    FOREIGN KEY (id_entreprise) REFERENCES entreprise(id)
);

CREATE TABLE mobilier (
    id INT PRIMARY KEY,
    id_type_mobilier INT NOT NULL,
    id_materiaux INT,
    id_etat INT NOT NULL,
    id_fournisseur INT,
    date_installation DATE,
    remarques TEXT,
    localisation VARCHAR(200),
    FOREIGN KEY (id_type_mobilier) REFERENCES type_mobilier(id),
    FOREIGN KEY (id_materiaux) REFERENCES materiaux(id),
    FOREIGN KEY (id_etat) REFERENCES etat(id),
    FOREIGN KEY (id_fournisseur) REFERENCES fournisseur(id)
);

CREATE TABLE signalement (
    id SERIAL PRIMARY KEY,
    id_mobilier INT NOT NULL,
    id_signale_par INT,
    id_urgence INT NOT NULL,
    id_statut INT NOT NULL,
    date_signalement DATE,
    description TEXT,
    FOREIGN KEY (id_mobilier) REFERENCES mobilier(id),
    FOREIGN KEY (id_signale_par) REFERENCES signale_par(id),
    FOREIGN KEY (id_urgence) REFERENCES urgence(id),
    FOREIGN KEY (id_statut) REFERENCES statut(id)
);

CREATE TABLE intervention (
    id SERIAL PRIMARY KEY,
    id_mobilier INT NOT NULL,
    id_fournisseur INT,
    id_signalement INT,
    id_type_intervention INT NOT NULL,
    id_technicien INT NOT NULL,
    date_intervention DATE,
    duree VARCHAR(100),
    cout_materiel MONEY,
    remarques TEXT,
    FOREIGN KEY (id_mobilier) REFERENCES mobilier(id),
    FOREIGN KEY (id_fournisseur) REFERENCES fournisseur(id),
    FOREIGN KEY (id_signalement) REFERENCES signalement(id),
    FOREIGN KEY (id_type_intervention) REFERENCES type_intervention(id),
    FOREIGN KEY (id_technicien) REFERENCES technicien(id)
);

