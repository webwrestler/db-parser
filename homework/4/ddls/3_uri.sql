
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
