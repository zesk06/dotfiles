# mysql

## SQL beginer course 

as seen [youtube](https://www.youtube.com/watch?v=HXV3zeQKqGY)

```mysql
# connect
mysql -h 127.0.0.1 -u mytest -p

# ##################################################################
# TABLE
# ##################################################################

# fields constraints could be
# - AUTO_INCREMENT pour la primary par ex
# - UNIQUE
# - NOT NULL
# - DEFAULT 'default value'

CREATE TABLE student (
    student_id INT AUTO_INCREMENT,
    name  VARCHAR(32) NOT NULL,
    major VARCHAR(32) DEFAULT 'Literracy',
    PRIMARY KEY(student_id)
    # FOREIGN KEY(mgr_id) REFERENCES other_table(other_column) ON DELETE SET NULL
);

DESCRIBE student;

# DROP TABLE student;

# ajout d'une colonne decimale, 3 chiffres, avec max deux decimales
ALTER TABLE student ADD gpa DECIMAL(3,2)
ALTER TABLE student DROP column gpa;

# ##################################################################
# INSERT
# ##################################################################
INSERT INTO student(name,major) VALUES ('Jack', 'Biology');
INSERT INTO student(name,major) VALUES ('Kate', 'Sociology');
INSERT INTO student(name) VALUES ('Claire');
INSERT INTO student(name,major) VALUES ('Jack', 'Biology');
INSERT INTO student(name,major) VALUES ('Mike', 'Computer Science');

# ##################################################################
# UPDATE
# ##################################################################
UPDATE student SET major = 'Bio' WHERE major = 'Biology'
UPDATE student SET major = 'Bio' WHERE major = 'Biology' AND student_id = 1;
UPDATE student SET major = 'Bio' WHERE major = 'Biology' OR  student_id = 1;

# ##################################################################
# DELETE
# ###################################################################
DELETE from student  WHERE major = 'Biology';

# ##################################################################
# SELECT
# ###################################################################
SELECT *               FROM student;
SELECT name            FROM student;
SELECT student.name    FROM student;
SELECT student.name    FROM student ORDER BY name;
SELECT student.name    FROM student ORDER BY name DESC;
SELECT student.name    FROM student ORDER BY name ASC  LIMIT 2;
SELECT name,major      FROM student WHERE major = 'Chemistry' ;
SELECT name,major      FROM student WHERE major <> 'Chemistry' ;
SELECT name,major      FROM student WHERE major = 'Chemistry' OR major = 'Computer Science';
SELECT name,major      FROM student WHERE name IN ('Claire', 'Kate', 'Mike');
SELECT name as surname FROM student;
SELECT DISTINCT name   FROM student;

# ###################################################################
# FOREIGN KEY
# ###################################################################

CREATE TABLE student (
    student_id INT AUTO_INCREMENT,
    name  VARCHAR(32) NOT NULL,
    major VARCHAR(32) DEFAULT 'Literracy',
    best_friend INT,
    PRIMARY KEY(student_id)
    FOREIGN KEY(best_friend) REFERENCES student(student_id) ON DELETE SET NULL
);

# creating foreign key afterwards
ALTER TABLE employee ADD FOREIGN KEY(branch_id) REFERENCES branch(branch_id) ON DELETE SET NULL;


# ###################################################################
# FUNCTIONS
# ###################################################################
SELECT COUNT(student_id) from student;
SELECT AVG(salary)       from employee;
SELECT SUM(salary)       from employee;
SELECT SUM(sex)          from employee  GROUP BY sex;

# ###################################################################
# WILDCARDS
# ###################################################################
SELECT * FROM branch_supplier WHERE supplier_name LIKE '%Lab%';
SELECT * FROM employee        WHERE birth_date LIKE '____-10-__';

# ###################################################################
# UNION
# ###################################################################
SELECT client_name FROM client 
  UNION SELECT supplier_name from branch_supplier;

SELECT client_name,branch_id FROM client 
  UNION SELECT supplier_name,branch_id from branch_supplier;

# ###################################################################
# JOIN
# ###################################################################

# INNER JOIN: get only row that match ON statement
SELECT employee.emp_id, employee.first_name, employee.last_name, branch.branch_name 
  FROM employee
  JOIN branch 
  ON employee.emp_id = branch.mgr_id;

# LEFT JOIN: get all rows from LEFT table
SELECT employee.emp_id, employee.first_name, employee.last_name, branch.branch_name 
  FROM employee
  LEFT JOIN branch 
  ON employee.emp_id = branch.mgr_id;
  
# RIGHT JOIN: get all rows from RIGHT table
SELECT employee.emp_id, employee.first_name, employee.last_name, branch.branch_name 
  FROM employee
  RIGHT JOIN branch 
  ON employee.emp_id = branch.mgr_id;

# ###################################################################
# NESTED QUERIES
# ###################################################################

# find names of all employees who have sold over 30K to a single client
SELECT employee.first_name, employee.last_name
  FROM employee
  WHERE employee.emp_id IN (
    SELECT emp_id FROM works_with WHERE total_sales > 30000
  );

# select all clients of manager 102
# must limit to 1 to avoid errors in case of multiple results
SELECT client.client_name 
FROM client
WHERE client.branch_id = (
    SELECT branch.branch_id
    FROM branch
    WHERE branch.mgr_id = 102
    LIMIT 1
);

# ###################################################################
# TRIGGER
# ###################################################################

CREATE TABLE trigger_test (
    message VARCHAR(100), 
    emp_id VARCHAR(100)
    );

DELIMITER $$;

CREATE 
    TRIGGER my_trigger BEFORE INSERT
    ON employee
    FOR EACH ROW BEGIN
        INSERT INTO trigger_test VALUES('added new employee', NEW.first_name);
    END$$

CREATE 
    TRIGGER my_trigger2 BEFORE INSERT
    ON employee
    FOR EACH ROW BEGIN
        IF NEW.sex = 'M' THEN
            INSERT INTO trigger_test VALUES('added new male', NEW.first_name);
        ELSEIF NEW.sex = 'F' THEN
            INSERT INTO trigger_test VALUES('added new female', NEW.first_name);
        ELSE
            INSERT INTO trigger_test VALUES('added new other', NEW.first_name);
        END IF;
    END$$
    
DELIMITER ;

INSERT INTO 
    employee 
    VALUES(110, "beth", "weasly", "1969-01-23", "F", 12000, NULL, 1);
#######
#    VALUES(109, "john", "doe", "1969-01-23", "M", 12000, NULL, 1);
#######
```
