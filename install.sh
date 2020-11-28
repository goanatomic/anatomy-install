#!/bin/bash
git submodule add https://github.com/goanatomic/anatomy-ac.git
git mv anatomy-ac ac

for item in anatomy make model remove; do
	chmod +x ac/$item
done

for item in index settings; do
	ac/model $item
	cp ac/library/$item.php $item.php
done

mkdir assets
mkdir assets/css && touch assets/css/.gitkeep
mkdir assets/img && touch assets/img/.gitkeep
mkdir assets/js && touch assets/js/client.js

mkdir embed
mkdir embed/client
touch embed/client/funcs.html
touch embed/client/vars.html
mkdir embed/client/layout
for item in footer head header; do
	touch embed/client/layout/$item.html
	echo "<cms:extends 'anatomy/layout/$item.html' />" >> embed/client/layout/$item.html
done

git submodule add https://github.com/goanatomic/anatomy.git
git submodule add https://github.com/goanatomic/anatomy-couch.git
git submodule add https://github.com/goanatomic/anatomy-filters.git
git submodule add https://github.com/goanatomic/anatomy-vendor.git

git mv anatomy embed/anatomy
git mv anatomy-couch admin
git mv anatomy-filters embed/filters
git mv anatomy-vendor vendor