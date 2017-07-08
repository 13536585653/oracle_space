                             --������û������������

--�����û�
create user wz identified by wz;
--���û������ɫ
grant dba to wz;
--�����û���ɫ
revoke dba from wz;

--ɾ���û�
drop user wz;

--�޸��û�����
alter user wz identified by 123;

--���ն�ʹ��password�����޸��û�����
--password wz;

--�����˻�(������)
alter user wz account lock;

--�ⶳ�˻�
alter user wz account unlock;


--*************************************************************
--��ѯ��ǰ�û����õĽ�ɫ
select * from user_role_privs;


--����һ����ɫ
create role testadmin;

--ɾ��һ����ɫ
drop role testadmin;
--��������ɫӵ�е�Ȩ�޶�����������ɫ
grant connect,resource,dba to testadmin;

--��testadmin��ɫ��Ȩ��ָ���û�
grant testadmin to wz;


--������
create table user_info(
  u_id number primary key not null,
  u_name varchar2(50)
);
--ɾ����
drop table user_info

--����һ����ռ�
--go
create tablespace space01

datafile 'H:\oracle\oradata\orcl\space01.dbf' 

size 32m

autoextend on 

next 32m maxsize 2048m
--go
--ɾ����ռ䷽��һ��ֻ��ɾ�����߼������
drop tablespace space01;

--ɾ����ռ䣬�����߼�����������Լ����������Լ����
drop tablespace space01 including contents
and datafiles cascade constraints;
--�����û����� ʹ�ñ�ռ�(ʹ�ñ�ռ�ǰ�����ռ�Ҫ���ڣ�)
create user test1 identified by test1 default tablespace space01;
create user test2 identified by test2 default tablespace space01;

--��ÿ���û�����ʹ�ÿռ��С
alter user test1 quota 30m on space01;
alter user test2 quota 30m on space01;

--���û�����connect,resource��ɫ
grant connect,resource to test1,test2;

--��test1�û��������
--���Լ����������ݿ�������磺����ͼ�ȣ���Ȩ�������û�����
--all��ʾ��������г�����Ȩ��ָ���û�
--Ҳ���Էֱ���Ȩselect,update,delete,insert����
grant all on test1 to test2;

--��test2�û����������һ��test1���û������ڶ���test1�Ǳ�����
select * from test1.test1;
insert into test1.test1 values(1,'���У�');

--**************************************************************

--�����û���ͬʱָ��Ĭ�ϵı�ռ�
create user xxx identified by 123 default tablespace sqpce01;

--�޸��û���Ĭ�ϱ�ռ�
alter user xxx default tablespace space02;

--��ѯ��ǰ�û���Ĭ�ϱ�ռ�
select username,default_tablespace from user_users

select * from test1.test1

-- �鿴��ǰ�û��Ľ�ɫ(����Ȩ���Ľ�ɫ)
select username,granted_role from user_role_privs;

--�鿴��ǰ�û���ϵͳȨ��
select * from user_sys_privs;
select username,privilege from user_sys_privs;

--�鿴��ǰ�û��ı���Ȩ��
select * from user_tab_privs;


--��ѯ��ǰ�û��������ı�
select * from user_tables;

--�鿴��ṹ(���ն�������Ч)
desc test1.test1;
