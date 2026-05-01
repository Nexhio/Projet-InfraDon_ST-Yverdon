-- Active: 1776339493013@@127.0.0.1@5432@infradon



SELECT DISTINCT
    mat.id AS id_materiaux,
    eta.id AS id_etat,
    NULL AS id_fournisseur,
    CASE
        WHEN staging.inventaire_mobilier.date_installation ~ '^\d{2}\.\d{2}\.\d{4}$'
            THEN TO_DATE(staging.inventaire_mobilier.date_installation, 'DD.MM.YYYY')
        WHEN staging.inventaire_mobilier.date_installation ~ '^\d{4}-\d{2}-\d{2}$'
            THEN TO_DATE(staging.inventaire_mobilier.date_installation, 'YYYY-MM-DD')
        WHEN staging.inventaire_mobilier.date_installation ~ '^\d{4}$'
            THEN TO_DATE(staging.inventaire_mobilier.date_installation || '-01-01', 'YYYY-MM-DD')
        ELSE NULL
    END AS date_installation,
    CASE TRIM(staging.inventaire_mobilier.remarques)
        WHEN '' THEN NULL
        ELSE TRIM(staging.inventaire_mobilier.remarques)
    END AS remarques,
    TRIM(staging.inventaire_mobilier.lieu) ||
        CASE
            WHEN staging.inventaire_mobilier.latitude IS NOT NULL
            THEN ' (' || staging.inventaire_mobilier.latitude::TEXT || ', ' || staging.inventaire_mobilier.longitude::TEXT || ')'
            ELSE ''
        END AS localisation

FROM staging.inventaire_mobilier

JOIN public.materiaux mat
    ON LOWER(TRIM(mat.materiaux)) = LOWER(TRIM(staging.inventaire_mobilier.materiau))

JOIN public.etat eta
    ON LOWER(TRIM(eta.etat)) = LOWER(TRIM(staging.inventaire_mobilier.etat));