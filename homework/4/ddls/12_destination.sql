CREATE TABLE "destination_types" (
    "id" SERIAL PRIMARY KEY,
    "name" varchar
);

CREATE TABLE "destinations" (
    "id" SERIAL PRIMARY KEY,
    "name" varchar,
    "destination_type_id" bigint,
    CONSTRAINT fk_destination_type_id
        FOREIGN KEY(destination_type_id)
            REFERENCES destination_types(id)
);

CREATE TABLE "destination_databases" (
    "id" SERIAL PRIMARY KEY,
    "name" varchar,
    "username" varchar,
    "port" int,
    "host" varchar,
    "database_name" varchar,
    "connection" varchar,
    "driver" varchar
);

CREATE TABLE "destinations_databases" (
"destination_database_id" bigint,
"destination_id" bigint,
CONSTRAINT fk_destination_database_id
    FOREIGN KEY(destination_database_id)
        REFERENCES destination_databases(id),
CONSTRAINT fk_destination_id
    FOREIGN KEY(destination_id)
        REFERENCES destinations(id)
);
