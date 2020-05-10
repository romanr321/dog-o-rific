-- DROP SCHEMA main;

CREATE SCHEMA main AUTHORIZATION dogorific;

-- Drop table

-- DROP TABLE main.breeds;

CREATE TABLE main.breeds (
	id int4 NOT NULL,
	breed bytea NOT NULL,
	CONSTRAINT breeds_pk PRIMARY KEY (id)
);

-- Drop table

-- DROP TABLE main.favorites;

CREATE TABLE main.favorites (
	id serial NOT NULL,
	breed_id int4 NOT NULL,
	CONSTRAINT favorites_pk PRIMARY KEY (id),
	CONSTRAINT favorites_fk FOREIGN KEY (breed_id) REFERENCES main.breeds(id) ON DELETE CASCADE
);
CREATE UNIQUE INDEX favorites_breed_id_idx ON main.favorites USING btree (breed_id);
