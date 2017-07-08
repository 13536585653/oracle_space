--******************早执行任意一个DML操作的语句，就会自动打开一个隐式游标
begin 
    --开启隐式游标
    update emps set sal = sal+200 where empno=7499;
    --sql执行完会自动关闭游标
    if SQL%found then
      dbms_output.put_line('(found)存在记录');
    else
      dbms_output.put_line('(found)不存在记录');
    end if;
end;
select * from emps;

--*********************%notfound与%found相反****************************
begin
  --开启隐式游标
  update  emps set sal=sal+200 where empno=7499;
  if SQL%notfound then
    dbms_output.put_line('(notfound)没有记录');
  else
    dbms_output.put_line('(notfound)存在记录');
  end if;
end;

--*********%rowcount属性,操作后影响的行数***********************
begin
  if SQL%rowcount >0 then
    dbms_output.put_line('(rowcount)存在记录');
  else
    dbms_output.put_line('(rowcount)没有记录');
  end if;
end;

--isopen,判断游标是否打开
begin
  update emps set sal=sal+100 where empno=7369;
  if SQL%isopen then
    dbms_output.put_line('游标已经打开');
  else
    dbms_output.put_line('游标已经关闭');
  end if;
  commit;--提交事务（事务一但提交就会关闭结果集，所以游标一定是关闭的）
end;

select * from emps where empno =7369;

--************显示游标（必须使用cursor关键字声明游标）**************
--1、for循环显示游标
declare 
   --定义游标，将查询结果保存在游标中
   cursor my_cursor is select * from emps where deptno=10;
   --定义行类型的变量，从游标中取出的每一行数据赋值给这个变量
   v_emp emps%rowtype;
begin
   --循环读取游标数据，赋值给v_emp（for循环会自动open和close游标）
   for v_emp in my_cursor
     loop
       dbms_output.put_line('雇员名：'||v_emp.ename);
       dbms_output.put_line('职位：'||v_emp.job);
       dbms_output.put_line('工资：'||v_emp.sal);
       dbms_output.put_line('奖金：'||v_emp.comm);
       dbms_output.put_line('======================');
     end loop;
end;


--2、loop循环显示游标
declare
   cursor my_cursor is select * from emps where deptno=10;
   
   --定义游标变量
   v_emp emps%rowtype;  
begin
   --打开游标（loop循环必须打开游标）
   open my_cursor;
   loop
     --从游标中读取一行数据赋值给变量
     fetch my_cursor into v_emp;
     --当游标无记录行时退出循环
     exit when my_cursor%notfound;
     --显示数据
      Dbms_Output.put_line('雇员名：' || v_emp.ename);
      Dbms_Output.put_line('职位：' || v_emp.job);
      Dbms_Output.put_line('工资：' || v_emp.sal);
      Dbms_Output.put_line('奖金：' || v_emp.comm);
      Dbms_Output.put_line('===============================');
   end loop;
   --关闭游标
   close my_cursor;
end;

--***********使用游标更新记录**************************
declare
   --声明游标，先查询，然后指定更新
   cursor my_cursor is select empno from emps for update;
   --定义变量
   v_empno emps.empno%type;
   v_sal emps.sal%type;
begin
   --使用前打开游标
   open my_cursor;
   --循环遍历游标
   loop
     --每循环一次，使用fetch关键字查询游标中获取当前行数据
     fetch my_cursor into v_empno;
     --当游标找不到记录时，退出循环
     exit when my_cursor%notfound;
     --加工资业务
     if v_empno =7379 then,
       v_sal:=100;
       --将v_sal变量通过游标更新到记录中，使用update语句
       --where current of my_cursor 是UPDATE语句的条件，就是指游标的当前行
       update emps set sal=sal+v_sal where current of my_cursor;       
     end if;
   end loop;
   --提交事务tmjg
   commit;
   --循环结束后关闭游标
   close my_cursor;
end;

--***********使用游标删除记录**************************
declare
   --定义游标
   cursor my_cursor is select sal from emps for update;
   --定义变量
   v_sal emps.sal%type;
begin
   --打开游标
   open my_cursor;
   --循环
   loop
     --抓取游标数据赋值给v_sal
     fetch my_cursor into v_sal;
     exit when my_cursor%notfound;
     --删除业务
     if v_sal<2000 then
        --执行删除
        delete from emps where current of my_cursor;
        end if;
   end loop;
       --关闭游标
       close my_cursor;
