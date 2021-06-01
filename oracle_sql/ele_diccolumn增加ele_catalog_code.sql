---中台库执行

create table ele_diccolumn_0406 as select * from ele_diccolumn ;

declare
  I integer;
  J integer;
begin
     select count(1) INTO I from user_tab_columns where column_name like '%ELE_CATALOG_CODE%' and table_name = 'ELE_DICCOLUMN';
     IF I < 1 THEN
       dbms_output.put_line(I);
       execute immediate 'alter table ELE_DICCOLUMN add ELE_CATALOG_CODE VARCHAR2(42)';  
     END IF;
      execute immediate 'update ELE_DICCOLUMN a
       set ele_catalog_code =
           (select ele_catalog_code
              from ele_catalog b
             where a.ele_source = b.ele_source and rownum =1)';        
      commit;
end;




create table ele_dictable_0406 as select * from ele_dictable ;

declare
  I integer;
  J integer;
begin
     select count(1) INTO I from user_tab_columns where column_name like '%ELE_CATALOG_CODE%' and table_name = 'ELE_DICTABLE';
     IF I < 1 THEN
       dbms_output.put_line(I);
       execute immediate 'alter table ELE_DICTABLE add ELE_CATALOG_CODE VARCHAR2(42)';  
     END IF;
      execute immediate 'update ELE_DICTABLE a
       set ele_catalog_code =
           (select ele_catalog_code
              from ele_catalog b
             where a.ele_source = b.ele_source and rownum =1)';        
      commit;
end;

declare
  I integer;
  J integer;
   cursor a_cursor is
    select * from ele_catalog t where t.catalog_type='1' ;
