-- Active: 1776339493013@@127.0.0.1@5432@infradon


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