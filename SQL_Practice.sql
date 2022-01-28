/* 1. Create new database, schema and table*/
CREATE DATABASE school_db;
USE school_db;
CREATE TABLE course(id int, name_course varchar(255));
CREATE TABLE student(id int PRIMARY KEY, first_name varchar(255), last_name varchar(255));
CREATE TABLE enrollment(id int, student_id int, course_id int);

/* 2. Drop database and table*/
DROP TABLE enrollment;
DROP DATABASE school_db;

/* 3. Alter table to add unique, primary and foreign key constraints*/
ALTER TABLE course MODIFY COLUMN id INT PRIMARY KEY ;
ALTER TABLE course MODIFY COLUMN name_course VARCHAR(255) NOT NULL UNIQUE ;
ALTER TABLE enrollment MODIFY COLUMN id INT PRIMARY KEY AUTO_INCREMENT;
ALTER TABLE enrollment ADD CONSTRAINT fk_enrollment_student FOREIGN KEY (student_id) REFERENCES student(id);
ALTER TABLE enrollment ADD CONSTRAINT fk_enrollment_course FOREIGN KEY (course_id) REFERENCES course(id);

/* 4. Insert values to all 3 tables*/
/* Course and Enrollment will have Course Id*/
/* Student and Enrollment will have Student Id*/
/* Student can enroll for multiple courses (Enrollment table)*/
INSERT INTO course VALUES (1, "Java"),(2, "SQL"),(3, "Spring"),(4, "HTML"), (5, "Docker"), (6, "Interviews");
INSERT INTO student VALUES (1, "Javier","Eduardo"),(2, "Ricardo","Serrano"),
(3, "Pedro","Suarez"),(4, "Alex","Axel"), (5, "Sonia","Martinez");
INSERT INTO enrollment(student_id, course_id) VALUES (1,1),(1,2),(1,3),(1,6), (2,4),(2,5), (3, 2), (5, 2), (5,4);
INSERT INTO enrollment(student_id, course_id) VALUES (1,6);


/* 5. Delete a few courses*/
SET FOREIGN_KEY_CHECKS=0;
DELETE FROM course WHERE id = 6;
DELETE FROM course WHERE id = 5;
SET FOREIGN_KEY_CHECKS=1;

/* 6. Fetch all student details who have courses enrolled and all students who have not enrolled also*/
SELECT * FROM student s INNER JOIN enrollment e ON s.id = e.student_id WHERE student_id IS NOT NULL;
SELECT * FROM student s LEFT JOIN enrollment e ON s.id = e.student_id WHERE student_id IS NULL;

/* 7. Get the number of students enrolled for all courses*/
SELECT name_course, count(*) num_students FROM course c INNER JOIN enrollment e ON c.id = e.course_id GROUP BY name_course;

/* 8. Get the course name with the maximum number of enrollments*/
SELECT name_course, count(*) students_enrolled FROM course c INNER JOIN enrollment e 
ON c.id = e.course_id GROUP BY name_course ORDER BY students_enrolled DESC LIMIT 1;