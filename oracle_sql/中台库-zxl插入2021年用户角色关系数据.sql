--中台库执行
DECLARE
  I INTEGER;
  CURSOR A_CURSOR IS
    SELECT province FROM fasp_t_causerrole t WHERE t.year='2022' GROUP by province ;
BEGIN

  FOR A_CUR IN A_CURSOR LOOP
    DBMS_OUTPUT.PUT_LINE('【区划】' || A_CUR.PROVINCE);
    EXECUTE IMMEDIATE '
      INSERT INTO FASP_T_CAUSERROLE
      SELECT GUID,
      USERGUID,
      ROLEGUID,
      DBVERSION,
      PROVINCE,
      ''2021'' YEAR,
      ADMDIV
      FROM FASP_T_CAUSERROLE T
      WHERE
      T.PROVINCE = ''' || A_CUR.PROVINCE || '''
      AND T.YEAR = ''2022'' AND
      T.GUID IN(
      SELECT GUID FROM(
      SELECT USERGUID,ROLEGUID,GUID
      FROM FASP_T_CAUSERROLE
      WHERE YEAR = ''2022'' AND PROVINCE =''' ||
                            A_CUR.PROVINCE || '''
      MINUS
      SELECT USERGUID,ROLEGUID,GUID
      FROM FASP_T_CAUSERROLE
      WHERE YEAR = ''2021'' AND PROVINCE =''' ||
                      A_CUR.PROVINCE || ''') T)
';
  END LOOP;
  COMMIT;
END;

/**

--中台库执行  
declare
  I integer;
  cursor a_cursor is
    SELECT province FROM fasp_t_causerrole t WHERE t.year='2022' GROUP by province ;
BEGIN
 
  for a_cur in a_cursor LOOP
    SELECT COUNT(1) INTO I FROM fasp_t_causerrole t WHERE t.year ='2021' AND t.province = a_cur.province;
     IF I = 0 THEN
       dbms_output.put_line('【区划】'|| a_cur.province);
       EXECUTE IMMEDIATE '
      INSERT INTO fasp_t_causerrole
      SELECT guid, 
      userguid, 
      roleguid, 
      dbversion,
      province, 
      ''2021'' YEAR, 
      admdiv
      FROM fasp_t_causerrole t
       WHERE 
         t.province = '''||a_cur.province||'''
          AND t.year = ''2022''
   ';
      END IF;
   
  end loop;
  COMMIT;
end;






*/


