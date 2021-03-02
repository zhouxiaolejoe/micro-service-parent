declare
  J integer;
  I integer;
  H integer;
  cursor t_tables is
    select * from ele_catalog t where t.catalog_type='1';
begin
  for t_row in t_tables loop
    --增加物理表ELE_CATALOG_CODE
   select count(1) INTO J from user_tables where table_name=t_row.ele_source;
   IF J > 0 THEN
      execute immediate 'update '|| t_row.ele_source ||' t set t.START_DATE = to_date(to_char(sysdate, ''yyyyMMdd''), ''yyyy/MM/dd''),
      t.END_DATE = to_date(''29991231'', ''yyyyMMdd''),
      t.UPDATE_TIME = to_date(to_char(sysdate, ''yyyyMMddHH24:mi:ss''),''yyyy/MM/dd HH24:mi:ss''),
      t.CREATE_TIME = to_date(to_char(sysdate, ''yyyyMMddHH24:mi:ss''),''yyyy/MM/dd HH24:mi:ss'')
      ';
   END IF;
   commit;
  end loop;
end;
