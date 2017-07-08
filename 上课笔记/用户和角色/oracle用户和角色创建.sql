                             --最基本用户管理操作命令

--创建用户
create user wz identified by wz;
--给用户分配角色
grant dba to wz;
--回收用户角色
revoke dba from wz;

--删除用户
drop user wz;

--修改用户密码
alter user wz identified by 123;

--在终端使用password命令修改用户密码
--password wz;

--冻结账户(锁起来)
alter user wz account lock;

--解冻账户
alter user wz account unlock;


--*************************************************************
--查询当前用户所用的角色
select * from user_role_privs;


--创建一个角色
create role testadmin;

--删除一个角色
drop role testadmin;
--将其他角色拥有的权限都赋予给这个角色
grant connect,resource,dba to testadmin;

--将testadmin角色授权给指定用户
grant testadmin to wz;


--创建表
create table user_info(
  u_id number primary key not null,
  u_name varchar2(50)
);
--删除表
drop table user_info

--创建一个表空间
--go
create tablespace space01

datafile 'H:\oracle\oradata\orcl\space01.dbf' 

size 32m

autoextend on 

next 32m maxsize 2048m
--go
--删除表空间方法一（只是删除了逻辑组件）
drop tablespace space01;

--删除表空间，包括逻辑组件、内容以及物理组件和约束等
drop tablespace space01 including contents
and datafiles cascade constraints;
--创建用户并且 使用表空间(使用表空间前必须表空间要存在！)
create user test1 identified by test1 default tablespace space01;
create user test2 identified by test2 default tablespace space01;

--给每个用户分配使用空间大小
alter user test1 quota 30m on space01;
alter user test2 quota 30m on space01;

--给用户授予connect,resource角色
grant connect,resource to test1,test2;

--在test1用户里操作）
--将自己创建的数据库对象（例如：表、视图等）授权给其他用户访问
--all表示对象的所有吵着授权给指定用户
--也可以分别授权select,update,delete,insert操作
grant all on test1 to test2;

--在test2用户里操作（第一个test1是用户名，第二个test1是表名）
select * from test1.test1;
insert into test1.test1 values(1,'旺仔！');

--**************************************************************

--创建用户，同时指定默认的表空间
create user xxx identified by 123 default tablespace sqpce01;

--修改用户的默认表空间
alter user xxx default tablespace space02;

--查询当前用户的默认表空间
select username,default_tablespace from user_users

select * from test1.test1

-- 查看当前用户的角色(已授权过的角色)
select username,granted_role from user_role_privs;

--查看当前用户的系统权限
select * from user_sys_privs;
select username,privilege from user_sys_privs;

--查看当前用户的表级别权限
select * from user_tab_privs;


--查询当前用户所创建的表
select * from user_tables;

--查看表结构(在终端输入有效)
desc test1.test1;
