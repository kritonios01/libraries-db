# libraries-db
Semester project for the 2023 DB course.
School of Electrical and Computer Engineering, NTUA

## Build Instructions
### Server Application
1. Download and install [Node.js](https://nodejs.org/).
2. Install the nodemon package (preferably globally in to your system):
	```shell
	$ npm install -g nodemon
	```
3. Install the required dependencies:
	```shell
    $ cd backend
	$ npm install
	```
4. Launch the server:
	```shell
	$ nodemon server.js
	```

### MariaDB Service
1. Download and install [MariaDB Server](https://mariadb.org/download/?t=mariadb&p=mariadb&r=11.1.0)
2. Start the server:
	```shell
	$ sudo systemctl start mariadb
	```
3. Create a schema in MariaDB:
	```shell
	$ mariadb -u root
    > create database libraries
	```
    > You can name your database however you want, but if you don't name it 'libraries' make sure to rename the schema constant in [backend/server.js](backend/server.js) appropriately
4. Run the following scripts in your shell:
	```shell
	$ mariadb -u root libraries < script.sql
    $ create database libraries < insert_data.sql
	```