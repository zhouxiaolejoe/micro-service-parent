
  I integer;
begin
   select count(1) INTO I from user_tab_columns where column_name like '%SFJZCGML%' and table_name = 'ELE_VD06003';
   IF I < 1 THEN
    execute immediate 'alter table ELE_VD06003 add (SFJZCGML VARCHAR2(1))';
   END IF;  
