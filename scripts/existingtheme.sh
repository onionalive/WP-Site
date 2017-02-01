#!/bin/bash
read -r -p "What is the name of the theme you are using?" THEMENAME
cd ..
mkdir ./wp-content/themes/${THEMENAME}
rsync -arv --exclue 'js' --exclude 'css' /theme-src /wp-content/themes/${THEMENAME}/
