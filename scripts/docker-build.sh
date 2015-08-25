#!/bin/bash

script_dirirectory="$( cd "$( dirname "$0" )" && pwd )"
project_dirirectory=$script_dirirectory/..

cd $project_dirirectory

docker build --tag="czerasz/nginx-geoip2:1.9.4" .