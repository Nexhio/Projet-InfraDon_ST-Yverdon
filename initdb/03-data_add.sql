-- Active: 1772719530316@@127.0.0.1@5432@infradon
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