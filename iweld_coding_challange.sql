 -- full challange available at https://github.com/iweld/SQL_Coding_Challenge.git

/*First I'll create the database, already adding an ID and DATE to the original .csv data */
CREATE TABLE Countries(
	country_id INTEGER PRIMARY KEY AUTOINCREMENT, -- ID autofills and increases
	country_name VARCHAR(35),
	country_code_2 VARCHAR(35),
	country_code_3 VARCHAR(35),
	region VARCHAR(35),
	sub_region VARCHAR(35),
	intermediate_region VARCHAR(35),
	created_on date
);

CREATE TABLE cities(

	city_id INTEGER PRIMARY KEY AUTOINCREMENT, 
	city_name VARCHAR(35),
	latitude INTEGER,
  longitude INTEGER,
	country_code VARCHAR(2),
	capital BOOLEAN,
	population INTEGER,
	created_on date
);

  CREATE TABLE curency(
    	-- Create an auto-incrementing, unique key for every row.  
    	-- This will also be used as our Primary Key.
    	city_id INTEGER PRIMARY KEY AUTOINCREMENT, 
          curency_name VARCHAR(35),
     	country_code VARCHAR(2),
    	curency_code VARCHAR(3),
    	created_on date
);

    CREATE TABLE language(
    	-- Create an auto-incrementing, unique key for every row.  
    	-- This will also be used as our Primary Key.
    	city_id INTEGER PRIMARY KEY AUTOINCREMENT, 
          language_name VARCHAR(35),
     	country_code VARCHAR(2),
    	created_on date
);


