FROM debian:buster

RUN apt-get update
RUN apt-get upgrade -y

RUN apt-get install -y php7.3 php7.3-fpm php7.3-mysql curl

#Workdir va setup le prochain dossier de travail, automatiquement la suite des instructions
#se feront à l'emplacement du [path] Si le path n'existe pas il le créera
WORKDIR /tmp/wordpress/

COPY tools/config.sh .

#Je ne sais pas pourquoi ils font ça
RUN mkdir -p /run/php

#curl permet de transférer une donnée depuis ou vers un serveur en utilisant n'importe 
#quel protocole
#l'option -O précise de télécharger le fichier qui se trouve à l'URL et de le mettre au 
#même nom qui se trouve dans l'URL
RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar

#Donne les droits d'exécution / lecture / écriture d'un fichier
RUN chmod +x wp-cli.phar

#Déplace l'éxecutable dans le dossier bin au bon endroit pour qu'il puisse être exécuté
#seulement par Wordpress.
RUN mv wp-cli.phar /usr/local/bin/wp

WORKDIR /var/www/wordpress

#permet de télécharger les documents extra de wordpress 
RUN wp core download --allow-root

RUN chown -R www-data:www-data /var/www/wordpress

ENTRYPOINT ["sh", "/tmp/wordpress/config.sh"]


