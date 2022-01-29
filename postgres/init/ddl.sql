
-- ============================================== --
--              Users logic                       --
-- ============================================== --

CREATE TABLE "users" (
    "id" SERIAL PRIMARY KEY,
    "first_name" varchar(50),
    "last_name" varchar(50),
    "phone" varchar(50),
    "email" varchar(50)
);

CREATE TABLE "user_roles" (
    "id" SERIAL PRIMARY KEY,
    "name" varchar
);

CREATE TABLE "users_roles" (
    "user_id" bigint ,
    "user_role_id" bigint,
    CONSTRAINT fk_user_id
       FOREIGN KEY(user_role_id)
           REFERENCES user_roles(id),
    CONSTRAINT fk_user_role
       FOREIGN KEY(user_id)
           REFERENCES users(id)
);

CREATE TABLE "user_role_permissions" (
    "id" SERIAL PRIMARY KEY,
    "name" varchar
);

CREATE TABLE "user_roles_permissions" (
    "user_role_id" bigint,
    "user_role_permission_id" bigint,
    CONSTRAINT fk_user_role_permission_id
      FOREIGN KEY(user_role_permission_id)
          REFERENCES user_role_permissions(id),
    CONSTRAINT fk_user_role_id
      FOREIGN KEY(user_role_id)
          REFERENCES user_roles(id)
);

-- ============================================== --
--              Sites logic                       --
-- ============================================== --

CREATE TABLE "sites" (
                         "id" SERIAL PRIMARY KEY,
                         "name" varchar
);

CREATE TABLE "users_sites" (
                               "user_id" bigint,
                               "site_id" bigint,
                               CONSTRAINT fk_user_id
                                   FOREIGN KEY(user_id)
                                       REFERENCES users(id),
                               CONSTRAINT fk_site_id
                                   FOREIGN KEY(site_id)
                                       REFERENCES sites(id)
);

-- ============================================== --
--              Uri logic                         --
-- ============================================== --


CREATE TABLE "uri_ports" (
                             "id" SERIAL PRIMARY KEY,
                             "value" int
);

CREATE TABLE "uri_userinfo" (
                                "id" SERIAL PRIMARY KEY,
                                "value" varchar
);

CREATE TABLE "uri_paths" (
                             "id" SERIAL PRIMARY KEY,
                             "value" text
);

CREATE TABLE "uri_hostname_types" (
                                      "id" SERIAL PRIMARY KEY,
                                      "name" varchar
);

CREATE TABLE "uri_schemes" (
                               "id" SERIAL PRIMARY KEY,
                               "name" varchar
);

CREATE TABLE "uri_hostnames" (
                                 "id" SERIAL PRIMARY KEY,
                                 "uri_hostname_type_id" bigint,
                                 CONSTRAINT fk_uri_hostname_type_id
                                     FOREIGN KEY(uri_hostname_type_id)
                                         REFERENCES uri_hostname_types(id)
);

CREATE TABLE "uries" (
                         "id" SERIAL PRIMARY KEY,
                         "uri_hostname_id" bigint,
                         "uri_userinfo_id" bigint,
                         "uri_scheme_id" bigint not null,
                         "uri_path_id" bigint,
                         "uri_port_id" bigint,
                         CONSTRAINT fk_uri_hostname_id
                             FOREIGN KEY(uri_hostname_id)
                                 REFERENCES uri_hostnames(id),
                         CONSTRAINT fk_uri_userinfo_id
                             FOREIGN KEY(uri_userinfo_id)
                                 REFERENCES uri_userinfo(id),
                         CONSTRAINT fk_uri_scheme_id
                             FOREIGN KEY(uri_scheme_id)
                                 REFERENCES uri_schemes(id),
                         CONSTRAINT fk_uri_path_id
                             FOREIGN KEY(uri_path_id)
                                 REFERENCES uri_paths(id),
                         CONSTRAINT fk_uri_port_id
                             FOREIGN KEY(uri_port_id)
                                 REFERENCES uri_ports(id)
);

CREATE TABLE "sites_uries" (
                               "uri_id" bigint,
                               "site_id" bigint,
                               CONSTRAINT fk_uri_id
                                   FOREIGN KEY(uri_id)
                                       REFERENCES uries(id),
                               CONSTRAINT fk_site_id
                                   FOREIGN KEY(site_id)
                                       REFERENCES sites(id)
);

-- ============================================== --
--              Uri Parameter                     --
-- ============================================== --


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

-- ============================================== --
--              request action                    --
-- ============================================== --

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

-- ============================================== --
--              Request logic                     --
-- ============================================== --

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

-- ============================================== --
--              schedule request                  --
-- ============================================== --

CREATE TABLE "request_schedule_types" (
                                          "id" SERIAL PRIMARY KEY,
                                          "name" varchar
);

CREATE TABLE "request_schedules" (
                                     "id" SERIAL PRIMARY KEY,
                                     "uri_id" bigint,
                                     "request_schedule_type_id" bigint,
                                     "name" varchar,
                                     "value" varchar,
                                     "timezone" int,
                                     CONSTRAINT fk_request_schedule_type_id
                                         FOREIGN KEY(request_schedule_type_id)
                                             REFERENCES request_schedule_types(id)
);

CREATE TABLE "requests_schedules" (
                                      "request_schedule_id" bigint,
                                      "request_id" bigint,
                                      CONSTRAINT fk_request_schedule_id
                                          FOREIGN KEY(request_schedule_id)
                                              REFERENCES request_schedules(id),
                                      CONSTRAINT fk_request_id
                                          FOREIGN KEY(request_id)
                                              REFERENCES requests(id)
);

-- ============================================== --
--              request headers                   --
-- ============================================== --

