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
