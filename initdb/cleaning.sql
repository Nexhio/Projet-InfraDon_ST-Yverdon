

SELECT DISTINCT (
    CASE (technicien)
    WHEN 'JM'           THEN 'Jean-Marc Bonvin'
    WHEN 'Jean-Marc'    THEN 'Jean-Marc Bonvin'
    WHEN 'P. Alves'     THEN 'Pedro Alves'
    WHEN 'Pedro'        THEN 'Pedro Alves'
    WHEN 'Alves Pedro'  THEN 'Pedro Alves'
    WHEN 'Koffi Marc'   THEN 'Marc Koffi'
    WHEN 'stagiaire'    THEN 'Stagiaire'
    ELSE technicien
END)
AS technicien_trié, technicien
FROM interventions;




SELECT DISTINCT (
    CASE (statut)
    WHEN 'fait'          THEN 'Fait'
    WHEN 'en attente'    THEN 'En attente'
    WHEN 'en cours'      THEN 'En cours'
    ELSE 'En attente'
    END
)
AS urgence
FROM staging.signalements;