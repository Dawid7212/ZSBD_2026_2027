create table production(production_id INT GENERATED ALWAYS AS IDENTITY primary key , maschine_id VARCHAR2(30), quatitty NUMBER(10,0));
create table maschine(mashine_id INT GENERATED ALWAYS AS IDENTITY primary key, maschine_name VARCHAR2(40));
alter table production modify maschine_id INT;
alter table production add foreign key (maschine_id) references maschine(mashine_id);  

insert into maschine(maschine_name) values ('M130');
insert into production(maschine_id, quatitty) values (2, 200);