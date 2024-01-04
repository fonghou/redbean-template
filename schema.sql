create role web_anon nologin;
grant web_anon to authenticator;

create role api_user nologin;
grant api_user to authenticator;

create schema auth;
grant usage on schema auth to web_anon, api_user;

grant usage on schema postgres_air to web_anon,api_user;
grant select on all tables in schema postgres_air to web_anon;
grant all on all tables in schema postgres_air to api_user;
grant all on all sequences in schema postgres_air to api_user;

create schema main;
grant usage on schema main to web_anon,api_user;
grant select on main to web_anon;
grant all on main to api_user;

create table main.todos (
  id serial primary key,
  done boolean not null default false,
  task text not null,
  due timestamptz
);

SET search_path TO postgres_air;
CREATE INDEX flight_departure_airport ON flight(departure_airport);
CREATE INDEX flight_scheduled_departure ON postgres_air.flight (scheduled_departure);
CREATE INDEX flight_update_ts ON postgres_air.flight (update_ts);
CREATE INDEX booking_leg_booking_id ON postgres_air.booking_leg (booking_id);
CREATE INDEX booking_leg_update_ts ON postgres_air.booking_leg (update_ts);
CREATE INDEX account_last_name ON account (last_name);
