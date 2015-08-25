# Nginx Docker Image with GeoIP 2 Support

Build container:

    ./scripts/docker-build.sh

Usage:

    FROM czerasz/nginx-geoip2:1.9.4

    # Add GeoIP configuration file to enable GeoIP 2 variables
    ADD ./config/geoip2.conf /etc/nginx/conf.d/geoip2.conf

Run container:

    docker run -d --name='nginx-geoip2-test' 'czerasz/nginx-geoip2:1.9.4'

## Test

    ./test/test.sh