SWITCHING TO AND FROM THE POSTGRESQL INTERFACE

To enter the PostgreSQL terminal, enter the command:
sudo -u postgres psql postgres

To exit the PostgreSQL terminal and return to the normal Bash terminal, enter the command:
\q

POSTGRESQL COMMANDS (to be entered from the PostgreSQL terminal)

View help:
\?

Create the user "user1" with password "password1" and the ability to create databases:
sudo -u postgres psql -c"CREATE ROLE user1 WITH CREATEDB LOGIN PASSWORD 'password1';"

Create the database "database1" with user "user1" as the owner:
sudo -u postgres psql -c"CREATE DATABASE database1 WITH OWNER=user1;"

View list of PostgreSQL users:
\du

View list of PostgreSQL databases:
\list

Connect to database "database1":
\connect database1

List tables in database "database1":
\dt

Disconnect from "database1":
\disconnect

Destroy the table "pupils" in "database1"
DROP TABLE pupils;

Destroy the database "database1":
DROP DATABASE database1;

Remove the user "user1":
DROP USER user1;
