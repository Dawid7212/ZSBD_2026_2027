--Zad1
create view v_wysokie_pensje as select * from employees e
    where e.salary >6000;
select * from v_wysokie_pensje;

--Zad2
replace view v_wysokie_pensje as
    select * from employees e
    where e.salary > 12000;

select * from v_wysokie_pensje order by salary;

--Zad3
drop view v_wysokie_pensje;

--Zad4
create view v_pracownicy_finansisci as
    select 
        e.last_name, 
        e.first_name, 
        d.department_name
    from employees e
    join departments d on e.department_id = d.department_id
    where d.department_name = 'Finance';
    
select * from v_pracownicy_finansisci;

--Zad5
create view v_pensje_LudzieDoZwolnienia as 
    select 
    e.employee_id,
    e.last_name, 
    e.first_name, 
    e.salary, 
    e.job_id, email, 
    e.hire_date
from employees e
where e.salary between 5000 and 12000;

select * from v_pensje_LudzieDoZwolnienia order by salary desc;

--Zad6
select * from employees;
select * from v_pracownicy_finansisci;
insert into v_pracownicy_finansisci (last_name, first_name, department_name) 
    values ('Nowak', 'Jan', 'Finance');
--dodanie pracownika do widoku nie powiodło się

update v_pracownicy_finansisci
set first_name = 'Janusz'
where first_name = 'Daniel';
--aktualizacja też się powiodła

delete from v_pracownicy_finansisci
where first_name = 'Janusz';
--usunięcie też się powiodła
--usunięcie lub aktualizacja rekordów w wikoku nie powoduje zmian w tabelach z któryh pochodzą


--Zad7