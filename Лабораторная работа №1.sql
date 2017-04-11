CREATE TABLE t_messure(
  id_messure INT NOT NULL,
  NAME VARCHAR2(4) NOT NULL,
  CONSTRAINT pk_messure PRIMARY KEY(id_messure)
  )


CREATE TABLE t_material(
  id_material int NOT NULL,
  NAME VARCHAR2(100) NOT NULL,
  id_messure int NOT NULL,
  CONSTRAINT pk_material PRIMARY KEY(id_material),
  CONSTRAINT fk_material_messure FOREIGN KEY (id_messure)
  REFERENCES t_messure(id_messure)
  )

CREATE TABLE t_inprice(
	id_material int not NULL,
	price_date date not null,
	price number(10,2) check (price>=0),
	CONSTRAINT fk_inprice_material FOREIGN KEY(id_material)
	REFERENCES t_material(id_material) on delete cascade
)

CREATE TABLE t_store(
	id_store int not null,
	NAME VARCHAR2(100) 
	CONSTRAINT pk_store PRIMARY KEY(id_store),

)

CREATE TABLE t_employer(
	id_employer int NOT NULL,
		surname VARCHAR2(150),
		name VARCHAR2(100),
		father_name VARCHAR2(100),
		CONSTRAINT pk_employer PRIMARY KEY(id_employer));


CREATE TABLE t_caterer(
	id_caterer INT NOT NULL,
	name VARCHAR2(100),
	address VARCHAR2(200),
	phone VARCHAR2(20),
	fax VARCHAR2(20),
	CONSTRAINT pk_caterer PRIMARY KEY(id_caterer)

)

CREATE TABLE t_surplus(
	id_material INT NOT NULL,
	id_store INT NOT NULL,
	volume INT NOT NULL,
	CONSTRAINT fk_surplus_material FOREIGN KEY(id_material)
	REFERENCES t_material(id_material),

	CONSTRAINT fk_surplus_store FOREIGN KEY(id_store)
	REFERENCES t_store (id_store)
)

CREATE TABLE t_section(
	id_section INT NOT NULL,
	name VARCHAR2(100),
	id_section INT NOT NULL,
	CONSTRAINT pk_section PRIMARY KEY(id_section),
	CONSTRAINT fk_section_employer FOREIGN KEY(id_employer)
	REFERENCES t_employer(id_employer)
)



CREATE TABLE t_deliver(
	id_deliver INT NOT NULL,
	id_section INT NOT NULL,
	id_material INT NOT NULL,
	id_store INT NOT NULL,
	deliver_date date NOT NULL,

	CONSTRAINT pk_deliver PRIMARY KEY(id_deliver),

	CONSTRAINT fk_deliver_material FOREIGN KEY(id_material)
	REFERENCES t_material(id_material),

	CONSTRAINT fk_deliver_store FOREIGN KEY(id_store)
	REFERENCES t_store(id_store),

	CONSTRAINT fk_deliver_section FOREIGN KEY(id_section)
	REFERENCES t_section(id_section)

)

CREATE TABLE t_supply(
	id_supply INT NOT NULL,
	id_caterer INT NOT NULL,
	id_material INT NOT NULL,
	id_store INT NOT NULL,
	supply_date date NOT NULL,
	volume INT NOT NULL,

	CONSTRAINT pk_supply PRIMARY KEY(id_supply),

	CONSTRAINT fk_supply_caterer FOREIGN KEY(id_caterer)
	REFERENCES t_caterer(id_caterer),

	CONSTRAINT fk_supply_store FOREIGN KEY(id_store)
	REFERENCES t_store(id_store),

	CONSTRAINT fk_supply_material FOREIGN KEY(id_material)
	REFERENCES t_material(id_material)

)

alter TABLE t_caterer
	drop column address,
	add off_address VARCHAR2(100)
	add fact_address VARCHAR2(100)
	add email VARCHAR2(50)

alter TABLE t_inprice
	add CONSTRAINT pk_inprice 
	PRIMARY KEY (id_material,price_date)

CREATE TABLE t_group(
	id_group int not null,
	name VARCHAR2(100),
	CONSTRAINT pk_group PRIMARY KEY (id_group)
)

alter TABLE t_material
	add id_group int NOT NULL
	add CONSTRAINT fk_material
		FOREIGN KEY(id_group) REFERENCES t_group(id_group)
		on delete set null

