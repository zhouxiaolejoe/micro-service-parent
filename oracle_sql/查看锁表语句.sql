  SELECT T2.USERNAME, T2.SID, T2.SERIAL#, T2.LOGON_TIME
    FROM V$LOCKED_OBJECT T1, V$SESSION T2
   WHERE T1.SESSION_ID = T2.SID
   ORDER BY T2.LOGON_TIME;
 
 
--查看被锁的表
select b.owner,b.object_name,a.session_id,a.locked_mode from v$locked_object a,dba_objects b where b.object_id = a.object_id;
 
 
 --查看那个用户那个进程照成死锁
select b.username,b.sid,b.serial#,logon_time from v$locked_object a,v$session b
where a.session_id = b.sid order by b.logon_time;


--3.查出锁定表的sid, serial#,os_user_name, machine_name, terminal，锁的type,mode
SELECT s.sid, s.serial#, s.username, s.schemaname, s.osuser, s.process, s.machine,
s.terminal, s.logon_time, l.type
FROM v$session s, v$lock l
WHERE s.sid = l.sid
AND s.username IS NOT NULL
ORDER BY sid;


---查看所标的sql_hash_value,
SELECT object_name 被锁表 , machine 所属机器, l.ORACLE_USERNAME 表所在用户,s.sid, s.serial# ,s.LOCKWAIT ,s.SQL_HASH_VALUE
FROM gv$locked_object l, dba_objects o, gv$session s
WHERE l.object_id　= o.object_id
AND l.session_id = s.sid and o.Object_Name='P#BDM_T_JSCTRSUMDRC' ;



--查看对应的锁表SQL
select * from v$sql a where a.HASH_VALUE = '3023849173'

