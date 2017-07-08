

--�����༶��
create table class_info(
       c_id number primary key,
       c_name varchar2(50)
);

--ѧԱ��
create table stu_info(
       s_id number primary key ,
       s_name varchar2(50) not null,
       s_age number not null,
       s_sex char(20),
       c_id number references class_info(c_id) --�������
);

--�ɼ���
create table score_info(
       sub_id number primary key ,
       sub_name varchar2(50) not null,--��Ŀ����
       sub_score number not null,--����
       s_id number references stu_info(s_id)--�����
);

select * from class_info;
select * from stu_info;
select * from score_info;
--�༶��������
insert into class_info values(1,'ST01');
insert into class_info values(2,'ST02');
insert into class_info values(3,'ST03');

--ѧԱ��������
--1��
insert into stu_info values(1,'stu1',18,'��',1);
insert into stu_info values(2,'stu2',19,'Ů',1);
insert into stu_info values(3,'stu3',21,'Ů',1);
insert into stu_info values(4,'stu4',22,'��',1);
insert into stu_info values(5,'stu5',32,'��',1);
--2��
insert into stu_info values(6,'stu6',18,'��',2);
insert into stu_info values(7,'stu7',19,'Ů',2);
insert into stu_info values(8,'stu8',31,'Ů',2);
insert into stu_info values(9,'stu9',12,'��',2);
insert into stu_info values(10,'stu10',02,'Ů',2);
--3��
insert into stu_info values(11,'stu11',18,'��',3);
insert into stu_info values(12,'stu12',19,'Ů',3);
insert into stu_info values(13,'stu13',21,'Ů',3);
insert into stu_info values(14,'stu14',134,'��',3);
insert into stu_info values(15,'stu15',02,'Ů',null);
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
--ͳ�Ƹ����༶������
select c.c_name as �༶,count(s.s_id) as ������ from class_info c inner join stu_info s on c.c_id =s.c_id
group by c.c_name order by ������ desc;--desc Ϊ����

--ͳ��ѧԱ�и�������ε�������
select s.s_age  as ����� ,count(s.s_id) as ���� from stu_info s group by s.s_age order by ����� asc;--ascΪ����

--ͳ��ÿ���༶��������ε�������
select c.c_name as �༶,s.s_age as �����,count(s.s_id)
 as ���� from class_info c left join
 stu_info s on c.c_id=s.c_id group by c.c_name,s.s_age order by c.c_name asc;
 
 --ͳ�Ƹ����༶������Ů����������
 select c.c_name as �༶,s.s_sex as �Ա�,count(s.s_id )as ���� from class_info c right join
 stu_info s on c.c_id=s.s_id group by c.c_name,s.s_sex order by ���� asc;
 
 --��ѯ���а༶��ѧ������ѧ������Ŀ�ĳɼ�(��������)
 select c.c_name as �༶ ,s.s_name as ����,sub.sub_name as
  ��Ŀ,sub.sub_score as �ɼ� from
  class_info c left join stu_info s on c.c_id=s.c_id 
  left join score_info sub on s.s_id=sub.s_id
  group by c.c_name,s.s_name,sub.sub_name,sub.sub_score order by �༶;
  

--ͳ�Ƹ����༶��javaƽ����
select c.c_name as �༶,f.sub_name as ��Ŀ,
avg(f.sub_score)as ƽ����
from class_info c inner join stu_info s on 
c.c_id = s.c_id inner join score_info f on
s.s_id = f.s_id group by c.c_name,f.sub_name
 having f.sub_name='JAVA';
 
 --ģ����ѯ
 --��ѯԱ��������s��ͷ����Ϣ
 select * from scott.emp e where e.ename like 'S%';
 --��ѯԱ���յ�������ĸΪA����Ϣ��ʹ���º���"_"��ռλ��
 select * from scott.emp e where e.ename like '__A%';
 --��ѯ�������ϼ����ܵ�Ա����Ϣ
 select * from scott.emp where mgr is not null;
 --��ѯû���ϼ����ܵ�Ա����Ϣ
 select * from scott.emp where mgr is null;
 
 --��ѯ��Ա���Ϊ7566��7499,7844�Ĺ�Ա��Ϣ
 select * from scott.emp where empno in (7566,7499,7844);
 
 
 select * from scott.emp e where e.deptno =20;
 --��ѯ���ű��Ϊ20�Ĳ�����Ϣ�Լ���Ӧ��Ա����Ϣ
 --����һ��������ѯ��
 select * from scott.emp e left join scott.dept d 
 on e.deptno=d.deptno where d.deptno =20;
 --in�ؼ��֣��������������Ӳ�ѯin�ؼ��֣�,in�ؼ��ֲ�ѯ��ԭ�����Ƚ�����������ݲ������
 --����һ�����������������������Ľ���˶�
 select * from scott.emp e where e.deptno in 
 (select d.deptno from scott.dept d where d.dname ='RESEARCH');
 
 --exists(����������ѯ�Ĺؼ���)��exists�ؼ��ֲ�ѯ��ԭ��
 --���Ȳ�����������������������������Աȣ��Ƿ���ڣ������˶Գɹ�����true��
 
 --��ѯ���ϼ��쵼�Ĺ�Ա��Ϣ
 select * from scott.emp e where exists 
 (select * from scott.emp where empno =e.mgr);
 
 
 --********************************************************************************
 --��ѯ�Ȳ��ű��Ϊ20�����й�Ա���ʶ��ߵĹ�Ա��Ϣ�������Ӳ�ѯ��������ֵ��
 select * from scott.emp where 
 sal>all(select sal from scott.emp where deptno=20);
 
 
 --����A
 create table tableA(
        t_id number  not null,
        t_name varchar2(50) not null
 );
        insert into tableA values(1,'user1');
        insert into tableA values(2,'user2');
        insert into tableA values(3,'user3');
 --����B
 create table tableB(
        t_id number  not null,
        t_name varchar2(50) not null
 );
        insert into tableB values(1,'user1');
        insert into tableB values(4,'user4');
        insert into tableB values(5,'user5');
 --���ű����Ӳ�ѯ ���ؼ���union�Ḳ����ͬ�����ݣ�union all�Ὣ���ű������ȫ���������    
 select * from tableA union all select * from tableB; 
