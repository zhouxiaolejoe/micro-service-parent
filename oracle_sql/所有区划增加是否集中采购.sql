declare
  J integer;
  I integer;
  H integer;
  V_SQL VARCHAR2(300);
  ELE_CODE VARCHAR2(80);
  ELE_ID VARCHAR2(80);
  SFJZCG_ELE_ID VARCHAR2(80);
  TYPE MY_CURSOR_TYPE IS REF CURSOR;
  VD06003_CURSOR MY_CURSOR_TYPE;
  cursor t_tables is
     select * from ele_vd08002 t where t.fiscal_year='2022';
begin
  select ele_id into SFJZCG_ELE_ID from ele_union t where t.ele_catalog_code ='VD00001' and t.fiscal_year='2022' and ele_code ='2';
  for t_row in t_tables loop
    V_SQL:='SELECT ELE_CODE,ELE_ID FROM ELE_VD06003';
    OPEN VD06003_CURSOR FOR V_SQL;
    LOOP
    FETCH VD06003_CURSOR INTO ELE_CODE,ELE_ID;
    EXIT WHEN VD06003_CURSOR%NOTFOUND;   
      begin
      EXECUTE IMMEDIATE 'insert into ele_zfcgpm_sfjzcg(ezs_id, ezs_zfcgpm_id, ezs_sfjzcg_id, mof_div_code, fiscal_year, create_time, update_time)
      values
      ('''||sys_guid()||''', '''||ELE_ID||''', '''||SFJZCG_ELE_ID||''', '''||t_row.ele_code||''', '''||t_row.fiscal_year||''', to_date(to_char(sysdate, ''yyyyMMddHH24:mi:ss''),
                         ''yyyy/MM/dd HH24:mi:ss''), to_date(to_char(sysdate, ''yyyyMMddHH24:mi:ss''),''yyyy/MM/dd HH24:mi:ss''))'; 
      EXCEPTION WHEN others THEN NULL;
      end;   
    END LOOP; 
    commit;
  end loop;
end;
