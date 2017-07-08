--创建一张表，同时将列中的数据类型引用自子查询中的表数据列的类型
--同时将数据一并拷贝到新表中

create table temp(e_id,e_name,sal)
as select empno,ename,sal from scott.emp; 
--as的意思是同样的，这里的 用法是将表scott.emp的数据拷贝到新表temp中

--拷贝整张表
create table temp2 as select * from scott.emp;
delete from temp;
select  * from temp2;
--删除表
drop table temp;
drop table temp2;

--复制表数据(将scott.emp里面的表数据复制一份到temp表中)
--两个表复制一定要字段相同、结构相同。
--insert into temp select * from scott.emp;
select * from temp;


--事务回滚
savepoint p1;
insert into temp values(.......);
savepoint p2;
insert into temp values(.......);
savepoint p3;

rollback to p2;

create table test_number(
       num1 number,
       num2 number(3,2),--（3）保留三位有效数字，（2）小数点后面两位
       num3 number(3,-1)--(3)保留三位有效数字，（-1）小数点前一位
);

insert into test_number(num1,num2,num3)values(2.2,2.4585,337.82);
select * from test_number;


create table test_date(
       date1 date, 
       date2 timestamp
);
select * from test_date;
--插入日期，使用to_date和to_timestamp函数价格字符串转换成日期
insert into test_date values(
to_date('2016-01-02 12:35:01','YYYY-MM-dd HH24:MI:SS'),
to_timestamp('2016-02-12 11:23:11.123','YYYY-MM-DD HH24:MI:SS:FF3'));

--插入当前系统时间
insert into test_date values(sysdate,sysdate);


create table test_lob(
       u_name varchar2(50),
       author clob --是存储字符数据的大对象类型,可以存放大量的字符数据
);
insert into test_lob values('user1','夏天的阳光很媚；确实是很不错！');
select * from test_lob;

--rowid结合select一起使用,返回的是数据行的物理地址
select rowid,e.empno,e.ename,e.job from scott.emp e;

--rownum结合select一起使用,返回一个按顺序的数值,类似自增长
select rownum,e.empno,e.ename,e.job from scott.emp e;

--查询当前日期(dual是一张伪表)
select sysdate from dual;

--systimestamp : 返回当前的日期还有时分秒毫秒,还有时区
select systimestamp from dual;

--last_day(d) : 返回指定日期所在月份的最后一天的日期值,d代表日期
select last_day(sysdate) from dual;

--为当前日期添加两个月
select add_months(sysdate,2) from dual;

--months_between(f, s) : 返回两个日期f和s之间相差的月数
select months_between(sysdate,to_date('2015-10','yyyy-mm'))as 相差月数 from dual;

select next_day(sysdate,1)from dual;

--获取当前时间的年份
select extract(year from sysdate) from dual;
--获取当前时间的月份
select extract(month from sysdate) from dual;
--获取当前时间的日子
select extract(day from sysdate) from dual;


--返回当前年月日
select trunc(sysdate) from dual;
--返回当前年的第一天
select trunc(sysdate,'yy')from dual;
--返回当月的第一天
select trunc(sysdate,'mm')from dual;
--返回当前年月日
select trunc(sysdate,'dd')from dual;
--返回当年第一天
select trunc(sysdate,'yyyy') from dual;
--..........

--使用trunc（）截取数字，但不会四舍五入
select trunc(89.982,2) from dual; --结果：89.98
select trunc(232.33) from dual;   --结果：232
select trunc(323.2212,-2) from dual; --结果：300

--使用round（）截取数字，会四舍五入
select round(89.985,2) from dual; --结果：89.99
select round(232.83)from dual; --结果：233
select round(235.155,-1)from dual; --结果：240

--使用concat函数连接字符串，
select concat(ename,concat('(',concat(job,')')))
as 用户信息 from scott.emp;
--也可以使用'\\'符号进行连接
select ename ||'('||job||')'as 用户信息 from scott.emp;

select * from scott.emp where length(ename)=5;

--将雇员的金额显示为*号
select ename,replace(sal,sal,'*') as 薪资 from scott.emp;

--查找雇员名含有’LA’字符的信息
select * from scott.emp where instr(ename,'LA')>0;

--左填充
select lpad('hello',10,'*')from dual;
--右填充
select rpad('hello',10,'*')from dual;

select 2*3 from dual;--dual是一张用来显示临时数据的伪表

select ceil(2.48) from dual;

select bin_to_num(1,0,0,1,0)from dual;

--将当前系统时间转换成字符串类型
select  to_char(sysdate,'yyyy-mm-dd hh24:mi:ss') from dual;

--格式化成货币格式
select to_char(100203.78999999999999,'L999G999D99')as money from dual;


--将字符串转换成数字对象
select to_number('209.976', '9G999D999')*5 from dual; 
