DECLARE
  I integer;
  J integer;
  H integer;
  K integer;
  L integer;
BEGIN
     SELECT COUNT(1) INTO L from ele_element t WHERE t.element_code='ZJXZ';
     IF L < 1 THEN
       execute immediate '
       insert into ele_element (ELEMENT_ID, ELEMENT_CODE, ELEMENT_NAME, ELEMENT_EL_CODE, ELEMENT_DATATYPE, ELEMENT_DATALENGTH, ELEMENT_DATATYPE_FORMAT, ELE_CATALOG_ID, REMARK, SOURCETEXT, START_DATE, END_DATE, IS_ENABLED, UPDATE_TIME, IS_DELETED, CREATE_TIME, MOF_DIV_CODE, YEAR, TYPEGUID, ACTUAL_DATATYPE, PHYSICS_FIELD, ELE_CATALOG_CODE, VALUE_REF)
values (''CCF2CCF1A50E020CE050A8C005201C89'', ''ZJXZ'', ''资金性质'', ''ZJXZ'', ''NString'', ''4'', ''oracle'', ''B0722B5340647740E0533203A8C0DF7E'', null, null, to_date(''07-01-2021 10:05:34'', ''dd-mm-yyyy hh24:mi:ss''), to_date(''07-01-2021 10:05:34'', ''dd-mm-yyyy hh24:mi:ss''), ''1'', to_date(''15-01-2021 16:42:29'', ''dd-mm-yyyy hh24:mi:ss''), ''2'', to_date(''07-01-2021 10:05:34'', ''dd-mm-yyyy hh24:mi:ss''), ''109900000'', ''2021'', ''B45E3611FF657876E0533C01A8C07E25'', ''varchar2'', ''ZJXZ'', ''VD10001'', ''VD10001资金性质代码表的代码列'')
       ';  
     END IF;
     COMMIT;
     --ELE_VD10004增加列物理表ZJXZ
     select count(1) INTO I from user_tab_columns where column_name like '%ZJXZ%' and table_name = 'ELE_VD10004';
     IF I < 1 THEN
       execute immediate 'alter table ELE_VD10004 add ZJXZ VARCHAR2(4)';  
     END IF;
     --ELE_VD10003增加列物理表ZJXZ
     select count(1) INTO J from user_tab_columns where column_name like '%ZJXZ%' and table_name = 'ELE_VD10003';
     IF J < 1 THEN
       execute immediate 'alter table ELE_VD10003 add ZJXZ VARCHAR2(4)';  
     END IF;
     --ELE_VD10003增加列注册表ZJXZ
     SELECT count(1) INTO H from ele_diccolumn t WHERE t.ele_source='ELE_VD10003' AND t.element_code='ZJXZ';
     IF H < 1 THEN
      execute immediate '
      insert into ele_diccolumn (COL_ID, ELE_SOURCE, ELEMENT_CODE, ELEMENT_NAME, ELEMENT_EL_CODE, ELEMENT_DATATYPE, ELEMENT_DATALENGTH, ELEMENT_DATATYPE_FORMAT, ELE_CATALOG_ID, REMARK, SOURCETEXT, ISSHOW, ISUSES, CREATE_TIME, UPDATE_TIME, END_DATE, YEAR, PROVINCE, DEFAULTVALUE, COMPEL_OR_CHOICE, ELEMENT_ID, ACTUAL_DATATYPE, IS_VIEW, IS_EDIT, IS_KEY, PHYSICS_FIELD, IS_QUOTE, ELE_CATALOG_CODE)
values (''8A888646AC1649FDACF981DD6DA7E2CC'', ''ELE_VD10003'', ''ZJXZ'', ''资金性质'', ''ZJXZ'', ''NString'', ''4'', ''oracle'', ''B0722B5340647740E0533203A8C0DF7E'', null, ''1'', ''1'', ''1'', to_date(''27-09-2021 11:40:29'', ''dd-mm-yyyy hh24:mi:ss''), to_date(''27-09-2021 11:40:29'', ''dd-mm-yyyy hh24:mi:ss''), to_date(''27-09-2021'', ''dd-mm-yyyy''), ''2022'', ''109900000'', null, ''0'', ''CCF2CCF1A50E020CE050A8C005201C89'', ''VARCHAR2'', ''1'', ''1'', ''0'', ''ZJXZ'', ''1'', ''VD10001'')
     ';
     commit;
     END IF;
     --ELE_VD10004增加列注册表ZJXZ
     SELECT count(1) INTO K from ele_diccolumn t WHERE t.ele_source='ELE_VD10004' AND t.element_code='ZJXZ';
     IF K < 1 THEN
       execute immediate '
       insert into ele_diccolumn (COL_ID, ELE_SOURCE, ELEMENT_CODE, ELEMENT_NAME, ELEMENT_EL_CODE, ELEMENT_DATATYPE, ELEMENT_DATALENGTH, ELEMENT_DATATYPE_FORMAT, ELE_CATALOG_ID, REMARK, SOURCETEXT, ISSHOW, ISUSES, CREATE_TIME, UPDATE_TIME, END_DATE, YEAR, PROVINCE, DEFAULTVALUE, COMPEL_OR_CHOICE, ELEMENT_ID, ACTUAL_DATATYPE, IS_VIEW, IS_EDIT, IS_KEY, PHYSICS_FIELD, IS_QUOTE, ELE_CATALOG_CODE)
values (''B721675D466A46B781BA97839840CABE'', ''ELE_VD10004'', ''ZJXZ'', ''资金性质'', ''ZJXZ'', ''NString'', ''4'', ''oracle'', ''B0722B5340647740E0533203A8C0DF7E'', null, ''1'', ''1'', ''1'', to_date(''27-09-2021 11:40:58'', ''dd-mm-yyyy hh24:mi:ss''), to_date(''27-09-2021 11:40:58'', ''dd-mm-yyyy hh24:mi:ss''), to_date(''27-09-2021'', ''dd-mm-yyyy''), ''2022'', ''109900000'', null, ''0'', ''CCF2CCF1A50E020CE050A8C005201C89'', ''VARCHAR2'', ''1'', ''1'', ''0'', ''ZJXZ'', ''1'', ''VD10001'')
       ';
     commit;
     END IF;
end;

