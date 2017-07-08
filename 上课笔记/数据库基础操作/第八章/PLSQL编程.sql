--ֻ��ִ�в��ֵĴ����
begin 
  --���һЩ��Ϣ(�ڿ���̨)
  dbms_output.put_line('hello pl/sql');

end;

--*******************�����������ֺ�ִ�в���***********************

declare 
    --��������
    v_name varchar2(20);
    v_sal number(7,2);
    --����������ʹ��constant�ؼ��֣��������ͳ����ĸ�ֵ����ʹ��":="
    v_sal2 constant number(7,2) :=123.1;

begin
  --ִ�в�ѯ(into��������ֵ�ģ���ename,sal��ֵ��ֵ��v_name,v_sal)
  select ename,sal into v_name,v_sal from scott.emp where rownum =1;
  --����̨���
  dbms_output.put_line('�û�����'||v_name);
  dbms_output.put_line('���ʣ�'||v_sal);
  dbms_output.put_line('������'||v_sal2);
end;

--**********************����������ִ�С��쳣����************************
declare 
--��������
v_name varchar2(20);
v_sal number(7,2);
begin
      --ִ�в�ѯ�������е�&��ʾ�ӿ���̨��������
      select ename,sal into v_name,v_sal from scott.emp where empno=&no;
      --����̨���
      dbms_output.put_line('�û�����'||v_name);
      dbms_output.put_line('���ʣ�'||v_sal);
      
      exception
      --���⴦��no_data_found��
      when no_data_found then
        dbms_output.put_line('�Ҳ����κμ�¼');
end;

--*******************��������*****************************
declare
   v_name varchar2(20);--��������
   v_age number:=18;   --ʹ��":="����ʼֵ
   v_job scott.emp.job%type; --����scott.smp���job�е�����
begin
   select job into v_job from scott.emp where empno=7369;
   dbms_output.put_line(v_job);
end;

--*******************�������ͣ���¼���ͣ�******************************
declare
--�Զ���һ����¼���ͣ��൱���Լ�����һ�����ͣ�,������������
--�﷨��type�������ƣ�����,����.......�� 
  type my_record is record(
       empno scott.emp.empno%type,
       ename scott.emp.ename%type,
       sal scott.emp.sal%type
  );
 
  --����һ������������Ϊmy_record�ļ�¼����
  v_record my_record;
begin 
  --ʹ�ü�¼���ͣ�����ѯ��empno,ename,salֱ�Ӹ�ֵ��v_record����
  select empno,ename,sal into v_record from scott.emp where rownum=1;
  --����̨���
  dbms_output.put_line('��Ա��ţ�'||v_record.empno);
  dbms_output.put_line('��Ա������'||v_record.ename);
  dbms_output.put_line('��Ա���ʣ�'||v_record.sal);
end;

--*********************�������ͣ������ͣ�,��ʵ��������*****************************
declare 
  --�Զ���һ�������ͣ�Ҳ����һ�����飩
  --index by PLS_INTEGER ��ʾ������±�������
  type my_array is table of varchar2(50) index by PLS_INTEGER;
  
  --����һ������v_array������Ϊmy_array�ı�����
  v_array my_array;
  
begin
  select ename into v_array(0) from scott.emp where empno=7369;
  select ename into v_array(1) from scott.emp where empno=7499;
  select ename into v_array(2) from scott.emp where empno=7521;
  
  --�ڿ���̨���
  dbms_output.put_line('��һ��Ԫ�أ�'||v_array(0));
  dbms_output.put_line('�ڶ���Ԫ�أ�'||v_array(1));
  dbms_output.put_line('������Ԫ�أ�'||v_array(2));
end;

--******************�������ͣ�varray���ͣ�*****************************
declare
  --�Զ���һ��varray������
  type my_varray is varray(3) of varchar2(20);
  
  --��������ʱ��ֵ
  v_varray my_varray:=my_varray(100,101,102);
begin
  --ʹ��forѭ������
  for i in 1..v_varray.count
    loop
      dbms_output.put_line('��'||i||+'��Ԫ��:'||v_varray(i));
    end loop;
end;


--**************************����*****************************
--������������emp�ı�ṹ������
create table emps as select * from scott.emp;
select * from emps;

--������� if then
declare 
  --�����������ֱ�������emps���е�empno��sal�е���������
  v_empno emps.empno%type;
  v_sal emps.sal%type;
begin
  --ִ�в�ѯ����ֵ������
  select empno,sal into v_empno,v_sal from emps where empno=&no;
  --ִ���жϣ����v_salС��2000������´�Ա����н�ʣ���н��
  if v_sal < 2000 then
    update emps set sal=v_sal +1000 where empno =v_empno;
    --�ύ����
    commit;
    end if;
end;
select * from emps where empno=7369;

--*************************	if��then��else***************************
declare
  --��������
  v_loginname varchar2(50);
  v_password varchar2(50);
begin
  --�ӿ���̨��������
  v_loginname :='&name';
  v_password :='&passwd';
  --ִ����֤
  if v_loginname = 'admin' and v_password ='123'
  then
    dbms_output.put_line('��¼�ɹ���');
  else
    dbms_output.put_line('��¼ʧ�ܣ�');
    end if;
