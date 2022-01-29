
CREATE TABLE "uri_parameter_separators" (
    "id" SERIAL PRIMARY KEY,
    "value" varchar
);
CREATE TABLE "uri_parameter_types" (
    "id" SERIAL PRIMARY KEY,
    "value" varchar
);

CREATE TABLE "uri_parameters" (
    "id" SERIAL PRIMARY KEY,
    name varchar,
    value text,
    "uri_parameter_type_id" bigint,
    "uri_parameter_separator_id" bigint,
    CONSTRAINT fk_uri_parameter_type_id
        FOREIGN KEY(uri_parameter_type_id)
            REFERENCES uri_parameter_types(id),
    CONSTRAINT fk_uri_parameter_separator_id
        FOREIGN KEY(uri_parameter_separator_id)
            REFERENCES uri_parameter_separators(id)
);

CREATE TABLE "uries_parameters" (
    "uri_parameter_id" bigint,
    "uri_id" bigint,
    CONSTRAINT fk_params_uri_id
        FOREIGN KEY(uri_id)
            REFERENCES uries(id),
    CONSTRAINT fk_params_uri_parameter_id
        FOREIGN KEY(uri_parameter_id)
            REFERENCES uri_parameters(id)
);