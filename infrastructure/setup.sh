#!/bin/bash

# Load the environment variables
source .env

# Configure NGiNX Reverse Proxy for Portainer
mkdir -p ./config/nginx-proxy
touch ./config/nginx-proxy/portainer.git-init.org_location
echo "proxy_set_header Upgrade \$http_upgrade;" >> ./config/nginx-proxy/portainer.git-init.org_location
echo "proxy_set_header Connection \"upgrade\";" >> ./config/nginx-proxy/portainer.git-init.org_location
echo "proxy_set_header Connection \$http_connection;" >> ./config/nginx-proxy/portainer.git-init.org_location

# Disable NGiNX Reverse Proxy request body size restriction
touch ./config/nginx-proxy/registry-proxy.conf
echo "client_max_body_size 0;" >> ./config/nginx-proxy/registry-proxy.conf

# Fix Jenkins volume permissions
mkdir -p ./volumes/jenkins
sudo chown -R 1000:1000 ./volumes/jenkins

# Create the certs for the registry
mkdir -p ./config/registry/certs
openssl req -new -newkey rsa:4096 -days 365 -subj "/CN=registry.${DOMAINNAME}" -nodes -x509 -keyout ./config/registry/certs/registry.key -out ./config/registry/certs/registry.crt
