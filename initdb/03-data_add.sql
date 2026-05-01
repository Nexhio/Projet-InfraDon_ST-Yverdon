-- Active: 1776339493013@@127.0.0.1@5432@infradon
INSERT INTO public.materiaux (materiaux)
SELECT DISTINCT (
    CASE (materiau)
    WHEN 'sodium' THEN 'Lampadaire Sodium'
    WHEN 'LED'    THEN 'Lampadaire LED'
    END
)
AS materiaux
FROM staging.inventaire_mobilier
WHERE materiau LIKE 'LED' OR materiau LIKE 'sodium';


INSERT INTO public.etat (etat)
SELECT DISTINCT etat
FROM staging.inventaire_mobilier
AS etat;


INSERT INTO public.urgence (urgence)
SELECT DISTINCT (
    CASE (urgence)
    WHEN 'normal' THEN 'Normal'
    WHEN 'urgent'    THEN 'Urgent'
    ELSE 'Normal'
    END
)
AS urgence
FROM staging.signalements;


INSERT INTO public.statut (statut)
SELECT DISTINCT (
    CASE (statut)
    WHEN 'fait'          THEN 'Fait'
    WHEN 'en attente'    THEN 'En attente'
    WHEN 'en cours'      THEN 'En cours'
    ELSE 'En attente'
    END
)
FROM staging.signalements;


INSERT INTO public.type_intervention (type)
SELECT DISTINCT type_intervention_trie
FROM (
    SELECT DISTINCT
        type_intervention,
        objet,
        CASE (type_intervention)
            WHEN 'réparation'            THEN 'Réparation'
            WHEN 'redressage mât'        THEN 'Redressage mât'
            WHEN 'remplacement complet'  THEN 'Remplacement complet'
            WHEN 'remplacement ampoule'  THEN 'Remplacement ampoule'
            ELSE type_intervention
        END AS type_intervention_trie
    FROM staging.interventions
    WHERE objet LIKE '%ampadaire%'
);


INSERT INTO public.technicien (nom, prenom)
SELECT DISTINCT 
    SPLIT_PART(technicien, ' ', 2) AS nom,
    SPLIT_PART(technicien, ' ', 1) AS prenom
FROM (
    SELECT  
    CASE (technicien)
    WHEN 'JM'           THEN 'Jean-Marc Bonvin'
    WHEN 'Jean-Marc'    THEN 'Jean-Marc Bonvin'
    WHEN 'P. Alves'     THEN 'Pedro Alves'
    WHEN 'Pedro'        THEN 'Pedro Alves'
    WHEN 'Alves Pedro'  THEN 'Pedro Alves'
    WHEN 'Koffi Marc'   THEN 'Marc Koffi'
    WHEN 'stagiaire'    THEN 'Stagiaire'
    ELSE technicien
    END
FROM staging.interventions
);

INSERT INTO public.signale_par (nom)
SELECT DISTINCT (
    CASE (signale_par)
    WHEN 'email citoyen'        THEN 'Habitant'
    WHEN 'concierge école'      THEN 'Concierge École'
    WHEN 'habitant du quartier' THEN 'Habitant'
    WHEN 'patrouille JM'        THEN 'Jean-Marc Bonvin'
    WHEN 'un habitant'          THEN 'Habitant'
    WHEN 'un passant'           THEN 'Habitant'
    ELSE signale_par
    END
)
FROM staging.signalements;

INSERT INTO public.entreprise (entreprise, contact, telephone, email)
SELECT DISTINCT entreprise,
    CASE (contact)
        WHEN 'voir site web' THEN NULL
        ELSE (contact)
    END,

    CASE
        WHEN telephone LIKE '+41%' 
            THEN
            REGEXP_REPLACE(
                '0'|| TRIM(LEADING '+41' FROM TRIM(telephone)),
                '(\d{3})(\d{3})(\d{2})(\d{2})',
                '\1 \2 \3 \4'
            )
            ELSE
                REGEXP_REPLACE(
                    REGEXP_REPLACE(TRIM(telephone), '\s', '', 'g'),
                        '(\d{3})(\d{3})(\d{2})(\d{2})',
                        '\1 \2 \3 \4'
                        )
        END,
        
    CASE (email)
        WHEN 'voir site web' THEN NULL
        ELSE (email)
    END
FROM staging.fournisseurs_contacts;



--/////////////////////TABLE FK///////////////////////


INSERT INTO public.fournisseur (id_entreprise, remarques)
SELECT DISTINCT
    public.entreprise.id,
    CASE TRIM(staging.fournisseurs_contacts.remarques)
        WHEN '' THEN NULL
        ELSE TRIM(staging.fournisseurs_contacts.remarques)
    END AS remarques
FROM staging.fournisseurs_contacts
JOIN public.entreprise 
    ON TRIM(public.entreprise.entreprise) = TRIM(staging.fournisseurs_contacts.entreprise);


