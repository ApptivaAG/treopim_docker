#!/usr/bin/env bash
set -e

echo "claiming data directories"
chown -R www-data:www-data /var/www/html
chown -R www-data:www-data /var/log/docker

cd /var/www/html

if [ "$(ls /var/www/html)" ]; then
	echo "Already installed"
else
	echo "Installing..."
  sudo -u www-data composer create-project treolabs/skeleton ./ --no-dev --prefer-dist &&
	sudo -u www-data composer require --no-update treolabs/pim:* && sudo -u www-data composer update --no-dev
	sudo -u www-data chmod +x ./bin/cron.sh
	cp vendor/treolabs/treocore/copy/bin/* bin/
  echo "Installation complete"
fi

printf "* * * * * /var/www/html/bin/cron.sh process-treocore /usr/local/bin/php\n" | crontab -u www-data -

service apache2 start
service cron start
exec "$@"
