CREATE TABLE location (
	id serial primary key,
	city TEXT,
	state TEXT,
	country TEXT
);

CREATE TABLE interest (
	id serial primary key,
	title TEXT
);

CREATE TABLE person (
	id serial primary key,
	"firstName" TEXT,
	"lastName" TEXT,
	age INTEGER,
	location_id INTEGER NOT NULL,
	CONSTRAINT fk_location
		FOREIGN KEY(location_id)
			REFERENCES location(id)
);

CREATE TABLE person_interest (
	person_id INTEGER,
	interest_id INTEGER,
	CONSTRAINT fk_person
		FOREIGN KEY(person_id)
			REFERENCES person(id),
	CONSTRAINT fk_interest
		FOREIGN KEY(interest_id)
			REFERENCES interest(id)
);

INSERT INTO location (city, state, country) VALUES ('Nashville', 'Tennessee', 'United States'), ('Memphis', 'Tennessee', 'United States'), ('Phoenix', 'Arizona', 'United States'), ('Denver', 'Colorado', 'United States');

INSERT INTO person ("firstName", "lastName", age, location_id) VALUES ('Chickie', 'Ourtic', 21, 1), ('Hilton', 'O''Hanley', 37, 1), ('Barbe', 'Purver', 50, 3), ('Reeta', 'Sammons', 34, 2), ('Abbott', 'Fisbburne', 49, 1), ('Winnie', 'Whines', 19, 4), ('Samantha', 'Leese', 35, 2), ('Edouard', 'Lorimer', 29, 1), ('Mattheus', 'Shaplin', 27, 3), ('Donnell', 'Corney', 25, 3), ('Wallis', 'Kauschke', 28, 3), ('Melva', 'Lanham', 20, 2), ('Amelina', 'McNirlan', 22, 4), ('Courtney', 'Holley', 22, 1), ('Sigismond', 'Vala', 21, 4), ('Jacquelynn', 'Halfacre', 24, 2), ('Alanna', 'Spino', 25, 3), ('Isa', 'Slight', 32, 1), ('Kakalina', 'Renne', 26, 3);

INSERT INTO interest (title) VALUES ('Programming'), ('Gaming'), ('Computers'), ('Music'), ('Movies'), ('Cooking'), ('Sports');

INSERT INTO person_interest (person_id, interest_id) VALUES (1, 1), (1, 2), (1, 6), (2, 1), (2, 7), (2, 4), (3, 1), (3, 3), (3, 4), (4, 1), (4, 2), (4, 7), (5, 6), (5, 3), (5, 4), (6, 2), (6, 7), (7, 1), (7, 3), (8, 2), (8, 4), (9, 5), (9, 6), (10, 7), (10, 5), (11, 1), (11, 2), (11, 5), (12, 1), (12, 4), (12, 5), (13, 2), (13, 3), (13, 7), (14, 2), (14, 4), (14, 6), (15, 1), (15, 5), (15, 7), (16, 2), (16, 3), (16, 4), (17, 1), (17, 3), (17, 5), (17, 7), (18, 2), (18, 4), (18, 6), (19, 1), (19, 2), (19, 3), (19, 4), (19, 5), (19, 6), (19, 7);

UPDATE person SET age = age + 1
	WHERE ("firstName", "lastName") 
		IN (('Chickie', 'Ourtic'), ('Winnie', 'Whines'), ('Edouard', 'Lorimer'), ('Courtney', 'Holley'), ('Melva', 'Lanham'), ('Isa', 'Slight'), ('Abbot', 'Fisbburne'), ('Reeta', 'Sammons'));

DELETE FROM person_interest WHERE person_id IN (SELECT person.id FROM person JOIN person_interest ON person.id=person_interest.person_id WHERE (person."firstName", person."lastName") IN (('Hilton', 'O''Hanley'), ('Alanna', 'Spino')));

DELETE FROM person WHERE ("firstName", "lastName") IN (('Hilton', 'O''Hanley'), ('Alanna', 'Spino'));

SELECT "firstName", "lastName" FROM person;

SELECT "firstName", "lastName", city, state FROM person JOIN location ON person.location_id=location.id WHERE city='Nashville' AND state='Tennessee';

SELECT city, COUNT("firstName") FROM person JOIN location ON person.location_id=location.id GROUP BY city;

SELECT title, COUNT(*) FROM person JOIN person_interest ON person.id=person_interest.person_id JOIN interest ON person_interest.interest_id=interest.id GROUP BY title;

SELECT "firstName", "lastName", city, state, title FROM person JOIN location ON person.location_id=location.id JOIN person_interest ON person.id=person_interest.person_id JOIN interest ON person_interest.interest_id=interest.id WHERE city='Nashville' AND state='Tennessee' AND title='Programming';
