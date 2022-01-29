CREATE TABLE "parser_setting_types" (
    "id" SERIAL PRIMARY KEY,
    "name" varchar
);

CREATE TABLE "parser_object_column_types" (
    "id" SERIAL PRIMARY KEY,
    "name" varchar
);

CREATE TABLE "parser_settings" (
    "id" SERIAL PRIMARY KEY,
    "value" varchar,
    "parsing_setting_type_id" bigint,
    CONSTRAINT fk_parsing_setting_type_id
        FOREIGN KEY(parsing_setting_type_id)
            REFERENCES parser_setting_types(id)
);

CREATE TABLE "parser_object_columns" (
"id" SERIAL PRIMARY KEY,
"name" varchar,
"parser_setting_id" bigint,
"parser_object_column_type_id" bigint,
CONSTRAINT fk_parser_setting_id
   FOREIGN KEY(parser_setting_id)
       REFERENCES parser_settings(id),
CONSTRAINT fk_parser_object_column_type_id
    FOREIGN KEY(parser_object_column_type_id)
        REFERENCES parser_object_column_types(id)
);

CREATE TABLE "parser_objects" (
    "id" SERIAL PRIMARY KEY,
    "name" varchar,
    "parent_id" bigint,
    "parser_setting_id" bigint,
    CONSTRAINT fk_parent_id
        FOREIGN KEY(parent_id)
            REFERENCES parser_objects(id),
    CONSTRAINT fk_parser_setting_id
        FOREIGN KEY(parser_setting_id)
            REFERENCES parser_settings(id)
);

CREATE TABLE "requests_parser_objects" (
    "parser_object_id" bigint,
    "request_id" bigint,
    CONSTRAINT fk_parser_object_id
      FOREIGN KEY(parser_object_id)
          REFERENCES parser_objects(id),
    CONSTRAINT fk_headers_request_id
        FOREIGN KEY(request_id)
            REFERENCES requests(id)
);