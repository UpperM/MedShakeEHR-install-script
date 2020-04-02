ehrInstallFolder="/home/ehr"
echo "Installation des paquets nécessaires"
apt install apache2 php7.3 mariadb-server git pdftk imagemagick ghostscript -y
apt install php7.3-gd php7.3-intl php7.3-zip php7.3-xml php7.3-imagick php7.3-imap php7.3-soap php7.3-xml php7.3-mbstring php7.3-curl php7.3-mysql -y

# Update PHP Config
echo "Update PHP configuration"
phpConfig="/etc/php/7.3/apache2/php.ini"

phpUploadMaxFilesize="upload_max_filesize = 2M"
ehRUploadMaxFilesize="upload_max_filesize = 25M"

phpMaxInputVars="max_input_vars = 1000"
ehRMaxInputVars="max_input_vars = 20000"

phpPostMaxSize="post_max_size = 8M"
ehrPostMaxSize="post_max_size = 25M"

sed -i -e "s/${phpUploadMaxFilesize}/${ehRUploadMaxFilesize}/g" ${phpConfig}
sed -i -e "s/${phpMaxInputVars}/${ehRMaxInputVars}/g" ${phpConfig}
sed -i -e "s/${phpPostMaxSize}/${ehrPostMaxSize}/g" ${phpConfig}

echo "Création du repertoire web"
mkdir -p "${ehrInstallFolder}/public_html/"
cd "${ehrInstallFolder}/public_html/"

echo "Récupération du script d'installation sur Github"
wget https://raw.githubusercontent.com/MedShake/MedShakeEHR-base/master/installer/self-installer.php

echo "Ajout des droits à www-data sur le repertoire ${ehrInstallFolder}"

chmod -R 775 ${ehrInstallFolder}
chown -R www-data:www-data ${ehrInstallFolder}

echo "Désactivation du site par défaut d'Apache2"
a2dissite 000-default

echo "Création du fichier de configuration apache2 pour EHR"
echo '
<VirtualHost *:80>
	DocumentRoot "/home/ehr/public_html"
	ErrorLog ${APACHE_LOG_DIR}/error_ehr.log
	CustomLog ${APACHE_LOG_DIR}/access_ehr.log combined

	<Directory "/home/ehr/public_html">
			Options Indexes FollowSymLinks
			AllowOverride All
			Require all granted
	</Directory>
</VirtualHost>
' > /etc/apache2/sites-available/ehr.conf

echo "Activiation du site et des modules"
a2ensite ehr
a2enmod rewrite
a2enmod headers
systemctl restart apache2

echo "#############################################"
echo "########### INSTALLATION TERMINEE  ##########"
echo "#############################################"
echo "Veuillez accèder à http://localhost/self-installer.php"
echo "Indiquer ${ehrInstallFolder} comme répertoire d’installation"
