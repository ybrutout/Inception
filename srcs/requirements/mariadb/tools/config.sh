chown -R mysql:mysql /var/lib/mysql

#Verification que le dossier que va utiliser la basse de donnée à bien été créé dans le bon
#dossier. 
if [ ! -d /var/lib/mysql/$MARIADB_NAME ]; then
	#On lance le service mysql mais en lui redéfinissant son directory
	service mysql start --datadir=/var/lib/mysql

	#On crée un dossier qui va être utiliser par le daemon (le daemon stock toutes les infos
	#qui vont communiqué ensemble entre les sewrvices dans un même dossier)
	mkdir -p /var/run/mysqld

	#Une fois les dossiers requis créer on va aussi s'assurer que les documents requis sont
	#présent. touch va créer un document vide par définition. 
	touch /var/run/mysqld/mysqlf.pid

	#lance la configuration qui contient les commandes mysql pour créer l'user avec ces permissions
	#pour wordpress
	eval "echo \"$(cat /tmp/config.sql)\"" | mariadb -u root

	#Il faut protéger le root de mysql car on veut que l'user créer précédemment ait accès 
	#à la database créé mais pas à toutes les databases.
	mysqladmin -u root password $MARIADB_ROOT_PWD;

	#Je sais pas Pourquoi on arrête le service donc à voir ou à essayer //TO DO
	service mysql stop --datadir=/var/lib/mysql
else
	#On crée un dossier qui va être utiliser par le daemon (le daemon stock toutes les infos
	#qui vont communiqué ensemble entre les sewrvices dans un même dossier)
	mkdir -p /var/run/mysqld

	#Une fois les dossiers requis créer on va aussi s'assurer que les documents requis sont
	#présent. touch va créer un document vide par définition. 
	touch /var/run/mysqld/mysqlf.pid
	#Peut être devoir créer le .sock requis dans le document.
	#touch /var/run/mysqld/mysqld.sock

fi

chown -R mysql:mysql /var/run/mysqld
#Lancement recommandé de MariaDB avec le set-up correct.
mysqld_safe --datadir=/var/lib/mysql





