CREATE TABLE "users" (
                         "id" SERIAL PRIMARY KEY,
                         "name" varchar,
                         "created_at" timestamp
);

CREATE TABLE "users_roles" (
                               "id" SERIAL PRIMARY KEY,
                               "user_id" int,
                               "user_role_id" int
);

CREATE TABLE "user_roles" (
                              "id" SERIAL PRIMARY KEY,
                              "name" varchar,
                              "created_at" timestamp
);

CREATE TABLE "user_role_permissions" (
                                         "id" SERIAL PRIMARY KEY,
                                         "name" varchar,
                                         "created_at" timestamp
);

CREATE TABLE "user_roles_permissions" (
                                          "id" SERIAL PRIMARY KEY,
                                          "user_role_id" int,
                                          "user_role_permission_id" int
);

CREATE TABLE "sites" (
                         "id" SERIAL PRIMARY KEY,
                         "user_id" int,
                         "name" varchar,
                         "created_at" timestamp
);

CREATE TABLE "sites_requests" (
                                  "id" SERIAL PRIMARY KEY,
                                  "site_id" int,
                                  "request_id" int
);

CREATE TABLE "requests" (
                            "id" SERIAL PRIMARY KEY,
                            "request_type_id" int,
                            "request_protocol_id" int,
                            "request_method_id" int,
                            "request_domain_name_id" int,
                            "request_urn_id" int,
                            "name" varchar,
                            "created_at" timestamp
);

CREATE TABLE "request_urns" (
                                "id" SERIAL PRIMARY KEY,
                                "path" text,
                                "created_at" timestamp
);

CREATE TABLE "request_domain_names" (
                                        "id" SERIAL PRIMARY KEY,
                                        "site_id" int,
                                        "value" varchar,
                                        "created_at" timestamp
);

CREATE TABLE "request_headers" (
                                   "id" SERIAL PRIMARY KEY,
                                   "name" varchar,
                                   "created_at" timestamp
);

CREATE TABLE "request_header_values" (
                                         "id" SERIAL PRIMARY KEY,
                                         "value" text,
                                         "created_at" timestamp
);

CREATE TABLE "requests_headers" (
                                    "id" SERIAL PRIMARY KEY,
                                    "request_id" int,
                                    "request_header_value_id" int,
                                    "request_header_id" int,
                                    "created_at" int
);

CREATE TABLE "request_protocols" (
                                     "id" SERIAL PRIMARY KEY,
                                     "name" varchar,
                                     "created_at" timestamp
);

CREATE TABLE "request_methods" (
                                   "id" SERIAL PRIMARY KEY,
                                   "name" varchar,
                                   "created_at" timestamp
);

CREATE TABLE "request_urns_parameters" (
                                           "id" SERIAL PRIMARY KEY,
                                           "request_urn_id" int,
                                           "request_urn_parameter_id" int,
                                           "created_at" timestamp
);

CREATE TABLE "request_urn_parameters" (
                                          "id" SERIAL PRIMARY KEY,
                                          "request_urn_parameter_type_id" int,
                                          "request_urn_parameter_separator_id" int,
                                          "name" varchar,
                                          "value" text,
                                          "created_at" timestamp
);

CREATE TABLE "request_urn_parameter_types" (
                                               "id" SERIAL PRIMARY KEY,
                                               "name" varchar,
                                               "created_at" timestamp
);

CREATE TABLE "request_urn_parameter_separators" (
                                                    "id" SERIAL PRIMARY KEY,
                                                    "name" varchar,
                                                    "created_at" timestamp
);

CREATE TABLE "request_actions" (
                                   "id" SERIAL PRIMARY KEY,
                                   "name" varchar,
                                   "priority" int,
                                   "created_at" timestamp
);

CREATE TABLE "requests_actions" (
                                    "id" SERIAL PRIMARY KEY,
                                    "request_action_id" int,
                                    "request_id" int
);

CREATE TABLE "request_actions_urn_parameters" (
                                                  "id" SERIAL PRIMARY KEY,
                                                  "request_urn_parameter_id" int,
                                                  "request_action_id" int
);

CREATE TABLE "requests_logs" (
                                 "id" SERIAL PRIMARY KEY,
                                 "request_id" int,
                                 "request_log_id" int
);

CREATE TABLE "request_log" (
                               "id" SERIAL PRIMARY KEY,
                               "request_log_type_id" int,
                               "data" json,
                               "created_at" timestamp
);

CREATE TABLE "request_log_types" (
                                     "id" SERIAL PRIMARY KEY,
                                     "name" varchar
);

CREATE TABLE "request_schedule" (
                                    "id" SERIAL PRIMARY KEY,
                                    "request_id" int,
                                    "request_schedule_type_id" int,
                                    "value" varchar
);

CREATE TABLE "request_schedule_types" (
                                          "id" SERIAL PRIMARY KEY,
                                          "name" varchar
);

