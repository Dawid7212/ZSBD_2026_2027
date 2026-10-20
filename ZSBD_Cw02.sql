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

--Zadanie1
select  e.last_name || ' : ' || e.salary AS wynagrodzenie
from employees e
where 1=1 and
    e.department_id IN(20,50) and 
    e.salary between 2000 and 7000
order by e.last_name;

--Zadanie2
select  e.hire_date,
        e.last_name,
        e.&&kolumna_uzytkownika
    from employees e
    where e.manager_id is not null 
    and e.hire_date >= DATE '2005-01-01' AND e.hire_date < DATE '2006-01-01'
    order by e.&&kolumna_uzytkownika;

--Zadanie3  
select  e.first_name || ' ' || e.last_name AS osóbka,
        e.salary,
        e.phone_number
    from employees e
    where e.last_name LIKE '__e%'
        AND e.first_name LIKE '%' || '&&czesc_imiena' || '%'
    order by
        1 DESC,
        2 ASC;

--Zadanie4      
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
 
--Zadanie5   
select
    e.department_id,
    SUM(e.salary) AS suma_zarobkow,
    ROUND(AVG(e.salary)) AS srednia_zarobkow
    from employees e
    group by 
        e.department_id
    having 
        MIN(e.salary) > 5000;

--Zadanie6         
select 
        e.last_name,
        e.department_id,
        d.department_name,
        e.job_id
    from employees e
        join departments d on e.department_id = d.department_id
        join locations l on d.location_id = l.location_id
    where l.city = 'Toronto';
        
--Zadanie7
select 
        e.first_name || ' ' || e.last_name as Jenifer,
        colleague.first_name || ' ' || colleague.last_name as wspolpracownik,
        colleague.department_id
    from 
        employees e
        join employees colleague on e.department_id = colleague.department_id
    where 
        e.first_name = 'Jennifer'
        and e.employee_id != colleague.employee_id;
        
--Zadanie8
select 
        d.department_id,
        d.department_name
    from 
        departments d
    where 
        not exists (select * from employees e where e.department_id = d.department_id);

--Zadanie9
select 
        e.first_name,
        e.last_name,
        j.job_title,
        d.department_name,
        e.salary
    from 
        employees e
        join jobs j ON e.job_id = j.job_id
        join departments d on e.department_id = d.department_id;
        
--Zadanie10      
select 
        e.first_name,
        e.last_name,
        e.salary
    from 
        employees e
    where 
        e.salary > (select avg(salary) from employees)
    order by 
        e.salary desc;
        
--Zadanie11
with UuUu as (
    select distinct department_id
    from employees
    where last_name like '%u%'
)
select 
        e.employee_id,
        e.first_name,
        e.last_name,
        e.department_id
    from 
        employees e
    where
        e.department_id in (select department_id from UuUu);
        
--Zadanie12 
select round(avg(months_between(sysdate, hire_date))) as srednia from employees;
select 
        e.first_name,
        e.last_name,
        e.hire_date,
        round(months_between(sysdate, e.hire_date)) as przepracowane_MSC
    from 
        employees e
    where 
        months_between(sysdate, e.hire_date) > (select avg(months_between(sysdate, hire_date)) from employees);

--Zadanie13
select 
        d.department_name,
        count(e.employee_id) as liczba_pracownikow,
        round(avg(e.salary), 2) as srednie_wynagrodzenie
    from 
        departments d
        join employees e on d.department_id = e.department_id
    group by 
        d.department_name
    order by 
    liczba_pracownikow desc;

--Zadanie14
with achIT as (
select  min(e2.salary)
        from employees e2
        join departments d on e2.department_id = d.department_id
        where d.department_name = 'IT'
)
select 
        e.first_name,
        e.last_name,
        e.salary
    from 
        employees e
    where 
        e.salary < (select * from achIT);
 
--Zadanie15        
select distinct 
        d.department_id,
        d.department_name
    from 
        departments d
        join employees e on d.department_id = e.department_id
    where 
        e.salary > (select avg(salary) from employees);
        
--Zadanie16
select 
        j.job_title,
        round(avg(e.salary), 2) as srednie_zarobki
    from 
        employees e
        join jobs j on e.job_id = j.job_id
    group by 
        j.job_title
    order by 
        avg(e.salary) desc
    fetch first 5 rows only;
         
 --Zadanie17        
select 
        r.region_name,
        count(distinct c.country_id) as liczba_krajow,
        count(e.employee_id) as liczba_pracownikow
    from 
        regions r
        left join countries c on r.region_id = c.region_id
        left join locations l on c.country_id = l.country_id
        left join departments d on l.location_id = d.location_id
        left join employees e on d.department_id = e.department_id
    group by 
        r.region_name;
        
--Zadanie18        
select 
    e.first_name as imie_p,
    e.last_name as nazwisko_p,
    e.salary as zarobki_p,
    m.first_name as imie_m,
    m.last_name as nazwisko_m,
    m.salary as zarobki_m
from 
    employees e
    join employees m on e.manager_id = m.employee_id
where 
    e.salary > m.salary;
    
--Zadanie19
select 
        extract(month from hire_date) as miesiac,
        count(employee_id) as liczbaZatrudionychPracownikow
    from 
        employees
    group by 
        extract(month from hire_date)
    order by 
        miesiac;

--Zadanie20
select 
        d.department_name,
        round(avg(e.salary), 2) as srednie
    from 
        departments d
        join employees e on d.department_id = e.department_id
    group by 
        d.department_id,
        d.department_name
    order by 
        avg(e.salary) desc
    fetch first 3 rows only;