begin
     for a_cur in a_cursor loop
        execute immediate 'select count(1) from ELE_DICTABLE where ele_source = '''|| a_cur.ele_source ||'''' into I;
        execute immediate 'select count(1) from ELE_DICTABLE where tab_id = '''|| a_cur.ele_catalog_id ||'''' into J;
        dbms_output.put_line('【表名】'|| I || '  数量:' || J); 
        IF (I < 1 and J < 1) THEN
           execute immediate 'insert into ele_dictable
        (tab_id,
         ele_source,
         tab_name,
         tab_viewname,
         remark,
         isshow,
         isuses,
         create_time,
         update_time,
         end_date,
         year,
         province,
         appid,
         catalog_type_id,
         codemode,
         apply,
         element_el_code,
         col_view,
         entity_number,
         catalog_type)
       select 
         ele_catalog_id,
         ele_source,
         ele_catalog_name,
         case
               when upper(ele_source) = ''ELE_UNION'' then
                ''V_'' || ele_source ||''_''|| ele_catalog_code
               else
                ''V_'' || ele_source
             end as TABLECODE,
         REMARK,
         ''1'' ISSHOW,
         ''1'' ISUSES,
          to_date(to_char(sysdate, ''yyyyMMddHH24:mi:ss''),
                       ''yyyy/MM/dd HH24:mi:ss''),
          to_date(to_char(sysdate, ''yyyyMMddHH24:mi:ss''),
                       ''yyyy/MM/dd HH24:mi:ss''),   
          to_date(to_char(sysdate, ''yyyyMMdd''), ''yyyy/MM/dd''),    
          fiscal_year,
          mof_div_code,
          ''1''APPID,
          ''1'' catalog_type_id,
          codemode,
          ''1'' apply,
          ''1'' element_el_code,
          ''1'' col_view,
          ''1'' entity_number,
          ''0'' catalog_type
          from ele_catalog  where ele_source = '''|| a_cur.ele_source ||'''';  
     
        END IF;
     end loop;
end;


/**
declare
  I integer;
  J integer;
  cursor a_cursor is
    select distinct ele_catalog_code from ele_catalog t where t.ele_source='ELE_UNION' ;
begin
  for t_row in a_cursor loop
   execute immediate '
    insert all
      into ele_diccolumn (COL_ID, ELE_SOURCE, ELEMENT_CODE, ELEMENT_NAME, ELEMENT_EL_CODE, ELEMENT_DATATYPE, ELEMENT_DATALENGTH, ELEMENT_DATATYPE_FORMAT, ELE_CATALOG_ID, REMARK, SOURCETEXT, ISSHOW, ISUSES, CREATE_TIME, UPDATE_TIME, END_DATE, YEAR, PROVINCE, DEFAULTVALUE, COMPEL_OR_CHOICE, ELEMENT_ID, ACTUAL_DATATYPE, IS_VIEW, IS_EDIT, IS_KEY, PHYSICS_FIELD)
      values ('''||sys_guid()||''', ''ELE_' || t_row.ele_catalog_code || ''', ''BE00001'', ''目录主键'', ''ELECATALOGID'', ''String'', ''38'', ''oracle'', ''32002kttmPxx'', null, ''1'', ''1'', ''1'', to_date(to_char(sysdate, ''yyyyMMddHH24:mi:ss''),''yyyy/MM/dd HH24:mi:ss''), to_date(to_char(sysdate, ''yyyyMMddHH24:mi:ss''),''yyyy/MM/dd HH24:mi:ss''), to_date(to_char(sysdate, ''yyyyMMdd''), ''yyyy/MM/dd''), ''2021'', ''109900000'', null, ''0'', ''00001'', ''varchar2'', ''1'', ''1'', ''0'', ''ELE_CATALOG_ID'')

      into ele_diccolumn (COL_ID, ELE_SOURCE, ELEMENT_CODE, ELEMENT_NAME, ELEMENT_EL_CODE, ELEMENT_DATATYPE, ELEMENT_DATALENGTH, ELEMENT_DATATYPE_FORMAT, ELE_CATALOG_ID, REMARK, SOURCETEXT, ISSHOW, ISUSES, CREATE_TIME, UPDATE_TIME, END_DATE, YEAR, PROVINCE, DEFAULTVALUE, COMPEL_OR_CHOICE, ELEMENT_ID, ACTUAL_DATATYPE, IS_VIEW, IS_EDIT, IS_KEY, PHYSICS_FIELD)
      values ('''||sys_guid()||''', ''ELE_' || t_row.ele_catalog_code || ''', ''BE00001'', ''代码集主键'', ''ELEID'', ''String'', ''38'', ''oracle'', ''32002kttmPxx'', null, ''1'', ''1'', ''1'', to_date(to_char(sysdate, ''yyyyMMddHH24:mi:ss''),''yyyy/MM/dd HH24:mi:ss''), to_date(to_char(sysdate, ''yyyyMMddHH24:mi:ss''),''yyyy/MM/dd HH24:mi:ss''), to_date(to_char(sysdate, ''yyyyMMdd''), ''yyyy/MM/dd''), ''2021'', ''109900000'', null, ''0'', ''00001'', ''varchar2'', ''1'', ''1'', ''0'', ''ELE_ID'')

      into ele_diccolumn (COL_ID, ELE_SOURCE, ELEMENT_CODE, ELEMENT_NAME, ELEMENT_EL_CODE, ELEMENT_DATATYPE, ELEMENT_DATALENGTH, ELEMENT_DATATYPE_FORMAT, ELE_CATALOG_ID, REMARK, SOURCETEXT, ISSHOW, ISUSES, CREATE_TIME, UPDATE_TIME, END_DATE, YEAR, PROVINCE, DEFAULTVALUE, COMPEL_OR_CHOICE, ELEMENT_ID, ACTUAL_DATATYPE, IS_VIEW, IS_EDIT, IS_KEY, PHYSICS_FIELD)
      values ('''||sys_guid()||''', ''ELE_' || t_row.ele_catalog_code || ''', ''BE00008'', ''年'', ''YEAR'', ''NString'', ''4'', ''oracle'', ''32002kttmPxx'', null, ''1'', ''1'', ''1'', to_date(to_char(sysdate, ''yyyyMMddHH24:mi:ss''),''yyyy/MM/dd HH24:mi:ss''), to_date(to_char(sysdate, ''yyyyMMddHH24:mi:ss''),''yyyy/MM/dd HH24:mi:ss''), to_date(to_char(sysdate, ''yyyyMMdd''), ''yyyy/MM/dd''), ''2021'', ''109900000'', null, ''0'', ''00008'', ''varchar2'', ''1'', ''1'', ''0'', ''FISCAL_YEAR'')

      into ele_diccolumn (COL_ID, ELE_SOURCE, ELEMENT_CODE, ELEMENT_NAME, ELEMENT_EL_CODE, ELEMENT_DATATYPE, ELEMENT_DATALENGTH, ELEMENT_DATATYPE_FORMAT, ELE_CATALOG_ID, REMARK, SOURCETEXT, ISSHOW, ISUSES, CREATE_TIME, UPDATE_TIME, END_DATE, YEAR, PROVINCE, DEFAULTVALUE, COMPEL_OR_CHOICE, ELEMENT_ID, ACTUAL_DATATYPE, IS_VIEW, IS_EDIT, IS_KEY, PHYSICS_FIELD)
      values ('''||sys_guid()||''', ''ELE_' || t_row.ele_catalog_code || ''', ''BE00017'', ''财政区划代码'', ''MOFDIVCODE'', ''NString'', ''9'', ''oracle'', ''32002kttmPxx'', null, ''1'', ''1'', ''1'', to_date(to_char(sysdate, ''yyyyMMddHH24:mi:ss''),''yyyy/MM/dd HH24:mi:ss''), to_date(to_char(sysdate, ''yyyyMMddHH24:mi:ss''),''yyyy/MM/dd HH24:mi:ss''), to_date(to_char(sysdate, ''yyyyMMdd''), ''yyyy/MM/dd''), ''2021'', ''109900000'', null, ''0'', ''00017'', ''varchar2'', ''1'', ''1'', ''0'', ''MOF_DIV_CODE'')

      into ele_diccolumn (COL_ID, ELE_SOURCE, ELEMENT_CODE, ELEMENT_NAME, ELEMENT_EL_CODE, ELEMENT_DATATYPE, ELEMENT_DATALENGTH, ELEMENT_DATATYPE_FORMAT, ELE_CATALOG_ID, REMARK, SOURCETEXT, ISSHOW, ISUSES, CREATE_TIME, UPDATE_TIME, END_DATE, YEAR, PROVINCE, DEFAULTVALUE, COMPEL_OR_CHOICE, ELEMENT_ID, ACTUAL_DATATYPE, IS_VIEW, IS_EDIT, IS_KEY, PHYSICS_FIELD)
      values ('''||sys_guid()||''', ''ELE_' || t_row.ele_catalog_code || ''', ''BE00018'', ''级次'', ''LEVELNO'', ''Integer'', ''2'', ''oracle'', ''32002kttmPxx'', null, ''1'', ''1'', ''1'', to_date(to_char(sysdate, ''yyyyMMddHH24:mi:ss''),''yyyy/MM/dd HH24:mi:ss''), to_date(to_char(sysdate, ''yyyyMMddHH24:mi:ss''),''yyyy/MM/dd HH24:mi:ss''), to_date(to_char(sysdate, ''yyyyMMdd''), ''yyyy/MM/dd''), ''2021'', ''109900000'', null, ''0'', ''00018'', ''number'', ''1'', ''1'', ''0'', ''LEVEL_NO'')

      into ele_diccolumn (COL_ID, ELE_SOURCE, ELEMENT_CODE, ELEMENT_NAME, ELEMENT_EL_CODE, ELEMENT_DATATYPE, ELEMENT_DATALENGTH, ELEMENT_DATATYPE_FORMAT, ELE_CATALOG_ID, REMARK, SOURCETEXT, ISSHOW, ISUSES, CREATE_TIME, UPDATE_TIME, END_DATE, YEAR, PROVINCE, DEFAULTVALUE, COMPEL_OR_CHOICE, ELEMENT_ID, ACTUAL_DATATYPE, IS_VIEW, IS_EDIT, IS_KEY, PHYSICS_FIELD)
      values ('''||sys_guid()||''', ''ELE_' || t_row.ele_catalog_code || ''', ''BE00019'', ''是否末级'', ''ISLEAF'', ''Integer'', ''1'', ''oracle'', ''32002kttmPxx'', null, ''1'', ''1'', ''1'', to_date(to_char(sysdate, ''yyyyMMddHH24:mi:ss''),''yyyy/MM/dd HH24:mi:ss''), to_date(to_char(sysdate, ''yyyyMMddHH24:mi:ss''),''yyyy/MM/dd HH24:mi:ss''), to_date(to_char(sysdate, ''yyyyMMdd''), ''yyyy/MM/dd''), ''2021'', ''109900000'', null, ''0'', ''00019'', ''number'', ''1'', ''1'', ''0'', ''IS_LEAF'')

      into ele_diccolumn (COL_ID, ELE_SOURCE, ELEMENT_CODE, ELEMENT_NAME, ELEMENT_EL_CODE, ELEMENT_DATATYPE, ELEMENT_DATALENGTH, ELEMENT_DATATYPE_FORMAT, ELE_CATALOG_ID, REMARK, SOURCETEXT, ISSHOW, ISUSES, CREATE_TIME, UPDATE_TIME, END_DATE, YEAR, PROVINCE, DEFAULTVALUE, COMPEL_OR_CHOICE, ELEMENT_ID, ACTUAL_DATATYPE, IS_VIEW, IS_EDIT, IS_KEY, PHYSICS_FIELD)
      values ('''||sys_guid()||''', ''ELE_' || t_row.ele_catalog_code || ''', ''BE00020'', ''启用日期'', ''STARTDATE'', ''Date'', null, ''oracle'', ''32002kttmPxx'', null, ''1'', ''1'', ''1'', to_date(to_char(sysdate, ''yyyyMMddHH24:mi:ss''),''yyyy/MM/dd HH24:mi:ss''), to_date(to_char(sysdate, ''yyyyMMddHH24:mi:ss''),''yyyy/MM/dd HH24:mi:ss''), to_date(to_char(sysdate, ''yyyyMMdd''), ''yyyy/MM/dd''), ''2021'', ''109900000'', null, ''0'', ''00020'', ''Date'', ''1'', ''1'', ''0'', ''START_DATE'')

      into ele_diccolumn (COL_ID, ELE_SOURCE, ELEMENT_CODE, ELEMENT_NAME, ELEMENT_EL_CODE, ELEMENT_DATATYPE, ELEMENT_DATALENGTH, ELEMENT_DATATYPE_FORMAT, ELE_CATALOG_ID, REMARK, SOURCETEXT, ISSHOW, ISUSES, CREATE_TIME, UPDATE_TIME, END_DATE, YEAR, PROVINCE, DEFAULTVALUE, COMPEL_OR_CHOICE, ELEMENT_ID, ACTUAL_DATATYPE, IS_VIEW, IS_EDIT, IS_KEY, PHYSICS_FIELD)
      values ('''||sys_guid()||''', ''ELE_' || t_row.ele_catalog_code || ''', ''BE00021'', ''停用日期'', ''ENDDATE'', ''Date'', null, ''oracle'', ''32002kttmPxx'', null, ''1'', ''1'', ''1'', to_date(to_char(sysdate, ''yyyyMMddHH24:mi:ss''),''yyyy/MM/dd HH24:mi:ss''), to_date(to_char(sysdate, ''yyyyMMddHH24:mi:ss''),''yyyy/MM/dd HH24:mi:ss''), to_date(to_char(sysdate, ''yyyyMMdd''), ''yyyy/MM/dd''), ''2021'', ''109900000'', null, ''0'', ''00021'', ''Date'', ''1'', ''1'', ''0'', ''END_DATE'')

      into ele_diccolumn (COL_ID, ELE_SOURCE, ELEMENT_CODE, ELEMENT_NAME, ELEMENT_EL_CODE, ELEMENT_DATATYPE, ELEMENT_DATALENGTH, ELEMENT_DATATYPE_FORMAT, ELE_CATALOG_ID, REMARK, SOURCETEXT, ISSHOW, ISUSES, CREATE_TIME, UPDATE_TIME, END_DATE, YEAR, PROVINCE, DEFAULTVALUE, COMPEL_OR_CHOICE, ELEMENT_ID, ACTUAL_DATATYPE, IS_VIEW, IS_EDIT, IS_KEY, PHYSICS_FIELD)
      values ('''||sys_guid()||''', ''ELE_' || t_row.ele_catalog_code || ''', ''BE00022'', ''是否启用'', ''ISENABLED'', ''Integer'', ''1'', ''oracle'', ''32002kttmPxx'', null, ''1'', ''1'', ''1'', to_date(to_char(sysdate, ''yyyyMMddHH24:mi:ss''),''yyyy/MM/dd HH24:mi:ss''), to_date(to_char(sysdate, ''yyyyMMddHH24:mi:ss''),''yyyy/MM/dd HH24:mi:ss''), to_date(to_char(sysdate, ''yyyyMMdd''), ''yyyy/MM/dd''), ''2021'', ''109900000'', null, ''0'', ''00022'', ''number'', ''1'', ''1'', ''0'', ''IS_ENABLED'')

      into ele_diccolumn (COL_ID, ELE_SOURCE, ELEMENT_CODE, ELEMENT_NAME, ELEMENT_EL_CODE, ELEMENT_DATATYPE, ELEMENT_DATALENGTH, ELEMENT_DATATYPE_FORMAT, ELE_CATALOG_ID, REMARK, SOURCETEXT, ISSHOW, ISUSES, CREATE_TIME, UPDATE_TIME, END_DATE, YEAR, PROVINCE, DEFAULTVALUE, COMPEL_OR_CHOICE, ELEMENT_ID, ACTUAL_DATATYPE, IS_VIEW, IS_EDIT, IS_KEY, PHYSICS_FIELD)
      values ('''||sys_guid()||''', ''ELE_' || t_row.ele_catalog_code || ''', ''BE00023'', ''更新时间'', ''UPDATETIME'', ''DateTime'', null, ''oracle'', ''32002kttmPxx'', null, ''1'', ''1'', ''1'', to_date(to_char(sysdate, ''yyyyMMddHH24:mi:ss''),''yyyy/MM/dd HH24:mi:ss''), to_date(to_char(sysdate, ''yyyyMMddHH24:mi:ss''),''yyyy/MM/dd HH24:mi:ss''), to_date(to_char(sysdate, ''yyyyMMdd''), ''yyyy/MM/dd''), ''2021'', ''109900000'', null, ''0'', ''00023'', ''Date'', ''1'', ''1'', ''0'', ''UPDATE_TIME'')

      into ele_diccolumn (COL_ID, ELE_SOURCE, ELEMENT_CODE, ELEMENT_NAME, ELEMENT_EL_CODE, ELEMENT_DATATYPE, ELEMENT_DATALENGTH, ELEMENT_DATATYPE_FORMAT, ELE_CATALOG_ID, REMARK, SOURCETEXT, ISSHOW, ISUSES, CREATE_TIME, UPDATE_TIME, END_DATE, YEAR, PROVINCE, DEFAULTVALUE, COMPEL_OR_CHOICE, ELEMENT_ID, ACTUAL_DATATYPE, IS_VIEW, IS_EDIT, IS_KEY, PHYSICS_FIELD)
      values ('''||sys_guid()||''', ''ELE_' || t_row.ele_catalog_code || ''', ''BE00027'', ''代码集代码'', ''ELECODE'', ''NString'', ''20'', ''oracle'', ''32002kttmPxx'', null, ''1'', ''1'', ''1'', to_date(to_char(sysdate, ''yyyyMMddHH24:mi:ss''),''yyyy/MM/dd HH24:mi:ss''), to_date(to_char(sysdate, ''yyyyMMddHH24:mi:ss''),''yyyy/MM/dd HH24:mi:ss''), to_date(to_char(sysdate, ''yyyyMMdd''), ''yyyy/MM/dd''), ''2021'', ''109900000'', null, ''0'', ''00027'', ''varchar2'', ''1'', ''1'', ''0'', ''ELE_CODE'')

      into ele_diccolumn (COL_ID, ELE_SOURCE, ELEMENT_CODE, ELEMENT_NAME, ELEMENT_EL_CODE, ELEMENT_DATATYPE, ELEMENT_DATALENGTH, ELEMENT_DATATYPE_FORMAT, ELE_CATALOG_ID, REMARK, SOURCETEXT, ISSHOW, ISUSES, CREATE_TIME, UPDATE_TIME, END_DATE, YEAR, PROVINCE, DEFAULTVALUE, COMPEL_OR_CHOICE, ELEMENT_ID, ACTUAL_DATATYPE, IS_VIEW, IS_EDIT, IS_KEY, PHYSICS_FIELD)
      values ('''||sys_guid()||''', ''ELE_' || t_row.ele_catalog_code || ''', ''BE00028'', ''代码集名称'', ''ELENAME'', ''GBString'', ''100'', ''oracle'', ''32002kttmPxx'', null, ''1'', ''1'', ''1'', to_date(to_char(sysdate, ''yyyyMMddHH24:mi:ss''),''yyyy/MM/dd HH24:mi:ss''), to_date(to_char(sysdate, ''yyyyMMddHH24:mi:ss''),''yyyy/MM/dd HH24:mi:ss''), to_date(to_char(sysdate, ''yyyyMMdd''), ''yyyy/MM/dd''), ''2021'', ''109900000'', null, ''0'', ''00028'', ''varchar2'', ''1'', ''1'', ''0'', ''ELE_NAME'')

      into ele_diccolumn (COL_ID, ELE_SOURCE, ELEMENT_CODE, ELEMENT_NAME, ELEMENT_EL_CODE, ELEMENT_DATATYPE, ELEMENT_DATALENGTH, ELEMENT_DATATYPE_FORMAT, ELE_CATALOG_ID, REMARK, SOURCETEXT, ISSHOW, ISUSES, CREATE_TIME, UPDATE_TIME, END_DATE, YEAR, PROVINCE, DEFAULTVALUE, COMPEL_OR_CHOICE, ELEMENT_ID, ACTUAL_DATATYPE, IS_VIEW, IS_EDIT, IS_KEY, PHYSICS_FIELD)
      values ('''||sys_guid()||''', ''ELE_' || t_row.ele_catalog_code || ''', ''BE00030'', ''是否删除'', ''ISDELETED'', ''Integer'', ''1'', ''oracle'', ''32002kttmPxx'', null, ''1'', ''1'', ''1'', to_date(to_char(sysdate, ''yyyyMMddHH24:mi:ss''),''yyyy/MM/dd HH24:mi:ss''), to_date(to_char(sysdate, ''yyyyMMddHH24:mi:ss''),''yyyy/MM/dd HH24:mi:ss''), to_date(to_char(sysdate, ''yyyyMMdd''), ''yyyy/MM/dd''), ''2021'', ''109900000'', null, ''0'', ''00030'', ''number'', ''1'', ''1'', ''0'', ''IS_DELETED'')

      into ele_diccolumn (COL_ID, ELE_SOURCE, ELEMENT_CODE, ELEMENT_NAME, ELEMENT_EL_CODE, ELEMENT_DATATYPE, ELEMENT_DATALENGTH, ELEMENT_DATATYPE_FORMAT, ELE_CATALOG_ID, REMARK, SOURCETEXT, ISSHOW, ISUSES, CREATE_TIME, UPDATE_TIME, END_DATE, YEAR, PROVINCE, DEFAULTVALUE, COMPEL_OR_CHOICE, ELEMENT_ID, ACTUAL_DATATYPE, IS_VIEW, IS_EDIT, IS_KEY, PHYSICS_FIELD)
      values ('''||sys_guid()||''', ''ELE_' || t_row.ele_catalog_code || ''', ''BE00031'', ''父节点ID'', ''PARENTID'', ''String'', ''38'', ''oracle'', ''32002kttmPxx'', null, ''1'', ''1'', ''1'', to_date(to_char(sysdate, ''yyyyMMddHH24:mi:ss''),''yyyy/MM/dd HH24:mi:ss''), to_date(to_char(sysdate, ''yyyyMMddHH24:mi:ss''),''yyyy/MM/dd HH24:mi:ss''), to_date(to_char(sysdate, ''yyyyMMdd''), ''yyyy/MM/dd''), ''2021'', ''109900000'', null, ''0'', ''00031'', ''varchar2'', ''1'', ''1'', ''0'', ''PARENT_ID'')

      into ele_diccolumn (COL_ID, ELE_SOURCE, ELEMENT_CODE, ELEMENT_NAME, ELEMENT_EL_CODE, ELEMENT_DATATYPE, ELEMENT_DATALENGTH, ELEMENT_DATATYPE_FORMAT, ELE_CATALOG_ID, REMARK, SOURCETEXT, ISSHOW, ISUSES, CREATE_TIME, UPDATE_TIME, END_DATE, YEAR, PROVINCE, DEFAULTVALUE, COMPEL_OR_CHOICE, ELEMENT_ID, ACTUAL_DATATYPE, IS_VIEW, IS_EDIT, IS_KEY, PHYSICS_FIELD)
      values ('''||sys_guid()||''', ''ELE_' || t_row.ele_catalog_code || ''', ''BE00035'', ''是否标准'', ''ISSTANDARD'', ''Integer'', ''1'', ''oracle'', ''32002kttmPxx'', null, ''1'', ''1'', ''1'', to_date(to_char(sysdate, ''yyyyMMddHH24:mi:ss''),''yyyy/MM/dd HH24:mi:ss''), to_date(to_char(sysdate, ''yyyyMMddHH24:mi:ss''),''yyyy/MM/dd HH24:mi:ss''), to_date(to_char(sysdate, ''yyyyMMdd''), ''yyyy/MM/dd''), ''2021'', ''109900000'', null, ''0'', ''00035'', ''number'', ''1'', ''1'', ''0'', ''IS_STANDARD'')

      into ele_diccolumn (COL_ID, ELE_SOURCE, ELEMENT_CODE, ELEMENT_NAME, ELEMENT_EL_CODE, ELEMENT_DATATYPE, ELEMENT_DATALENGTH, ELEMENT_DATATYPE_FORMAT, ELE_CATALOG_ID, REMARK, SOURCETEXT, ISSHOW, ISUSES, CREATE_TIME, UPDATE_TIME, END_DATE, YEAR, PROVINCE, DEFAULTVALUE, COMPEL_OR_CHOICE, ELEMENT_ID, ACTUAL_DATATYPE, IS_VIEW, IS_EDIT, IS_KEY, PHYSICS_FIELD)
      values ('''||sys_guid()||''', ''ELE_' || t_row.ele_catalog_code || ''', ''BE00036'', ''创建时间'', ''CREATETIME'', ''DateTime'', null, ''oracle'', ''32002kttmPxx'', null, ''1'', ''1'', ''1'', to_date(to_char(sysdate, ''yyyyMMddHH24:mi:ss''),''yyyy/MM/dd HH24:mi:ss''), to_date(to_char(sysdate, ''yyyyMMddHH24:mi:ss''),''yyyy/MM/dd HH24:mi:ss''), to_date(to_char(sysdate, ''yyyyMMdd''), ''yyyy/MM/dd''), ''2021'', ''109900000'', null, ''0'', ''00036'', ''Date'', ''1'', ''1'', ''0'', ''CREATE_TIME'')
      into ele_diccolumn (COL_ID, ELE_SOURCE, ELEMENT_CODE, ELEMENT_NAME, ELEMENT_EL_CODE, ELEMENT_DATATYPE, ELEMENT_DATALENGTH, ELEMENT_DATATYPE_FORMAT, ELE_CATALOG_ID, REMARK, SOURCETEXT, ISSHOW, ISUSES, CREATE_TIME, UPDATE_TIME, END_DATE, YEAR, PROVINCE, DEFAULTVALUE, COMPEL_OR_CHOICE, ELEMENT_ID, ACTUAL_DATATYPE, IS_VIEW, IS_EDIT, IS_KEY, PHYSICS_FIELD)
      values ('''||sys_guid()||''', ''ELE_' || t_row.ele_catalog_code || ''', ''BE00001'', ''目录编码'', ''ELECATALOGCODE'', ''String'', ''38'', ''oracle'', ''32002kttmPxx'', null, ''1'', ''1'', ''1'', to_date(to_char(sysdate, ''yyyyMMddHH24:mi:ss''),''yyyy/MM/dd HH24:mi:ss''), to_date(to_char(sysdate, ''yyyyMMddHH24:mi:ss''),''yyyy/MM/dd HH24:mi:ss''), to_date(to_char(sysdate, ''yyyyMMdd''), ''yyyy/MM/dd''), ''2021'', ''109900000'', null, ''0'', ''00001'', ''varchar2'', ''1'', ''1'', ''0'', ''ELE_CATALOG_CODE'')       
      select * from dual';
  end loop;
