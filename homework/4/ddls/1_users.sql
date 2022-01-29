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
