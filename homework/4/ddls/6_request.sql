CREATE TABLE "request_methods" (
    "id" SERIAL PRIMARY KEY,
    "name" varchar
);

CREATE TABLE "request_types" (
    "id" SERIAL PRIMARY KEY,
    "name" varchar
);

CREATE TABLE "requests" (
    "id" SERIAL PRIMARY KEY,
    "uri_id" bigint,
    "request_type_id" bigint,
    "request_method_id" bigint,
    "name" varchar,
    CONSTRAINT fk_request_method_id
        FOREIGN KEY(request_method_id)
            REFERENCES request_methods(id),
    CONSTRAINT fk_request_type_id
        FOREIGN KEY(request_type_id)
            REFERENCES request_types(id)
);

CREATE TABLE "sites_requests" (
    "uri_id" bigint,
    "request_id" bigint,
    CONSTRAINT fk_uri_id
       FOREIGN KEY(uri_id)
           REFERENCES uries(id),
    CONSTRAINT fk_request_id
       FOREIGN KEY(request_id)
           REFERENCES requests(id)
);
