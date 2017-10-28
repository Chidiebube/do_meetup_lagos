#!/usr/bin/env bash

# Script to install nginx and enable on boot.

sleep 30

echo "installing nginx"

# Exit when a command fails.
set -e

# Exit if previous command returns a non 0 status.
set -o pipefail 

# Show all commands being executed at each stage.
set -x

# Update instance and install nginx
update_system() {
    apt-get update -y
    apt-get upgrade -y
    apt-get install nginx -y
}

# Enable and start nginx service
start_nginx() {
    sudo systemctl enable nginx
    sudo systemctl start nginx
}

# Create new directories
create_directories() {
    mkdir /etc/nginx/vhost.d
    mkdir -p /var/www/html/newDomain
}


# Create a copy of original configuration files and import configuration
copy_config_files() {
    cp /etc/nginx/nginx.conf /etc/nginx/nginx.conf.original
    cp /tmp/nginx.conf.new /etc/nginx/nginx.conf
    cp /tmp/new_domain.conf /etc/nginx/vhost.d/new_domain.conf
    cp /tmp/index.html.new /var/www/html/newDomain/index.html
}

# Restart Nginx
restart_nginx() {
    systemctl restart nginx
}

# Execution starts here
main() {
    update_system
    start_nginx
    create_directories
    copy_config_files
    restart_nginx
}

main "$@"
 