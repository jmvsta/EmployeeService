DROP DATABASE IF EXISTS employee;
CREATE DATABASE employee
    WITH
    OWNER = postgres;
\CONNECT employee
DROP ROLE IF EXISTS dev_user;
CREATE USER dev_user
    WITH LOGIN
    ENCRYPTED PASSWORD ?;

CREATE SCHEMA employee_dev AUTHORIZATION dev_user;

GRANT CONNECT ON DATABASE employee TO dev_user;
GRANT CREATE ON DATABASE employee TO dev_user;

CREATE SEQUENCE employee_dev.team_seq START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE employee_dev.employee_seq START WITH 1 INCREMENT BY 1;

CREATE TABLE employee_dev.team
(
    id          BIGINT PRIMARY KEY DEFAULT nextval('employee_dev.team_seq'),
    name        VARCHAR(100) NOT NULL UNIQUE,
    teamlead_id BIGINT
);

CREATE TABLE employee_dev.employee
(
    id      BIGINT PRIMARY KEY DEFAULT nextval('employee_dev.employee_seq'),
    name    VARCHAR(100) NOT NULL,
    team_id BIGINT REFERENCES employee_dev.team (id)
);

ALTER TABLE employee_dev.team
    ADD CONSTRAINT fk_team_lead
        FOREIGN KEY (teamlead_id)
            REFERENCES employee_dev.employee (id);

WITH dev AS (SELECT id
             FROM employee_dev.team
             WHERE name = 'Development')
INSERT
INTO employee_dev.employee (name, team_id)
SELECT v.name, dev.id
FROM (VALUES ('Mirko'),
             ('Predrag'),
             ('Petar'),
             ('Vojislav')) AS v(name)
         CROSS JOIN dev;

UPDATE employee_dev.team
SET teamlead_id = (SELECT id FROM employee_dev.employee WHERE name = 'Mirko')
WHERE name = 'Development';

GRANT USAGE, CREATE ON SCHEMA employee_dev TO dev_user;
GRANT ALL PRIVILEGES ON ALL TABLES IN SCHEMA employee_dev TO dev_user;
GRANT ALL PRIVILEGES ON ALL SEQUENCES IN SCHEMA employee_dev TO dev_user;
