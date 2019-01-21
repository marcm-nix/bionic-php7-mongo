# Examples

Copy PHP project and run webserver on localhost:8083
```
docker cp php_app/ /app
docker run --rm -d -p 8083:80 mmskl/bionic-php7.2-mongodb php -S 0.0.0.0:80
```

Symfony app with webserver installed. Volume's bind to `/app` which is default workdir. Expose port 80
```
docker run -v $PWD:/app mmskl/bionic-php7.2-mongodb composer install # to install dependencies
docker run -d -v $PWD:/app --name example_api --expose 80 marcmnix/php7-mongo bin/console server:run "0.0.0.0:80"
docker inspect example_api | grep -i ip # to get container IP
```
