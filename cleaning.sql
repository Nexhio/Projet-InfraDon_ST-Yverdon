SELECT (
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


SELECT (
    CASE (materiau)
    WHEN 'sodium' THEN 'Lampadaire Sodium'
    WHEN 'LED'    THEN 'Lampadaire LED'
    END
)
AS materiau_trié
FROM inventaire_mobilier
WHERE materiau LIKE 'LED' OR materiau LIKE 'sodium' ;

SELECT DISTINCT etat
FROM inventaire_mobilier;
