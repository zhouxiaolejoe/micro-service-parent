DECLARE
  I integer;
  V_SQL VARCHAR2(300);
  TABLE_NAME VARCHAR(50);
  TYPE MY_CURSOR_TYPE IS REF CURSOR;
  CATALOG_CURSOR MY_CURSOR_TYPE;
  cursor t_tables is
    select * from ele_vd08001 t  where t.ele_code ='325000000' AND t.fiscal_year='2022';
begin
  for t_row in t_tables LOOP
      V_SQL:='SELECT ELE_SOURCE FROM ELE_CATALOG where ELE_CATALOG_CODE=''JKL''';
      OPEN CATALOG_CURSOR FOR V_SQL;
      LOOP
      FETCH CATALOG_CURSOR INTO TABLE_NAME;
      EXIT WHEN CATALOG_CURSOR%NOTFOUND;   
      dbms_output.put_line('¡¾±íÃû¡¿'|| TABLE_NAME);
     
      execute immediate '
      INSERT INTO ELE_JKL SELECT admdiv, ele_catalog_code, ele_catalog_id, sys_guid(), fiscal_year, '''||t_row.ele_code||''', level_no, is_leaf, start_date, end_date, is_enabled, update_time, ele_code, ele_name, is_deleted, parent_id, is_standard, create_time, remark, isnormversion FROM '||TABLE_NAME||'
      ';
      COMMIT;
      
      execute immediate '
        UPDATE '||TABLE_NAME||' t SET t.parent_id =(
        SELECT ele_id FROM '||TABLE_NAME||' WHERE ele_code=( 
        SELECT ele_code FROM '||TABLE_NAME||' WHERE mof_diV_code =''320000000'' AND ele_id =t.parent_id
        ) AND  mof_div_code ='''||t_row.ele_code||'''
        ) WHERE t.mof_div_code ='''||t_row.ele_code||'''
      ';     
    END LOOP;
  end loop;
END;


