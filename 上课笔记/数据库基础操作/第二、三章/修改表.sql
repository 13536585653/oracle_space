--设置用户test1默认表空间
alter user test1 identified by space01;
--创建表class_info
create table class_info(
       c_id number primary key,
       c_name varchar2(50)
);
select * from class_info;
--创建表stu_info
create table stu_info(
       stu_on char(32) primary key,--主键约束
       stu_name varchar2(20) not null,--非空约束
       card_id char(20) unique, --唯一约束
       sex char(2) check(sex='男' or sex='女'),--检查约束
       address varchar2(100) default '地址不详',--默认约束
       cid number references class_info(c_id) --外键约束
);
select * from student_info;

--修改表名
alter table stu_info rename to student_info;

--修改字段名（列名）
alter table student_info rename column stu_on to s_no;

--添加列名
alter table class_info add c_content varchar2(200) not null;

-- 修改某一列的数据类型
alter table class_info modify c_content varchar(100);

--删除列
alter table class_info drop column c_content;


--添加主键约束(class_pk是约束名称，只是一个引用(别名))
alter table class_info add constraint class_pk primary key(s_no);

--删除主键约束（根据约束名称将主键约束删除）
alter table class_info drop constraint class_pk;

--查询表
select * from class_info;

--***********************************************************
--DML操作
--插入操作
insert into class_info values(1,'ST01');
insert into class_info values(2,'ST02');

--提交事务
commit;

--更新操作（将C_ID为2的班级名称更改为ST03）
update class_info set c_name ='ST03' where c_id=2;

delete from class_info where c_name='ST03';
--删除名称为ST03的班级

--DQL语句
--查询所有列
select * from class_info;
--查询某列
select c_id,c_name from class_info;

--条件查询（用于过滤数据），使用where关键字
select * from class_info where c_id=1;

--查询班级id大于1的所有班级
select * from class_info where c_id>1 and c_id<10;

--查询Scott用户下的emp（员工表），已授权给每个用户，所以可以查出来
select * from scott.emp;

select * from scott.emp where sal>3000;

--查询月收入为1250的总人数
select count(*)as 总人数 from scott.emp where sal=1250 ;

--查询部门编号为30的所有人的平均工资
select avg(sal)as 平均收入 from scott.emp where deptno=30;

--查询职位为MANAGER的月收入的总和
select sum(sal) as 月收入总和 from scott.emp where job='MANAGER';

--查询员工名称为SMITH的上级主管的名字（使用子查询）
--select a.ename 员工名字,b.ename 上级名字 from scott.emp a,scott.emp b where a.mgr=b.empno(+);
select ename SMITH上级名字为 from scott.emp where empno in(select mgr from scott.emp where ename='SMITH');

