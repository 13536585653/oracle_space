--�༶��
create table class_info(
 c_id number primary key,
 c_name varchar2(50)
);

--ѧԱ��
create table stu_info(
 s_id number primary key,
 s_name varchar2(50) not null,
 s_age number not null,
 s_sex char(20),
 c_id number references class_info(c_id) --�������
);

--�ɼ���
create table score_info(
 sub_id number primary key,
 sub_name varchar2(50) not null, --��Ŀ����
 sub_score number not null, --����
 s_id number references stu_info(s_id) --�������  
);

select * from class_info;
select * from stu_info;
select * from score_info;

--�༶��������
insert into class_info values(1,'ST01');
insert into class_info values(2,'ST02');
insert into class_info values(3,'ST03');

--ѧԱ�Ĳ�������
--1��
insert into stu_info values(1,'stu1',18,'��',1);
insert into stu_info values(2,'stu2',19,'��',1);
insert into stu_info values(3,'stu3',20,'��',1);
insert into stu_info values(4,'stu4',19,'Ů',1);
insert into stu_info values(5,'stu5',18,'Ů',1);
--2��
insert into stu_info values(6,'stu6',18,'��',2);
insert into stu_info values(7,'stu7',19,'��',2);
insert into stu_info values(8,'stu8',20,'Ů',2);
insert into stu_info values(9,'stu9',19,'Ů',2);
insert into stu_info values(10,'stu10',18,'Ů',2);
--3��
insert into stu_info values(11,'stu11',18,'��',3);
insert into stu_info values(12,'stu12',19,'��',3);
insert into stu_info values(13,'stu13',20,'��',3);
insert into stu_info values(14,'stu14',19,'Ů',3);
insert into stu_info values(15,'stu15',18,'Ů',null);

--�ɼ����������
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






--ͳ�Ƹ����༶������
select c.c_name as �༶, count(s.s_id) as ������
from class_info c inner join stu_info s on c.c_id = s.c_id
group by c.c_name order by ������ desc;




--ͳ������ѧԱ�и�������ε�������
select s.s_age as ����, count(s.s_id) as ���� from stu_info s group by s.s_age; 





--ͳ��ÿ���༶��������ε�������
select c.c_name as �༶,s.s_age as ����,count(s.s_age) as ������ 
from class_info c left join stu_info s on c.c_id = s.c_id group by c.c_name,s.s_age;



--ͳ�Ƹ����༶����,Ů����������
select c.c_name as �༶ ,s.s_sex as �Ա�,count(s.s_age) as ����
from class_info c inner join stu_info s
on c.c_id=s.c_id group by c.c_name,s.s_sex order by c.c_name;




--��ѯ���а༶������ѧ������Ŀ�ĳɼ�
select c.c_name as �༶, s.s_name as ѧ������, r.sub_name as ��Ŀ,
r.sub_score as �ɼ� from class_info c right join stu_info s on
c.c_id = s.c_id left join score_info r on s.s_id = r.s_id;




--ͳ�Ƹ����༶��javaƽ����
select c.c_name as �༶,f.sub_name as ��Ŀ,
avg(f.sub_score)as ƽ���� 
from class_info c inner join stu_info s on
c.c_id = s.c_id inner join score_info f on
s.s_id = f.s_id group by c.c_name,f.sub_name 

select c.c_name as �༶, s.s_sex as �Ա�, count(*) 
from class_info c inner join stu_info s on c.c_id = s.c_id
group by c.c_name,s.s_sex order by c.c_name asc ;



--ͳ�����а༶����ƽ����
select c.c_name as �༶,f.sub_name as ��Ŀ,
avg(f.sub_score)as ƽ���� 
from class_info c inner join stu_info s on
c.c_id = s.c_id inner join score_info f on
s.s_id = f.s_id group by c.c_name,f.sub_name 

select c.c_name as �༶, s.s_sex as �Ա�, count(*) 
from class_info c inner join stu_info s on c.c_id = s.c_id
group by c.c_name,s.s_sex order by c.c_name asc; 


select * from scott.emp;

--��ѯԱ��������S��ͷ����Ϣ
select * from scott.emp e where e.ename like 'S%';
--��ѯԱ��������������ĸΪA����Ϣ(ʹ���º���"_"��ռλ)
select * from scott.emp e where e.ename like '__A%';

--��ѯ���ϼ����ܵ�Ա����Ϣ
select * from scott.emp where mgr is not null;

--��ѯû���ϼ����ܵ�Ա����Ϣ
select * from scott.emp where mgr is null;

--��ѯ��Ա���Ϊ7566��7499��7844�Ĺ�Ա��Ϣ
select * from scott.emp where empno in(7566,7499,7844);

--��ѯ���ű��Ϊ20��Ա����Ϣ
select * from scott.emp e where e.deptno = 20;

--��ѯ���ű��Ϊ20�Ĳ�����Ϣ�Լ���Ӧ��Ա����Ϣ
--���Ӳ�ѯ
select * from scott.emp e left join scott.dept d 
on e.deptno = d.deptno where d.deptno = 20;

--�Ӳ�ѯ
select * from scott.emp e where e.deptno in 
(select d.deptno from scott.dept d where d.dname='RESEARCH');


--exists
--��ѯ���ϼ��쵼�Ĺ�Ա��Ϣ

--exists
select * from scott.emp e where exists 
(select * from scott.emp ep where ep.empno=e.mgr);
--in
select * from scott.emp e where e.mgr in 
(select ep.mgr from scott.emp ep);

--��ѯ�Ȳ��ű��Ϊ20�����й�Ա���ʶ��ߵĹ�Ա��Ϣ(�����Ӳ�ѯ�����ֵ)
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

--�ϲ���������������ظ���
select * from tableA union select * from tableB;

--�ϲ�������������ظ���
select * from tableA union all select * from tableB;








