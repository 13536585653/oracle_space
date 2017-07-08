--班级表
create table class_info(
 c_id number primary key,
 c_name varchar2(50)
);

--学员表
create table stu_info(
 s_id number primary key,
 s_name varchar2(50) not null,
 s_age number not null,
 s_sex char(20),
 c_id number references class_info(c_id) --外键关联
);

--成绩表
create table score_info(
 sub_id number primary key,
 sub_name varchar2(50) not null, --科目名称
 sub_score number not null, --分数
 s_id number references stu_info(s_id) --外键关联  
);

select * from class_info;
select * from stu_info;
select * from score_info;

--班级测试数据
insert into class_info values(1,'ST01');
insert into class_info values(2,'ST02');
insert into class_info values(3,'ST03');

--学员的测试数据
--1班
insert into stu_info values(1,'stu1',18,'男',1);
insert into stu_info values(2,'stu2',19,'男',1);
insert into stu_info values(3,'stu3',20,'男',1);
insert into stu_info values(4,'stu4',19,'女',1);
insert into stu_info values(5,'stu5',18,'女',1);
--2班
insert into stu_info values(6,'stu6',18,'男',2);
insert into stu_info values(7,'stu7',19,'男',2);
insert into stu_info values(8,'stu8',20,'女',2);
insert into stu_info values(9,'stu9',19,'女',2);
insert into stu_info values(10,'stu10',18,'女',2);
--3班
insert into stu_info values(11,'stu11',18,'男',3);
insert into stu_info values(12,'stu12',19,'男',3);
insert into stu_info values(13,'stu13',20,'男',3);
insert into stu_info values(14,'stu14',19,'女',3);
insert into stu_info values(15,'stu15',18,'女',null);

--成绩表测试数据
insert into score_info values(1,'JAVA',70,1);
insert into score_info values(2,'PHP',60,1);
insert into score_info values(3,'JAVA',75,2);
insert into score_info values(4,'PHP',65,2);
insert into score_info values(5,'JAVA',55,3);
insert into score_info values(6,'PHP',65,3);
insert into score_info values(7,'JAVA',80,4);
insert into score_info values(8,'PHP',90,4);
insert into score_info values(9,'JAVA',62,5);
insert into score_info values(10,'PHP',77,5);
insert into score_info values(11,'JAVA',30,6);
insert into score_info values(12,'PHP',50,6);
insert into score_info values(13,'JAVA',73,7);
insert into score_info values(14,'PHP',61,7);
insert into score_info values(15,'JAVA',70,8);
insert into score_info values(16,'PHP',65,8);
insert into score_info values(17,'JAVA',59,9);
insert into score_info values(18,'PHP',63,9);
insert into score_info values(19,'JAVA',82,10);
insert into score_info values(20,'PHP',63,10);
insert into score_info values(21,'JAVA',70,11);
insert into score_info values(22,'PHP',67,11);
insert into score_info values(23,'JAVA',42,12);
insert into score_info values(24,'PHP',53,12);
insert into score_info values(25,'JAVA',60,13);
insert into score_info values(26,'PHP',62,13);
insert into score_info values(27,'JAVA',79,14);
insert into score_info values(28,'PHP',61,14);
insert into score_info values(29,'JAVA',70,15);
insert into score_info values(30,'PHP',66,15);

select * from score_info;






--统计各个班级总人数
select c.c_name as 班级, count(s.s_id) as 总人数
from class_info c inner join stu_info s on c.c_id = s.c_id
group by c.c_name order by 总人数 desc;




--统计所有学员中各个年龄段的总人数
select s.s_age as 年龄, count(s.s_id) as 人数 from stu_info s group by s.s_age; 





--统计每个班级各个年龄段的总人数
select c.c_name as 班级,s.s_age as 年龄,count(s.s_age) as 总人数 
from class_info c left join stu_info s on c.c_id = s.c_id group by c.c_name,s.s_age;



--统计各个班级男生,女生的总人数
select c.c_name as 班级 ,s.s_sex as 性别,count(s.s_age) as 人数
from class_info c inner join stu_info s
on c.c_id=s.c_id group by c.c_name,s.s_sex order by c.c_name;




--查询所有班级的所有学生各科目的成绩
select c.c_name as 班级, s.s_name as 学生姓名, r.sub_name as 科目,
r.sub_score as 成绩 from class_info c right join stu_info s on
c.c_id = s.c_id left join score_info r on s.s_id = r.s_id;




--统计各个班级的java平均分
select c.c_name as 班级,f.sub_name as 科目,
avg(f.sub_score)as 平均分 
from class_info c inner join stu_info s on
c.c_id = s.c_id inner join score_info f on
s.s_id = f.s_id group by c.c_name,f.sub_name 

select c.c_name as 班级, s.s_sex as 性别, count(*) 
from class_info c inner join stu_info s on c.c_id = s.c_id
group by c.c_name,s.s_sex order by c.c_name asc ;



--统计所有班级各科平均分
select c.c_name as 班级,f.sub_name as 科目,
avg(f.sub_score)as 平均分 
from class_info c inner join stu_info s on
c.c_id = s.c_id inner join score_info f on
s.s_id = f.s_id group by c.c_name,f.sub_name 

select c.c_name as 班级, s.s_sex as 性别, count(*) 
from class_info c inner join stu_info s on c.c_id = s.c_id
group by c.c_name,s.s_sex order by c.c_name asc; 


select * from scott.emp;

--查询员工姓名以S开头的信息
select * from scott.emp e where e.ename like 'S%';
--查询员工姓名第三个字母为A的信息(使用下横线"_"来占位)
select * from scott.emp e where e.ename like '__A%';

--查询有上级主管的员工信息
select * from scott.emp where mgr is not null;

--查询没有上级主管的员工信息
select * from scott.emp where mgr is null;

--查询雇员编号为7566、7499、7844的雇员信息
select * from scott.emp where empno in(7566,7499,7844);

--查询部门编号为20的员工信息
select * from scott.emp e where e.deptno = 20;

--查询部门编号为20的部门信息以及相应的员工信息
--连接查询
select * from scott.emp e left join scott.dept d 
on e.deptno = d.deptno where d.deptno = 20;

--子查询
select * from scott.emp e where e.deptno in 
(select d.deptno from scott.dept d where d.dname='RESEARCH');


--exists
--查询有上级领导的雇员信息

--exists
select * from scott.emp e where exists 
(select * from scott.emp ep where ep.empno=e.mgr);
--in
select * from scott.emp e where e.mgr in 
(select ep.mgr from scott.emp ep);

--查询比部门编号为20的所有雇员工资都高的雇员信息(大于子查询的最大值)
select * from scott.emp where sal > 
all(select sal from scott.emp where deptno=20)


create table tableA(
  t_id number not null,
  t_name varchar2(50) not null 
);
insert into tableA values(1,'user1');
insert into tableA values(2,'user2');
insert into tableA values(3,'user3');


create table tableB(
  t_id number not null,
  t_name varchar2(50) not null 
);
insert into tableB values(1,'user1');
insert into tableB values(4,'user4');
insert into tableB values(5,'user5');

--合并结果集（不允许重复）
select * from tableA union select * from tableB;

--合并结果集（允许重复）
select * from tableA union all select * from tableB;








