create database clinic_db;

create table doctor
(
    id      int auto_increment primary key,
    name    varchar(150) unique not null,
    address varchar(255)        not null
);

insert into doctor (name, address)
values('mahmoud saied bahaa' , 'matrouh'),
      ('fathy Ahmed' , 'Alex'),
      ('Abdelghafour fathy' , 'Giza'),
      ('soad saied' , 'Alex'),
      ('fatma saied' , 'Cairo')
      ;
create table doctor_certificates
(
    id        int auto_increment primary key,
    title     varchar(255),
    doctor_id int not null,

    foreign key (doctor_id) references doctor (id)
        on delete cascade
        on update cascade
);

insert into doctor_certificates (title, doctor_id)
values ('bbc' , 1),
       ('ccc' , 1),
       ('RRc' , 7),
       ('bbc' , 7),
       ('ccc' , 7),
       ('ccc' , 11),
       ('ccc' , 9);

create table client
(
    id   int auto_increment primary key,
    name varchar(150) unique not null,
    age  int                 not null
);


create table client_details
(
    id        int auto_increment primary key,
    address   varchar(150) unique not null,
    phone     varchar(13)         not null,
    client_id int unique,
    foreign key (client_id) references client (id)
        on delete cascade
        on update cascade
);

create table visit
(
    id         int auto_increment primary key,
    doctor_id  int,
    client_id  int,
    visit_date timestamp default current_timestamp,

    foreign key (doctor_id) references doctor (id),
    foreign key (client_id) references client (id)

);

create table visit
(
    doctor_id int,
    client_id int,

    primary key (doctor_id, client_id),
    foreign key (doctor_id) references doctor (id),
    foreign key (client_id) references client (id)

);


select d.name , d.address , dc.title
    from doctor d
inner join doctor_certificates dc
    on d.id = dc.doctor_id;


select d.name , d.address , dc.title
from doctor d
         right join doctor_certificates dc
                    on d.id = dc.doctor_id;


select d.name , d.address , dc.title
from doctor d
         cross join doctor_certificates dc
                    on d.id = dc.doctor_id;




select d.name , d.address, count(*) as certificates
from doctor d
    left join doctor_certificates dc on d.id = dc.doctor_id
where d.id in (7,9)
group by d.name , d.address
having certificates > 1;

select book.title , count(*) as borrow_count_main
from book
    left join loans on book.id = loans.book_id
    group by book.id , book.title
    having
    borrow_count_main > ( select avg(aa.borrow_count) from (select count(*) as borrow_count from book left join loans on book.id = loans.book_id group by book.id) as aa);




