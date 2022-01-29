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
