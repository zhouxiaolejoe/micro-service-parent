  SELECT T2.USERNAME, T2.SID, T2.SERIAL#, T2.LOGON_TIME
    FROM V$LOCKED_OBJECT T1, V$SESSION T2
   WHERE T1.SESSION_ID = T2.SID
   ORDER BY T2.LOGON_TIME;
 
 
--�鿴�����ı�
select b.owner,b.object_name,a.session_id,a.locked_mode from v$locked_object a,dba_objects b where b.object_id = a.object_id;
 
 
 --�鿴�Ǹ��û��Ǹ������ճ�����
select b.username,b.sid,b.serial#,logon_time from v$locked_object a,v$session b
where a.session_id = b.sid order by b.logon_time;


--3.����������sid, serial#,os_user_name, machine_name, terminal������type,mode
SELECT s.sid, s.serial#, s.username, s.schemaname, s.osuser, s.process, s.machine,
s.terminal, s.logon_time, l.type
FROM v$session s, v$lock l
WHERE s.sid = l.sid
AND s.username IS NOT NULL
ORDER BY sid;


---�鿴�����sql_hash_value,
SELECT object_name ������ , machine ��������, l.ORACLE_USERNAME �������û�,s.sid, s.serial# ,s.LOCKWAIT ,s.SQL_HASH_VALUE
FROM gv$locked_object l, dba_objects o, gv$session s
WHERE l.object_id��= o.object_id
AND l.session_id = s.sid and o.Object_Name='P#BDM_T_JSCTRSUMDRC' ;



--�鿴��Ӧ������SQL
select * from v$sql a where a.HASH_VALUE = '3023849173'

