#!/bin/bash

# Install Anatomy scripts
git submodule add https://github.com/goanatomic/anatomy-ac.git ac

# Make Anatomy scripts executable
for item in anatomy make model remove; do
	chmod +x ac/$item
done

# Model Index and Settings templates
for item in index settings; do
	ac/model $item
	cp ac/library/$item.php $item.php
done

# Make assets folder
mkdir assets
mkdir assets/css && touch assets/css/.gitkeep
mkdir assets/img && touch assets/img/.gitkeep
mkdir assets/js && touch assets/js/client.js

# Make embed folder with .htaccess
mkdir embed
touch embed/.htaccess
echo "deny from all" >> embed/.htaccess

# Create client folder
mkdir embed/client
mkdir embed/client/css
# client css
for item in base layout modules typography vars; do
	touch embed/client/css/$item.css;
done
touch embed/client/funcs.html
touch embed/client/vars.html
# client layout
mkdir embed/client/layout
for item in footer head header; do
	touch embed/client/layout/$item.html
	echo "<cms:extends 'anatomy/layout/$item.html' />" >> embed/client/layout/$item.html
done

# Add other Anatomy submodules
git submodule add git@github.com:goanatomic/anatomy.git embed/anatomy
git submodule add git@github.com:goanatomic/anatomy-couch.git admin
git submodule add git@github.com:goanatomic/anatomy-filters.git embed/filters
git submodule add git@github.com:goanatomic/anatomy-vendor.git vendor



# Self destruct && touch new config files
rm -rf anatomy-install
cp admin/config.example.php admin/config.php
cp admin/addons/kfunctions.example.php admin/addons/kfunctions.php
if sublime &> /dev/null
then
	sublime admin/config.php
	sublime admin/addons/kfunctions.php
fi