create table Franchise
	(
	 fran_id INTEGER PRIMARY KEY NOT NULL,
	 fran_name	VARCHAR(50) NOT NULL UNIQUE,
     category VARCHAR(50) NOT NULL,
	 website VARCHAR(100) NOT NULL UNIQUE
	);
	
create table Manager
	(
	 manager_id INTEGER PRIMARY KEY NOT NULL,
	 manager_name VARCHAR(50) NOT NULL,
	 gender VARCHAR(10) NOT NULL,
	 salary INTEGER NOT NULL,
     email	VARCHAR(50) UNIQUE
	);
	
create table Outlet_details
	(
	 outlet_id INTEGER PRIMARY KEY NOT NULL,
	 manager_id INTEGER NOT NULL,
	 employee_count INTEGER NOT NULL,
     parking VARCHAR(20) NOT NULL,
	 FOREIGN KEY(manager_id)
	  	REFERENCES Manager(manager_id) ON DELETE CASCADE
	);
	
create table Outlet_location
	(
	 outlet_id INTEGER PRIMARY KEY NOT NULL,
	 fran_id INTEGER NOT NULL,
	 street_address VARCHAR(500) NOT NULL,
	 zipcode INTEGER NOT NULL,
	 contact BIGINT UNIQUE NOT NULL,
	 FOREIGN KEY(fran_id)
	  		REFERENCES Franchise(fran_id) ON DELETE CASCADE
	);
	
create table City
	(
	 zipcode INTEGER PRIMARY KEY NOT NULL,
	 city VARCHAR(50) NOT NULL,
	 state VARCHAR(50) NOT NULL
	);
	
create table Sales
	(
	 sales_id INTEGER PRIMARY KEY NOT NULL,
	 fran_id INTEGER NOT NULL,
	 total_sale DECIMAL(10,2) NOT NULL,
	 total_count DECIMAL(10,2) NOT NULL,
	 average DECIMAL(10,2) NOT NULL,
	 FOREIGN KEY(fran_id)
	  	REFERENCES Franchise(fran_id) ON DELETE CASCADE
	);

create table Audit 
	(
	 id integer, 
	 insert_date Date
	);
	