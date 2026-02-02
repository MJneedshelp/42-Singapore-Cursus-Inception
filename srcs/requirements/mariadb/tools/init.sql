CREATE DATABASE IF NOT EXISTS wordpress;
CREATE USER 'wp_user'@'%' IDENTIFIED BY 'dummy';
GRANT ALL PRIVILEGES ON wordpress.* TO 'wp_user'@'%';
