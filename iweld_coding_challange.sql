 -- full challange available at https://github.com/iweld/SQL_Coding_Challenge.git


-- Goint to start by creating every table and importing the data
CREATE SCHEMA if not exists import_data;

DROP TABLE if exists import_data.countries;


-- all data from countries.csv imported as text 
-- I'm already making sure the data is organized and following the expected pattern (DATA WRANGLING))
-- this means: No duplicates, No invalid characters, corrected speling and format

CREAT TABLE import_data.countries(

	country_id INT generated ALWAYS AS IDENTITY,
	country_name TEXT,
	country_code_2 TEXT,
	country_code_3 TEXT,
	region TEXT,
	sub_region TEXT,
	intermediate_region TEXT,
	created_on DATE,
	PRIMARY KEY (country_id)

)



COPY import_data.countries(
	country_name,
	country_code_2,
	country_code_3,
	region,
	sub_region,
	intermediate_region
)

FROM /home/USER/SQL_Coding_Challenge/source_data/csv_data/countries.csv

WITH DELIMITER ',' HEADER CSV;

--now to create the organized version of this data:

CREATE SCHEMA if NOT EXISTS organized_data; -- organized_data
DROP TABLE IF EXISTS organized_data.countries CASCADE;

CREATE TABLE organized_data.countries(
	country_id INT NOT null,
	country_name TEXT,
	country_code_2 varchar(2) NOT null,
	country_code_3 varchar(3) NOT null,
	region TEXT,
	sub_region TEXT,
	intermediate_region TEXT,
	created_on DATE,
	PRIMARY KEY (country_id)
)

INSERT INTO organized_data.countries(
	country_id,
	country_name,
	country_code_2,
	country_code_3,
	region,
	sub_region,
	intermediate_region ,
	created_on,
	PRIMARY KEY (country_id)

)
-- trim() removes extra spaces from before or after the text
-- lower() puts everything in lowercase
-- regex_replace(a, b, c, d) replace b for c (in our case, replace specil characters with nothing aka delete them)
-- where a is the original strin and d are flags (i - case insensitive, )
-- in particular c = [^\w\s^.] -> anything that ISNT \w (any word/number/undercore), \s (whitespace), ^(the character ^) and . (literal dot)
(SELECT
	original.country_id,
	trim(lower(regexp_replace(original.country_name, '[^\w\s^.]', '', 'i'))),
	trim(lower(regexp_replace(original.country_code_2, '[^\w\s^.]', '', 'i'))::varchar,
	trim(lower(regexp_replace(original.country_code_3, '[^\w\s^.]', '', 'i')))::varchar,
	trim(lower(regexp_replace(original.region, '[^\w\s^.]', '', 'i'))),
	trim(lower(regexp_replace(original.sub_region, '[^\w\s^.]', '', 'i'))),
	trim(lower(regexp_replace(original.intermediate_region, '[^\w\s^.]', '', 'i'))),
	curent_date
	FROM
		import_data.countries as original
)

--repeat the process for every file
DROP TABLE if exists import_data.cities;

CREATE TABLE import_data.cities(
	city_id INT GENERATED ALWAYS as IDENTITY,
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

FROM /home/USER/SQL_Coding_Challenge/source_data/csv_data/cities.csv
WITH DELIMITER ',' HEADER CSV;

DROP TABLE IF EXISTS organized_data.cities;
CREATE TABLE organized_data.cities(
	city_id INT NOT null,
	city_name TEXT,
	latitude float,
	longitude floa, 
	country_code_2 varchar(2)NOT null,
	capital boolean,
	population int,
	insert_date date,
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

)(

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
		import_data.cities as original
)



DROP TABLE if exists import_data.currencies;

CREATE TABLE import_data.currencies(
	curency_id INT GENERATED ALWAYAS as IDENTITY,
	country_code_2 TEXT,
	currency_name TEXT,
	currency_code TEXT,
	PRIMARY KEY (curency_id)
);

FROM /home/USER/SQL_Coding_Challenge/source_data/csv_data/currencies.csv
WITH DELIMITER ',' HEADER CSV;

DROP TABLE IF EXISTS organized_data.currencies;
CREATE TABLE organized_data.currencies(
	currency_id int,
	country_code_2 varchar(2) NOT NULL,
	currency_name TEXT,
	currency_code TEXT,
	PRIMARY KEY (currency_id)
)

INSERT INTO organized_data.currencies(
	curency_id.
	country_code_2,
	currency_name,
	currency_code

)(
	SELECT
		original.curency_id,
		trim(lower(regexp_replace(original.country_code_2, '[^\w\s^.]', '', 'i')))::varchar,
		trim(lower(regexp_replace(original.currency_name, '[^\w\s^.]', '', 'i'))),
		trim(lower(regexp_replace(original.currency_code, '[^\w\s^.]', '', 'i'))),
	FROM
		import_data.currencies as original

)

DROP TABLE if exists import_data.languages;

CREATE TABLE import_data.languages(
	languague_id INT GENERATED ALWAYS as IDENTITY,
	language TEXT,
	country_code_2 TEXT,
	PRIMARY KEY (languague_id)

);
FROM /home/USER/SQL_Coding_Challenge/source_data/csv_data/languages.csv
WITH DELIMITER ',' HEADER CSV;

DROP TABLE if exists organized_data.languages;
CREATE TABLE organized_data.language(
	languague_id INT,
	language TEXT,
	country_code_2 varchar(2)NOT null,
	PRIMARY KEY (languague_id)
);

INSERT INTO organized_data.languages(
	languague_id,
	language,
	country_code_2
)(
	SELECT
		original.languague_id
		trim(lower(regex_replace(original.language,'[^\w\s^.]', '', 'i'))),
		trim(lower(regexp_replace(original.country_code_2, '[^\w\s^.]', '', 'i')))::varchar,
	FROM
		import_data.languages AS original
)
