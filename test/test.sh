#!/bin/bash

script_dirirectory="$( cd "$( dirname "$0" )" && pwd )"
project_dirirectory=$script_dirirectory/..

container_name='czerasz-nginx-geoip2-test'
docker_version=$(docker -v)

# Build Docker container
$project_dirirectory/scripts/docker-build.sh

# Test for the proper Docker version
if [[ `echo "$docker_version" | grep '^Docker version 1\.[89]'` ]]; then
  echo 'Right Docker version is installed'
else
  echo 'Error: Docker > 1.8 required'
  exit 1;
fi

# Remove the old Docker container
if [ `docker ps -a --format '{{.Names}}' | grep "$container_name"` ]; then
  docker rm -f "$container_name";
fi

docker run --name="$container_name" \
           -v $project_dirirectory/config/geoip2.conf:/etc/nginx/conf.d/geoip2.conf \
           -d 'czerasz/nginx-geoip2:1.9.4'

#-->BEGIN: Test if Nginx returns the right headers
container_ip=$(docker inspect -f '{{.NetworkSettings.IPAddress}}' "$container_name")

if [[ `curl $container_ip -s -D - :80 -o /dev/null | grep '^X-COUNTRY-CODE'` ]]; then
  echo 'Test pass: X-COUNTRY-CODE'
else
  exit 1
fi

if [[ `curl -s -D - $container_ip:80 -o /dev/null | grep 'X-COUNTRY-NAME'` ]]; then
  echo 'Test pass: X-COUNTRY-NAME'
else
  exit 1
fi

if [[ `curl -s -D - $container_ip:80 -o /dev/null | grep 'X-CITY-NAME'` ]]; then
  echo 'Test pass: X-CITY-NAME'
else
  exit 1
fi
#-->END: Test if Nginx returns the right headers

# Clean environment
docker stop "$container_name";
docker rm "$container_name";
