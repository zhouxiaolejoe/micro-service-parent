DECLARE
  I INTEGER;
  tablename VARCHAR2(40);
  sql_text VARCHAR2(4000) ;
  CURSOR TABLE_CURSOR IS
    SELECT T.* FROM USER_TAB_COLUMNS T  WHERE T.TABLE_NAME='V_ELE_TEST';
BEGIN
  
sql_text:= 'create table V_ELE_TEST_zxl (';
  FOR TABLE_CUR IN TABLE_CURSOR LOOP
    IF TABLE_CUR.char_col_decl_length != 0 OR TABLE_CUR.char_col_decl_length IS NULL THEN
      sql_text:=sql_text||TABLE_CUR.COLUMN_NAME ||' '|| TABLE_CUR.DATA_TYPE ||
      
      CASE WHEN TABLE_CUR.char_col_decl_length IS NOT NULL AND TABLE_CUR.char_col_decl_length != 0 THEN 
      ' (' || TABLE_CUR.char_col_decl_length||')'||','
      WHEN TABLE_CUR.char_col_decl_length = 0 THEN 
        ','
      ELSE ',' END;
    END IF ;
  END LOOP;
  sql_text := SUBSTR(sql_text,0,LENGTH(sql_text)-1)||')';
  dbms_output.put_line(sql_text);
  SELECT COUNT(1) INTO I FROM USER_TABLES WHERE TABLE_NAME='V_ELE_TEST_ZXL'; 
  IF I<=0 THEN
    EXECUTE IMMEDIATE sql_text;
  END IF;
END;


