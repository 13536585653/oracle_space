
--用户二
select * from wz.users_info;

update wz.users_info set u_name='狼野' where age='15';

--加入一个行共享锁
lock table wz.users_info in row share mode;
--加入一个行专用锁
lock table wz.users_info in  exclusive mode;
