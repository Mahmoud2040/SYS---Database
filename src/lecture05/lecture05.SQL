select * from book;
select * from member;
select * from loans;

select count(*) as no_of_books from book;
select count(*) as no_of_loans from loans;

select min(loan_date) as earliest_loan, max(loan_date) as latest_loan from loans;

select min(member.membership_period) , max(member.membership_period) from member;

select m.id ,  m.name , count(l.id)
from member m left join loans l on m.id = l.member_id
group by m.id , m.name;

select b.title , count(l.id)
from book b left join library_db.loans l on b.id = l.book_id
group by b.title;

select avg(member.membership_period) from member;

select m.id ,  m.name , count(l.id)
from member m left join loans l on m.id = l.member_id
group by m.id , m.name
having count(l.id) > 1
;

select  b.title , count(DISTINCT l.member_id)
from book b left join loans l on b.id = l.book_id
group by  b.title
having count(DISTINCT l.member_id) > 0
;

select m.id ,  m.name , count(l.id)
from member m left join loans l on m.id = l.member_id
where l.status = 'overdue'
group by m.id , m.name
;