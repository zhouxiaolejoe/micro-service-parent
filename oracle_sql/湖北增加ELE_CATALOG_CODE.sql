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
     select count(1) INTO I from user_tab_columns where column_name like '%ELE_CATALOG_CODE%' and table_name = t_row.ele_source;
     IF I < 1 THEN
       dbms_output.put_line(t_row.ele_source);
      execute immediate 'alter table '|| t_row.ele_source ||' add ELE_CATALOG_CODE VARCHAR2(42)';
      execute immediate 'update '|| t_row.ele_source ||' t set t.ele_catalog_code = (select ele_catalog_code from ele_catalog u where t.ele_catalog_id = u.ele_catalog_id)';
     END IF;
   END IF;
   --增加列注册表ELE_CATALOG_CODE
   select count(1) INTO H from ele_diccolumn t where t.ele_source=t_row.ele_source and t.element_el_code like '%ELECATALOGCODE%';
   IF H < 1 THEN
     execute immediate '
      insert into ele_diccolumn (COL_ID, ELE_SOURCE, ELEMENT_CODE, ELEMENT_NAME, ELEMENT_EL_CODE, ELEMENT_DATATYPE, ELEMENT_DATALENGTH, ELEMENT_DATATYPE_FORMAT, ELE_CATALOG_ID, REMARK, SOURCETEXT, ISSHOW, ISUSES, CREATE_TIME, UPDATE_TIME, END_DATE, YEAR, PROVINCE, DEFAULTVALUE, COMPEL_OR_CHOICE, ELEMENT_ID, ACTUAL_DATATYPE, IS_VIEW, IS_EDIT, IS_KEY, IS_QUOTE, PHYSICS_FIELD)
      values ('''||sys_guid()||''', ''' || t_row.ele_source || ''', ''BE00001'', ''目录编码'', ''ELECATALOGCODE'', ''String'', ''38'', ''oracle'', ''i3FPlwwB'', null, ''1'', ''1'', ''1'', to_date(to_char(sysdate, ''yyyyMMddHH24:mm:ss''),''yyyy/MM/dd HH24:mi:ss''), to_date(to_char(sysdate, ''yyyyMMddHH24:mm:ss''),''yyyy/MM/dd HH24:mi:ss''), to_date(to_char(sysdate, ''yyyyMMdd''), ''yyyy/MM/dd''), ''2021'', ''109900000'', null, ''0'', ''00001'', ''varchar2'', ''1'', ''1'', ''0'',''1'', ''ELE_CATALOG_CODE'')
     ';
     commit;
   END IF;
  end loop;
end;


