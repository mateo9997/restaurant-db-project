FROM mysql:latest
ENV MYSQL_DATABASE=restaurantdb
ENV MYSQL_ROOT_PASSWORD=yourpassword
ADD ../scripts/setup.sql /docker-entrypoint-initdb.d
EXPOSE 3306