select * from tablename as of timestamp to_timestamp('2018-05-04 13:30:00','yyyy-MM-dd hh24:mi:ss')
/**
查询这个时间点的数据

（有可能因为系统时间和数据库时间不一致查不出数据 所以先查询数据库的时间

select  to_char(sysdate,'yyyy-mm-dd hh24:mi:ss') from dual

按照这个时间为准，找到数据删除时间之前的数据）

找到数据可以导出为Excel ，怎么恢复就不是问题了

flashback table tablename to timestamp to_timestamp('2018-05-04 13:30:00','yyyy-MM-dd hh24:mi:ss')

执行这条语句把数据恢复到这个时间点

---------------------------------------------

报错： ORA-08189: 因为未启用行移动功能, 不能闪回表

alter table tablename  enable row movement

开启行移动功能

*/
