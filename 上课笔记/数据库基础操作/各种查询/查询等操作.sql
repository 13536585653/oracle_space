--升序查询
select * from scott.emp order by hiredate desc;

--分组统计，统计各个部门的平均工资（使用group by）
--select avg(sal) as 平均工资 from scott.emp group by deptno;

--统计各个部门的平均薪资，且平均薪资大于2000（having不能单独使用，只能跟在group by 后面）
select d.dname as 部门,d.deptno as 部门编号,avg(e.sal) as 平均工资
from scott.emp e left join scott.dept d on e.deptno = d.deptno group by d.dname,d.deptno having avg(e.sal)>2000;
--查询所有部门下名字为SALES的所有员工（内连接）
select * from scott.dept d inner join scott.emp e on d.deptno =e.deptno where d.dname='SALES';

--交叉连接(不加条件，默认是笛卡尔积，也就是两张或多张表的阶乘)
--方法一
select  * from scott.dept d,scott.emp e where d.deptno = e.deptno;
--方法二
select  * from scott.dept d cross join scott.emp e where d.deptno=e.deptno;

--左连接
select * from scott.dept d left join scott.emp e on d.deptno = e.deptno;
