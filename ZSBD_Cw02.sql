DROP TABLE COUNTRIES cascade constraints;
DROP TABLE DEPARTMENTS cascade constraints;
DROP TABLE EMPLOYEES cascade constraints;
DROP TABLE JOB_HISTORY cascade constraints;
DROP TABLE JOBS cascade constraints;
DROP TABLE LOCATIONS cascade constraints;
DROP TABLE MASCHINE cascade constraints;
DROP TABLE PRODUCTION cascade constraints;
DROP TABLE REGIONS cascade constraints;

CREATE TABLE REGIONS AS SELECT * FROM HR.REGIONS;
CREATE TABLE COUNTRIES AS SELECT * FROM HR.COUNTRIES;
CREATE TABLE LOCATIONS AS SELECT * FROM HR.LOCATIONS;
CREATE TABLE DEPARTMENTS AS SELECT * FROM HR.DEPARTMENTS;
CREATE TABLE EMPLOYEES AS SELECT * FROM HR.EMPLOYEES;
CREATE TABLE JOB_HISTORY AS SELECT * FROM HR.JOB_HISTORY;
CREATE TABLE JOBS AS SELECT * FROM HR.JOBS;

alter table DEPARTMENTS add primary key (department_id);
alter table LOCATIONS add primary key (location_id);
alter table COUNTRIES add primary key (country_id);
alter table REGIONS add primary key (region_id);
alter table EMPLOYEES add primary key (employee_id);
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

select  e.last_name || ' : ' || e.salary AS wynagrodzenie
from employees e
where 1=1 and
    e.department_id IN(20,50) and 
    e.salary between 2000 and 7000
order by e.last_name;

select  e.hire_date,
        e.last_name,
        e.&&kolumna_uzytkownika
    from employees e
    where e.manager_id is not null 
    and e.hire_date >= DATE '2005-01-01' AND e.hire_date < DATE '2006-01-01'
    order by e.&&kolumna_uzytkownika;
    
select  e.first_name || ' ' || e.last_name AS osóbka,
        e.salary,
        e.phone_number
    from employees e
    where e.last_name LIKE '__e%'
        AND e.first_name LIKE '%' || '&&czesc_imiena' || '%'
    order by
        1 DESC,
        2 ASC;
        
select 
    e.first_name,
    e.last_name,
    e.salary,
    round(MONTHS_BETWEEN(DATE '2026-10-20', e.hire_date)) AS przepracowane_miesiace,
    CASE 
        WHEN (MONTHS_BETWEEN(DATE '2026-10-20', e.hire_date)) < 150 THEN e.salary * 0.10
        WHEN (MONTHS_BETWEEN(DATE '2026-10-20', e.hire_date)) BETWEEN 150 AND 200 THEN e.salary * 0.20
        ELSE e.salary * 0.30
    END AS wysokosc_dodatku
    from employees e
    order by przepracowane_miesiace desc;
    
select
    e.department_id,
    SUM(e.salary) AS suma_zarobkow,
    ROUND(AVG(e.salary)) AS srednia_zarobkow
    from employees e
    group by 
        e.department_id
    having 
        MIN(e.salary) > 5000;
        
select 
    e.last_name,
    e.department_id,
    d.department_name,
    e.job_id
from employees e
    join departments d on e.department_id = d.department_id
    join locations l on d.location_id = l.location_id
where l.city = 'Toronto';
        

