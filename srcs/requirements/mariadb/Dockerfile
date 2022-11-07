FROM debian:buster
 
RUN apt-get update
RUN apt-get upgrade -y

RUN	apt-get install -y mariadb-server

COPY ./tools/config.sql /tmp/config.sql

#je vais devoir copie des trucs (COPY)
COPY tools/config.sh /tmp

#copie le document de config pour remplacer celui normalement déjà présent 
COPY tools/mariadb.cnf /etc/mysql/

#Je vais devoir finir par la cmd ENTRYPOINT pour lancer les scripts qui feront la configurations du service pendant que le service tourne. 
ENTRYPOINT ["sh", "/tmp/config.sh"]