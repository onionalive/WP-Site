#!/bin/bash
read -r -p "Database name: " database_name
read -r -p "Database User: " database_user
read -r -p "Database Password: " database_pw

echo "Awesome, updating wp-config with this information."

sed -ie "s/database_name_here/$databasename/g" testfile.php
sed -ie "s/database_name_here/$databasename/g" testfile.php
sed -ie "s/database_name_here/$databasename/g" testfile.php
