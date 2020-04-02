# MedShakeEHR-install-script

[![GitHub release](https://img.shields.io/badge/release-v0.1.0-blue)](https://github.com/UpperM/MedShakeEHR-install-script/releases/latest)

Script pour installer l'application MedShakeEHR sur un serveur Debian 10.
Attention ce script est a utilisé uniquement dans un environnement de DEV/TEST !

<!-- TABLE OF CONTENTS -->
## Table of Contents
* [Getting Started](#getting-started)
  * [Installation](#installation)
* [Author](#author)

# Getting Started
## Requirements
Téléchargez le script sur le serveur
```sh
cd /tmp
wget https://raw.githubusercontent.com/UpperM/MedShakeEHR-install-script/master/install-ehr.sh
```

## Installation
Executez le script
```sh
sh /tmp/install-ehr.sh
```
L'installation va débuter et installer les paquets nécessaire. Ce dernier va aussi configurer Apache2 et PHP.

A la fin de l'installation rendez-vous sur http//ip_du_serveur/self-installer.php pour lancer la configuration de l'application.

N'oubliez pas de définir un mot de passe à votre compte root MySQL

Documentation officielle : https://www.logiciel-cabinet-medical.fr/documentation-technique/environnement-de-production-necessaire-a-medshakeehr.html

# Author
Author: [UpperM](https://twitter.com/UppperM)
