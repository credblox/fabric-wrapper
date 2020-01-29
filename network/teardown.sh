#!/bin/bash
#
# Exit on first error, print all commands.

# Shut down the Docker containers for the system tests.
cd "$(dirname "$0")"
docker-compose -f docker-compose.yml kill && docker-compose -f docker-compose.yml down
if [ "$(docker ps -aq)" ]; then
	docker rm -f $(docker ps -aq)
fi

# remove chaincode docker images
if [ "$(docker images dev-* -q)" ]; then
	docker rmi $(docker images dev-* -q)
fi

# Your system is now clean
echo -e "\nNetwork teardown completed!!\n"