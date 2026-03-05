```mermaid
classDiagram

class MOBILIER {
    MOBILIER : int id PK
    MOBILIER : int id_type_mobilier FK
    MOBILIER : int id_materiaux FK
    MOBILIER : int id_etat_actuel FK
    MOBILIER : int id_fournisseur FK
    MOBILIER : date date_installation
    MOBILIER : string remarques
    MOBILIER : string localisation
}

MOBILIER -- TYPE_MOBILIER
MOBILIER -- MATERIAUX
MOBILIER -- ETAT_ACTUEL
MOBILIER -- FOURNISSEUR

class TYPE_MOBILIER {
    TYPE_MOBILIER : int id PK
    TYPE_MOBILIER : string type
}

class MATERIAUX {
    MATERIAUX : int id PK
    MATERIAUX : string materiaux
}

class ETAT_ACTUEL {
        ETAT_ACTUEL : int id PK
        ETAT_ACTUEL : string etat
}

class SIGNALEMENT {
    SIGNALEMENT : int id PK
    SIGNALEMENT : int id_mobilier FK
    SIGNALEMENT : int id_signale_par FK
    SIGNALEMENT : int id_urgence FK
    SIGNALEMENT : int id_statut FK
    SIGNALEMENT : date date_signalement
    SIGNALEMENT : string description
}
SIGNALEMENT -- MOBILIER
SIGNALEMENT -- SIGNALE_PAR
SIGNALEMENT -- URGENCE
SIGNALEMENT -- STATUT

class SIGNALE_PAR {
    SIGNALE_PAR : int id PK
    SIGNALE_PAR : string nom
    SIGNALE_PAR : string prenom
}

class URGENCE {
    URGENCE : int id PK
    URGENCE : string urgence
}

class STATUT {
    STATUT : int id PK
    STATUT : string statut
}

class INTERVENTION {
    INTERVENTION : int id PK
    INTERVENTION : int id_mobilier FK
    INTERVENTION : int id_fournisseur FK
    INTERVENTION : int id_signalement FK
    INTERVENTION : int id_type_intervention FK
    INTERVENTION : int id_technicien FK
    INTERVENTION : date date_intervention
    INTERVENTION : string duree
    INTERVENTION : decimal cout_materiel
    INTERVENTION : string remarques
}

INTERVENTION -- MOBILIER
INTERVENTION -- FOURNISSEUR
INTERVENTION -- SIGNALEMENT
INTERVENTION -- TYPE_INTERVENTION
INTERVENTION -- TECHNICIEN

class TYPE_INTERVENTION {
    TYPE_INTERVENTION : int id PK
    TYPE_INTERVENTION : string type
}

class TECHNICIEN {
    TECHNICIEN : int id PK
    TECHNICIEN : string nom
    TECHNICIEN : string prenom
}

class FOURNISSEUR {
    FOURNISSEUR : int id PK
    FOURNISSEUR : int id_entreprise FK
    FOURNISSEUR : int id_materiaux FK
    FOURNISSEUR : string remarques
}

FOURNISSEUR -- ENTREPRISE
FOURNISSEUR -- MATERIAUX

class ENTREPRISE {
    ENTREPRISE : int id PK
    ENTREPRISE : string entreprise
    ENTREPRISE : string contact
    ENTREPRISE : string telephone
    ENTREPRISE : string email
}
