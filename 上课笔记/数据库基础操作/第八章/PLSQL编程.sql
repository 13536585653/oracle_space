--只有执行部分的代码块
begin 
  --输出一些信息(在控制台)
  dbms_output.put_line('hello pl/sql');

end;

--*******************定义声明部分和执行部分***********************

declare 
    --声明变量
    v_name varchar2(20);
    v_sal number(7,2);
    --声明常量（使用constant关键字），变量和常量的赋值都是使用":="
    v_sal2 constant number(7,2) :=123.1;

begin
  --执行查询(into是用来赋值的，将ename,sal的值赋值给v_name,v_sal)
  select ename,sal into v_name,v_sal from scott.emp where rownum =1;
  --控制台输出
  dbms_output.put_line('用户名：'||v_name);
  dbms_output.put_line('工资：'||v_sal);
  dbms_output.put_line('常量：'||v_sal2);
end;

--**********************定义声明、执行、异常部分************************
declare 
--声明变量
v_name varchar2(20);
v_sal number(7,2);
begin
      --执行查询，条件中的&表示从控制台接收数据
      select ename,sal into v_name,v_sal from scott.emp where empno=&no;
      --控制台输出
      dbms_output.put_line('用户名：'||v_name);
      dbms_output.put_line('工资：'||v_sal);
      
      exception
      --例外处理（no_data_found）
      when no_data_found then
        dbms_output.put_line('找不到任何记录');
end;

--*******************引用类型*****************************
declare
   v_name varchar2(20);--声明变量
   v_age number:=18;   --使用":="赋初始值
   v_job scott.emp.job%type; --引用scott.smp表的job列的类型
begin
   select job into v_job from scott.emp where empno=7369;
   dbms_output.put_line(v_job);
end;

--*******************复合类型（记录类型）******************************
declare
--自定义一个记录类型（相当于自己创建一种类型）,都是引用类型
--语法：type类型名称（属性,属性.......） 
  type my_record is record(
       empno scott.emp.empno%type,
       ename scott.emp.ename%type,
       sal scott.emp.sal%type
  );
 
  --声明一个变量，类型为my_record的记录类型
  v_record my_record;
begin 
  --使用记录类型，将查询的empno,ename,sal直接赋值给v_record变量
  select empno,ename,sal into v_record from scott.emp where rownum=1;
  --控制台输出
  dbms_output.put_line('雇员编号：'||v_record.empno);
  dbms_output.put_line('雇员姓名：'||v_record.ename);
  dbms_output.put_line('雇员工资：'||v_record.sal);
end;

--*********************复合类型（表类型）,其实就是数组*****************************
declare 
  --自定义一个表类型（也就是一个数组）
  --index by PLS_INTEGER 表示数组的下标自增长
  type my_array is table of varchar2(50) index by PLS_INTEGER;
  
  --声明一个变量v_array，类型为my_array的表类型
  v_array my_array;
  
begin
  select ename into v_array(0) from scott.emp where empno=7369;
  select ename into v_array(1) from scott.emp where empno=7499;
  select ename into v_array(2) from scott.emp where empno=7521;
  
  --在控制台输出
  dbms_output.put_line('第一个元素：'||v_array(0));
  dbms_output.put_line('第二个元素：'||v_array(1));
  dbms_output.put_line('第三个元素：'||v_array(2));
end;

--******************复合类型（varray类型）*****************************
declare
  --自定义一个varray的类型
  type my_varray is varray(3) of varchar2(20);
  
  --声明变量时赋值
  v_varray my_varray:=my_varray(100,101,102);
begin
  --使用for循环遍历
  for i in 1..v_varray.count
    loop
      dbms_output.put_line('第'||i||+'个元素:'||v_varray(i));
    end loop;
end;


--**************************下午*****************************
--创建表，并复制emp的表结构和数据
create table emps as select * from scott.emp;
select * from emps;

--控制语句 if then
declare 
  --声明变量，分别引用自emps表中的empno，sal列的数据类型
  v_empno emps.empno%type;
  v_sal emps.sal%type;
begin
  --执行查询，赋值给变量
  select empno,sal into v_empno,v_sal from emps where empno=&no;
  --执行判断，如果v_sal小于2000，这更新此员工的薪资（加薪）
  if v_sal < 2000 then
    update emps set sal=v_sal +1000 where empno =v_empno;
    --提交事务
    commit;
    end if;
end;
select * from emps where empno=7369;

--*************************	if—then—else***************************
declare
  --声明变量
  v_loginname varchar2(50);
  v_password varchar2(50);
