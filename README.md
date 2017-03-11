# Continuous Delivery w/ Docker
Setup a complete continuous deployment configuration on a single docker host using Docker Compose.

## Features:

- Reverse proxy using jwilder's nginx-proxy
- LetsEncrypt TLS config using letsencrypt-nginx-proxy-companion
- Building the services using Jenkins and a Docker-In-Docker Slave
- Authentication for the private registry using port.us
- Watch for changes in the private registry using watchtower

## Setup / Config:

1. ```
   cd infrastructure
   vim .env				# Configure your environment
   ./setup.sh 				# Creates the config files used by the compose
   docker-compose up -d
   ```

2. Configure port.us:

   - Create users
   - Create watchtower and builder user

3. Configure Jenkins:

   - Install the default plugins
   - Create users
   - Add the build slaves
   - Create the build jobs (poll SCM) w/ builder credentials

4. Configure Portainer

5. ```
   cd projects
   vim .env 				# Configure the watchtower / project
   docker-compose up -d	# Start the watchtower and service container to be watched
   docker network connect projects_default infrastructure_nginx_1 # Add the reverse proxy to the new network
   ```

6. Commit a change to the SCM and enjoy the magic.