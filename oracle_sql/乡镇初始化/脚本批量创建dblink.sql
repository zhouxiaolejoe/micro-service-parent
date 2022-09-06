DECLARE
  I INTEGER;
  J INTEGER;
  drop_dblink VARCHAR2(2000);
  create_dblink VARCHAR2(2000);
  CURSOR t_tables IS
    SELECT * FROM fasp_t_syncdatabase t WHERE t.datasourceid <> 'mid' AND province IN(SELECT ele_code FROM ele_vd08001_town);
BEGIN
  FOR t_row IN t_tables LOOP
    SELECT COUNT(1) INTO I from  User_Db_Links t WHERE t.DB_LINK =''||UPPER(t_row.username)||UPPER(t_row.PROVINCE)||'';
    IF I<=0 THEN
        create_dblink:='create database link '||UPPER(t_row.username)||UPPER(t_row.PROVINCE)||' connect to '||t_row.username||' identified by "'||t_row.password||'" using '''||REPLACE(t_row.url,'jdbc:oracle:thin:@','')||'''';
       dbms_output.put_line(create_dblink);
       execute immediate create_dblink;
    END IF; 
  END LOOP;
END;


