# FROM		: On précise l'image sur la quelle démarer / hériter
#			  Par conséquent, toutes les commandes shell doivent s'y adapter

# RUN		: Run une commande shell (quelle différence avec CMD ?)
# 1er RUN 	: permet d'update apt-get et de nettoyer ensuite le gestionnaire de paquets

# WORKDIR	: On définit le dossier de travail
# 			  Toutes les commandes qui suivront seront exécutées à partir de ce répertoire.
# CMD		: On exécute le fichier shell

# Pas besoin de Docker Compose car tout doit être dans un seul container
# Les Dockerfiles sont des fichiers qui permettent de construire une image Docker adaptée à nos besoins

# Classement ressources utiles :
# La meilleure : https://guillaumebriday.fr/comprendre-et-mettre-en-place-docker

# 1) Les Dockerfiles : https://putaindecode.io/articles/les-dockerfiles/
# 2) Sur phpMyAdmin : https://www.digitalocean.com/community/tutorials/how-to-install-and-secure-phpmyadmin-on-debian-9
# 3) Relation DB/Nginx etc ... : https://bigint.fr/blog/2019-05-10/Docker-par-l-exemple

FROM debian:buster
CMD sh srcs/run.sh
