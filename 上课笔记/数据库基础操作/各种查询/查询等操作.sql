--�����ѯ
select * from scott.emp order by hiredate desc;

--����ͳ�ƣ�ͳ�Ƹ������ŵ�ƽ�����ʣ�ʹ��group by��
--select avg(sal) as ƽ������ from scott.emp group by deptno;

--ͳ�Ƹ������ŵ�ƽ��н�ʣ���ƽ��н�ʴ���2000��having���ܵ���ʹ�ã�ֻ�ܸ���group by ���棩
select d.dname as ����,d.deptno as ���ű��,avg(e.sal) as ƽ������
from scott.emp e left join scott.dept d on e.deptno = d.deptno group by d.dname,d.deptno having avg(e.sal)>2000;
--��ѯ���в���������ΪSALES������Ա���������ӣ�
select * from scott.dept d inner join scott.emp e on d.deptno =e.deptno where d.dname='SALES';

--��������(����������Ĭ���ǵѿ�������Ҳ�������Ż���ű�Ľ׳�)
--����һ
select  * from scott.dept d,scott.emp e where d.deptno = e.deptno;
--������
select  * from scott.dept d cross join scott.emp e where d.deptno=e.deptno;

--������
select * from scott.dept d left join scott.emp e on d.deptno = e.deptno;