end;

--********带参数游标***********************
declare 
  --定义游标
  cursor my_cursor(v_sal emps.sal%type)is select * from
  emps where sal>v_sal;
  --定义变量
  v_emp emps%rowtype;
begin 
  --打开游标（打开时从命令行传入一个参数）
  open my_cursor(&sal);
  --循环
  loop
    --读取一行数据
    fetch my_cursor into v_emp;
    exit when my_cursor%notfound;
    --显示数据
    dbms_output.put_line('雇员名：'||v_emp.ename);
    dbms_output.put_line('职位：'||v_emp.job);
    dbms_output.put_line('工资：'||v_emp.sal);
    dbms_output.put_line('奖金：'||v_emp.comm);
    dbms_output.put_line('*********************');
  end loop;
  close my_cursor;
end;

--***********************带参数的游标**************************
declare 
  --声明一个带参数游标，在使用是游标将参数传递给具体的sql语句执行
  cursor my_cursor(v_sal emps.sal%type)is select * from
  emps where sal>v_sal;
  --定义一个行类型的变量，用于接收游标中的行记录
  v_emp emps%rowtype;
begin
  --打开游标，传递一个参数
  open my_cursor(500);
  loop
    --遍历游标，从游标中抓取每一条数据
  fetch my_cursor into v_emp;
  exit when my_cursor%notfound;
  --输出行记录中的列信息
  dbms_output.put_line('姓名：'||v_emp.ename||',薪资：'||v_emp.sal);
  end loop;
  --关闭游标
  close my_cursor;
end;

--**************动态游标（强类型）*********************************
declare 
  --定义一个强类型的游标类型，那么必须使用一个变量了来引用这个类型
  type emp_cursor is ref cursor return emps%rowtype;
  --声明一个变量，这个变量的类型就是上面所定义的emp_cursor类型
  v_cursor emp_cursor;
  --声明一个行类型的变量，用于接收游标中的行记录
  v_emp emps%rowtype;
begin
  --打开游标（注意：动态游标是在打开的时候关联查询语句）
  open v_cursor for select * from emps;
  --循环遍历，抓取一个行数据，赋值给v_emp变量
  loop
    fetch v_cursor into v_emp;
    --当游标无记录时，退出循环
    exit when v_cursor%notfound;
    --输出行中的列信息
    dbms_output.put_line('姓名：'||v_emp.ename||',编号：'||v_emp.empno);
  end loop;
    --关闭游标
    close v_cursor;
end;


--******************动态游标（弱类型）********************
declare
    --声明一个弱类型的游标，不需要指定返回类型
    --那么这个游标就可以返回任意类型的结果
    --同强类型一样，先定义一个动态表类型，然后声明引用这个类型
    type emp_cursor is ref cursor;
    --先定义一个变量，引用上面的游标类型
    v_cursor emp_cursor;
    --先定义两个变量，用于接收游标的动态结果集
    v_emp emps%rowtype;
    v_dept depts%rowtype;
    v_count number;
begin
    
    --打开动态游标，关联查询
    open v_cursor for select * from emps;
    --循环遍历，将结果集复制给v_emp变量
    loop
      fetch v_cursor into v_emp;
      --游标无记录时退出循环
      exit when v_cursor%notfound;
      --输出行v_emp的列信息
      dbms_output.put_line('姓名：'||v_emp.ename);
    end loop;
      --关闭游标
      close v_cursor;
      dbms_output.put_line('=============================');
      --重新打开游标，关联其他的查询
      open v_cursor for select * from depts;
      --循环遍历游标，赋值给v_dept变量
      loop
        fetch v_cursor into v_dept;
        exit when v_cursor%notfound;
        dbms_output.put_line('部门名称：'||v_dept.dname);
      end loop;
      --关闭游标
      close v_cursor;
      
      dbms_output.put_line('****************************');
      --再次打开游标，查询员工总人数
      open v_cursor for select count(*) from emps;
      --直接抓取游标中的记录复制给变量v_count
      fetch v_cursor into v_count;
      --输出结果
      dbms_output.put_line('总人数：'||v_count);
      --关闭游标
      close v_cursor;
end;
      --创建并拷贝表数据
    create table depts as select * from scott.dept;
    select * from depts;
    
