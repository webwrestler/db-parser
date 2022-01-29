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
