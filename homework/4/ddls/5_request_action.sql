CREATE TABLE "request_action_types" (
    "id" SERIAL PRIMARY KEY,
    "name" varchar
);

CREATE TABLE "request_actions" (
    "id" SERIAL PRIMARY KEY,
    "name" varchar,
    "priority" int,
    "request_action_type_id" bigint,
    CONSTRAINT fk_request_action_type_id
       FOREIGN KEY(request_action_type_id)
           REFERENCES request_action_types(id)
);

CREATE TABLE "request_actions_uri_parameters" (
    "uri_parameter_id" bigint,
    "request_action_id" bigint,
    CONSTRAINT fk_uri_parameter_id
        FOREIGN KEY(uri_parameter_id)
            REFERENCES uri_parameters(id),
    CONSTRAINT fk_request_action_id
        FOREIGN KEY(request_action_id)
            REFERENCES request_actions(id)
);