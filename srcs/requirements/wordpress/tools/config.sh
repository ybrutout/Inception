#Je commence pas par mettre la même condition car j'ai l'impression que ça set le port mais moi je set 
#ca dans le docker-compose (je crois) //TO DO
grep -E "/etc/php/7.3/fpm/pool.d/www.conf" > /dev/null 2>&1


#Il faut changer le dossier de configuration mais à la place de le changer tout on va le supprimer 
#pour en regénérant un avec nos valeurs
rm -rf /var/www/html/wordpress/wp-config.php
wp config create --dbname=$DATABASE_NAME \
		--dbuser=$DATABASE_USER \
		--dbpass=$DATABASE_PWD \
		--dbhost=$DATABASE_HOST \
		--path="/var/www/html/wordpress/" \
		--allow-root \
		--skip-check

#si wordpress n'est pas encore correctement installé
if ! wp core is-installed --allow-root; then
	wp core install --url="$WP_URL" \
					--title="$WP_TITLE" \
					--admin_user="$WP_ADMIN_USER" \
					--admin_password="$WP_ADMIN_PWD" \
					--admin_email="$WP_ADMIN_EMAIL" \
					--skip-email \
					--allow-root

    #création d'un utilisateur de test
    wp user create $WP_USER $WP_USER_EMAIL  --role=editor \
                                            --user_pass=$WP_USER_PWD \
                                            --allow-root

    #J'essaye de télécharger un autre thèmes voir si ça fonctionne //TO DO
    wp theme install Signify Dark --activate --allow-root
fi

#Moi j'ai pas update wordpress apres voir si ca crée des problemes //TO DO
wp plugin update --all --allow-root

#On va lancer Wordpress avec la fastCGI et qu'il tourne en arrière plan 
php-fpm7.3 --nodaemonize