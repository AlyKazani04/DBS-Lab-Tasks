-- 1
--CREATE TABLE DEPARTMENT (
--    dept_id NUMBER, 
--    dept_name VARCHAR2(50) NOT NULL,
--    location VARCHAR2(50) NOT NULL,
--    CONSTRAINT pk_dept PRIMARY KEY (dept_id)
--);

-- 2
--CREATE TABLE EMPLOYEE_BASIC (
--    emp_id NUMBER NOT NULL,
--    full_name VARCHAR2(60) NOT NULL,
--    email VARCHAR2(80) UNIQUE,
--    phone VARCHAR(20),
--    hire_date DATE,
--    CONSTRAINT pk_emp_basic PRIMARY KEY (emp_id)
--);

-- 3
--CREATE TABLE JOB_ROLE (
--    job_id NUMBER,
--    job_title VARCHAR2(40),
--    min_salary NUMBER DEFAULT 20000,
--    max_salary NUMBER,
--    CONSTRAINT pk_job_role PRIMARY KEY (job_id),
--    CONSTRAINT chk_job_sal CHECK(max_salary > min_salary)
--);

-- 4
--CREATE TABLE EMPLOYEE_PERSONAL (
--    emp_id NUMBER,
--    gender CHAR(1), 
--    date_of_birth DATE,
--    marital_status VARCHAR2(10),
--    CONSTRAINT pk_emp_per PRIMARY KEY (emp_id),
--    CONSTRAINT chk_gender CHECK (gender IN ('M', 'F')),
--    CONSTRAINT chk_marriage_status CHECK(marital_status IN ('SINGLE', 'MARRIED'))
--);
    
-- 5
--CREATE TABLE EMPLOYEE_WORK (
--    emp_id NUMBER,
--    dept_id NUMBER,
--    job_id NUMBER,
--    joining_date DATE,
--    CONSTRAINT fk_dept FOREIGN KEY (dept_id) REFERENCES DEPARTMENT(dept_id),
--    CONSTRAINT fk_job FOREIGN KEY (job_id) REFERENCES JOB_ROLE(job_id),
--    CONSTRAINT pk_emp_wrk PRIMARY KEY (emp_id)
--);

-- 6
--CREATE TABLE PROJECT (
--    project_id NUMBER,
--    project_name VARCHAR2(60),
--    start_date DATE,
--    end_date DATE,
--    CONSTRAINT pk_proj_id PRIMARY KEY (project_id),
--    CONSTRAINT chk_proj_date CHECK (start_date < end_date)
--);

-- 7
--CREATE TABLE PROJECT_ASSIGNMENT (
--    emp_id NUMBER,
--    project_id NUMBER,
--    assigned_date DATE,
--    CONSTRAINT pk_emp_proj_id PRIMARY KEY (emp_id, project_id),
--    CONSTRAINT fk_emp_id FOREIGN KEY (emp_id) REFERENCES EMPLOYEE_WORK(emp_id),
--    CONSTRAINT fk_proj_id FOREIGN KEY (project_id) REFERENCES PROJECT(project_id)
--);

-- 8
--ALTER TABLE PROJECT_ASSIGNMENT DROP CONSTRAINT fk_emp_id;
--ALTER TABLE PROJECT_ASSIGNMENT ADD CONSTRAINT fk_emp_id
--    FOREIGN KEY (emp_id) REFERENCES EMPLOYEE_WORK(emp_id)
--    ON DELETE CASCADE;
    
-- 9
--ALTER TABLE EMPLOYEE_WORK DROP CONSTRAINT fk_dept;
--ALTER TABLE EMPLOYEE_WORK ADD CONSTRAINT fk_dept
--    FOREIGN KEY (dept_id) REFERENCES DEPARTMENT(dept_id)
--    ON DELETE SET NULL;
    
-- 10
--CREATE TABLE CLIENT (
--    client_id NUMBER,
--    client_name VARCHAR2(40),
--    email VARCHAR2(60),
--    client_type VARCHAR2(20),
--    country VARCHAR2(30)
--);

-- 11
--ALTER TABLE CLIENT ADD CONSTRAINT pk_cl_id PRIMARY KEY (client_id);
--ALTER TABLE CLIENT ADD CONSTRAINT email_uni UNIQUE (email);
--ALTER TABLE CLIENT ADD CONSTRAINT cli_type 
--    CHECK (client_type IN ('LOCAL', 'INTERNATIONAL'));
    
-- 12
--ALTER TABLE CLIENT MODIFY client_name VARCHAR2(80);
--ALTER TABLE CLIENT MODIFY email VARCHAR2(60) NOT NULL;
--ALTER TABLE CLIENT MODIFY country VARCHAR2(30) DEFAULT 'PAKISTAN';

-- 13
--ALTER TABLE CLIENT DROP CONSTRAINT cli_type;
--ALTER TABLE CLIENT RENAME CONSTRAINT email_uni TO uniq_email;

-- 14
--CREATE TABLE EMPLOYEE_BACKUP AS SELECT * FROM EMPLOYEE_WORK;

-- 15
--CREATE TABLE PAYROLL (
--    emp_id NUMBER,
--    salary NUMBER,
--    bonus NUMBER DEFAULT 0,
--    pay_date DATE,
--    CONSTRAINT pk_emp_paydate PRIMARY KEY (emp_id, pay_date),
--    CONSTRAINT chk_pos_nums CHECK (emp_id >= 0 AND salary >= 0 AND bonus >= 0),
--    CONSTRAINT fk_emp_id_payroll FOREIGN KEY (emp_id) REFERENCES EMPLOYEE_WORK(emp_id)
--);

-- 16
--CREATE TABLE ATTENDANCE (
--    attendance_id NUMBER,
--    emp_id NUMBER,
--    project_id NUMBER,
--    dept_id NUMBER,
--    attendance_date DATE,
--    CONSTRAINT pk_attend_id PRIMARY KEY (attendance_id),
--    CONSTRAINT fk_emp_id_attend FOREIGN KEY (emp_id) REFERENCES EMPLOYEE_WORK(emp_id),
--    CONSTRAINT fk_proj_id_attend FOREIGN KEY (project_id) REFERENCES PROJECT(project_id),
--    CONSTRAINT fk_dept_id_attend FOREIGN KEY (dept_id) REFERENCES DEPARTMENT(dept_id)
--);

-- 17
--ALTER TABLE PROJECT_ASSIGNMENT DISABLE CONSTRAINT fk_emp_id;
--ALTER TABLE PROJECT_ASSIGNMENT ENABLE CONSTRAINT fk_emp_id;

-- 18
--CREATE TABLE LEAVE_APPLICATION (
--    leave_id NUMBER,
--    emp_id NUMBER,
--    start_date DATE,
--    end_date DATE,
--    leave_days NUMBER,
--    CONSTRAINT pk_leave_id PRIMARY KEY (leave_id),
--    CONSTRAINT fk_emp_id_leave FOREIGN KEY (emp_id) REFERENCES EMPLOYEE_WORK(emp_id),
--    CONSTRAINT chk_leave_days CHECK (leave_days <= 30),
--    CONSTRAINT chk_date_logic CHECK (start_date < end_date)
--);

-- 19
--DROP TABLE DEPARTMENT;

-- 20
