--�û�һ
select * from wz.users_info;
--�������wz.users_info�������u_nameΪ15���˽��в������޸ģ�
select * from wz.users_info where age=15 for update
--�����������û���wz.users_info����������ݽ����޸�
select * from wz.users_info for update
--����Ѿ����������Ͳ��õȴ�
select * from wz.users_info for update nowait
--����Ѿ������������µ�ʱ��ȴ�5��
select * from wz.users_info for update wait 5

update wz.users_info set addr='�㶫' where age=15;

--��wz.users_info����һ���й�����
lock table wz.users_info in row share mode;
