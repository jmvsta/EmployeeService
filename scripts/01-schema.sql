CREATE SCHEMA employee_prod AUTHORIZATION user_prod;

CREATE SEQUENCE employee_prod.team_seq START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE employee_prod.employee_seq START WITH 1 INCREMENT BY 1;

CREATE TABLE employee_prod.team (
                                   id          BIGINT PRIMARY KEY DEFAULT nextval('employee_prod.team_seq'),
                                   name        VARCHAR(100)     NOT NULL UNIQUE,
                                   teamlead_id BIGINT
);

CREATE TABLE employee_prod.employee (
                                       id      BIGINT PRIMARY KEY DEFAULT nextval('employee_prod.employee_seq'),
                                       name    VARCHAR(100) NOT NULL,
                                       team_id BIGINT REFERENCES employee_prod.team (id)
);

ALTER TABLE employee_prod.team
    ADD CONSTRAINT fk_team_lead FOREIGN KEY (teamlead_id)
        REFERENCES employee_prod.employee (id);

INSERT INTO employee_prod.team (name) VALUES ('Development');

WITH dev AS (
    SELECT id FROM employee_prod.team WHERE name = 'Development'
)
INSERT INTO employee_prod.employee (name, team_id)
SELECT v.name, dev.id
FROM (VALUES ('Mirko'), ('Predrag'), ('Petar'), ('Vojislav'), ('Dmitriy')) AS v(name), dev;

UPDATE employee_prod.team
SET teamlead_id = (SELECT id FROM employee_prod.employee WHERE name = 'Mirko')
WHERE name = 'Development';

GRANT USAGE, CREATE ON SCHEMA employee_prod TO user_prod;
GRANT ALL PRIVILEGES ON ALL TABLES IN SCHEMA employee_prod TO user_prod;
GRANT ALL PRIVILEGES ON ALL SEQUENCES IN SCHEMA employee_prod TO user_prod;
