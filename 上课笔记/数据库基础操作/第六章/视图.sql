--��ѯ�༶ΪST01������ѧ��
select c.c_name,s.s_name,s.s_age,s.s_sex from stu_info s left
join class_info c on s.c_id = c.c_id
where c.c_name ='ST01';

--ͳ�����а༶������Ů����������
select c.c_name as �༶,s.s_sex as �Ա�,count(s.s_id) as ����
from stu_info s left join class_info c on s.c_id = c.c_id group by
c.c_name,s.s_sex order by count(s.s_id) desc;

--������ͼ��ʽ���﷨����ϵ��ͼ��
CREATE [OR REPLACE] [FORCE|NOFORCE] VIEW view_name [(alias[, alias]...)] 
AS subquery 
[WITH CHECK OPTION [CONSTRAINT constraint]] 
[WITH READ ONLY]

--��ͳ�Ʋ�ѯ����һ����ͼ
create or replace view stu_view
as 
select c.c_name as �༶,s.s_sex as �Ա�,count (s.s_id) as ����
from class_info c left join stu_info s on c.c_id = s.c_id
group by c.c_name ,s.s_sex order by c.c_name asc;

--��ѯ��ͼ
select * from stu_view;

--ɾ����ͼ
drop view stu_view;


--��ͳ�Ʋ�ѯ����һ��ֻ����ͼ
create or replace view stu_view
as 
select c.c_name as �༶,s.s_sex as �Ա�,count (s.s_id) as ����
from class_info c left join stu_info s on c.c_id = s.c_id
group by c.c_name ,s.s_sex order by c.c_name asc
with read only;

--���༶��ѯ����һ����ͼ
create or replace view class_view
as 
select * from class_info;

select * from class_view;

--ͨ����ͼ�޸ı�����
update class_view set c_name='ST01' where c_id=1;

--��ѧ����Ϣ����һ��Լ����ͼ
create or replace view stu_view
as
select * from stu_info where s_age>18
with check option;
--������ͼ������with check option ѡ�����ͼ���� DML
--����ʱ������Υ����ͼ�Ĳ�ѯ����
update stu_view set s_age=13;

select * from stu_view;

--�ﻯ��ͼ����ʽ��
create materialized view materialized_view_name
build [immediate|deferred]  --1.������ʽ
refresh [complete|fast|force|never]     --2.�ﻯ��ͼˢ�·�ʽ
on [commit|demand]   --3.ˢ�´�����ʽ
start with (start_date)   --4.��ʼʱ��
next (interval_date)   --5.���ʱ��
with [primary key|rowid]  --6.����ģʽ(Ĭ�� primary key)
ENABLE QUERY REWRITE   --7.�Ƿ����ò�ѯ��д
as     --8.�ؼ���
select statement;   --9.����ѡȡ���ݵ�select���


--���ӣ�
--��������ˢ�µ��ﻯ��ͼʱӦ�ȴ����洢����־�ռ�
--��scott.emp���д����ﻯ��ͼ��־
 create materialized view log on emp
 tablespace users �Cָ����ŵı�ռ�(��ʡ��)
with rowid; --����rowid��¼��ͼ��־

--ʼ�����ﻯ��ͼ
--��ʽһ(�ύʱˢ��)
create materialized view mv_emp
tablespace users                   --ָ����ռ�(��ʡ��)
build immediate                    --������ͼʱ����������
refresh fast                       --��������ˢ��
on commit                          --����DML�����ύ��ˢ��
with rowid                         --����ROWIDˢ��
as select * from emp
--��ʽ��(��ʱˢ��)
create materialized view mv_emp2
tablespace users                   --ָ����ռ�(��ʡ��)
refresh fast                       --��������ˢ��
start with sysdate                 --������ͼʱ����������
next sysdate+1/1440                /*ÿ��һ����ˢ��һ��*/
with rowid                         --����ROWIDˢ��
as select * from emp

--ɾ���ﻯ��ͼ��־
drop materialized view mv_emp


