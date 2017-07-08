--创建一个序列
create sequence seq maxvalue 9999999 start with 1 increment 
by 1;
--查询序列
select  seq.nextval from dual;
--删除序列
drop sequence seq;

create table test_info(
       t_id number primary key ,
       t_name varchar2(50) not null
);
--使用序列作为自增长(将序列插入到表中)
insert into test_info values(seq.nextval,'user1');
insert into test_info values(seq.nextval,'user2');
insert into test_info values(seq.nextval,'user3');
insert into test_info values(seq.nextval,'user4');
insert into test_info values(seq.nextval,'user5');

select * from test_info ;

--创建同义词
create public synonym aaa for test_info;
create public synonym aaa for test_info;
--创建或覆盖公有的同义词
create or replace public synonym aaa for test_info;

select * from aaa;

--创建私有同义词
create synonym aaa for test_info;
--访问私有同义词	
select * from aaa;
--删除同义词
drop synonym aaa;


--**********************************************************
                       --分区
                       --一、范围分区
--创建表空间
create tablespace tbs1
datafile 'H:\oracle\oradata\orcl\tbs1.bdf'
size 32m
autoextend on 
next 32m maxsize 2048m;

create tablespace tbs2
datafile 'H:\oracle\oradata\orcl\tbs2.bdf'
size 32m
autoextend on 
next 32m maxsize 2048m;

drop table users_info;
--范围分区
--创建表时使用范围表分区（根据ID范围存储）
create table users_info (
       u_id number primary key,
       u_name varchar2(50) not null,
       addr varchar2(255) not null,
       birth date not null
)partition by range(u_id)(
       partition part1 values less than(5) tablespace tbs1,
       partition part2 values less than(10) tablespace tbs2,
       partition part3 values less than(maxvalue) tablespace space01
);


--MAXVALUE代表了一个不确定的值，这个值高于其他分区中任何分区的键的值
insert into users_info values(1,'user1','珠海',to_date('1992-03-12','YYYY-MM-DD'));
insert into users_info values(2,'user2','江西',to_date('1974-03-22','YYYY-MM-DD'));
insert into users_info values(3,'user3','珠海',to_date('1672-03-12','YYYY-MM-DD'));
insert into users_info values(4,'user4','江西',to_date('1914-04-14','YYYY-MM-DD'));
insert into users_info values(5,'user5','香港',to_date('1871-03-12','YYYY-MM-DD'));
insert into users_info values(6,'user6','香港',to_date('1997-03-29','YYYY-MM-DD'));
insert into users_info values(7,'user7','香港',to_date('1996-03-18','YYYY-MM-DD'));
insert into users_info values(8,'user8','珠海',to_date('1996-03-16','YYYY-MM-DD'));
insert into users_info values(9,'user9','江西',to_date('1998-03-12','YYYY-MM-DD'));
insert into users_info values(10,'user10','珠海',to_date('1990-03-11','YYYY-MM-DD'));
insert into users_info values(11,'user11','珠海',to_date('1790-03-11','YYYY-MM-DD'));
insert into users_info values(12,'user12','珠海',to_date('1992-03-18','YYYY-MM-DD'));
insert into users_info values(13,'user13','珠海',to_date('1851-03-16','YYYY-MM-DD'));
insert into users_info values(14,'user14','珠海',to_date('1905-03-30','YYYY-MM-DD'));
insert into users_info values(15,'user15','珠海',to_date('1995-03-13','YYYY-MM-DD'));
truncate table users_info;
--查询
select * from users_info ;

--分区查询（根据ID）
select * from users_info partition(part1);
select * from users_info partition(part2);
select * from users_info partition(part3);


--按日期范围划分
--创建表时使用范围分区（根据日期范围存储）
drop table users_info;
create table users_info(
       u_id number primary key not null,
       u_name varchar2(50) not null,
       addr varchar2(255) not null,
       birth date not null
)partition by range(birth)(
       partition part1 values less than(to_date('1983-03-01','yyyy-mm-dd')) tablespace tbs1,
       partition part2 values less than(to_date('1983-07-01','yyyy-mm-dd')) tablespace tbs2,
       partition part3 values less than(maxvalue) tablespace space01
);

--分区查询（按日期）
select * from users_info partition(part1);
select * from users_info partition(part2);
select * from users_info partition(part3);
       
                            --二、hash分区
--根据hash算法使用hash分区
create table users_info(
       u_id number primary key not null,
       u_name varchar2(50) not null,
       addr varchar2(255) not null,
       birth date not null
)partition by hash(u_id)(
       partition part1 tablespace tbs1,
       partition part2 tablespace tbs2,
       partition part3 tablespace space01
);    

--分区查询（hash查询,随机划分）
select * from users_info partition(part1);   
select * from users_info partition(part2);
select * from users_info partition(part3); 


                                 --三、list分区
