# Projet Web API

Vous allez faire un projet de web api utilisant Ruby On Rails.
Vous pouvez partir du code fait en cours ou non.

# I- Sujet

## Application

L'application devra être une API de type REST web. Elle devra etre accompagnée (ou inclure) une app qui consommera votre API REST.

## La base

Votre API devra impléter par défaut un CRUD (Create, Read, Update, Delete), un tri, une pagination et un rendu partiel.
Votre API contiendra au minimum deux modeles dont au moins un imbriqué.
Lors du développement de l'API, le développeur devra créer un minimum de fichier et de ligne de code pour implémenter le CRUD.

## Application Consommatrice
Vous devez creer une app Ruby On Rails qui consommera votre API. Cette app peut être inclus dans votre projet API ou être séparée. Cette app doit contenir tout les points abordés en cours. Cette app doit être hébergée sur Heroku.
De type CRUD, votre application sera interactive dans la consommation de votre API. Cette application doit être sécurisées grâce aux outils vus en cours.

## Filtres
Vous devrez inclure dans votre API un filtre générique sous la forme suivante: http://xxxxx.com/catalog/v1/products?type=pizza,pates&rating=4,5&days=sunday
Sur une chaine de caratères:
- l'utilisateur peut rechercher une valeur fixe (type=pizza)
- l'utilisateur peut rechercher plusieurs valeurs,  ex les produits de type 'pizza' ou 'pates' (type=pizza,pate)

Sur les valeurs numériques:
- l'utilisateur peut rechercher une valeur fixe (rating=4)
- l'utilisateur peut rechercher plusieurs valeurs,  ex les produits de rating '4' ou '5' (rating=4,5)
- l'utilisateur peut rechercher des fourchettes de valeurs,  ex les produits de rating compris en '4' et '10' (rating=[4,10])
- l'utilisateur peut rechercher des valeurs inférieurs ou égal,  ex les produits de rating inférieur ou egal à '10' (rating=[,10])
- l'utilisateur peut rechercher des valeurs supérieurs ou égal,  ex les produits de rating séperieur ou égal à '4' (rating=[4,])

Sur les valeurs de temps:
- l'utilisateur peut rechercher une valeur fixe (createdat=04-04-2020)
- l'utilisateur peut rechercher plusieurs valeurs,  ex les produits créés le 04/04/2020 ou le 05/05/2020 (createdat=04-04-2020,05-05-2020)
- l'utilisateur peut rechercher des fourchettes de valeurs,  ex les produits créés entre le 04/04/2020 et le 05/05/2020 (createdat=[04-04-2020,05-05-2020])
- l'utilisateur peut rechercher des valeurs inférieurs ou égal,  ex les produits créés avant le 05/05/2020 (createdat=[,05-05-2020])
- l'utilisateur peut rechercher des valeurs supérieurs ou égal,  ex les produits créés après le 04/04/2020 (createdat=[04-04-2020,])

## Recherche
Vous devrez inclure dans votre librairie une recherche générique sous la forme suivante: http://xxxxx/catalog/v1/products/search?name=*napoli*&type=pizza,pate&sort=rating,name
Lors du développement de l'API, le développeur devra créer un minimum de fichier et de ligne de code pour implémenter la recherche.

## Authentification/Securisation
Vous devez implétementer un système de sécurité de votre choix pour votre API (access token) pour les actions du CRUD les plus sensibles.
https://github.com/gonzalo-bulnes/simple_token_authentication
https://github.com/oauth-xx/oauth2
https://github.com/doorkeeper-gem/doorkeeper

## Base de données
Vous devez utilisé Posgresql combiné à Active record

## Web API
Vous devrez réaliser la doc de l'API avec SwaggerUI et plus particulierement la gem swagger-docs [aide](https://github.com/richhollis/swagger-docs)

## Hébergement
Votre/Vos projet devra/ont être hébergé/s sur Héroku


## Tests unitaires (bonus: 3 points)
Un projet de test unitaire et test systems pourra être réalisé pour au moins un service d'API et votre Application de consommation.

## Design App Consommatrice (bonus 3 points)
Designez votre app consommatrice en utilisant css et javascript pour la rendre plus attractive.


# Groupes et fonctionnement

Le projet est a développé en groupe de 2 personnes.
Tous les groupes seront définis en cours, sous la supervision de l'enseignant. Les groupes s'enregistrent avec un nom de groupe ainsi que les noms de leurs membres.

Toute inscription est définitive.  Les étudiants ne sont pas autorisés, par la suite, à changer de groupe.

Au sein d'un groupe, les étudiants se répartiront les tâches pour le projet, de façon équitable.  Il est explicitement exigé que chaque membre consacre au moins 50% de son travail à du développement technique. Du code de test est acceptable, tant qu'il ne constitue pas l'intégralité de la réalisation technique du membre du groupe.

Les étudiants sont encouragés (mais pas obligés) à mettre en place un système de contrôle des sources de type Git ou équivalent, afin d'affecter et partager efficacement les fichiers de codes et autres composants numériques du projet (fichiers sources, descripteurs de déploiement, documents de recherche, cas d'utilisation, suites de tests, etc.).

# Soutenance et rendu

La soutenance aura lieux le jeudi 3 décembre 2020.
La soutenance se déroulera sur Teams, chaque membre devra mettre sa caméra et son micro afin de participer.
Les horaires de passage sont définis pour chaque groupe.
Toute absence à la soutenance entrainera un 0 (ZERO) pour le membre du groupe.

Les rendus doivent figurer sur un seul compte par groupe.
Le rendu s'effectuera via un repos GIT. L'adresse du rendu est envoyé par mail.
Le mail de rendu est nadia.auger@ynov.com
Les fichiers rendus doivent contenir
  - L'arborescence du projet, immédiatement exploitable après création des bases de données et exécution des migrations.
  - Un AUTHORS.TXT listant les membres du groupe (prénom, nom), à raison d'un par ligne.  Il liste ensuite les responsabilités effectives de chacun dans le groupe.
Le sujet du mail doit contenir votre section ainsi que le nom du projet.
Les fichiers rendus peuvent aussi comprendre:
  - Des documents de recherche créés pour le projet et fournissant plus de détails pour l'enseignant.
Pour tout autre type de fichier, veuillez demander à l'enseignant si son inclusion est appropriée.
La soutenance dure 20 minutes durant lesquelles les membres présentent leur travail. Un échange de questions peut se faire entre le professeur et les membres du groupe.

# Groupes et fonctionnement
FONTON Aros - David Ly | Black&Yellow

IBIRIZ Noura - SOUSSAN Jimmy | DLM

STAES Pierrick - GIRARD Yohan | Groupe 1

MARTEAU Antoine - SAUMUROT Florian | Les Ksos

RALAIMIADANA Tanguy - EL GANA Bastien | Les imposteurs

DOS SANTOS Nicolas - FROMENTIN Victor | MyWatchList

ROBLES Jeremie - NOEL Alexis | Les inconnus
