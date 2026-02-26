classDiagram
    class Localisation {
        <<ValueObject>>
        +String lieu
        +Float latitude
        +Float longitude
    }

    class Mobilier {
        +String id_mobilier
        +Enum type_mobilier
        +String materiau
        +Date date_installation
        +Enum etat_actuel
        +String remarques
    }

    class Signalement {
        +Date date_signalement
        +String signale_par
        +String description
        +Enum urgence
        +Enum statut
    }

    class Intervention {
        +Date date_intervention
        +String type_intervention
        +String technicien
        +Duration duree
        +Float cout_materiel
        +String remarques
    }

    class Fournisseur {
        +String entreprise
        +String contact
        +String telephone
        +String email
        +String type_materiel
        +String remarques
    }

    Mobilier "1" -- "1" Localisation : se situe à
    Mobilier "1" -- "*" Signalement : fait l'objet de
    Mobilier "1" -- "*" Intervention : subit
    Intervention "0..1" -- "1" Signalement : resout
    Fournisseur "1" -- "*" Mobilier : fournit/maintient
