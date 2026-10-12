create table DEPARTMENTS(department_id INT primary key, depaetment_name VARCHAR2(40), manager_id INT, location_id INT);
create table LOCATIONS(location_id INT primary key, street_adress VARCHAR2(40), postal_code VARCHAR2(40), city VARCHAR2(30), state_province VARCHAR2(30), country_id INT);
create table COUNTRIES(country_id INT primary key, country_name VARCHAR2(40), region_id INT);
create table REGIONS(region_id INT primary key, region_name VARCHAR2(30));
create table EMPLOYEES(employee_id INT primary key, first_name VARCHAR2(30), last_name VARCHAR2(30), email VARCHAR2(30),phone_number VARCHAR2(20),hire_date DATE, job_id INT, salary NUMBER(8,2), commission_pct NUMBER(20,0), manager_id INT ,department_id INT);
create table JOB_HISTORY (employee_id INT, start_date DATE,end_date DATE,job_id INT);
alter table  JOB_HISTORY add department_id INT; 
create table JOBS(job_id INT, JOB_title VARCHAR2(30), min_salary NUMBER(8,2), max_salary NUMBER(8,2));
alter table JOBS add primary key (job_id);
alter table JOB_HISTORY add primary key (employee_id, start_date);

alter table DEPARTMENTS add foreign key (location_id) REFERENCES LOCATIONS(location_id);
alter table DEPARTMENTS add foreign key (manager_id) REFERENCES EMPLOYEES(employee_id);
alter table JOB_HISTORY add foreign key (department_id) REFERENCES DEPARTMENTS(department_id);
alter table EMPLOYEES add foreign key (job_id) REFERENCES JOBS(job_id);
alter table EMPLOYEES add foreign key (manager_id) REFERENCES EMPLOYEES(employee_id);
alter table EMPLOYEES add foreign key (department_id) REFERENCES DEPARTMENTS(department_id);
alter table LOCATIONS add foreign key (country_id) references COUNTRIES(country_id);
alter table COUNTRIES add foreign key (region_id) REFERENCES REGIONS(region_id);
alter table JOB_HISTORY add foreign key (job_id) REFERENCES JOBS(job_id);
alter table JOB_HISTORY add FOREIGN KEY (employee_id) REFERENCES EMPLOYEES(employee_id);

alter table JOBS ADD CONSTRAINT jobs_salary_check CHECK (max_salary - min_salary >= 2000);

insert into JOBS values(1, 'programista', 9000, 22000);
insert into JOBS values(2, 'administrator_IT', 6000, 12000);
insert into JOBS values(3, 'analityk_danych', 5000, 12000);
insert into JOBS values(4, 'kerownik', 9000, 15000);

insert into EMPLOYEES values(1, 'Dawid', 'Kowalski', 'dkowal@gmail.com', '678345890', date '2024-03-10', 4, 12000, 80, 1, null);
insert into EMPLOYEES values(2, 'Dominik', 'Chorzępa', 'dch@gmail.com', '678876890', date '2025-03-10', 2, 12000, 85, 1, null);
insert into EMPLOYEES values(3, 'Mateusz', 'Pawlak', 'mp@gmail.com', '128345890', date '2024-09-10', 3, 6000, 80, 1, null);
insert into EMPLOYEES values(4, 'Andrzej', 'Kłos', 'ak@gmail.com', '678545890', date '2024-03-11', 1, 12000, 80, 1, null);

update EMPLOYEES set manager_id = 1 where employee_id in (2,3);

update JOBS set min_salary = min_salary + 500 where job_title like '%b%' or job_title like '%s%';
update JOBS set max_salary = max_salary + 500 where job_title like '%b%' or job_title like '%s%';

update employees set job_id = null;
delete from JOBS where max_salary > 9000;

drop table job_history;
flashback table job_history to before drop;