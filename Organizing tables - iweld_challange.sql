 -- full challange available at https://github.com/iweld/SQL_Coding_Challenge.git


-- Going to start by creating every table and importing the data
CREATE SCHEMA IF NOT EXISTS import_data;

DROP TABLE IF EXISTS import_data.countries;


-- all data from countries.csv imported as text 
-- I'm already making sure the data is organized and following the expected pattern (DATA WRANGLING)
-- this means: No duplicates, No invalid characters, corrected spelling and format

CREATE TABLE import_data.countries(

	country_id INT GENERATED ALWAYS AS IDENTITY,
	country_name TEXT,
	country_code_2 TEXT,
	country_code_3 TEXT,
	region TEXT,
	sub_region TEXT,
	intermediate_region TEXT,
	created_on DATE,
	PRIMARY KEY (country_id)
);



COPY import_data.countries(
	country_name,
	country_code_2,
	country_code_3,
	region,
	sub_region,
	intermediate_region
)
FROM '/home/laslus/SQL_Coding_Challenge/source_data/csv_data/countries.csv'
WITH DELIMITER ',' CSV HEADER;

--now to create the organized version of this data:

CREATE SCHEMA IF NOT EXISTS organized_data;
DROP TABLE IF EXISTS organized_data.countries CASCADE;

CREATE TABLE organized_data.countries(
	country_id INT NOT NULL,
	country_name TEXT,
	country_code_2 VARCHAR(2) NOT NULL,
	country_code_3 VARCHAR(3) NOT NULL,
	region TEXT,
	sub_region TEXT,
	intermediate_region TEXT,
	created_on DATE,
	PRIMARY KEY (country_id)
);

INSERT INTO organized_data.countries(
	country_id,
	country_name,
	country_code_2,
	country_code_3,
	region,
	sub_region,
	intermediate_region,
	created_on
)
-- trim() removes extra spaces from before or after the text
-- lower() puts everything in lowercase
-- regexp_replace(a, b, c, d) replaces b with c (in our case, replaces special characters with nothing aka delete them)
-- where a is the original string and d are flags (i - case insensitive)
-- in particular b = [^\w\s^.] -> anything that ISNT \w (any word/number/underscore), \s (whitespace), ^ (the character ^) and . (literal dot)
SELECT
	original.country_id,
	trim(lower(regexp_replace(original.country_name, '[^\w\s^.]', '', 'i'))),
	trim(lower(regexp_replace(original.country_code_2, '[^\w\s^.]', '', 'i')))::varchar,
	trim(lower(regexp_replace(original.country_code_3, '[^\w\s^.]', '', 'i')))::varchar,
	trim(lower(regexp_replace(original.region, '[^\w\s^.]', '', 'i'))),
	trim(lower(regexp_replace(original.sub_region, '[^\w\s^.]', '', 'i'))),
	trim(lower(regexp_replace(original.intermediate_region, '[^\w\s^.]', '', 'i'))),
	current_date
FROM
	import_data.countries AS original;

--repeat the process for every file
DROP TABLE IF EXISTS import_data.cities;

CREATE TABLE import_data.cities(
	city_id INT GENERATED ALWAYS AS IDENTITY,
	city_name TEXT,
	latitude TEXT,
	longitude TEXT, 
	country_code_2 TEXT,
	capital TEXT,
	population TEXT,
	insert_date TEXT,
	PRIMARY KEY(city_id)		-- lower() function converts all characters to lowercase.

);

COPY import_data.cities(
	city_name,
	latitude,
	longitude,
	country_code_2,
	capital,
	population,
	insert_date

)

FROM '/home/laslus/SQL_Coding_Challenge/source_data/csv_data/cities.csv'
WITH DELIMITER ',' CSV HEADER;

DROP TABLE IF EXISTS organized_data.cities;
CREATE TABLE organized_data.cities(
	city_id INT NOT NULL,
	city_name TEXT,
	latitude FLOAT,
	-- FIX 8: "floa" -> "float"
	longitude FLOAT,
	country_code_2 VARCHAR(2) NOT NULL,
	capital BOOLEAN,
	population INT,
	insert_date DATE,
	PRIMARY KEY(city_id)	
);

INSERT INTO organized_data.cities(
	city_name,
	latitude,
	longitude,
	country_code_2,
	capital,
	population,
	insert_date
)
	SELECT 
		original.city_id,
		trim(lower(regexp_replace(original.city_name, '[^\w\s^.]', '', 'i'))),
		original.longitude::float,
		original.latitude::float,
		trim(lower(regexp_replace(original.country_code_2, '[^\w\s^.]', '', 'i')))::varchar,
		original.capital::boolean,
		original.population::int,
		original.insert_date::date
	FROM
		import_data.cities as original;




DROP TABLE IF EXISTS import_data.currencies;

CREATE TABLE import_data.currencies(
	currency_id INT GENERATED ALWAYS AS IDENTITY,
	country_code_2 TEXT,
	currency_name TEXT,
	currency_code TEXT,
	PRIMARY KEY (currency_id)
);

COPY import_data.currencies(
	country_code_2,
	currency_name,
	currency_code
)
FROM '/home/USER/SQL_Coding_Challenge/source_data/csv_data/currencies.csv'
WITH DELIMITER ',' CSV HEADER;

DROP TABLE IF EXISTS organized_data.currencies;
CREATE TABLE organized_data.currencies(
	currency_id INT,
	country_code_2 VARCHAR(2) NOT NULL,
	currency_name TEXT,
	currency_code TEXT,
	PRIMARY KEY (currency_id)
);

INSERT INTO organized_data.currencies(
	currency_id,
	country_code_2,
	currency_name,
	currency_code
)
SELECT
	original.currency_id,
		trim(lower(regexp_replace(original.country_code_2, '[^\w\s^.]', '', 'i')))::varchar,
		trim(lower(regexp_replace(original.currency_name, '[^\w\s^.]', '', 'i'))),
	trim(lower(regexp_replace(original.currency_code, '[^\w\s^.]', '', 'i')))
FROM
	import_data.currencies AS original;

DROP TABLE IF EXISTS import_data.languages;

CREATE TABLE import_data.languages(
	languague_id INT GENERATED ALWAYS AS IDENTITY,
	language TEXT,
	country_code_2 TEXT,
	PRIMARY KEY (languague_id)

);

COPY import_data.languages(
	language,
	country_code_2
)
FROM '/home/USER/SQL_Coding_Challenge/source_data/csv_data/languages.csv'
WITH DELIMITER ',' CSV HEADER;

DROP TABLE IF EXISTS organized_data.languages;
CREATE TABLE organized_data.languages(
	languague_id INT,
	language TEXT,
	country_code_2 VARCHAR(2) NOT NULL,
	PRIMARY KEY (languague_id)
);

INSERT INTO organized_data.languages(
	languague_id,
	language,
	country_code_2
)
SELECT
	original.languague_id,
	trim(lower(regexp_replace(original.language, '[^\w\s^.]', '', 'i'))),
	trim(lower(regexp_replace(original.country_code_2, '[^\w\s^.]', '', 'i')))::varchar
FROM
	import_data.languages AS original;
