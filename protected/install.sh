#!/bin/bash

git submodule update --init --recursive
chmod -R 777 protected/runtime/ assets/ uploads/ thumbs/
cd protected/vendors/restler/ &&  composer update
cd ../../..
cp protected/config/example.custom.php protected/config/custom.php
read -p "Press [Enter] key to start edit config file..."
vim protected/config/custom.php
php protected/yiic dbworker load
echo 'YiiBoilerplate installed!'

