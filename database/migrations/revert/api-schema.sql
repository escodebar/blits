-- Revert blits:api-schema from pg

BEGIN;
drop schema api;
COMMIT;
