--******************��ִ������һ��DML��������䣬�ͻ��Զ���һ����ʽ�α�
begin 
    --������ʽ�α�
    update emps set sal = sal+200 where empno=7499;
    --sqlִ������Զ��ر��α�
    if SQL%found then
      dbms_output.put_line('(found)���ڼ�¼');
    else
      dbms_output.put_line('(found)�����ڼ�¼');
    end if;
end;
select * from emps;

--*********************%notfound��%found�෴****************************
begin
  --������ʽ�α�
  update  emps set sal=sal+200 where empno=7499;
  if SQL%notfound then
    dbms_output.put_line('(notfound)û�м�¼');
  else
    dbms_output.put_line('(notfound)���ڼ�¼');
  end if;
end;

--*********%rowcount����,������Ӱ�������***********************
begin
  if SQL%rowcount >0 then
    dbms_output.put_line('(rowcount)���ڼ�¼');
  else
    dbms_output.put_line('(rowcount)û�м�¼');
  end if;
end;

--isopen,�ж��α��Ƿ��
begin
  update emps set sal=sal+100 where empno=7369;
  if SQL%isopen then
    dbms_output.put_line('�α��Ѿ���');
  else
    dbms_output.put_line('�α��Ѿ��ر�');
  end if;
  commit;--�ύ��������һ���ύ�ͻ�رս�����������α�һ���ǹرյģ�
end;

select * from emps where empno =7369;

--************��ʾ�α꣨����ʹ��cursor�ؼ��������α꣩**************
--1��forѭ����ʾ�α�
declare 
   --�����α꣬����ѯ����������α���
   cursor my_cursor is select * from emps where deptno=10;
   --���������͵ı��������α���ȡ����ÿһ�����ݸ�ֵ���������
   v_emp emps%rowtype;
begin
   --ѭ����ȡ�α����ݣ���ֵ��v_emp��forѭ�����Զ�open��close�α꣩
   for v_emp in my_cursor
     loop
       dbms_output.put_line('��Ա����'||v_emp.ename);
       dbms_output.put_line('ְλ��'||v_emp.job);
       dbms_output.put_line('���ʣ�'||v_emp.sal);
       dbms_output.put_line('����'||v_emp.comm);
       dbms_output.put_line('======================');
     end loop;
end;


--2��loopѭ����ʾ�α�
declare
   cursor my_cursor is select * from emps where deptno=10;
   
   --�����α����
   v_emp emps%rowtype;  
begin
   --���α꣨loopѭ��������α꣩
   open my_cursor;
   loop
     --���α��ж�ȡһ�����ݸ�ֵ������
     fetch my_cursor into v_emp;
     --���α��޼�¼��ʱ�˳�ѭ��
     exit when my_cursor%notfound;
     --��ʾ����
      Dbms_Output.put_line('��Ա����' || v_emp.ename);
      Dbms_Output.put_line('ְλ��' || v_emp.job);
      Dbms_Output.put_line('���ʣ�' || v_emp.sal);
      Dbms_Output.put_line('����' || v_emp.comm);
      Dbms_Output.put_line('===============================');
   end loop;
   --�ر��α�
   close my_cursor;
end;

--***********ʹ���α���¼�¼**************************
declare
   --�����α꣬�Ȳ�ѯ��Ȼ��ָ������
   cursor my_cursor is select empno from emps for update;
   --�������
   v_empno emps.empno%type;
   v_sal emps.sal%type;
begin
   --ʹ��ǰ���α�
   open my_cursor;
   --ѭ�������α�
   loop
     --ÿѭ��һ�Σ�ʹ��fetch�ؼ��ֲ�ѯ�α��л�ȡ��ǰ������
     fetch my_cursor into v_empno;
     --���α��Ҳ�����¼ʱ���˳�ѭ��
     exit when my_cursor%notfound;
     --�ӹ���ҵ��
     if v_empno =7379 then,
       v_sal:=100;
       --��v_sal����ͨ���α���µ���¼�У�ʹ��update���
       --where current of my_cursor ��UPDATE��������������ָ�α�ĵ�ǰ��
       update emps set sal=sal+v_sal where current of my_cursor;       
     end if;
   end loop;
   --�ύ����tmjg
   commit;
   --ѭ��������ر��α�
   close my_cursor;
end;

--***********ʹ���α�ɾ����¼**************************
declare
   --�����α�
   cursor my_cursor is select sal from emps for update;
   --�������
   v_sal emps.sal%type;
