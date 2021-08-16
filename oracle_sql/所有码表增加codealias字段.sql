declare
  J integer;
  I integer;
  H integer;
  K integer;
  cursor t_tables is
    select * from ele_catalog t where t.catalog_type='1' and t.ele_catalog_code='VD00002';
begin
  select count(1) INTO K from ELE_ELEMENT where element_code='BE90001';
  IF J < 1 THEN
     execute immediate 'insert into ELE_ELEMENT (ELEMENT_ID, ELEMENT_CODE, ELEMENT_NAME, ELEMENT_EL_CODE, ELEMENT_DATATYPE, ELEMENT_DATALENGTH, ELEMENT_DATATYPE_FORMAT, ELE_CATALOG_ID, REMARK, SOURCETEXT, START_DATE, END_DATE, IS_ENABLED, UPDATE_TIME, IS_DELETED, CREATE_TIME, MOF_DIV_CODE, YEAR, TYPEGUID, ACTUAL_DATATYPE, PHYSICS_FIELD, ELE_CATALOG_CODE, VALUE_REF)
     values (''DAD3F6ABDECC481F898F56C019260B75'', ''BE90001'', ''基础要素別名'', ''codealias'', ''String'', ''20'', ''oracle'', null, null, null, to_date(''21-07-2021'', ''dd-mm-yyyy''), to_date(''21-07-2021'', ''dd-mm-yyyy''), ''1'', to_date(''21-07-2021 11:24:48'', ''dd-mm-yyyy hh24:mi:ss''), ''2'', to_date(''21-07-2021 11:18:51'', ''dd-mm-yyyy hh24:mi:ss''), ''109900000'', ''2022'', ''C9CA953BBAEB40C8A791AF7E396B5DB4'', ''VARCHAR2'', ''codealias'', null, null)';
  END IF;
  for t_row in t_tables loop
    --增加物理表CODEALIAS
   select count(1) INTO J from user_tables where table_name=t_row.ele_source;
   IF J > 0 THEN
     select count(1) INTO I from user_tab_columns where column_name like '%CODEALIAS%' and table_name = t_row.ele_source;
     IF I < 1 THEN
       dbms_output.put_line(t_row.ele_source);
      execute immediate 'alter table '|| t_row.ele_source ||' add CODEALIAS VARCHAR2(20)';
     END IF;
   END IF;
   --增加列注册表CODEALIAS
   select count(1) INTO H from ele_diccolumn t where t.ele_source=t_row.ele_source and t.element_el_code like '%CODEALIAS%';
   IF H < 1 THEN
     execute immediate '
      insert into ele_diccolumn (COL_ID, ELE_SOURCE, ELEMENT_CODE, ELEMENT_NAME, ELEMENT_EL_CODE, ELEMENT_DATATYPE, ELEMENT_DATALENGTH, ELEMENT_DATATYPE_FORMAT, ELE_CATALOG_ID, REMARK, SOURCETEXT, ISSHOW, ISUSES, CREATE_TIME, UPDATE_TIME, END_DATE, YEAR, PROVINCE, DEFAULTVALUE, COMPEL_OR_CHOICE, ELEMENT_ID, ACTUAL_DATATYPE, IS_VIEW, IS_EDIT, IS_KEY, IS_QUOTE, PHYSICS_FIELD)
      values ('''||sys_guid()||''', ''' || t_row.ele_source || ''', ''BE90001'', ''基础要素別名'', ''CODEALIAS'', ''String'', ''20'', ''oracle'', null, null, ''1'', ''1'', ''1'', to_date(to_char(sysdate, ''yyyyMMddHH24:mm:ss''),''yyyy/MM/dd HH24:mi:ss''), to_date(to_char(sysdate, ''yyyyMMddHH24:mm:ss''),''yyyy/MM/dd HH24:mi:ss''), to_date(to_char(sysdate, ''yyyyMMdd''), ''yyyy/MM/dd''), ''2021'', ''109900000'', null, ''0'', ''00001'', ''varchar2'', ''1'', ''1'', ''0'',''2'', ''CODEALIAS'')
     ';
     commit;
   END IF;
  end loop;
end;


