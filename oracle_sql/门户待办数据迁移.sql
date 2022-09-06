--ÖÐÌ¨¿âÖ´ÐÐ
DECLARE
  I INTEGER;
  CURSOR USER_CURSOR IS
    SELECT t.*,t.rowid from fasp_t_causer t WHERE t.entrustguid IS NOT NULL ;
BEGIN
  FOR USER_CUR IN USER_CURSOR LOOP
   EXECUTE IMMEDIATE '
   INSERT INTO FASP_T_CAENTRUSTUSERTIME (GUID, USERGUID, ENTRUSTGUID, STARTDATE, ENDDATE, STATUS) VALUES(
   sys_guid(), ''' || USER_CUR.GUID || ''',''' || USER_CUR.ENTRUSTGUID || ''',
   '||
   case
     when USER_CUR.STARTDATE IS null then '
       to_char(to_date(to_char(sysdate, ''yyyy-MM-dd''),''yyyy-MM-dd HH24:mi:ss''),''yyyy-MM-dd HH24:mi:SS'')
       ,
       to_char(to_date(to_char(add_months(sysdate,12), ''yyyy-MM-dd''),''yyyy-MM-dd HH24:mi:ss''),''yyyy-MM-dd HH24:mi:SS''),'
     ELSE
       'to_char(to_date('''||USER_CUR.STARTDATE||''',''yyyy-MM-dd HH24:mi:ss''),''yyyy-MM-dd HH24:mi:SS''),
        to_char(to_date('''||USER_CUR.ENDDATE||''',''yyyy-MM-dd HH24:mi:ss''),''yyyy-MM-dd HH24:mi:SS''),'
   END ||'
   '||case 
        when USER_CUR.USERTYPE = '1' then '1'
        when USER_CUR.USERTYPE = '0' then '2'
        when USER_CUR.USERTYPE = '2' then '2'
        ELSE '3'
      end||'
   )
   ';
  END LOOP;
  COMMIT;
END;




/**
DELETE FROM FASP_T_CAENTRUSTUSERTIME
WHERE (USERGUID,ENTRUSTGUID) IN (SELECT USERGUID,ENTRUSTGUID FROM FASP_T_CAENTRUSTUSERTIME GROUP BY USERGUID,ENTRUSTGUID HAVING COUNT(USERGUID) > 1)
AND ROWID NOT IN
(SELECT MIN(ROWID) FROM FASP_T_CAENTRUSTUSERTIME GROUP BY USERGUID,ENTRUSTGUID HAVING COUNT(*) > 1);

*/

















