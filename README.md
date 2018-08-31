# Example

docker run --rm -d -v $PWD:/app --name example-api -p 80:80 marcmnix/php7-mongo bin/console server:run "*localhost:80"
