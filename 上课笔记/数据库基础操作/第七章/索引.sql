--Ϊstu_Info���s_name��һ�д���һ��B���ĵ�������
create index stu_info on stu_info(s_name);

select * from stu_info where s_name ='stu1';

--ɾ������
drop index stu_info;

--Ϊstu_info���s_name��s_sex�д���һ��B���ĸ�������
create index stu_index on stu_info(s_name,s_sex);

--Ϊstu_Info���s_name����һ��Ψһ������s_name�л�����ظ���¼
--����ʹ��Ψһ����
create unique index stu_index on stu_info(s_name);

--���������ܴ�ʱ����������ʱ��ѡ��滮�����κʹ�ŵĿռ�
create index stu_index on stu_info(s_name)
pctfree 30 tablespace space01;
 
--����λͼ����(λͼ����������ֻ�й̶����͵�ֵ���У����磺�Ա�)
create bitmap index stu_index on stu_info(s_sex);

--��������������oracle�����ݺ�������Ľ������ʹ��B������λͼ����
create index stu_index on stu_info(upper(s_name));

--�ϲ�����
alter index stu_index coalesce;

--�ؽ�����
alter index my_index rebuild;


select * from stu_info where s_sex='Ů'; 
