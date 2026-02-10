-- 1
CREATE TABLE DEPARTMENT (
    dept_id INT, 
    dept_name VARCHAR2(50) NOT NULL,
    location VARCHAR2(50) NOT NULL,
    CONSTRAINT pk_dept PRIMARY KEY (dept_id)
);

-- 2
CREATE TABLE EMPLOYEE_BASIC (
    emp_id INT NOT NULL,
    full_name VARCHAR2(60) NOT NULL,
    email VARCHAR2(80) UNIQUE,
    phone VARCHAR(20),
    hire_date DATE,
    CONSTRAINT pk_emp_basic PRIMARY KEY (emp_id)
);

-- 3
CREATE TABLE JOB_ROLE (
    job_id INT,
    job_title VARCHAR2(40),
    min_salary INT DEFAULT 20000,
    max_salary INT,
    CONSTRAINT pk_job_role PRIMARY KEY (job_id),
    CONSTRAINT chk_job_sal CHECK(max_salary > min_salary)
);

-- 4
CREATE TABLE EMPLOYEE_PERSONAL (
    emp_id INT,
    gendet CHAR(1), 
    date_of_birth DATE,
    marital_status VARCHAR2(10),
    CONSTRAINT pk_emp_per PRIMARY KEY (emp_id),
    CONSTRAINT chk_gender CHECK(gender IN ('M', 'F')),
    CONSTRAINT chk_marriage_status CHECK(marital_status IN ('SINGLE', 'MARRIED'))
);
    
-- 5
CREATE TABLE EMPLOYEE_WORK (
    emp_id INT,
    dept_id INT,
    job_id INT,
    joining_date DATE,
    CONSTRAINT fk_dept FOREIGN KEY (dept_id) REFERENCES DEPARTMENT(dept_id),
    CONSTRAINT fk_job FOREIGN KEY (job_id) REFERENCES JOB_ROLE(job_id),
    CONSTRAINT pk_emp_wrk PRIMARY KEY (emp_id)
);

-- 6
CREATE TABLE PROJECT (
    project_id INT,
    project_name VARCHAR2(60),
    start_date DATE,
    end_date DATE,
    CONSTRAINT pk_proj_id PRIMARY KEY (project_id),
    CONSTRAINT chk_proj_date CHECK (start_date < end_date)
);

-- 7
CREATE TABLE PROJECT_ASSIGNMENT (
    emp_id INT,
    project_id INT,
    assigned_date DATE,
    CONSTRAINT pk_emp_proj_id PRIMARY KEY (emp_id, project_id),
    CONSTRAINT fk_emp_id FOREIGN KEY (emp_id) REFERENCES EMPLOYEE_WORK(emp_id),
    CONSTRAINT fk_proj_id FOREIGN KEY (project_id) REFERENCES PROJECT(project_id)
);