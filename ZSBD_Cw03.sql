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
create or replace view v_zadanie7 as
select
    d.department_id,
    d.department_name,
    count(e.employee_id) as liczba_pracownikow,
    avg(e.salary) as srednia_pensja,
    max(e.salary) as naj_pensja
from departments d
join employees e on e.department_id = d.department_id
group by d.department_id, d.department_name
having count(e.employee_id) >= 4;

select * from v_zadanie7 order by liczba_pracownikow;

insert into v_statystyki_dzialow (
    department_id,
    department_name,
    liczba_pracownikow,
    srednia_pensja,
    najwyzsza_pensja
)
values (
    999,'dzial R&D',4,7000,10000
);
--Do tak zdefiniowanego widoku nie można bezpośrednio dodawać danych, ponieważ zawiera group by oraz funkcje agregujące t.j. count, avg i max. 
--Jeden wiersz widoku jest podsumowaniem całego działu, a nie pojedynczym rekordem pracownika

--Zad8
create view v_wysokie_pensje_Zad8 as select * from employees e
    where e.salary >12000
    with check option;
        
select * from v_wysokie_pensje_Zad8;

insert into v_wysokie_pensje_Zad8(
    employee_id,
    last_name,
    first_name,
    email,
    hire_date,
    job_id,
    salary
)
values (5367,'Bogaty','Jan','bogacz@wp.pl',sysdate,'AD_VP',13000);
--warunek with check option nie zezwolił na dodanie pracownika o zarobkach niższych niż zadelklarowano w nagłówku

--Zad9
create materialized view mv_managerowie
build immediate    --dane zostają zapisane w widoku od razu podczas tworzenia mview
refresh complete on demand   -- odświerzenie wyników na żądanie a nie po zmienie po zmienie w tabeli źródłowej
as select 
    e.employee_id,
    e.first_name,
    e.last_name,
    d.department_id,
    d.department_name
from employees e
join departments d on d.manager_id = e.employee_id;

select * from mv_managerowie;

exec dbms_mview.refresh('v_managerowie', 'c');  --oświerzanie zawartości mv, 'c' oznacza complete, czyli pełne odświeżenie


--Zad10
create view v_najlepiej_oplacani as
select * from employees
order by salary desc nulls last, employee_id
fetch first 10 rows only;

select * from v_najlepiej_oplacani;
