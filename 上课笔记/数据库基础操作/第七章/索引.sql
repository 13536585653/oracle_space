--为stu_Info表的s_name这一列创建一个B树的单列索引
create index stu_info on stu_info(s_name);

select * from stu_info where s_name ='stu1';

--删除索引
drop index stu_info;

--为stu_info表的s_name，s_sex列创建一个B树的复合索引
create index stu_index on stu_info(s_name,s_sex);

--为stu_Info表的s_name创建一个唯一索引，s_name中会出现重复记录
--可以使用唯一索引
create unique index stu_index on stu_info(s_name);

--当数据量很大时，创建索引时可选择规划索引段和存放的空间
create index stu_index on stu_info(s_name)
pctfree 30 tablespace space01;
 
--创建位图索引(位图索引适用于只有固定类型的值的列，例如：性别)
create bitmap index stu_index on stu_info(s_sex);

--创建函数索引，oracle会依据函数计算的结果决定使用B树还是位图索引
create index stu_index on stu_info(upper(s_name));

--合并索引
alter index stu_index coalesce;

--重建索引
alter index my_index rebuild;


select * from stu_info where s_sex='女'; 
