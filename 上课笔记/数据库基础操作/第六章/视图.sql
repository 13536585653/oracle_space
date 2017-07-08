--查询班级为ST01的所有学生
select c.c_name,s.s_name,s.s_age,s.s_sex from stu_info s left
join class_info c on s.c_id = c.c_id
where c.c_name ='ST01';

--统计所有班级男生、女生的总人数
select c.c_name as 班级,s.s_sex as 性别,count(s.s_id) as 人数
from stu_info s left join class_info c on s.c_id = c.c_id group by
c.c_name,s.s_sex order by count(s.s_id) desc;

--创建视图格式、语法（关系视图）
CREATE [OR REPLACE] [FORCE|NOFORCE] VIEW view_name [(alias[, alias]...)] 
AS subquery 
[WITH CHECK OPTION [CONSTRAINT constraint]] 
[WITH READ ONLY]

--给统计查询创建一个视图
create or replace view stu_view
as 
select c.c_name as 班级,s.s_sex as 性别,count (s.s_id) as 人数
from class_info c left join stu_info s on c.c_id = s.c_id
group by c.c_name ,s.s_sex order by c.c_name asc;

--查询视图
select * from stu_view;

--删除视图
drop view stu_view;


--给统计查询创建一个只读视图
create or replace view stu_view
as 
select c.c_name as 班级,s.s_sex as 性别,count (s.s_id) as 人数
from class_info c left join stu_info s on c.c_id = s.c_id
group by c.c_name ,s.s_sex order by c.c_name asc
with read only;

--给班级查询创建一个视图
create or replace view class_view
as 
select * from class_info;

select * from class_view;

--通过视图修改表数据
update class_view set c_name='ST01' where c_id=1;

--给学生信息表创建一个约束视图
create or replace view stu_view
as
select * from stu_info where s_age>18
with check option;
--由于视图加入了with check option 选项，在视图进行 DML
--操作时，不能违反视图的查询条件
update stu_view set s_age=13;

select * from stu_view;

--物化视图（格式）
create materialized view materialized_view_name
build [immediate|deferred]  --1.创建方式
refresh [complete|fast|force|never]     --2.物化视图刷新方式
on [commit|demand]   --3.刷新触发方式
start with (start_date)   --4.开始时间
next (interval_date)   --5.间隔时间
with [primary key|rowid]  --6.创建模式(默认 primary key)
ENABLE QUERY REWRITE   --7.是否启用查询重写
as     --8.关键字
select statement;   --9.基表选取数据的select语句


--例子：
--创建增量刷新的物化视图时应先创建存储的日志空间
--在scott.emp表中创建物化视图日志
 create materialized view log on emp
 tablespace users –指定存放的表空间(可省略)
with rowid; --基于rowid记录视图日志

--始创建物化视图
--方式一(提交时刷新)
create materialized view mv_emp
tablespace users                   --指定表空间(可省略)
build immediate                    --创建视图时即生成数据
refresh fast                       --基于增量刷新
on commit                          --数据DML操作提交就刷新
with rowid                         --基于ROWID刷新
as select * from emp
--方式二(定时刷新)
create materialized view mv_emp2
tablespace users                   --指定表空间(可省略)
refresh fast                       --基于增量刷新
start with sysdate                 --创建视图时即生成数据
next sysdate+1/1440                /*每隔一分钟刷新一次*/
with rowid                         --基于ROWID刷新
as select * from emp

--删除物化视图日志
drop materialized view mv_emp