CREATE TABLE "request_schedule_progress" (
                                             "id" SERIAL PRIMARY KEY,
                                             "request_id" int,
                                             "date_start" timestamp,
                                             "timezone" varchar
);

CREATE TABLE "requests_parser_objects" (
                                           "id" SERIAL PRIMARY KEY,
                                           "request_id" int,
                                           "parser_object_id" int
);

CREATE TABLE "parser_objects" (
                                  "id" SERIAL PRIMARY KEY,
                                  "name" varchar
);

CREATE TABLE "parser_objects_columns" (
                                          "id" SERIAL PRIMARY KEY,
                                          "parser_object_id" int,
                                          "name" varchar,
                                          "alias" varchar
);

ALTER TABLE "users_roles" ADD FOREIGN KEY ("user_id") REFERENCES "users" ("id");

ALTER TABLE "users_roles" ADD FOREIGN KEY ("user_role_id") REFERENCES "user_roles" ("id");

ALTER TABLE "user_roles_permissions" ADD FOREIGN KEY ("user_role_permission_id") REFERENCES "user_role_permissions" ("id");

ALTER TABLE "user_roles_permissions" ADD FOREIGN KEY ("user_role_id") REFERENCES "user_roles" ("id");

ALTER TABLE "sites" ADD FOREIGN KEY ("user_id") REFERENCES "users" ("id");

ALTER TABLE "sites_requests" ADD FOREIGN KEY ("site_id") REFERENCES "sites" ("id");

ALTER TABLE "sites_requests" ADD FOREIGN KEY ("request_id") REFERENCES "requests" ("id");

ALTER TABLE "requests" ADD FOREIGN KEY ("request_protocol_id") REFERENCES "request_protocols" ("id");

ALTER TABLE "requests" ADD FOREIGN KEY ("request_method_id") REFERENCES "request_methods" ("id");

ALTER TABLE "requests" ADD FOREIGN KEY ("request_domain_name_id") REFERENCES "request_domain_names" ("id");

ALTER TABLE "requests" ADD FOREIGN KEY ("request_urn_id") REFERENCES "request_urns" ("id");

ALTER TABLE "request_domain_names" ADD FOREIGN KEY ("site_id") REFERENCES "sites" ("id");

ALTER TABLE "requests_headers" ADD FOREIGN KEY ("request_id") REFERENCES "requests" ("id");

ALTER TABLE "requests_headers" ADD FOREIGN KEY ("request_header_value_id") REFERENCES "request_header_values" ("id");

ALTER TABLE "requests_headers" ADD FOREIGN KEY ("request_header_id") REFERENCES "request_headers" ("id");

ALTER TABLE "request_urns_parameters" ADD FOREIGN KEY ("request_urn_id") REFERENCES "request_urns" ("id");

ALTER TABLE "request_urns_parameters" ADD FOREIGN KEY ("request_urn_parameter_id") REFERENCES "request_urn_parameters" ("id");

ALTER TABLE "request_urn_parameters" ADD FOREIGN KEY ("request_urn_parameter_type_id") REFERENCES "request_urn_parameter_types" ("id");

ALTER TABLE "request_urn_parameters" ADD FOREIGN KEY ("request_urn_parameter_separator_id") REFERENCES "request_urn_parameter_separators" ("id");

ALTER TABLE "requests_actions" ADD FOREIGN KEY ("request_id") REFERENCES "requests" ("id");

ALTER TABLE "requests_actions" ADD FOREIGN KEY ("request_action_id") REFERENCES "request_actions" ("id");

ALTER TABLE "request_actions_urn_parameters" ADD FOREIGN KEY ("request_action_id") REFERENCES "request_actions" ("id");

ALTER TABLE "request_actions_urn_parameters" ADD FOREIGN KEY ("request_urn_parameter_id") REFERENCES "request_urn_parameters" ("id");

ALTER TABLE "requests_logs" ADD FOREIGN KEY ("request_id") REFERENCES "requests" ("id");

ALTER TABLE "requests_logs" ADD FOREIGN KEY ("request_log_id") REFERENCES "request_log" ("id");

ALTER TABLE "request_log" ADD FOREIGN KEY ("request_log_type_id") REFERENCES "request_log_types" ("id");

ALTER TABLE "request_schedule" ADD FOREIGN KEY ("request_id") REFERENCES "requests" ("id");

ALTER TABLE "request_schedule" ADD FOREIGN KEY ("request_schedule_type_id") REFERENCES "request_schedule_types" ("id");

ALTER TABLE "request_schedule_progress" ADD FOREIGN KEY ("request_id") REFERENCES "requests" ("id");

ALTER TABLE "requests_parser_objects" ADD FOREIGN KEY ("request_id") REFERENCES "requests" ("id");

ALTER TABLE "requests_parser_objects" ADD FOREIGN KEY ("parser_object_id") REFERENCES "parser_objects" ("id");

ALTER TABLE "parser_objects_columns" ADD FOREIGN KEY ("parser_object_id") REFERENCES "parser_objects" ("id");