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