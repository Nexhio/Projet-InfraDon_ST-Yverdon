```mermaid
classDiagram

class PK ID {
    UNIQUE ; NOT NULL
}

class MOBILIER {
    int id PK
    int id_type_mobilier FK
    int id_materiaux FK
    int id_etat FK
    int id_fournisseur FK
    date date_installation
    string remarques
    string localisation
}

MOBILIER -- TYPE_MOBILIER
MOBILIER -- MATERIAUX
MOBILIER -- ETAT
MOBILIER -- FOURNISSEUR

class TYPE_MOBILIER {
     int id PK
     string type
}

class MATERIAUX {
     int id PK
     string materiaux
}

class ETAT {
    int id PK
    string etat
}

class SIGNALEMENT {
    int id PK
    int id_mobilier FK
    int id_signale_par FK
    int id_urgence FK
    int id_statut FK
    date date_signalement
    string description
}

SIGNALEMENT -- MOBILIER
SIGNALEMENT -- SIGNALE_PAR
SIGNALEMENT -- URGENCE
SIGNALEMENT -- STATUT

class SIGNALE_PAR {
    int id PK
    string nom
    string prenom
}

class URGENCE {
    int id PK
    string urgence
}

class STATUT {
    int id PK
    string statut
}

class INTERVENTION {
    int id PK
    int id_mobilier FK
    int id_fournisseur FK
    int id_signalement FK
    int id_type_intervention FK
    int id_technicien FK
    date date_intervention
    string duree
    decimal cout_materiel
    string remarques
}

INTERVENTION -- MOBILIER
INTERVENTION -- FOURNISSEUR
INTERVENTION -- SIGNALEMENT
INTERVENTION -- TYPE_INTERVENTION
INTERVENTION -- TECHNICIEN

class TYPE_INTERVENTION {
    int id PK
    string type
}

class TECHNICIEN {
    int id PK
    string nom
    string prenom
}

class FOURNISSEUR {
    int id PK
    int id_entreprise FK
    string remarques
}

FOURNISSEUR -- ENTREPRISE

class ENTREPRISE {
    int id PK
    string entreprise
    string contact
    string telephone
    string email
}
