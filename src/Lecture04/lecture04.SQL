CREATE TABLE book
(
    id               int auto_increment primary key,
    title            varchar(255) NOT NULL,
    isbn             varchar(13)       DEFAULT NULL,
    copies_available int               DEFAULT '1',
    created_at       timestamp    NULL DEFAULT CURRENT_TIMESTAMP

);

create table book_details
(
    id             int auto_increment primary key,
    author         varchar(255) NOT NULL,
    published_year int DEFAULT NULL,
    book_id        int unique,
    foreign key (book_id) references book (id)
        on delete cascade
        on update cascade
);


CREATE TABLE member
(
    id                int auto_increment primary key,
    name              varchar(255) NOT NULL,
    join_date         timestamp  DEFAULT CURRENT_TIMESTAMP,
    is_active         tinyint(1) DEFAULT '1',
    membership_period int          NOT NULL
);

create table member_details
(
    member_id int primary key,
    email     varchar(255) NOT NULL,
    phone     varchar(20) DEFAULT NULL,
    foreign key (member_id) references member (id)
        on delete cascade
        on update cascade
);

CREATE TABLE loans
(
    id          int AUTO_INCREMENT primary key,
    member_id   int  NOT NULL,
    book_id     int  NOT NULL,
    loan_date   date NOT NULL DEFAULT (curdate()),
    return_date date          DEFAULT NULL,
    status      varchar(20),
    due_date    date          DEFAULT NULL,
    foreign key (member_id) references member (id)
        on delete restrict
        on update cascade,
    foreign key (book_id) references book (id)
        on delete restrict
        on update cascade
);


INSERT INTO book (title, isbn, copies_available)
VALUES ('Clean Code', '9780132350884', 5),
       ('Effective Java', '9780134685991', 3),
       ('The Pragmatic Programmer', '9780201616224', 4),
       ('Design Patterns', '9780201633610', 2),
       ('Refactoring', '9780201485677', 6);

INSERT INTO book_details (author, published_year, book_id)
VALUES ('Robert C. Martin', 2008, 1),
       ('Joshua Bloch', 2018, 2),
       ('Andrew Hunt & David Thomas', 1999, 3),
       ('Erich Gamma et al.', 1994, 4),
       ('Martin Fowler', 1999, 5);


INSERT INTO member (name, membership_period)
VALUES ('Alice Johnson', 12),
       ('Bob Smith', 6),
       ('Charlie Brown', 24),
       ('Diana Evans', 18),
       ('Ethan Clark', 12);


INSERT INTO member_details (member_id, email, phone)
VALUES (1, 'alice.johnson@example.com', '+201111111111'),
       (2, 'bob.smith@example.com', '+201222222222'),
       (3, 'charlie.brown@example.com', '+201333333333'),
       (4, 'diana.evans@example.com', '+201444444444'),
       (5, 'ethan.clark@example.com', '+201555555555');

INSERT INTO loans (member_id, book_id, loan_date, due_date, status, return_date)
VALUES (1, 2, '2025-11-01', '2026-11-15', 'borrowed', null),
       (3, 5, '2025-10-20', '2025-11-03', 'returned', null),
       (4, 1, '2025-11-02', '2026-11-16', 'borrowed', '2026-12-16'),
       (3, 5, '2025-10-20', '2026-11-03', 'borrowed', null);


select *
from loans;

update loans
set status = 'overdue'
where id = 2;


select title, published_year
from book
         inner join book_details on book.id = book_details.book_id;

select member.name, loans.id, loans.due_date
from member
         inner join loans on member.id = loans.member_id;

select member.name, book.title, loans.id, loans.due_date
from member
         inner join loans on member.id = loans.member_id
         inner join book on book.id = loans.book_id
;

select m.name, b.title, l.id, l.due_date
from member m
         inner join loans l on m.id = l.member_id
         inner join book b on b.id = l.book_id
;

select m.name , m.id , l.id , l.due_date
from member m
left join loans l on m.id = l.member_id
where l.id is null
;