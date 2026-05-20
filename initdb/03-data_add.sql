-- Active: 1778314026582@@127.0.0.1@5432@infradon
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


INSERT INTO public.mobilier (code, id_materiaux, id_etat, latitude, longitude, date_installation, remarques, localisation)
SELECT
    TRIM(staging.inventaire_mobilier.id) AS code,
    public.materiaux.id AS id_materiaux,
    public.etat.id AS id_etat,
    NULLIF(REPLACE(TRIM(staging.inventaire_mobilier.latitude),  ',', '.'), '')::NUMERIC AS latitude,
    NULLIF(REPLACE(TRIM(staging.inventaire_mobilier.longitude), ',', '.'), '')::NUMERIC AS longitude,

    CASE
        WHEN staging.inventaire_mobilier.date_installation ~ '^\d{4}$'
            THEN (TRIM(staging.inventaire_mobilier.date_installation) || '-01-01')::DATE

        WHEN staging.inventaire_mobilier.date_installation ~ '^\d{2}\.\d{2}\.\d{4}$'
            THEN TO_DATE(staging.inventaire_mobilier.date_installation, 'DD.MM.YYYY')

        WHEN staging.inventaire_mobilier.date_installation ~ '^\d{4}-\d{2}-\d{2}$'
            THEN staging.inventaire_mobilier.date_installation::DATE

        WHEN staging.inventaire_mobilier.date_installation ~ '^\w+ \d{4}$'
            THEN TO_DATE(
                REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(
                REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(
                    LOWER(TRIM(staging.inventaire_mobilier.date_installation)),
                'janvier',  '01'), 'février',   '02'), 'mars',      '03'),
                'avril',    '04'), 'mai',        '05'), 'juin',      '06'),
                'juillet',  '07'), 'août',       '08'), 'septembre', '09'),
                'octobre',  '10'), 'novembre',   '11'), 'décembre',  '12')
            , 'MM YYYY')::DATE

        ELSE NULL
    END AS date_installation,

    CASE TRIM(staging.inventaire_mobilier.remarques)
        WHEN '' THEN NULL
        ELSE TRIM(staging.inventaire_mobilier.remarques)
    END AS remarques,

    TRIM(staging.inventaire_mobilier.lieu) AS localisation

FROM staging.inventaire_mobilier

JOIN public.materiaux
    ON public.materiaux.materiaux = CASE LOWER(TRIM(staging.inventaire_mobilier.materiau))
        WHEN 'sodium' THEN 'Lampadaire Sodium'
        WHEN 'led'    THEN 'Lampadaire LED'
        ELSE NULL
    END

JOIN public.etat
    ON public.etat.etat = TRIM(staging.inventaire_mobilier.etat)

WHERE staging.inventaire_mobilier.materiau IS NOT NULL
  AND staging.inventaire_mobilier.etat     IS NOT NULL
  AND TRIM(staging.inventaire_mobilier.materiau) != ''
  AND TRIM(staging.inventaire_mobilier.etat)     != '';


INSERT INTO signalement (id_mobilier, id_signale_par, id_urgence, id_statut, date_signalement, description)
SELECT
    m.id,
    sp.id,
    u.id,
    st.id,
    CASE
        WHEN ss.date ~ '^\d{4}-\d{2}-\d{2}$' THEN ss.date::DATE
        WHEN ss.date ~ '^\d{2}\.\d{2}\.\d{4}$' THEN TO_DATE(ss.date, 'DD.MM.YYYY')
        ELSE NULL
    END,
    ss.description
FROM staging.signalements ss
JOIN mobilier m ON ss.objet ILIKE '%' || m.localisation || '%'
JOIN signale_par sp ON sp.nom = CASE TRIM(ss.signale_par)
        WHEN 'email citoyen'        THEN 'Habitant'
        WHEN 'concierge école'      THEN 'Concierge École'
        WHEN 'habitant du quartier' THEN 'Habitant'
        WHEN 'patrouille JM'        THEN 'Jean-Marc Bonvin'
        WHEN 'un habitant'          THEN 'Habitant'
        WHEN 'un passant'           THEN 'Habitant'
        ELSE TRIM(ss.signale_par)
    END
JOIN urgence u ON u.urgence = CASE TRIM(ss.urgence)
        WHEN 'urgent' THEN 'Urgent'
        ELSE 'Normal'
    END
JOIN statut st ON st.statut = CASE TRIM(ss.statut)
        WHEN 'fait'       THEN 'Fait'
        WHEN 'en cours'   THEN 'En cours'
        ELSE 'En attente'
    END
WHERE ss.objet ILIKE '%ampadaire%';


INSERT INTO intervention (id_mobilier, id_type_intervention, id_technicien, date_intervention, duree, cout_materiel, remarques)
SELECT
    m.id,
    ti.id,
    t.id,
    CASE
        WHEN si.date ~ '^\d{4}-\d{2}-\d{2}$' THEN si.date::DATE
        WHEN si.date ~ '^\d{2}\.\d{2}\.\d{4}$' THEN TO_DATE(si.date, 'DD.MM.YYYY')
        ELSE NULL
    END,
    si.duree,
    NULLIF(REGEXP_REPLACE(TRIM(si.cout_materiel), '[^\d.]', '', 'g'), '')::NUMERIC::MONEY,
    si.remarques
FROM staging.interventions si
JOIN mobilier m ON si.objet ILIKE '%' || m.localisation || '%'
JOIN materiaux mat ON mat.id = m.id_materiaux
JOIN type_intervention ti ON ti.type = CASE TRIM(si.type_intervention)
        WHEN 'réparation'           THEN 'Réparation'
        WHEN 'redressage mât'       THEN 'Redressage mât'
        WHEN 'remplacement complet' THEN 'Remplacement complet'
        WHEN 'remplacement ampoule' THEN 'Remplacement ampoule'
        ELSE TRIM(si.type_intervention)
    END
JOIN technicien t ON TRIM(t.prenom || ' ' || t.nom) = CASE TRIM(si.technicien)
        WHEN 'JM'           THEN 'Jean-Marc Bonvin'
        WHEN 'Jean-Marc'    THEN 'Jean-Marc Bonvin'
        WHEN 'P. Alves'     THEN 'Pedro Alves'
        WHEN 'Pedro'        THEN 'Pedro Alves'
        WHEN 'Alves Pedro'  THEN 'Pedro Alves'
        WHEN 'Koffi Marc'   THEN 'Marc Koffi'
        WHEN 'stagiaire'    THEN 'Stagiaire'
        ELSE TRIM(si.technicien)
    END
WHERE si.objet ILIKE '%ampadaire%'
  AND (
      (si.objet ILIKE '%sodium%' AND mat.materiaux ILIKE '%Sodium%')
   OR (si.objet ILIKE '%led%'   AND mat.materiaux ILIKE '%LED%')
   OR (si.objet NOT ILIKE '%sodium%' AND si.objet NOT ILIKE '%led%')
  );
