CREATE TABLE "request_body_types" (
    "id" SERIAL PRIMARY KEY,
    "name" varchar
);

CREATE TABLE "request_body" (
    "id" SERIAL PRIMARY KEY,
    "data" text,
    "request_id" bigint,
    "request_body_type_id" bigint,
    CONSTRAINT fk_request_body_type_id
        FOREIGN KEY(request_body_type_id)
            REFERENCES request_body_types(id),
    CONSTRAINT fk_request_id
        FOREIGN KEY(request_id)
            REFERENCES requests(id)
);

CREATE TABLE "request_bodies_header_groups" (
    "request_header_group_id" bigint,
    "request_body_id" bigint,
    CONSTRAINT fk_request_header_group_id
        FOREIGN KEY(request_header_group_id)
            REFERENCES request_header_groups(id),
    CONSTRAINT fk_request_body_id
        FOREIGN KEY(request_body_id)
            REFERENCES request_body(id)
);