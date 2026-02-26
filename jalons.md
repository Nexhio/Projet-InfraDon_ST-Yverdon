```mermaid
gantt
dateFormat  2026-02-26
title Jalons du projet
%% excludes weekdays 2014-01-10

section J0 Modélisation
MCD, MLD, qualité:active, 2026-02-19, 14d

section J1 Import
MPD, staging, nettoyage: 2026-03-05, 14d

Section J2 Requêtes
Requêtes métier, staging, nettoyage: 2026-03-19, 14d

section J3 Sécurité
Rôles, permissions: 2026-04-02, 14d

section J4 dbt + poster
Stating -> marts + poster A3: 2026-04-16, 14d

section J5 Présentation + poster
Poster A3 affiché + présentation: 2026-05-28

section Rendu final
Scripts, jalons, adaptations: 2026-05-31
