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