begin
  --从控制台接受数据
  v_loginname :='&name';
  v_password :='&passwd';
  --执行验证
  if v_loginname = 'admin' and v_password ='123'
  then
    dbms_output.put_line('登录成功！');
  else
    dbms_output.put_line('登录失败！');
    end if;
end;

--*************************if—then—elsif—else**************************
declare
    v_empno emps.empno%type;
    v_job emps.job%type;
begin
  select empno,job into v_empno,v_job from emps where empno= '&no';
    if v_job='MANAGER' then
      update emps set sal=sal+1000 where empno=v_empno;
      dbms_output.put_line('你是领导！');
    elsif v_job='SALESMAN' then
       update emps set sal=sal+500 where empno=v_empno;
       dbms_output.put_line('你是组长！');
    else update emps set sal=sal+200 where empno=v_empno;
       dbms_output.put_line('你是普通人！');
    end if;
    --提交事务
    commit;
end;

--********************case**************************
declare 
    --声明变量
    v_mark number(4);
    v_outstr varchar(40);
begin
  --从控制台接收成绩
  v_mark :=&m;
  case
    when v_mark<=100 and v_mark>90 then
      v_outstr :='优秀';
    when v_mark<90 and v_mark>=80 then
      v_outstr :='良好';
    when v_mark<80 and v_mark>=70 then
      v_outstr :='中等';
    when v_mark<70 and v_mark>=60 then
      v_outstr :='及格';
    when v_mark<60 and v_mark>=0 then
      v_outstr :='不及格';
    else
      v_outstr :='成绩输入有误！';
    end case;
    --控制台输出
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
      --控制台输出
      dbms_output.put_line('num:'||i);
    end loop;
end;


declare
    --声明表类型
    type emp_table_type is table of varchar2(20)
    index by PLS_INTEGER;--表示表按整数来排序
    v_enames emp_table_type;--定义变量引用表类型
    begin
      --所有值赋予v_enames
      select ename bulk collect into v_enames from emps;
      --输出
      for i in 1..v_enames.count
        loop
          dbms_output.put_line(v_enames(i));
          end loop;
     end;
     
--**************执行DDL************************************
declare 
     --定义变量
     v_sql varchar2(100);
begin
  --赋值
  v_sql :='create table test_info(t_id number(4),t_name varchar2(20))';
  --执行动态SQL
  execute immediate v_sql;
end;     
   select * from test_info;  

--外部传入sql语句
declare
   v_sql varchar2(100);
begin
  --如在控制台输入select * from emps;
  v_sql := '&sql';
  execute immediate v_sql; 
end;

--*****************************获取单条数据************************
declare 
  --定义动态sql变量
  v_sql varchar2(100);
  v_emp emps%rowtype;--定义行引用类型，引用所有列
begin 
  --将动态sql赋值到变量中(:no相当于Java里面的sql中的"?"，
  --这里的"?"对应从控制台输入的":no")
  v_sql :='select * from emps where empno=:no';
  --执行动态sql（使用using关键字来设置where条件参数）
  execute immediate v_sql into v_emp using &no;
  --输出结果
  dbms_output.put_line('姓名：'||v_emp.ename||'   '||'职位：'||v_emp.job);
  
end;

--*********************多条数据的获取***************************
declare
  --定义动态sql变量
  v_sql varchar2(100);
  --定义表类型（其实就是数组类型），该数组中元素类型为行类型
  type v_table_list is table of emps%rowtype
  --定义该表下标按照整数自动增长
  index by binary_integer;
  --定义变量引用表类型
  v_list v_table_list;
begin
  v_sql:='select * from emps';
  --执行动态sql，并将结果放入v_list变量中
  execute immediate v_sql bulk collect into v_list;
  --输出
  --集合循环出来的每一个元素都是一个行类型的记录
  --因此可以根据行取出其中的某列数据
  for i in 1..v_list.count
    loop
      dbms_output.put_line('姓名：'||v_list(i).ename||'   ,'||'职位：'||v_list(i).job);
    end loop;
end;

--*********dml中使用returning关键字获取dml语句执行的结果******************
declare 
    --定义一个变量，该变量的类型为员工工资字段的类型
    v_sal emps.sal%type;
begin
    --执行静态sql
    update emps set sal =sal+200 where empno=&no
    --更新之后，可以通过returning关键字获取更新后的值
    --将更新后的sal这一列的值赋给v_sql变量
    returning sal into v_sal;
    --输出执行sql后的工资
    dbms_output.put_line('修改后的工资：'||v_sal);
  
end;

select * from emps where empno=7369;
