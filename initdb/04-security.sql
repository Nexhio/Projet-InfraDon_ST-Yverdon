-- =============================================================================
-- 04-security.sql
-- Gestion des rôles, utilisateurs et permissions
-- Projet Yverdon-les-Bains - Infrastructure de données
-- =============================================================================


-- -----------------------------------------------------------------------------
-- 1. RÉVOQUER LES DROITS PAR DÉFAUT DU RÔLE PUBLIC
-- -----------------------------------------------------------------------------

REVOKE ALL ON ALL TABLES IN SCHEMA public FROM public;
REVOKE ALL ON SCHEMA public FROM public;


-- -----------------------------------------------------------------------------
-- 2. CRÉATION DES UTILISATEURS
-- -----------------------------------------------------------------------------

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
    NOSUPERUSER
    NOCREATEDB;

CREATE USER samuelADM
    WITH PASSWORD 'motdepasse$'
    VALID UNTIL '2026-12-31'
    NOSUPERUSER
    NOCREATEDB;

CREATE USER laurentADM
    WITH PASSWORD 'motdepasse$'
    VALID UNTIL '2026-12-31'
    NOSUPERUSER
    NOCREATEDB;


-- -----------------------------------------------------------------------------
-- 3. CRÉATION DES RÔLES FONCTIONNELS
-- -----------------------------------------------------------------------------

CREATE ROLE lecteur;
CREATE ROLE editeur;
CREATE ROLE administrateur;


-- -----------------------------------------------------------------------------
-- 4. CONNEXION ET ACCÈS AU SCHÉMA
-- -----------------------------------------------------------------------------

GRANT CONNECT ON DATABASE infradon TO lecteur, editeur, administrateur;
GRANT USAGE ON SCHEMA public TO lecteur, editeur, administrateur;


-- -----------------------------------------------------------------------------
-- 5. PRIVILÈGES SUR LES TABLES EXISTANTES
-- -----------------------------------------------------------------------------

-- Lecture seule
GRANT SELECT ON ALL TABLES IN SCHEMA public TO lecteur;

-- Édition complète
GRANT SELECT, INSERT, UPDATE, DELETE ON ALL TABLES IN SCHEMA public TO editeur;

-- Accès total (tables + séquences pour les colonnes SERIAL/BIGSERIAL)
GRANT ALL PRIVILEGES ON ALL TABLES IN SCHEMA public TO administrateur;
GRANT ALL PRIVILEGES ON ALL SEQUENCES IN SCHEMA public TO administrateur;


-- -----------------------------------------------------------------------------
-- 6. PRIVILÈGES PAR DÉFAUT POUR LES FUTURES TABLES
-- -----------------------------------------------------------------------------

ALTER DEFAULT PRIVILEGES IN SCHEMA public
    GRANT SELECT ON TABLES TO lecteur;

ALTER DEFAULT PRIVILEGES IN SCHEMA public
    GRANT SELECT, INSERT, UPDATE, DELETE ON TABLES TO editeur;

ALTER DEFAULT PRIVILEGES IN SCHEMA public
    GRANT ALL PRIVILEGES ON TABLES TO administrateur;

ALTER DEFAULT PRIVILEGES IN SCHEMA public
    GRANT ALL PRIVILEGES ON SEQUENCES TO administrateur;


-- -----------------------------------------------------------------------------
-- 7. ASSIGNATION DES RÔLES AUX UTILISATEURS
-- -----------------------------------------------------------------------------

GRANT editeur TO louis, samuel, laurent;
GRANT administrateur TO louisADM, samuelADM, laurentADM;