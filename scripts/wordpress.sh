#!/bin/bash
# This script sets up wordpress and connects it to the database
# it should be ran AFTER
# Git clone, npm install, and bower have been run
echo ""
echo ""
echo "moving around necessary files..."
#Move .htaccess file
cp ../wp/.htaccess ../.htaccess

# if wp-config is sample rename without sample
# otherwise will do nothing
mv ../wp/wp-config-sample.php ../wp/wp-config.php
echo "Done!"
echo ""
read -r -p "What is the site/theme name?" site_name ; echo ""
sed -ie "s/site_name/${site_name}/g" ../gulpfile.js

# Create database to connect wordpress to
echo "*////////////////////////////////////////////////////////"
echo "*               Wordpress Setup                        *"
echo "*///////////////////////////////////////////////////////"
echo ""
echo "Let's get the information for the database to connect to"
echo ""
read -r -p "Database name: " database_name
read -r -p "Database User: " database_user
read -s -p "Database Password: " database_pw

echo ""
echo "Awesome, updating wp-config with this information."
echo ""

# update wp-config with  correct databse details
sed -ie "s/database_name_here/$database_name/g" ../wp/wp-config.php
sed -ie "s/username_here/$database_user/g" ../wp/wp-config.php
sed -ie "s/password_here/$database_pw/g" ../wp/wp-config.php
echo "connecting to $database_name"
echo "using user: $database_user..."
echo ""


# update wp-config to point to
# correct directory
sed -i "40i define( 'WP_CONTENT_DIR', dirname(dirname(__FILE__)) . '/wp-content' );" ../wp/wp-config.php
sed -i "41i define( 'WP_CONTENT_URL', 'http://localhost/extra/wp-site/wp-content' );" ../wp/wp-config.php
echo "Done, grabbing salts from wordpress API and applying to config"
echo ""

#create hashes for wp-config
#set WP salts
SALTS=$(curl -s https://api.wordpress.org/secret-key/1.1/salt/)
while read -r SALT; do
SEARCH="define('$(echo "$SALT" | cut -d "'" -f 2)"
REPLACE=$(echo "$SALT" | cut -d "'" -f 4)
echo "... $SEARCH ... $SEARCH ..."
sed -i "/^$SEARCH/s/put your unique phrase here/$(echo $REPLACE | sed -e 's/\\/\\\\/g' -e 's/\//\\\//g' -e 's/&/\\\&/g')/" ../wp/wp-config.php
done <<< "$SALTS"

# Download timber blank starter theme
echo ""
read -r -p "Are you using an existing theme? [y/n]" existingtheme
if [[ $existingtheme = y ]] ; then
	echo ""
	echo "Setting up the existing theme..." ; echo ""
	bash existingtheme.sh
	echo "Done!" ; echo ""
else
read -r -p "Do you want to download the timber starter theme? [y/n]" startertheme
if [[ $startertheme = y ]] ; then
	cd ..
	mkdir -p wp-content/themes
	cd wp-content/themes
	git clone https://github.com/timber/starter-theme
	echo ""
	echo "Awesome! The theme was installed in /wp-config/themes/"
	echo ""
	echo "Just let me add the JS to the theme and we should be good to go..."
	sed -i '1i <script src="{{site.theme.link}}/main.js" type="text/javascript">' ./starter-theme/templates/footer.twig
fi
fi

echo ""
echo "Done, wp-config should be updated."
echo "Dont forget to turn on timber and switch to the correct theme in the WP admin"
echo ":^)"
