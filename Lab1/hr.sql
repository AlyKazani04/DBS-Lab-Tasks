-- 1
select * from jobs;

-- 2
select min_salary, max_salary from jobs
where JOB_TITLE = 'President';

-- 3
select * from employees 
where  SALARY > 20000;

-- 4
select job_id from employees
where  salary >= 15000;

-- 5
select employee_id, first_name, last_name, department_id from employees
where last_name = 'Snares';

-- 6
select employee_id, first_name, last_name, department_id from employees
where department_id = 57;

-- 7
select phone_number from employees
where department_id = 80 and manager_id = 100;

-- 8
select * from employees
where first_name in ('John', 'NEENA', 'Lency');

-- 9
select city from locations
where country_id = 'IT';

-- 10
select city from locations
where country_id not in ('IN', 'CH');

-- 11
select * from jobs
where min_salary > 8000 and min_salary < 15000;

-- 12
select phone_number from employees
where department_id = 90 and job_id != 'IT_PROG';

-- 13
select * from employees
where hire_date > '12-Dec-07';

-- 14
select * from employees
where hire_date > '12-Dec-07' and department_id = 100;

-- 15
select * from employees
where hire_date > '12-Dec-07' and department_id != 100;

-- 16
select * from employees
where COMMISSION_PCT = 0 and department_id not in (90, 100);

-- 17
select * from employees
where hire_date >= '1-JAN-10' and hire_date <= '31-DEC-10';

-- 18
select * from jobs
where min_salary > 8000 and min_salary < 15000;

-- 19
select first_name, last_name, job_id from employees
where department_id > 90 and department_id < 100 and employee_id > 100 and employee_id < 150;

-- 20
select salary, commission_pct, salary + coalesce(commission_pct,0) * salary as total_salary from employees;

-- Practice Tasks
-- 1
select email from employees
where manager_id = 101 and department_id = 50;

-- 2
select * from departments
where department_name = 'Finance/Sales/SA_RE';

-- 3
select AVG((min_salary + max_salary) / 2) as average_manager_salary from jobs
where job_title like '%Manager';

-- 4
select * from employees
where salary < 10000;

-- 5
select * from jobs
where max_salary <= 20000;

-- 6
select employee_id, first_name, last_name, department_id from employees
where last_name = 'Jones';

-- 7
select city from locations
where country_id = 'IT';

-- 8
select phone_number from employees
where manager_id = 100 and department_id = 80;

-- 9
select * from employees
where job_id not like 'SA%';

-- 10
select * from employees
where first_name like 'A%';

-- 11
select * from employees
where salary > 50000 and job_id like 'SA%';