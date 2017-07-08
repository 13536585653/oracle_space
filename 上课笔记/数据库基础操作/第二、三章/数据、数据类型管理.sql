--����һ�ű�ͬʱ�����е����������������Ӳ�ѯ�еı������е�����
--ͬʱ������һ���������±���

create table temp(e_id,e_name,sal)
as select empno,ename,sal from scott.emp; 
--as����˼��ͬ���ģ������ �÷��ǽ���scott.emp�����ݿ������±�temp��

--�������ű�
create table temp2 as select * from scott.emp;
delete from temp;
select  * from temp2;
--ɾ����
drop table temp;
drop table temp2;

--���Ʊ�����(��scott.emp����ı����ݸ���һ�ݵ�temp����)
--��������һ��Ҫ�ֶ���ͬ���ṹ��ͬ��
--insert into temp select * from scott.emp;
select * from temp;


--����ع�
savepoint p1;
insert into temp values(.......);
savepoint p2;
insert into temp values(.......);
savepoint p3;

rollback to p2;

create table test_number(
       num1 number,
       num2 number(3,2),--��3��������λ��Ч���֣���2��С���������λ
       num3 number(3,-1)--(3)������λ��Ч���֣���-1��С����ǰһλ
);

insert into test_number(num1,num2,num3)values(2.2,2.4585,337.82);
select * from test_number;


create table test_date(
       date1 date, 
       date2 timestamp
);
select * from test_date;
--�������ڣ�ʹ��to_date��to_timestamp�����۸��ַ���ת��������
insert into test_date values(
to_date('2016-01-02 12:35:01','YYYY-MM-dd HH24:MI:SS'),
to_timestamp('2016-02-12 11:23:11.123','YYYY-MM-DD HH24:MI:SS:FF3'));

--���뵱ǰϵͳʱ��
insert into test_date values(sysdate,sysdate);


create table test_lob(
       u_name varchar2(50),
       author clob --�Ǵ洢�ַ����ݵĴ��������,���Դ�Ŵ������ַ�����
);
insert into test_lob values('user1','�����������ģ�ȷʵ�Ǻܲ���');
select * from test_lob;

--rowid���selectһ��ʹ��,���ص��������е������ַ
select rowid,e.empno,e.ename,e.job from scott.emp e;

--rownum���selectһ��ʹ��,����һ����˳�����ֵ,����������
select rownum,e.empno,e.ename,e.job from scott.emp e;

--��ѯ��ǰ����(dual��һ��α��)
select sysdate from dual;

--systimestamp : ���ص�ǰ�����ڻ���ʱ�������,����ʱ��
select systimestamp from dual;

--last_day(d) : ����ָ�����������·ݵ����һ�������ֵ,d��������
select last_day(sysdate) from dual;

--Ϊ��ǰ�������������
select add_months(sysdate,2) from dual;

--months_between(f, s) : ������������f��s֮����������
select months_between(sysdate,to_date('2015-10','yyyy-mm'))as ������� from dual;

select next_day(sysdate,1)from dual;

--��ȡ��ǰʱ������
select extract(year from sysdate) from dual;
--��ȡ��ǰʱ����·�
select extract(month from sysdate) from dual;
--��ȡ��ǰʱ�������
select extract(day from sysdate) from dual;


--���ص�ǰ������
select trunc(sysdate) from dual;
--���ص�ǰ��ĵ�һ��
select trunc(sysdate,'yy')from dual;
--���ص��µĵ�һ��
select trunc(sysdate,'mm')from dual;
--���ص�ǰ������
select trunc(sysdate,'dd')from dual;
--���ص����һ��
select trunc(sysdate,'yyyy') from dual;
--..........

--ʹ��trunc������ȡ���֣���������������
select trunc(89.982,2) from dual; --�����89.98
select trunc(232.33) from dual;   --�����232
select trunc(323.2212,-2) from dual; --�����300

--ʹ��round������ȡ���֣�����������
select round(89.985,2) from dual; --�����89.99
select round(232.83)from dual; --�����233
select round(235.155,-1)from dual; --�����240

--ʹ��concat���������ַ�����
select concat(ename,concat('(',concat(job,')')))
as �û���Ϣ from scott.emp;
--Ҳ����ʹ��'\\'���Ž�������
select ename ||'('||job||')'as �û���Ϣ from scott.emp;

select * from scott.emp where length(ename)=5;

--����Ա�Ľ����ʾΪ*��
select ename,replace(sal,sal,'*') as н�� from scott.emp;

--���ҹ�Ա�����С�LA���ַ�����Ϣ
select * from scott.emp where instr(ename,'LA')>0;

--�����
select lpad('hello',10,'*')from dual;
--�����
select rpad('hello',10,'*')from dual;

select 2*3 from dual;--dual��һ��������ʾ��ʱ���ݵ�α��

select ceil(2.48) from dual;

select bin_to_num(1,0,0,1,0)from dual;

--����ǰϵͳʱ��ת�����ַ�������
select  to_char(sysdate,'yyyy-mm-dd hh24:mi:ss') from dual;

--��ʽ���ɻ��Ҹ�ʽ
select to_char(100203.78999999999999,'L999G999D99')as money from dual;


--���ַ���ת�������ֶ���
select to_number('209.976', '9G999D999')*5 from dual; 
