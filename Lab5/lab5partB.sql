-- PART B

CREATE TABLE Students (
    student_id NUMBER PRIMARY KEY,
    student_name VARCHAR2(50),
    department VARCHAR2(50),
    semester NUMBER
);

CREATE TABLE Courses (
    course_id NUMBER PRIMARY KEY,
    course_name VARCHAR2(50),
    credit_hours NUMBER
);

CREATE TABLE Enrollments (
    enroll_id NUMBER PRIMARY KEY,
    student_id NUMBER,
    course_id NUMBER,
    grade VARCHAR2(2),
    CONSTRAINT fk_student
    FOREIGN KEY (student_id) REFERENCES Students(student_id),
    CONSTRAINT fk_course
    FOREIGN KEY (course_id) REFERENCES Courses(course_id)
);

-- 1
INSERT INTO STUDENTS (STUDENT_ID, STUDENT_NAME, DEPARTMENT, SEMESTER)
VALUES (101, 'Ali Khan', 'CS', 3);

-- 2
INSERT INTO STUDENTS
VALUES (102, 'Sara Ahmed', 'AI', 2);

-- 3
INSERT INTO COURSES
VALUES (501, 'Database Systems', 3);

-- 4
INSERT INTO COURSES
VALUES (502, 'Operating Systems', 4);

-- 5
INSERT INTO ENROLLMENTS VALUES (1, 101, 501, 'A');

-- 6
UPDATE STUDENTS SET SEMESTER = 3 WHERE STUDENT_ID = 102;

-- 7
UPDATE COURSES SET CREDIT_HOURS = 4 WHERE COURSE_ID = 501;

-- 8
UPDATE ENROLLMENTS SET GRADE = 'A+' WHERE STUDENT_ID = 101 AND COURSE_ID = 501;

-- 9
DELETE FROM STUDENTS WHERE STUDENT_ID = 102;

-- 10
DELETE FROM COURSES WHERE COURSE_ID = 502;