end;

--*************************if��then��elsif��else**************************
declare
    v_empno emps.empno%type;
    v_job emps.job%type;
begin
  select empno,job into v_empno,v_job from emps where empno= '&no';
    if v_job='MANAGER' then
      update emps set sal=sal+1000 where empno=v_empno;
      dbms_output.put_line('�����쵼��');
    elsif v_job='SALESMAN' then
       update emps set sal=sal+500 where empno=v_empno;
       dbms_output.put_line('�����鳤��');
    else update emps set sal=sal+200 where empno=v_empno;
       dbms_output.put_line('������ͨ�ˣ�');
    end if;
    --�ύ����
    commit;
end;

--********************case**************************
declare 
    --��������
    v_mark number(4);
    v_outstr varchar(40);
begin
  --�ӿ���̨���ճɼ�
  v_mark :=&m;
  case
    when v_mark<=100 and v_mark>90 then
      v_outstr :='����';
    when v_mark<90 and v_mark>=80 then
      v_outstr :='����';
    when v_mark<80 and v_mark>=70 then
      v_outstr :='�е�';
    when v_mark<70 and v_mark>=60 then
      v_outstr :='����';
    when v_mark<60 and v_mark>=0 then
      v_outstr :='������';
    else
      v_outstr :='�ɼ���������';
    end case;
    --����̨���
    dbms_output.put_line(v_outstr);
end;
--********************loop*****************************************
declare
    v_num number(4):=1;
begin
  Loop
    dbms_output.put_line('num:'||v_num);
  exit when v_num=10;
    v_num:=v_num+1;
    end loop;
end;

--*****************while****************************************
declare
    v_num number(4):=1;
begin
  while v_num<11
    loop
      dbms_output.put_line('num:'||v_num);
      v_num:=v_num+1;
      end loop;
end;

--*********************for*************************************

begin
  for i in 1..10
    loop
      --����̨���
      dbms_output.put_line('num:'||i);
    end loop;
end;


declare
    --����������
    type emp_table_type is table of varchar2(20)
    index by PLS_INTEGER;--��ʾ������������
    v_enames emp_table_type;--����������ñ�����
    begin
      --����ֵ����v_enames
      select ename bulk collect into v_enames from emps;
      --���
      for i in 1..v_enames.count
        loop
          dbms_output.put_line(v_enames(i));
          end loop;
     end;
     
--**************ִ��DDL************************************
declare 
     --�������
     v_sql varchar2(100);
begin
  --��ֵ
  v_sql :='create table test_info(t_id number(4),t_name varchar2(20))';
  --ִ�ж�̬SQL
  execute immediate v_sql;
end;     
   select * from test_info;  

--�ⲿ����sql���
declare
   v_sql varchar2(100);
begin
  --���ڿ���̨����select * from emps;
  v_sql := '&sql';
  execute immediate v_sql; 
end;

--*****************************��ȡ��������************************
declare 
  --���嶯̬sql����
  v_sql varchar2(100);
  v_emp emps%rowtype;--�������������ͣ�����������
begin 
  --����̬sql��ֵ��������(:no�൱��Java�����sql�е�"?"��
  --�����"?"��Ӧ�ӿ���̨�����":no")
  v_sql :='select * from emps where empno=:no';
  --ִ�ж�̬sql��ʹ��using�ؼ���������where����������
  execute immediate v_sql into v_emp using &no;
  --������
  dbms_output.put_line('������'||v_emp.ename||'   '||'ְλ��'||v_emp.job);
  
end;

--*********************�������ݵĻ�ȡ***************************
declare
  --���嶯̬sql����
  v_sql varchar2(100);
  --��������ͣ���ʵ�����������ͣ�����������Ԫ������Ϊ������
  type v_table_list is table of emps%rowtype
  --����ñ��±갴�������Զ�����
  index by binary_integer;
  --����������ñ�����
  v_list v_table_list;
begin
  v_sql:='select * from emps';
  --ִ�ж�̬sql�������������v_list������
  execute immediate v_sql bulk collect into v_list;
  --���
  --����ѭ��������ÿһ��Ԫ�ض���һ�������͵ļ�¼
  --��˿��Ը�����ȡ�����е�ĳ������
  for i in 1..v_list.count
    loop
      dbms_output.put_line('������'||v_list(i).ename||'   ,'||'ְλ��'||v_list(i).job);
    end loop;
end;

--*********dml��ʹ��returning�ؼ��ֻ�ȡdml���ִ�еĽ��******************
declare 
    --����һ���������ñ���������ΪԱ�������ֶε�����
    v_sal emps.sal%type;
begin
    --ִ�о�̬sql
    update emps set sal =sal+200 where empno=&no
    --����֮�󣬿���ͨ��returning�ؼ��ֻ�ȡ���º��ֵ
    --�����º��sal��һ�е�ֵ����v_sql����
    returning sal into v_sal;
    --���ִ��sql��Ĺ���
    dbms_output.put_line('�޸ĺ�Ĺ��ʣ�'||v_sal);
  
end;

select * from emps where empno=7369;
