--用户一
select * from wz.users_info;
--不允许对wz.users_info表里面的u_name为15的人进行操作（修改）
select * from wz.users_info where age=15 for update
--不允许其他用户对wz.users_info里的所有数据进行修改
select * from wz.users_info for update
--如果已经被锁定，就不用等待
select * from wz.users_info for update nowait
--如果已经被锁定，更新的时候等待5秒
select * from wz.users_info for update wait 5

update wz.users_info set addr='广东' where age=15;

--给wz.users_info加入一个行共享锁
lock table wz.users_info in row share mode;
