

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
FROM staging.interventions);