end;
*/

---三个业务库重新刷视图
create or replace view fasp_t_diccolumn as
select t.element_id as deid,
       t1.ele_catalog_id as csid,
       '' as exp,
       '1' as issys,
       t.physics_field as dbcolumncode,
       t.isuses as isuses,
       t.year as year,
       t.province as province,
       t.col_id as columnid,
       t.physics_field as columncode,
      case
         when upper(t2.ele_source) = 'ELE_UNION' then
          'V_' || t2.ele_source ||'_'|| t2.ele_catalog_code
         else
          'V_' || t2.ele_source
       end as TABLECODE,
       t.element_name as name,
       t.actual_datatype as datatype,
       t.element_datalength as datalength,
       null as scale,
       1 as version,
       0 as nullable,
       null as defaultvalue,
       null as dbversion
  from ele_diccolumn t
  left join ele_v_catalog t1
    on t.element_code = t1.element_code
  left join ele_catalog t2 
  on t.ele_source = t2.ele_source
union all
select t.deid,
       t.csid,
       t.exp,
       t.issys,
       t.dbcolumncode,
       t.isuses,
       t.year,
       t.province,
       t.columnid,
       t.columncode,
       t.tablecode,
       t.name,
       t.datatype,
       t.datalength,
       t.scale,
       t.version,
       t.nullable,
       t.defaultvalue,
       t.dbversion
  from bus_t_diccolumn t;



---三个业务库

create or replace view fasp_t_dictable as
select t.year,
       t.province,
       case when instr(t.ele_source,'V_') > 0 then t.tab_viewname
         else
           t.ele_source 
         end as tablecode,
       t.tab_name as name,
       t.remark,
       1 tabletype,
       1 version,
       t.ele_source as dbtabname,
       t.appid,
       '' exp,
       '0' tablepart,
       1 isshow,
       '0' dbimpflag,
       1 issys,
       t.isuses,
       t.tab_viewname as viewtablename,
       0 datasync,
       0 hastrigger,
       '' syncclassname,
       '1' status
union all
select t.year,
       t.province,
       t.tablecode,
       t.name,
       t.remark,
       t.tabletype,
       t.version,
       t.dbtabname,
       t.appid,
       t.exp,
       t.tablepart,
       t.isshow,
       t.dbimpflag,
       t.issys,
       t.isuses||'' as isuses,
       t.viewtablename,
       t.datasync,
       t.hastrigger,
       t.syncclassname,
       t.status
  from bus_t_dictable t;




--- 三个业务库
/**
create or replace synonym ele_dictable
  for MID_dev.ele_dictable;
  
  
create or replace synonym ele_diccolumn
for MID_dev.ele_diccolumn;

*/
































