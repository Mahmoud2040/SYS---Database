create database clinic_db;

create table doctor
(
    id      int auto_increment primary key,
    name    varchar(150) unique not null,
    address varchar(255)        not null
);

create table doctor_certificates
(
    id        int auto_increment primary key,
    title     varchar(255),
    doctor_id int not null,

    foreign key (doctor_id) references doctor (id)
        on delete cascade
        on update cascade
);

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

