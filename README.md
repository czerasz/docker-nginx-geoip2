# Nginx Docker Image with GeoIP 2 Support

[![](https://imagelayers.io/badge/czerasz/nginx-geoip2:latest.svg)](https://imagelayers.io/?images=czerasz/nginx-geoip2:latest 'Get your own badge on imagelayers.io')

## Usage

```bash
docker run -d --name=nginx czerasz/nginx-geoip2:latest
```

Or use in `Dockerfile`:

```
FROM czerasz/nginx-geoip2:latest

# Add GeoIP configuration file to enable GeoIP 2 variables
ADD ./config/geoip2.conf /etc/nginx/conf.d/geoip2.conf
```

## Test

Build container:

    ./scripts/docker-build.sh

Run tests:

    ./test/test.sh
