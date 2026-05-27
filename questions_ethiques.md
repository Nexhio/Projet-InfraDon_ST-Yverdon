**RÉFLEXIONS ÉTHIQUES**


# Question 1 
À qui appartiennent les données du mobilier urbain d'Yverdon ? À la commune, aux habitant·e·s, au prestataire qui a développé le système ?

Les données du mobilier urbain d'Yverdon sont des données publiques : collectées et gérées par la commune dans l'exercice de ses missions, elles lui appartiennent. Les signalements émanent des habitants, mais les données personnelles qu'ils contiennent — nom, coordonnées — restent la propriété des personnes concernées et sont protégées par la LPD. Le prestataire qui développe le système détient la propriété intellectuelle du logiciel, pas des données qu'il traite. Cette distinction est essentielle : changer de prestataire ne doit pas signifier perdre ses données.

# Question 2
Si un algorithme prédit qu'un banc est "prioritaire" pour une rénovation, et que ce banc est dans un quartier défavorisé : est-ce un résultat équitable ou le signe d'un biais dans les données de signalement ?

Un algorithme de priorisation reflète les données qu'on lui fournit. Si les habitant·e·s des quartiers défavorisés signalent moins — par manque d'accès numérique ou de confiance envers les institutions — le banc dégradé n'apparaîtra pas comme prioritaire, non parce qu'il l'est moins, mais parce qu'il est sous-signalé. À l'inverse, un résultat prioritaire dans ce quartier peut être parfaitement équitable. La vraie question n'est pas le résultat, mais la représentativité des données d'entrée : un biais dans la collecte produit mécaniquement un biais dans la décision.
# Question 3
Votre base de données contient des noms de technicien·ne·s. Pendant combien d'années faut-il conserver cet historique ? Qui décide ?

Les noms des techniciens sont des données personnelles au sens de la LPD : leur conservation ne peut être illimitée. La durée dépend de la finalité — traçabilité des interventions, litiges, audits — et doit lui être proportionnelle. En Suisse, les archives communales sont soumises à la législation cantonale sur l'archivage, qui peut imposer des durées minimales. C'est donc la commune qui décide, encadrée par la loi. Mais décider ne suffit pas : il faut aussi documenter ce choix dans une politique de rétention, et prévoir la pseudonymisation ou la suppression à échéance.
Pour les données d'Yverdon, une politique raisonnable et défendable serait :

- Conservation nominative : 5 à 10 ans (couverture des délais de prescription ordinaires)
- Après cette période : anonymisation automatique (le nom disparaît, l'intervention reste)
- Données purement statistiques (coûts, durées, types) : conservation indéfinie, car elles ne sont plus personnelles

Ce qui compte, c'est de documenter le choix et sa justification — c'est ça, une infrastructure dont les compromis sont assumés.

# Question 4
Si le Service technique décide d'analyser les déplacements des technicien·ne·s via GPS pour optimiser les tournées : quelles questions éthiques cela soulève-t-il ?

Tracker les déplacements GPS des techniciens, c'est collecter en continu des données biométriques de localisation sur des employés — sans qu'ils aient nécessairement consenti. Cela soulève plusieurs questions : qui accède aux données, à quelle granularité, et dans quel but réel ? L'optimisation des tournées peut glisser vers la surveillance du rendement individuel, voire disciplinaire. La LPD exige une finalité explicite et proportionnée. Les employés doivent être informés, et idéalement consultés. L'efficacité opérationnelle ne justifie pas à elle seule une atteinte à la vie privée au travail.