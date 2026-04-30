-- Création des utilisateurs
CREATE USER louis 
	WITH PASSWORD 'motdepasse'
	VALID UNTIL '2026-12-31'
	NOSUPERUSER
	NOCREATEDB;

CREATE USER samuel 
	WITH PASSWORD 'motdepasse'
	VALID UNTIL '2026-12-31'
	NOSUPERUSER
	NOCREATEDB;

CREATE USER laurent 
	WITH PASSWORD 'motdepasse'
	VALID UNTIL '2026-12-31'
	NOSUPERUSER
	NOCREATEDB;


CREATE USER louisADM 
	WITH PASSWORD 'motdepasse$'
	VALID UNTIL '2026-12-31'
	
CREATE USER samuelADM 
	WITH PASSWORD 'motdepasse$'
	VALID UNTIL '2026-12-31'

CREATE USER laurentADM 
	WITH PASSWORD 'motdepasse$'
	VALID UNTIL '2026-12-31'
	
-- Rôles fonctionnels (groupes)
CREATE ROLE lecteur;
CREATE ROLE editeur;
CREATE ROLE administrateur;

-- Privilèges sur la base
GRANT CONNECT ON DATABASE infradon TO lecteur, editeur, administrateur;
GRANT USAGE ON SCHEMA public TO lecteur, editeur, administrateur;

-- Privilèges par rôle
GRANT SELECT ON ALL TABLES IN SCHEMA public TO lecteur;
GRANT SELECT, INSERT, UPDATE, DELETE ON ALL TABLES IN SCHEMA public TO editeur;
GRANT ALL PRIVILEGES ON ALL TABLES IN SCHEMA public TO administrateur;
GRANT ALL PRIVILEGES ON ALL SEQUENCES IN SCHEMA public TO administrateur;

-- Assignation des utilisateurs
GRANT editeur TO louis, samuel, laurent;
GRANT administrateur TO louisADM, samuelADM, laurentADM;
