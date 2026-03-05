```mermaid
classDiagram
    
    class Mobilier {
        PK id
        type_mobilier
        materiau
        date_installation
        etat_actuel
        remarques
        localisation
    }

    class Signalement {
        PK id
        date_signalement
        signale_par
        description
        urgence
        statut
    }

    class Intervention {
        PK id
        date_intervention
        type_intervention
        technicien
        duree
        cout_materiel
        remarques
    }

    class Fournisseur {
        PK id
        entreprise
        contact
        telephone
        email
        type_materiel
        remarques
    }

    Mobilier "1" -- "*" Signalement : fait l'objet de
    Mobilier "1" -- "*" Intervention : subit
    Intervention "0..1" -- "1" Signalement : resout
    Fournisseur "1" -- "*" Mobilier : fournit/maintient
