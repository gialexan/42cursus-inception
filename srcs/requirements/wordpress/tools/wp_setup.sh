#!/usr/bin/env bash

# habilitar alias
shopt -s expand_aliases

# apelido paracomando root
alias wp='wp --allow-root'

wp core download --locale="pt_BR"

wp config create \
	  	--dbname="$WP_DB_NAME" \
	    --dbuser="$WP_DB_USER" \
	    --dbpass="$WP_DB_PASSWORD" \
		--dbhost=mariadb \
		--dbprefix="wp_"

wp core install \
		--url="$DOMAIN_NAME" \
	    --title="Inception" \
		--admin_user="$WP_DB_USER" \
		--admin_password="$WP_DB_PASSWORD" \
		--admin_email="$WP_DB_EMAIL" \
		--skip-email

wp user create "$WP_GUEST_USER" "$WP_GUEST_EMAIL" \
	  	--user_pass="$WP_GUEST_PASSWORD" \
	    --role=subscriber \
	    --porcelain

wp theme activate twentytwentytwo

# executar php-fpm
exec "$@"