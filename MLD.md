```mermaid

classDiagram
class TABLE {
    int id PK "UNIQUE ; NOT NULL"
}
class MOBILIER {
    int id PK "UNIQUE ; NOT NULL"
    int id_type_mobilier FK "NOT NULL"
    int id_materiaux FK
    int id_etat FK "NOT NULL"
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
     int id PK "UNIQUE ; NOT NULL"
     string type
}
class MATERIAUX {
     int id PK "UNIQUE ; NOT NULL"
     string materiaux
}
class ETAT {
    int id PK "UNIQUE ; NOT NULL"
    string etat
}
class SIGNALEMENT {
    int id PK "UNIQUE ; NOT NULL"
    int id_mobilier FK "NOT NULL"
    int id_signale_par FK
    int id_urgence FK "NOT NULL"
    int id_statut FK "NOT NULL"
    date date_signalement
    string description
}
SIGNALEMENT -- MOBILIER
SIGNALEMENT -- SIGNALE_PAR
SIGNALEMENT -- URGENCE
SIGNALEMENT -- STATUT
class SIGNALE_PAR {
    int id PK "UNIQUE ; NOT NULL"
    string nom
    string prenom
}
class URGENCE {
    int id PK "UNIQUE ; NOT NULL"
    string urgence
}
class STATUT {
    int id PK "UNIQUE ; NOT NULL"
    string statut
}
class INTERVENTION {
    int id PK "UNIQUE ; NOT NULL"
    int id_mobilier FK "NOT NULL"
    int id_fournisseur FK
    int id_signalement FK
    int id_type_intervention FK "NOT NULL"
    int id_technicien FK "NOT NULL"
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
    int id PK "UNIQUE ; NOT NULL"
    string type
}
class TECHNICIEN {
    int id PK "UNIQUE ; NOT NULL"
    string nom
    string prenom
}
class FOURNISSEUR {
    int id PK "UNIQUE ; NOT NULL"
    int id_entreprise FK "NOT NULL"
    string remarques
}
FOURNISSEUR -- ENTREPRISE
class ENTREPRISE {
    int id PK "UNIQUE ; NOT NULL"
    string entreprise
    string contact
    string telephone
    string email
}
