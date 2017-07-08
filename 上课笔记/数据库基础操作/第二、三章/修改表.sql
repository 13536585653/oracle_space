--�����û�test1Ĭ�ϱ�ռ�
alter user test1 identified by space01;
--������class_info
create table class_info(
       c_id number primary key,
       c_name varchar2(50)
);
select * from class_info;
--������stu_info
create table stu_info(
       stu_on char(32) primary key,--����Լ��
       stu_name varchar2(20) not null,--�ǿ�Լ��
       card_id char(20) unique, --ΨһԼ��
       sex char(2) check(sex='��' or sex='Ů'),--���Լ��
       address varchar2(100) default '��ַ����',--Ĭ��Լ��
       cid number references class_info(c_id) --���Լ��
);
select * from student_info;

--�޸ı���
alter table stu_info rename to student_info;

--�޸��ֶ�����������
alter table student_info rename column stu_on to s_no;

--�������
alter table class_info add c_content varchar2(200) not null;

-- �޸�ĳһ�е���������
alter table class_info modify c_content varchar(100);

--ɾ����
alter table class_info drop column c_content;


--�������Լ��(class_pk��Լ�����ƣ�ֻ��һ������(����))
alter table class_info add constraint class_pk primary key(s_no);

--ɾ������Լ��������Լ�����ƽ�����Լ��ɾ����
alter table class_info drop constraint class_pk;

--��ѯ��
select * from class_info;

--***********************************************************
--DML����
--�������
insert into class_info values(1,'ST01');
insert into class_info values(2,'ST02');

--�ύ����
commit;

--���²�������C_IDΪ2�İ༶���Ƹ���ΪST03��
update class_info set c_name ='ST03' where c_id=2;

delete from class_info where c_name='ST03';
--ɾ������ΪST03�İ༶

--DQL���
--��ѯ������
select * from class_info;
--��ѯĳ��
select c_id,c_name from class_info;

--������ѯ�����ڹ������ݣ���ʹ��where�ؼ���
select * from class_info where c_id=1;

--��ѯ�༶id����1�����а༶
select * from class_info where c_id>1 and c_id<10;

--��ѯScott�û��µ�emp��Ա����������Ȩ��ÿ���û������Կ��Բ����
select * from scott.emp;

select * from scott.emp where sal>3000;

--��ѯ������Ϊ1250��������
select count(*)as ������ from scott.emp where sal=1250 ;

--��ѯ���ű��Ϊ30�������˵�ƽ������
select avg(sal)as ƽ������ from scott.emp where deptno=30;

--��ѯְλΪMANAGER����������ܺ�
select sum(sal) as �������ܺ� from scott.emp where job='MANAGER';

--��ѯԱ������ΪSMITH���ϼ����ܵ����֣�ʹ���Ӳ�ѯ��
--select a.ename Ա������,b.ename �ϼ����� from scott.emp a,scott.emp b where a.mgr=b.empno(+);
select ename SMITH�ϼ�����Ϊ from scott.emp where empno in(select mgr from scott.emp where ename='SMITH');

