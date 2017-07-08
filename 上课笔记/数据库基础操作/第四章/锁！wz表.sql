create table users_info(
       u_name varchar2(50),
       age number,
       addr varchar2(50)
);
grant dba to test1,test2;

drop table users_info;
select * from users_info;
insert into users_info values('wz',15,'½­Î÷');
