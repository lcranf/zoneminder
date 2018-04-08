#!/bin/bash

set -e

# Create events folder
if [ ! -d /var/cache/zoneminder/events ]; then
	echo "Create events folder"
	mkdir /var/cache/zoneminder/events
	chown -R root:www-data /var/cache/zoneminder/events
	chmod -R 777 /var/cache/zoneminder/events
else
	echo "Using existing data directory for events"

	# Check the ownership on the /var/cache/zoneminder/events directory
	if [ `stat -c '%U:%G' /var/cache/zoneminder/events` != 'root:www-data' ]; then
		echo "Correcting /var/cache/zoneminder/events ownership..."
		chown -R root:www-data /var/cache/zoneminder/events
	fi

	# Check the permissions on the /var/cache/zoneminder/events directory
	if [ `stat -c '%a' /var/cache/zoneminder/events` != '777' ]; then
		echo "Correcting /var/cache/zoneminder/events permissions..."
		chmod -R 777 /var/cache/zoneminder/events
	fi
fi

# Create images folder
if [ ! -d /var/cache/zoneminder/images ]; then
	echo "Create images folder"
	mkdir /var/cache/zoneminder/images
	chown -R root:www-data /var/cache/zoneminder/images
	chmod -R 777 /var/cache/zoneminder/images
else
	echo "Using existing data directory for images"

	# Check the ownership on the /var/cache/zoneminder/images directory
	if [ `stat -c '%U:%G' /var/cache/zoneminder/images` != 'root:www-data' ]; then
		echo "Correcting /var/cache/zoneminder/images ownership..."
		chown -R root:www-data /var/cache/zoneminder/images
	fi

	# Check the permissions on the /var/cache/zoneminder/images directory
	if [ `stat -c '%a' /var/cache/zoneminder/images` != '777' ]; then
		echo "Correcting /var/cache/zoneminder/images permissions..."
		chmod -R 777 /var/cache/zoneminder/images
	fi
fi

# Create temp folder
if [ ! -d /var/cache/zoneminder/temp ]; then
	echo "Create temp folder"
	mkdir /var/cache/zoneminder/temp
	chown -R root:www-data /var/cache/zoneminder/temp
	chmod -R 777 /var/cache/zoneminder/temp
else
	echo "Using existing data directory for temp"

	# Check the ownership on the /var/cache/zoneminder/temp directory
	if [ `stat -c '%U:%G' /var/cache/zoneminder/temp` != 'root:www-data' ]; then
		echo "Correcting /var/cache/zoneminder/temp ownership..."
		chown -R root:www-data /var/cache/zoneminder/temp
	fi

	# Check the permissions on the /var/cache/zoneminder/temp directory
	if [ `stat -c '%a' /var/cache/zoneminder/temp` != '777' ]; then
		echo "Correcting /var/cache/zoneminder/temp permissions..."
		chmod -R 777 /var/cache/zoneminder/temp
	fi
fi