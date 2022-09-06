DECLARE
  I integer;
  V_SQL VARCHAR2(300);
  TYPE MY_CURSOR_TYPE IS REF CURSOR;
  CATALOG_CURSOR MY_CURSOR_TYPE;
    TABLE_NAME VARCHAR(50);

  cursor t_tables is
    SELECT DISTINCT province FROM (
SELECT t.DB_LINK,ft.province FROM dba_db_links t 
RIGHT JOIN fasp_t_syncdatabase ft ON UPPER(ft.username||ft.province) = t.DB_LINK
WHERE t.owner ='MID_320000')t WHERE t.province IN ('325000000','320582000');
begin
  for t_row in t_tables LOOP
      V_SQL:='SELECT ELE_SOURCE FROM ELE_CATALOG where ELE_CATALOG_CODE=''JKL''';
      OPEN CATALOG_CURSOR FOR V_SQL;
      LOOP
      FETCH CATALOG_CURSOR INTO TABLE_NAME;
      EXIT WHEN CATALOG_CURSOR%NOTFOUND;   
      dbms_output.put_line('¡¾±íÃû¡¿'|| TABLE_NAME);
      sync_zfys_table(TABLE_NAME,t_row.province);
      END LOOP;
  end loop;
END;
