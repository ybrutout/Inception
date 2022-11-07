chown -R mysql:mysql /var/lib/mysql

echo "Je passe ici non ?"

#Verification que le dossier que va utiliser la basse de donnée à bien été créé dans le bon
#dossier. 
if [ ! /var/lib/mysql/$MARIADB_NAME ]; then
	echo "ICI"
	#On lance le service mysql mais en lui redéfinissant son directory
	service mysql start --datadir=/var/lib/mysql

	#On crée un dossier qui va être utiliser par le daemon (le daemon stock toutes les infos
	#qui vont communiqué ensemble entre les sewrvices dans un même dossier)
	mkdir -p /var/run/mysqld

	#Une fois les dossiers requis créer on va aussi s'assurer que les documents requis sont
	#présent. touch va créer un document vide par définition. 
	touch /var/run/mysqld/mysqlf.pid
	#Peut être devoir créer le .sock requis dans le document.
	#touch /var/run/mysqld/mysqld.sock

	#Il faut créer la database et l'user mais pour cela il faut le faire directement à 
	#l'intérieur de mariaDB 
	#1. Crée une base de donnée qui aura le nom MARIADB_NAME;
	#2. Crée un user MARIADB_USER qui aura comme mot de passe MARIADB_PWD
	#3. Accorde tous les privilèges de la base de donné MARIADB_NAME à l'user MARIADB_USER
	#4. Applique les changements faits. 
	#J'ai pas mis de @localhost ou de '%' dans mon MARIADB_user voir si ça fonctionne 
	# mariadb -e "\
	# CREATE DATABASE $MARIADB_NAME;
	# CREATE USER '$MARIADB_USER' IDENTIFIED BY $MARIADB_PWD;
	# GRANT ALL PRIVILEGES ON $MARIADB_NAME.* TO '$MARIADB_USER';
	# FLUSH PRIVILEGES;"

	eval "echo \"$(cat /tmp/config.sql)\"" | mariadb -u root

	#Il faut protéger le root de mysql car on veut que l'user créer précédemment ait accès 
	#à la database créé mais pas à toutes les databases.
	mysqladmin -u root password $MARIADB_ROOT_PWD;

	#Je sais pas Pourquoi on arrête le service donc à voir ou à essayer //TO DO
	service mysql stop --datadir=/var/lib/mysql
	echo "TRY"
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