--根据地址字段使用列表分区 
drop table users_info;                                                    
create table users_info(
       u_id number primary key not null,
       u_name varchar2(50) not null,
       addr varchar2(255) not null,
       birth date not null
)partition by list(addr)(
       partition part1 values('珠海') tablespace tbs1,
       partition part2 values('江西') tablespace tbs2,
       partition part3 values('香港') tablespace space01
);   

--list查询
select * from users_info partition(part1); 
select * from users_info partition(part2);
select * from users_info partition(part3);  

                                --三、组合分区
                                --1、范围加列表
drop table users_info;
create table users_info(
       u_id number primary key not null,
       u_name varchar2(50) not null,
       addr varchar2(255) not null,
       birth date not null
)partition  by range(birth) --主分区使用范围分区
 subpartition by list(addr) --子分区使用list分区
(
 partition part1 values less than(to_date('1970-01-01','yyyy-mm-dd')) tablespace tbs1
(
     subpartition subpart1 values('珠海'),
     subpartition subpart2 values('江西'),
     subpartition subpart3 values('香港')
 ),
 partition part2 values less than(to_date('1983-07-01','yyyy-mm-dd')) tablespace tbs2
 (
     subpartition subpart4 values('珠海'),
     subpartition subpart5 values('江西'),
     subpartition subpart6 values('香港')
 ),
 partition part3 values less than(maxvalue) tablespace space01
);
--查询整个分区内的所有数据
select * from users_info partition(part1);
select * from users_info partition(part2);
select * from users_info partition(part3);

--查询子分区内的数据
select * from users_info subpartition(subpart1);
select * from users_info subpartition(subpart2);
select * from users_info subpartition(subpart3);
                                 --2、范围加hash
drop table users_info;
create table users_info(
       u_id number primary key not null,
       u_name varchar2(50) not null,
       addr varchar2(255) not null,
       birth date not null
)partition  by range(birth) --主分区使用范围分区
 subpartition by hash(addr) --子分区使用hash分区
(
 partition part1 values less than(to_date('1970-01-01','yyyy-mm-dd')) tablespace tbs1
(
     subpartition subpart1,
     subpartition subpart2,
     subpartition subpart3 
 ),
 partition part2 values less than(to_date('1983-07-01','yyyy-mm-dd')) tablespace tbs2
 (
     subpartition subpart4,
     subpartition subpart5,
     subpartition subpart6
 ),
 partition part3 values less than(maxvalue) tablespace space01
);        


--查询整个分区内的所有数据
select * from users_info partition(part1);
select * from users_info partition(part2);
select * from users_info partition(part3);

--查询子分区内的数据
select * from users_info subpartition(subpart1);
select * from users_info subpartition(subpart2);
select * from users_info subpartition(subpart3);                         


--********************************************************
--添加主分区
alter table users_info add partition part4 values less than(maxvalue) tablespace tbs1
--添加子分区
alter table users_info modify partition part1 
add subparttion subpart3 values('深圳')
	--删除分区
--删除主分区
alter table users_info drop partition part1
--删除子分区
alter table users_info drop partition subpart1
	--重命名表分区
alter table users_info rename partition subpart1 to subpart0
--	显示数据库所有分区表的信息
select * from DBA_PART_TABLES
	--显示当前用户所有分区表的信息
select * from USER_PART_TABLES
	--查询指定表分区数据
select * from users_info partition(part1)--主分区
select * from users_info subpartition(subpart1)--子分区
	--删除分区表一个分区的数据
alter table users_info truncate partition part1


--**************************分割线（,拆分表）*******************************
drop table users_info;

--创建一个序列
create sequence seq minvalue 1000 maxvalue 999999 start with 1000
increment by 1;

--创建用户表
create table users_info (
       u_id number primary key,
       u_name varchar2(50)not null,
       u_addr varchar2(200)not null
);

--创建多个订票记录表
create table tickets_0(
       t_id number primary key ,
       price number not null,
       begin_route varchar2(50)not null, --起点站
       end_route varchar2(50)not null,   --终点站
       u_id number references users_info(u_id)
); 

create table tickets_1(
       t_id number primary key ,
       price number not null,
       begin_route varchar2(50)not null,
       end_route varchar2(50)not null,
       u_id number references users_info(u_id)
);

create table tickets_2(
       t_id number primary key ,
       price number not null,
       begin_route varchar2(50)not null,
       end_route varchar2(50)not null,
       u_id number references users_info(u_id)
);

insert into users_info values(seq.nextval,'user1','珠海');
insert into users_info values(seq.nextval,'user2','广东');
insert into users_info values(seq.nextval,'user3','江西');

select * from users_info;

insert into tickets_0 values(seq.nextval,11,'香港','江西',1002);
select * from tickets_0;
select * from tickets_1;
select * from tickets_2;

--查询合并
select * from tickets_0
union 
select * from tickets_1
union 
select * from tickets_2;

