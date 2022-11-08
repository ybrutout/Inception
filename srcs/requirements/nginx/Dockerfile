FROM debian::buster

RUN apt-get update			
RUN apt-get upgrade -y

#Installation de Ngincx qui sera le server + openssl qui va nous permettre d'utiliser le
#protocole TLS (protocole de cryptage +/- équivalent à SSL)
RUN apt-get install -y nginx openssl

#copie le configuration de nginx au bon endroit du conteneur
COPY tools/nginx.conf /etc/nginx/sites-enabled/default.conf

#on va créer le dossier utile pour le certification du site et la clé.
RUN mkdir -p /etc/ssl

#Il faut maintenant générer cette clé et ce certificat on va utiliser le openssl
#req = Création et mis en oeuvre de la requête de certification
#-x509 = faire en sorte que le certificat sois signé par lui même
#-nodes = fait en sorte que lq clé créer ne soit pas crypté
#-out FILENAME = On indique ou le certificat doit être écris
#-keyout $FILENAME = On indique où la clé doit être écrite.
#-subj "SET" = On précise les informations sur la personne qui signe le certificat (nous)
RUN 	openssl req -x509 -nodes \
		-out /etc/ssl/nginx_self.crt \	
		-keyout /etc/ssl/nginx_self.key \
		-subj "/C=BE/ST=Belgium/L=Namur/O=42/OU=19/CN=ybrutout/UID=ybrutout"

#lance la commande pour daemon off = il va tourner en arrière plan
CMD nginx -g "daemon off;"