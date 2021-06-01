declare
  I integer;
  cursor t_tables is
    select * from ele_catalog t where t.catalog_type ='1' and is_deleted='2';
begin
  for t_row in t_tables loop
      if t_row.ele_source ='ELE_UNION' then 
        dbms_output.put_line(t_row.ele_catalog_code);
        execute immediate '
        delete from  ele_union t where t.ele_catalog_code ='''||t_row.ele_catalog_code||''' and t.ele_code in (
         select ele_code from ele_union t where t.mof_div_code in (''109900000'') and t.ele_catalog_code ='''||t_row.ele_catalog_code||'''
         ) and t.mof_div_code <> ''109900000'' 
        ';
      else 
        dbms_output.put_line(t_row.ele_source);
          execute immediate '
        delete from  '||t_row.ele_source||' t where t.ele_code in (
         select ele_code from '||t_row.ele_source||' t where t.mof_div_code in (''109900000'') 
         ) and t.mof_div_code <> ''109900000''
        ';
      end if; 
  end loop;
end;
