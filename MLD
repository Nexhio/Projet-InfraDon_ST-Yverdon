```mermaid
erDiagram

    MOBILIER {
        int id PK
        string type_mobilier
        string materiau
        date date_installation
        string etat_actuel
        string remarques
        string localisation
        int id_fournisseur FK
    }

    SIGNALEMENT {
        int id PK
        int id_mobilier FK
        date date_signalement
        string signale_par
        string description
        string urgence
        string statut
    }

    INTERVENTION {
        int id PK
        int id_mobilier FK
        int id_fournisseur FK
        int id_signalement FK
        date date_intervention
        string type_intervention
        string technicien
        string duree
        decimal cout_materiel
        string remarques
    }

    FOURNISSEUR {
        int id PK
        string entreprise
        string contact
        string telephone
        string email
        string type_materiel
        string remarques
    }

    MOBILIER }o--|| FOURNISSEUR : "fourni/maintenu par"
    MOBILIER ||--o{ SIGNALEMENT : "fait l'objet de"
    MOBILIER ||--o{ INTERVENTION : "subit"
    INTERVENTION }o--o| SIGNALEMENT : "résout"
    INTERVENTION }o--|| FOURNISSEUR : "réalisée par"
