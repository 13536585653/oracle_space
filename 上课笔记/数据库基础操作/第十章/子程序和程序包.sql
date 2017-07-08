--************�����洢����***************************************
create procedure my_proc
is
begin
   dbms_output.put_line('hello procedure');
end;
--���ô洢���̣���PL/SQL����ȥ����(�����ǵ���java�еķ���һ��)
begin 
  my_proc;
end;
--ɾ���洢����
drop procedure my_proc;

--**********�������Ĵ洢���̣�������Ϊ�������in���������out��**********
--�������
create procedure my_proc(eno in emps.empno%type)
is 
   --����һ������
   v_ename emps.ename%type;
begin
   select ename into v_ename from emps where empno = eno;
   dbms_output.put_line('������'||v_ename);
exception
  when no_data_found then
    dbms_output.put_line('����ı������');
    
end;
drop procedure my_proc
--���ô������Ĵ洢����
begin 
  my_proc(7369);
end;

--*******************�������out*************************
create or replace procedure my_proc(v_count out number)
is 
begin
  --����ѯ���ܼ�¼����ֵ���������
  select count(*) into v_count from emps;
end;

--���ô洢���̣�ʹ�������������Ҫ������һ���������������ݸ�����
declare 
  --�˱��������ͱ������������������һ��
  v_count number(2);
begin 
  --�洢���̾ͻὫ�����ֵ���������
  my_proc(v_count);
  --���
  dbms_output.put_line('��������'||v_count);
end;

--*************���������������ʹ��******************************
--�������Ϊ��Ա��ţ����أ�������ù�Ա�Ĺ���
create or replace procedure my_proc
(in_empno emps.empno%type,out_sal out emps.sal%type)
is
begin
  --ִ�в�ѯ�����������Ϊ��ѯ������
  --����������ڱ����ѯ����
  select sal into out_sal from emps where empno = in_empno;
end;
drop procedure my_proc;
--����
declare 
  --����һ�����������ڴ洢��������Ľ��
  v_sal emps.sal%type;
begin 
  --��һ������������ڶ��������������˳����Ū��
  my_proc(7369,v_sal);
  dbms_output.put_line('н�ʣ�'||v_sal);
end;

--***************����������ָ������ֵ����************************
create or replace function my_func return number
is
  --����һ������
  v_count number(2);
begin
  select count(*) into v_count from emps;
  --����
  return v_count;
end;

--1����PL/SQL���е��ú���
declare
  v_count number(2);
begin
  --����������������ֵ�Ľ����ֵ������
  v_count :=my_func();
  dbms_output.put_line('�ܼ�¼����'||v_count);
end;
--2����sql����е��ú���
select my_func() as ������ from dual;

--************����һ����ţ�����Ա��н��**************
create or replace function my_func2(in_empno in emps.empno%type) 
return number
is
--��������
       v_sal number(4);
begin 
       select sal into v_sal from emps where empno=in_empno;
       return v_sal;
end;
drop function my_func2;

--��PL/SQL��ִ��
declare
      v_sal emps.sal%type;
begin
      v_sal := my_func2(7566);
      dbms_output.put_line('���ʣ�'||v_sal);
end;

--**********��sql�����ִ��***********
select my_func2(7566) as ���� from dual;

--**********����һ������������һ�����ű����Ϊ������
--���ظò��ŵ�������
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
  dbms_output.put_line('��������'||v_count);
end;

--ʹ�ó����
--���ȶ���淶���֣��淶������Java�еĽӿڣ������׼��û�о����ʵ�֣�
create or replace package my_pack
is 
  --����һ������
  function my_func(v_deptno emps.deptno%type)return number;
  --����һ���洢����
  procedure my_proc(v_empno emps.empno%type,v_sal out emps.sal%type);
end;


--Ȼ��������ʵ�ֲ��֣�������������java�е�ʵ���࣬����ʵ�ֹ淶��
create or replace package body my_pack
is
--ʵ�ֹ淶�еķ���
function my_func(v_deptno emps.deptno%type)return number
  is
    --����һ���������뷵���ܼ�¼��
    v_count number(2);
    begin
      select count(*) into v_count from emps where deptno=v_deptno;
      return v_count;
    end;
    
    --ʵ�ֹ淶�ж���Ĵ洢����
procedure my_proc(v_empno emps.empno%type,v_sal out emps.sal%type)
  is
      begin
           --����ѯ�����ֵ���������
        select sal into v_sal from emps where empno=v_empno; 
       end;
 end;
    drop package body my_pack
    
    --����
    declare
         --����һ���������ڽ��շ����ķ���ֵ
         v_count number(2);
         --����һ���������ڽ����������
         v_sal emps.sal%type;
    begin
      --����ʱ�� ����.������
      v_count :=my_pack.my_func(20);
      dbms_output.put_line('��������'||v_count);
      --���ô洢���� ����.������
      my_pack.my_proc(7566,v_sal);
      dbms_output.put_line('н�ʣ�'||v_sal);
    end;
    
    select * from emps;
