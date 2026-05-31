-- Brief C 




-- Livrable 1 Fiche de chaque lampadaire


CREATE VIEW v_lampadaires_detail AS
SELECT
    m.code                                          AS identifiant,
    m.localisation                                  AS lieu,
    mat.materiaux                                   AS type,
    EXTRACT(YEAR FROM m.date_installation)::INT     AS annee_installation,
    COUNT(i.id)                                     AS nb_interventions,
    COALESCE(SUM(i.cout_materiel::NUMERIC), 0)      AS cout_cumule_chf,
    MAX(i.date_intervention)                        AS derniere_intervention,
    m.latitude,
    m.longitude
FROM mobilier m
JOIN materiaux mat ON mat.id = m.id_materiaux
LEFT JOIN intervention i ON i.id_mobilier = m.id
GROUP BY m.id, m.code, m.localisation, mat.materiaux, m.date_installation, m.latitude, m.longitude;


-- Livrable 2 Classement de priorité
-- Score = pannes × 3 + âge × 2 + coût cumulé / 100


CREATE VIEW v_lampadaires_priorite AS
SELECT
    identifiant,
    lieu,
    type,
    annee_installation,
    nb_interventions,
    cout_cumule_chf,
    derniere_intervention,
    latitude,
    longitude,
    ROUND(
        (nb_interventions * 3)
        + (EXTRACT(YEAR FROM CURRENT_DATE) - COALESCE(annee_installation, EXTRACT(YEAR FROM CURRENT_DATE)::INT)) * 2
        + (cout_cumule_chf / 100),
    2) AS score_priorite
FROM v_lampadaires_detail
ORDER BY score_priorite DESC;


-- Livrable 3  Sélection dans le budget CHF 50'000
-- Coût unitaire estimé = coût moyen d'un "Remplacement complet"


CREATE VIEW v_lampadaires_budget AS
WITH cout_remplacement AS (
    SELECT ROUND(AVG(i.cout_materiel::NUMERIC), 2) AS cout_moyen
    FROM intervention i
    JOIN type_intervention ti ON ti.id = i.id_type_intervention
    WHERE ti.type = 'Remplacement complet'
),
selection AS (
    SELECT
        p.*,
        cr.cout_moyen                                                              AS cout_remplacement_estime,
        SUM(cr.cout_moyen) OVER (ORDER BY p.score_priorite DESC, p.identifiant)   AS budget_cumule
    FROM v_lampadaires_priorite p
    CROSS JOIN cout_remplacement cr
)
SELECT
    identifiant,
    lieu,
    type,
    annee_installation,
    nb_interventions,
    cout_cumule_chf,
    score_priorite,
    cout_remplacement_estime,
    budget_cumule,
    latitude,
    longitude
FROM selection
WHERE budget_cumule <= 50000
ORDER BY score_priorite DESC;
