--中台库执行 
declare
  I integer;
  cursor a_cursor is
    SELECT province FROM fasp_t_carole t WHERE t.year='2022' GROUP by province ;
BEGIN
  for a_cur in a_cursor LOOP
       EXECUTE IMMEDIATE '
       INSERT INTO fasp_t_carole
       SELECT agency,
       remark1,
       remark2,
       remark3,
       ''2021'' YEAR,
       province,
       roletype,
       rolenature,
       dbversion,
       status,
       division,
       bank,
       admdiv,
       rolelevel,
       guid,
       code,
       NAME,
       remark,
       issys,
       ordernum,
       paytypeflag,
       salarytypeflag,
       speaccttypeflag,
       bgttypeflag,
       ispubliced,
       bdmtypeflag
  FROM fasp_t_carole t
  WHERE 
   t.province = '''||a_cur.province||'''
    AND t.year = ''2022''
    AND t.status IN (''1'', ''2'')
    AND t.roletype IN (''1'', ''2'')
    AND t.guid not in (
    SELECT t.guid FROM fasp_t_carole t WHERE t.year =''2021'' AND t.province = '''||a_cur.province||       ''')
   ';
  end loop;
  COMMIT;
end;




/**



--中台库执行 
declare
  I integer;
  cursor a_cursor is
    SELECT province FROM fasp_t_carole t WHERE t.year='2022' GROUP by province ;
BEGIN
  for a_cur in a_cursor LOOP
     SELECT COUNT(1) INTO I FROM fasp_t_carole t WHERE t.year ='2021' AND t.province = a_cur.province;
     IF I = 0 THEN
       dbms_output.put_line('【区划】'|| a_cur.province);
         EXECUTE IMMEDIATE '
       INSERT INTO fasp_t_carole
       SELECT agency,
       remark1,
       remark2,
       remark3,
       ''2021'' YEAR,
       province,
       roletype,
       rolenature,
       dbversion,
       status,
       division,
       bank,
       admdiv,
       rolelevel,
       guid,
       code,
       NAME,
       remark,
       issys,
       ordernum,
       paytypeflag,
       salarytypeflag,
       speaccttypeflag,
       bgttypeflag,
       ispubliced,
       bdmtypeflag
  FROM fasp_t_carole t
  WHERE 
   t.province = '''||a_cur.province||'''
    AND t.year = ''2022''
    AND t.status IN (''1'', ''2'')
    AND t.roletype IN (''1'', ''2'')
   ';
     END IF;
  end loop;
  COMMIT;
end;



*/