CREATE TABLE "request_headers" (
                                   "id" SERIAL PRIMARY KEY,
                                   "name" varchar
);

CREATE TABLE "request_header_values" (
                                         "id" SERIAL PRIMARY KEY,
                                         "value" text,
                                         "is_crypt" boolean
);

CREATE TABLE "requests_headers" (
                                    "request_header_id" bigint,
                                    "request_header_value_id" bigint,
                                    "request_id" bigint,
                                    CONSTRAINT fk_request_header_id
                                        FOREIGN KEY(request_header_id)
                                            REFERENCES request_headers(id),
                                    CONSTRAINT fk_request_header_value_id
                                        FOREIGN KEY(request_header_value_id)
                                            REFERENCES request_header_values(id),
                                    CONSTRAINT fk_headers_request_id
                                        FOREIGN KEY(request_id)
                                            REFERENCES requests(id)
);

-- ============================================== --
--              request_header_groups             --
-- ============================================== --

CREATE TABLE "request_header_groups" (
                                         "id" SERIAL PRIMARY KEY,
                                         "name" varchar
);

CREATE TABLE "request_headers_group_values" (
                                                "request_header_id" bigint,
                                                "request_header_value_id" bigint,
                                                "request_header_group_id" bigint,
                                                CONSTRAINT fk_request_header_id
                                                    FOREIGN KEY(request_header_id)
                                                        REFERENCES request_headers(id),
                                                CONSTRAINT fk_request_header_value_id
                                                    FOREIGN KEY(request_header_value_id)
                                                        REFERENCES request_header_values(id),
                                                CONSTRAINT fk_request_header_group_id
                                                    FOREIGN KEY(request_header_group_id)
                                                        REFERENCES request_header_groups(id)
);

CREATE TABLE "requests_header_groups" (
                                          "request_header_group_id" bigint,
                                          "request_id" bigint,
                                          CONSTRAINT fk_request_header_group_id
                                              FOREIGN KEY(request_header_group_id)
                                                  REFERENCES request_header_groups(id),
                                          CONSTRAINT fk_headers_request_id
                                              FOREIGN KEY(request_id)
                                                  REFERENCES requests(id)
);

-- ============================================== --
--              request_body                      --
-- ============================================== --

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

-- ============================================== --
--              parser_setting                    --
-- ============================================== --
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


-- ============================================== --
--              destinations                      --
-- ============================================== --

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

-- ============================================== --
--              skeleton                          --
-- ============================================== --

CREATE TABLE "skeleton_types" (
                                  "id" SERIAL PRIMARY KEY,
                                  "name" varchar
);

CREATE TABLE "skeleton_attributes" (
                                       "id" SERIAL PRIMARY KEY,
                                       "name" varchar,
                                       "value" text
);

CREATE TABLE "skeleton_modify_functions" (
                                             "id" SERIAL PRIMARY KEY,
                                             "name" varchar
);

CREATE TABLE "skeletons" (
                             "id" SERIAL PRIMARY KEY,
                             "name" varchar,
                             "skeleton_type_id" bigint,
                             "parent_id" bigint,
                             CONSTRAINT fk_skeleton_type_id
                                 FOREIGN KEY(skeleton_type_id)
                                     REFERENCES skeleton_types(id),
                             CONSTRAINT fk_parent_id
                                 FOREIGN KEY(parent_id)
                                     REFERENCES skeletons(id)
);

CREATE TABLE "skeletons_attributes" (
                                        "skeleton_id" bigint,
                                        "skeleton_attribute_id" bigint,
                                        CONSTRAINT fk_skeleton_id
                                            FOREIGN KEY(skeleton_id)
                                                REFERENCES skeletons(id),
                                        CONSTRAINT skeleton_attribute_id
                                            FOREIGN KEY(skeleton_attribute_id)
                                                REFERENCES skeleton_attributes(id)
);

CREATE TABLE "skeleton_values" (
                                   "id" SERIAL PRIMARY KEY,
                                   "skeleton_modify_function_id" bigint,
                                   "value" text,
                                   CONSTRAINT fk_skeleton_modify_function_id
                                       FOREIGN KEY(skeleton_modify_function_id)
                                           REFERENCES skeleton_modify_functions(id)
);

CREATE TABLE "skeletons_values" (
                                    "skeleton_id" bigint,
                                    "skeleton_value_id" bigint,
                                    CONSTRAINT fk_skeleton_id
                                        FOREIGN KEY(skeleton_id)
                                            REFERENCES skeletons(id),
                                    CONSTRAINT fk_skeleton_value_id
                                        FOREIGN KEY(skeleton_value_id)
                                            REFERENCES skeleton_values(id)
);

-- ============================================== --
--              Job Logic                         --
-- ============================================== --

CREATE TABLE "jobs" (
                        "id" SERIAL PRIMARY KEY,
                        "queue" varchar,
                        "payload" text,
                        "attempts" int,
                        "reserved_at" int,
                        "available_at" int,
                        "created_at" timestamp
);

CREATE TABLE "failed_jobs" (
                               "id" SERIAL PRIMARY KEY,
                               "connection" text,
                               "queue" text,
                               "payload" text,
                               "exception" int,
                               "failed_at" int
);


-- ============================================== --
--              Audits Logic                      --
-- ============================================== --

CREATE TABLE "audits" (
                          "id" SERIAL PRIMARY KEY,
                          "event" varchar,
                          "auditable_type" varchar,
                          "auditable_id" bigint,
                          "new_value" json,
                          "old_value" json,
                          "url" varchar,
                          "ip_address" varchar,
                          "user_agent" varchar,
                          "created_at" timestamp,
                          "updated_at" timestamp
);

