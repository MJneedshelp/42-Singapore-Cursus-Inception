-- Update the db root user with the db root password
ALTER USER 'root'@'localhost' IDENTIFIED BY '__DB_ROOT_PASSWORD__';

-- Create the db only if it does not exist. E.g. created in the previous run
-- and the volume still persist
CREATE DATABASE IF NOT EXISTS __DB_NAME__;

-- Create the wp admin user if it is not created yet and grant privileges
-- to this user
CREATE USER IF NOT EXISTS '__DB_USER__'@'%' IDENTIFIED BY '__DB_PASSWORD__';
GRANT ALL PRIVILEGES ON __DB_NAME__.* TO '__DB_USER__'@'%';

-- Refresh to apply the privileges. Technically don't need since GRANT will
-- already apply the privileges immediately
FLUSH PRIVILEGES;
