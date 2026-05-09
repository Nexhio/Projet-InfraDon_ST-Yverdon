-- Active: 1776339493013@@127.0.0.1@5432@infradon


SELECT
    public.materiaux.id AS id_materiaux,
    public.etat.id AS id_etat,

    CASE
        WHEN staging.inventaire_mobilier.date_installation ~ '^\d{4}$'
            THEN (TRIM(staging.inventaire_mobilier.date_installation) || '-01-01') :: DATE

        WHEN staging.inventaire_mobilier.date_installation ~ '^\d{2}\.\d{2}\.\d{4}$'
            THEN TO_DATE(staging.inventaire_mobilier.date_installation, 'DD.MM.YYYY')

        WHEN staging.inventaire_mobilier.date_installation ~ '^\d{4}-\d{2}-\d{2}$'
            THEN staging.inventaire_mobilier.date_installation :: DATE

        WHEN staging.inventaire_mobilier.date_installation ~ '^\w+ \d{4}$'
            THEN TO_DATE(
                REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(
                REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(
                    LOWER(TRIM(staging.inventaire_mobilier.date_installation)),
                'janvier',  '01') , 'février',   '02') , 'mars',      '03'),
                'avril',    '04') , 'mai',        '05') , 'juin',      '06'),
                'juillet',  '07') , 'août',       '08') , 'septembre', '09'),
                'octobre',  '10') , 'novembre',   '11') , 'décembre',  '12')
            , 'MM YYYY') :: DATE

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
        WHEN 'bois'   THEN 'bois'
        WHEN 'métal'  THEN 'métal'
        WHEN 'metal'  THEN 'métal'
        WHEN 'pierre' THEN 'pierre'
        WHEN 'béton'  THEN 'béton'
        WHEN 'beton'  THEN 'béton'
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