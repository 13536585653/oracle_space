
--�û���
select * from wz.users_info;

update wz.users_info set u_name='��Ұ' where age='15';

--����һ���й�����
lock table wz.users_info in row share mode;
--����һ����ר����
lock table wz.users_info in  exclusive mode;
