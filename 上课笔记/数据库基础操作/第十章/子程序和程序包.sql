--************创建存储过程***************************************
create procedure my_proc
is
begin
   dbms_output.put_line('hello procedure');
end;
--调用存储过程，在PL/SQL块中去调用(就像是调用java中的方法一样)
begin 
  my_proc;
end;
--删除存储过程
drop procedure my_proc;

--**********带参数的存储过程（参数分为输入参数in和输出参数out）**********
--输入参数
create procedure my_proc(eno in emps.empno%type)
is 
   --声明一个变量
   v_ename emps.ename%type;
begin
   select ename into v_ename from emps where empno = eno;
   dbms_output.put_line('姓名：'||v_ename);
exception
  when no_data_found then
    dbms_output.put_line('输入的编号有误');
    
end;
drop procedure my_proc
--调用带参数的存储过程
begin 
  my_proc(7369);
end;

--*******************输出参数out*************************
create or replace procedure my_proc(v_count out number)
is 
begin
  --将查询的总记录数赋值给输出参数
  select count(*) into v_count from emps;
end;

--调用存储过程，使用输出参数，需要先声明一个变量，将它传递给过程
declare 
  --此变量的类型必须与输出参数的类型一致
  v_count number(2);
begin 
  --存储过程就会将结果赋值给这个变量
  my_proc(v_count);
  --输出
  dbms_output.put_line('总人数：'||v_count);
end;

--*************输入和输出参数结合使用******************************
--输入参数为雇员编号，返回（输出）该雇员的工资
create or replace procedure my_proc
(in_empno emps.empno%type,out_sal out emps.sal%type)
is
begin
  --执行查询，输入参数作为查询条件，
  --输出参数用于保存查询内容
  select sal into out_sal from emps where empno = in_empno;
end;
drop procedure my_proc;
--调用
declare 
  --声明一个变量，用于存储输出参数的结果
  v_sal emps.sal%type;
begin 
  --第一个输入参数，第二个是输出参数，顺序不能弄反
  my_proc(7369,v_sal);
  dbms_output.put_line('薪资：'||v_sal);
end;

--***************函数，必须指定返回值类型************************
create or replace function my_func return number
is
  --声明一个变量
  v_count number(2);
begin
  select count(*) into v_count from emps;
  --返回
  return v_count;
end;

--1、在PL/SQL块中调用函数
declare
  v_count number(2);
begin
  --调用行数，将返回值的结果赋值给变量
  v_count :=my_func();
  dbms_output.put_line('总记录数：'||v_count);
end;
--2、在sql语句中调用函数
select my_func() as 总人数 from dual;

--************输入一个编号，返回员工薪资**************
create or replace function my_func2(in_empno in emps.empno%type) 
return number
is
--声明变量
       v_sal number(4);
begin 
       select sal into v_sal from emps where empno=in_empno;
       return v_sal;
end;
drop function my_func2;

--在PL/SQL中执行
declare
      v_sal emps.sal%type;
begin
      v_sal := my_func2(7566);
      dbms_output.put_line('工资：'||v_sal);
end;

--**********在sql语句中执行***********
select my_func2(7566) as 工资 from dual;

--**********定义一个函数，传入一个部门编号作为参数，
--返回该部门的总人数
drop function my_func;
create or replace function my_func
(v_deptno in emps.deptno%type)
return number
is
v_count number(2);
begin
  select count(*) into v_count  from emps where v_deptno=deptno;
  return v_count;
end;


declare 
  v_count number;
begin 
  v_count :=my_func(7369);
  dbms_output.put_line('总人数：'||v_count);
end;

--使用程序包
--首先定义规范部分（规范类似与Java中的接口，定义标准、没有具体的实现）
create or replace package my_pack
is 
  --声明一个方法
  function my_func(v_deptno emps.deptno%type)return number;
  --声明一个存储过程
  procedure my_proc(v_empno emps.empno%type,v_sal out emps.sal%type);
end;


--然后定义主体实现部分（主体则类似与java中的实现类，用于实现规范）
create or replace package body my_pack
is
--实现规范中的方法
function my_func(v_deptno emps.deptno%type)return number
  is
    --定义一个变量用与返回总记录数
    v_count number(2);
    begin
      select count(*) into v_count from emps where deptno=v_deptno;
      return v_count;
    end;
    
    --实现规范中定义的存储过程
procedure my_proc(v_empno emps.empno%type,v_sal out emps.sal%type)
  is
      begin
           --将查询结果赋值给输出参数
        select sal into v_sal from emps where empno=v_empno; 
       end;
 end;
    drop package body my_pack
    
    --调用
    declare
         --声明一个变量用于接收方法的返回值
         v_count number(2);
         --声明一个变量用于接收输出参数
         v_sal emps.sal%type;
    begin
      --调用时是 包名.方法名
      v_count :=my_pack.my_func(20);
      dbms_output.put_line('总人数：'||v_count);
      --调用存储过程 包名.过程名
      my_pack.my_proc(7566,v_sal);
      dbms_output.put_line('薪资：'||v_sal);
    end;
    
    select * from emps;
