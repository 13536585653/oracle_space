

--创建班级表
create table class_info(
       c_id number primary key,
       c_name varchar2(50)
);

--学员表
create table stu_info(
       s_id number primary key ,
       s_name varchar2(50) not null,
       s_age number not null,
       s_sex char(20),
       c_id number references class_info(c_id) --外键关联
);

--成绩表
create table score_info(
       sub_id number primary key ,
       sub_name varchar2(50) not null,--科目名称
       sub_score number not null,--分数
       s_id number references stu_info(s_id)--外键表
);

select * from class_info;
select * from stu_info;
select * from score_info;
--班级测试数据
insert into class_info values(1,'ST01');
insert into class_info values(2,'ST02');
insert into class_info values(3,'ST03');

--学员测试数据
--1班
insert into stu_info values(1,'stu1',18,'男',1);
insert into stu_info values(2,'stu2',19,'女',1);
insert into stu_info values(3,'stu3',21,'女',1);
insert into stu_info values(4,'stu4',22,'男',1);
insert into stu_info values(5,'stu5',32,'男',1);
--2班
insert into stu_info values(6,'stu6',18,'男',2);
insert into stu_info values(7,'stu7',19,'女',2);
insert into stu_info values(8,'stu8',31,'女',2);
insert into stu_info values(9,'stu9',12,'男',2);
insert into stu_info values(10,'stu10',02,'女',2);
--3班
insert into stu_info values(11,'stu11',18,'男',3);
insert into stu_info values(12,'stu12',19,'女',3);
insert into stu_info values(13,'stu13',21,'女',3);
insert into stu_info values(14,'stu14',134,'男',3);
insert into stu_info values(15,'stu15',02,'女',null);
drop table class_info
drop table stu_info
drop table score_info

insert into score_info values(1,'PHP',60,1);
insert into score_info values(2,'JAVA',60,3);
insert into score_info values(3,'PHP',60,5);
insert into score_info values(4,'NET',123,5);
insert into score_info values(5,'JAVA',23,4);
insert into score_info values(6,'PHP',89,7);
insert into score_info values(7,'JAVA',69,12);
insert into score_info values(8,'PHP',53,3);
insert into score_info values(9,'NET',120,2);
insert into score_info values(10,'PHP',67,2);
insert into score_info values(11,'JAVA',60,2);
insert into score_info values(12,'NET',60,10);
insert into score_info values(13,'PHP',60,11);
insert into score_info values(14,'PHP',60,11);
insert into score_info values(15,'JAVA',60,10);
select * from score_info;
--统计各个班级总人数
select c.c_name as 班级,count(s.s_id) as 总人数 from class_info c inner join stu_info s on c.c_id =s.c_id
group by c.c_name order by 总人数 desc;--desc 为降序

--统计学员中各个年龄段的总人数
select s.s_age  as 年龄段 ,count(s.s_id) as 人数 from stu_info s group by s.s_age order by 年龄段 asc;--asc为升序

--统计每个班级各个年龄段的总人数
select c.c_name as 班级,s.s_age as 年龄段,count(s.s_id)
 as 人数 from class_info c left join
 stu_info s on c.c_id=s.c_id group by c.c_name,s.s_age order by c.c_name asc;
 
 --统计各个班级男生、女生的总人数
 select c.c_name as 班级,s.s_sex as 性别,count(s.s_id )as 人数 from class_info c right join
 stu_info s on c.c_id=s.s_id group by c.c_name,s.s_sex order by 人数 asc;
 
 --查询所有班级的学生所有学生各科目的成绩(三表联查)
 select c.c_name as 班级 ,s.s_name as 姓名,sub.sub_name as
  科目,sub.sub_score as 成绩 from
  class_info c left join stu_info s on c.c_id=s.c_id 
  left join score_info sub on s.s_id=sub.s_id
  group by c.c_name,s.s_name,sub.sub_name,sub.sub_score order by 班级;
  

--统计各个班级的java平均分
select c.c_name as 班级,f.sub_name as 科目,
avg(f.sub_score)as 平均分
from class_info c inner join stu_info s on 
c.c_id = s.c_id inner join score_info f on
s.s_id = f.s_id group by c.c_name,f.sub_name
 having f.sub_name='JAVA';
 
 --模糊查询
 --查询员工姓名以s开头的信息
 select * from scott.emp e where e.ename like 'S%';
 --查询员工姓第三个字母为A的信息（使用下横线"_"来占位）
 select * from scott.emp e where e.ename like '__A%';
 --查询所有有上级主管的员工信息
 select * from scott.emp where mgr is not null;
 --查询没有上级主管的员工信息
 select * from scott.emp where mgr is null;
 
 --查询雇员编号为7566、7499,7844的雇员信息
 select * from scott.emp where empno in (7566,7499,7844);
 
 
 select * from scott.emp e where e.deptno =20;
 --查询部门编号为20的部门信息以及相应的员工信息
 --方法一（正常查询）
 select * from scott.emp e left join scott.dept d 
 on e.deptno=d.deptno where d.deptno =20;
 --in关键字，方法二（运用子查询in关键字）,in关键字查询的原理是先将括号里的内容查出来，
 --放在一个数组里面再与外面查出来的结果核对
 select * from scott.emp e where e.deptno in 
 (select d.deptno from scott.dept d where d.dname ='RESEARCH');
 
 --exists(内外相连查询的关键字)，exists关键字查询的原理
 --是先查出外面的内容再与括号里的内容作对比（是否存在？），核对成功返回true；
 
 --查询有上级领导的雇员信息
 select * from scott.emp e where exists 
 (select * from scott.emp where empno =e.mgr);
 
 
 --********************************************************************************
 --查询比部门编号为20的所有雇员工资都高的雇员信息（大于子查询的最大最大值）
 select * from scott.emp where 
 sal>all(select sal from scott.emp where deptno=20);
 
 
 --建表A
 create table tableA(
        t_id number  not null,
        t_name varchar2(50) not null
 );
        insert into tableA values(1,'user1');
        insert into tableA values(2,'user2');
        insert into tableA values(3,'user3');
 --建表B
 create table tableB(
        t_id number  not null,
        t_name varchar2(50) not null
 );
        insert into tableB values(1,'user1');
        insert into tableB values(4,'user4');
        insert into tableB values(5,'user5');
 --两张表联接查询 （关键字union会覆盖相同的数据，union all会将两张表的数据全部查出来）    
 select * from tableA union all select * from tableB; 
