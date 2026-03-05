```mermaid
erDiagram

MOBILIER {
    int id PK
    int id_type_mobilier FK
    int id_materiaux FK
    int id_etat_actuel FK
    int id_fournisseur FK
    date date_installation
    string remarques
    string localisation
}

TYPE_MOBILIER {
    int id PK
    string type
}

MATERIAUX {
    int id PK
    string materiaux
}

ETAT_ACTUEL {
        int id PK
        string etat
}

SIGNALEMENT {
    int id PK
    int id_mobilier FK
    int id_signale_par FK
    int id_urgence FK
    int id_statut FK
    date date_signalement
    string description
}

SIGNALE_PAR {
    int id PK
    string nom
    string prenom
}

URGENCE {
    int id PK
    boolean urgence
}

STATUT {
    int id PK
    string statut
}

INTERVENTION {
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

TYPE_INTERVENTION {
    int id PK
    string type
}

TECHNICIEN {
    int id PK
    string nom
    string prenom
}

FOURNISSEUR {
    int id PK
    int id_entreprise FK
    int id_materiaux FK
    string remarques
}

ENTREPRISE {
    int id PK
    string entreprise
    string contact
    string telephone
    string email
}

    MOBILIER ||--|| TYPE_MOBILIER : est