begin
   --���α�
   open my_cursor;
   --ѭ��
   loop
     --ץȡ�α����ݸ�ֵ��v_sal
     fetch my_cursor into v_sal;
     exit when my_cursor%notfound;
     --ɾ��ҵ��
     if v_sal<2000 then
        --ִ��ɾ��
        delete from emps where current of my_cursor;
        end if;
   end loop;
       --�ر��α�
       close my_cursor;
end;

--********�������α�***********************
declare 
  --�����α�
  cursor my_cursor(v_sal emps.sal%type)is select * from
  emps where sal>v_sal;
  --�������
  v_emp emps%rowtype;
begin 
  --���α꣨��ʱ�������д���һ��������
  open my_cursor(&sal);
  --ѭ��
  loop
    --��ȡһ������
    fetch my_cursor into v_emp;
    exit when my_cursor%notfound;
    --��ʾ����
    dbms_output.put_line('��Ա����'||v_emp.ename);
    dbms_output.put_line('ְλ��'||v_emp.job);
    dbms_output.put_line('���ʣ�'||v_emp.sal);
    dbms_output.put_line('����'||v_emp.comm);
    dbms_output.put_line('*********************');
  end loop;
  close my_cursor;
end;

--***********************���������α�**************************
declare 
  --����һ���������α꣬��ʹ�����α꽫�������ݸ������sql���ִ��
  cursor my_cursor(v_sal emps.sal%type)is select * from
  emps where sal>v_sal;
  --����һ�������͵ı��������ڽ����α��е��м�¼
  v_emp emps%rowtype;
begin
  --���α꣬����һ������
  open my_cursor(500);
  loop
    --�����α꣬���α���ץȡÿһ������
  fetch my_cursor into v_emp;
  exit when my_cursor%notfound;
  --����м�¼�е�����Ϣ
  dbms_output.put_line('������'||v_emp.ename||',н�ʣ�'||v_emp.sal);
  end loop;
  --�ر��α�
  close my_cursor;
end;

--**************��̬�α꣨ǿ���ͣ�*********************************
declare 
  --����һ��ǿ���͵��α����ͣ���ô����ʹ��һ���������������������
  type emp_cursor is ref cursor return emps%rowtype;
  --����һ��������������������;��������������emp_cursor����
  v_cursor emp_cursor;
  --����һ�������͵ı��������ڽ����α��е��м�¼
  v_emp emps%rowtype;
begin
  --���α꣨ע�⣺��̬�α����ڴ򿪵�ʱ�������ѯ��䣩
  open v_cursor for select * from emps;
  --ѭ��������ץȡһ�������ݣ���ֵ��v_emp����
  loop
    fetch v_cursor into v_emp;
    --���α��޼�¼ʱ���˳�ѭ��
    exit when v_cursor%notfound;
    --������е�����Ϣ
    dbms_output.put_line('������'||v_emp.ename||',��ţ�'||v_emp.empno);
  end loop;
    --�ر��α�
    close v_cursor;
end;


--******************��̬�α꣨�����ͣ�********************
declare
    --����һ�������͵��α꣬����Ҫָ����������
    --��ô����α�Ϳ��Է����������͵Ľ��
    --ͬǿ����һ�����ȶ���һ����̬�����ͣ�Ȼ�����������������
    type emp_cursor is ref cursor;
    --�ȶ���һ������������������α�����
    v_cursor emp_cursor;
    --�ȶ����������������ڽ����α�Ķ�̬�����
    v_emp emps%rowtype;
    v_dept depts%rowtype;
    v_count number;
begin
    
    --�򿪶�̬�α꣬������ѯ
    open v_cursor for select * from emps;
    --ѭ������������������Ƹ�v_emp����
    loop
      fetch v_cursor into v_emp;
      --�α��޼�¼ʱ�˳�ѭ��
      exit when v_cursor%notfound;
      --�����v_emp������Ϣ
      dbms_output.put_line('������'||v_emp.ename);
    end loop;
      --�ر��α�
      close v_cursor;
      dbms_output.put_line('=============================');
      --���´��α꣬���������Ĳ�ѯ
      open v_cursor for select * from depts;
      --ѭ�������α꣬��ֵ��v_dept����
      loop
        fetch v_cursor into v_dept;
        exit when v_cursor%notfound;
        dbms_output.put_line('�������ƣ�'||v_dept.dname);
      end loop;
      --�ر��α�
      close v_cursor;
      
      dbms_output.put_line('****************************');
      --�ٴδ��α꣬��ѯԱ��������
      open v_cursor for select count(*) from emps;
      --ֱ��ץȡ�α��еļ�¼���Ƹ�����v_count
      fetch v_cursor into v_count;
      --������
      dbms_output.put_line('��������'||v_count);
      --�ر��α�
      close v_cursor;
end;
      --����������������
    create table depts as select * from scott.dept;
    select * from depts;
    
