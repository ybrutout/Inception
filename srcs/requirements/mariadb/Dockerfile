FROM debian::buster
#J'ai pas mis le apt-get je sais pas 
RUN apt update
RUN apt upgrade -y

RUN	apt install -y mariadb-server

#je vais devoir copie des trucs (COPY)
COPY tools/config.sh /tmp

#Je vais devoir finir par la cmd ENTRYPOINT pour lancer les scripts qui feront la configurations du service pendant que le service tourne. 
#ENTRYPOINT ["sh", "/tmp/config.sh"]