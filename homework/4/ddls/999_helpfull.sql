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
