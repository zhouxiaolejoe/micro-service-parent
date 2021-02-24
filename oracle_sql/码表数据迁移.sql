declare
  J integer;
  I integer;
  cursor t_tables is
    select * from ele_catalog where ele_catalog_code in ('VD88888','VD99999');
begin
  for t_row in t_tables loop
    --如果财政部规范表不存在创建通用表结构
    SELECT COUNT(*)
      INTO I
      FROM USER_TABLES T
     WHERE T.TABLE_NAME = t_row.ele_source;
    IF I < 1 THEN 
      dbms_output.put_line(t_row.ele_source);
      execute immediate '
       create table ' || t_row.ele_source || '
        ( 
          ele_id           VARCHAR2(38),
          ele_code         VARCHAR2(20),
          ele_name         VARCHAR2(100),
          ele_catalog_code VARCHAR2(38),
          parent_id        VARCHAR2(38),
          mof_div_code     VARCHAR2(9),
          fiscal_year      VARCHAR2(4),
          level_no         NUMBER(2),
          is_leaf          NUMBER(1),    
          is_enabled       NUMBER(1),
          is_deleted       NUMBER(1),
          is_standard      NUMBER(1),
          ele_catalog_id   VARCHAR2(38),
          '||case when t_row.ele_source <> 'ELE_UNION' then 'remark           VARCHAR2(200),' end ||'
          create_time      DATE,
          update_time      DATE,
          start_date       DATE,
          '||case when t_row.ele_source <> 'ELE_UNION' then 'admdiv           VARCHAR2(50),' end ||'
          end_date         DATE
          )';
    END IF;
    --迁移原先码表数据 
    SELECT COUNT(*)
      INTO J
      FROM USER_TABLES T
     WHERE T.TABLE_NAME = 'FASP_T_PUP' || t_row.ele_catalog_code;
    IF J > 0 THEN
       execute immediate '
        insert into ' || t_row.ele_source || '('
         ||case when t_row.ele_source <> 'ELE_UNION' then 'admdiv,' end ||
         'ele_catalog_id,
         ele_catalog_code,
         ele_id,
         fiscal_year,
         mof_div_code,
         level_no,
         is_leaf,
         start_date,
         end_date,
         is_enabled,
         update_time,
         ele_code,
         ele_name,
         is_deleted,
         parent_id,
         is_standard,
         '||case when t_row.ele_source <> 'ELE_UNION' then 'remark,' end ||
         'create_time)
        select '||case when t_row.ele_source <> 'ELE_UNION' then 'admdiv,' end ||'
               ''' || t_row.ele_catalog_id || ''',
               ''' || t_row.ele_catalog_code || ''',
               guid,
               year,
               province,
               levelno,
               isleaf,
               to_date(to_char(sysdate, ''yyyyMMdd''), ''yyyy/MM/dd''),
               to_date(to_char(sysdate, ''yyyyMMdd''), ''yyyy/MM/dd''),
               case
                 when status = ''1'' then
                  ''1''
                 when status = ''2'' then
                  ''2''
                 when status = ''3'' then
                  ''2''
               end IS_ENABLED,
               to_date(to_char(sysdate, ''yyyyMMddHH24:mm:ss''),
                       ''yyyy/MM/dd HH24:mi:ss''),
               code,
               name,
               case
                 when status = ''1'' then
                  ''2''
                 when status = ''2'' then
                  ''2''
                 when status = ''3'' then
                  ''1''
               end IS_DELETED,
               superguid,
               ''1'' is_standard,
              '||case when t_row.ele_source <> 'ELE_UNION' then 'remark,' end ||
          'to_date(to_char(sysdate, ''yyyyMMddHH24:mm:ss''),
                       ''yyyy/MM/dd HH24:mi:ss'')
          from FASP_T_PUP'|| t_row.ele_catalog_code||' where year =''2021'' and province=''870000000''';
          commit;
    END IF;
    --注册码表列结构信息
    select count(*) into i from ele_diccolumn_2021 t where t.ele_source = t_row.ele_catalog_code;
    if i < 1 then
    execute immediate '
    insert all
    '||case when t_row.ele_source <> 'ELE_UNION' then '
      into ele_diccolumn_2021 (COL_ID, ELE_SOURCE, ELEMENT_CODE, ELEMENT_NAME, ELEMENT_EL_CODE, ELEMENT_DATATYPE, ELEMENT_DATALENGTH, ELEMENT_DATATYPE_FORMAT, ELE_CATALOG_ID, REMARK, SOURCETEXT, ISSHOW, ISUSES, CREATE_TIME, UPDATE_TIME, END_DATE, YEAR, PROVINCE, DEFAULTVALUE, COMPEL_OR_CHOICE, ELEMENT_ID, ACTUAL_DATATYPE, IS_VIEW, IS_EDIT, IS_KEY, PHYSICS_FIELD)
      values ('''||sys_guid()||''', ''' || t_row.ele_catalog_code || ''', ''AD00001'', ''区划id'', ''ADMDIV'', ''GBString'', ''50'', ''oracle'', ''32002kttmPxx'', null, ''1'', ''1'', ''1'', to_date(to_char(sysdate, ''yyyyMMddHH24:mm:ss''),''yyyy/MM/dd HH24:mi:ss''), to_date(to_char(sysdate, ''yyyyMMddHH24:mm:ss''),''yyyy/MM/dd HH24:mi:ss''), to_date(to_char(sysdate, ''yyyyMMdd''), ''yyyy/MM/dd''), ''2021'', ''109900000'', null, ''0'', ''24BE6B39D77F4EF090ACA84553666311'', ''varchar2'', ''1'', ''1'', ''0'', ''ADMDIV'')
     'end ||'
      into ele_diccolumn_2021 (COL_ID, ELE_SOURCE, ELEMENT_CODE, ELEMENT_NAME, ELEMENT_EL_CODE, ELEMENT_DATATYPE, ELEMENT_DATALENGTH, ELEMENT_DATATYPE_FORMAT, ELE_CATALOG_ID, REMARK, SOURCETEXT, ISSHOW, ISUSES, CREATE_TIME, UPDATE_TIME, END_DATE, YEAR, PROVINCE, DEFAULTVALUE, COMPEL_OR_CHOICE, ELEMENT_ID, ACTUAL_DATATYPE, IS_VIEW, IS_EDIT, IS_KEY, PHYSICS_FIELD)
      values ('''||sys_guid()||''', ''' || t_row.ele_catalog_code || ''', ''BE00001'', ''目录主键'', ''ELECATALOGID'', ''String'', ''38'', ''oracle'', ''32002kttmPxx'', null, ''1'', ''1'', ''1'', to_date(to_char(sysdate, ''yyyyMMddHH24:mm:ss''),''yyyy/MM/dd HH24:mi:ss''), to_date(to_char(sysdate, ''yyyyMMddHH24:mm:ss''),''yyyy/MM/dd HH24:mi:ss''), to_date(to_char(sysdate, ''yyyyMMdd''), ''yyyy/MM/dd''), ''2021'', ''109900000'', null, ''0'', ''00001'', ''varchar2'', ''1'', ''1'', ''0'', ''ELE_CATALOG_ID'')

      into ele_diccolumn_2021 (COL_ID, ELE_SOURCE, ELEMENT_CODE, ELEMENT_NAME, ELEMENT_EL_CODE, ELEMENT_DATATYPE, ELEMENT_DATALENGTH, ELEMENT_DATATYPE_FORMAT, ELE_CATALOG_ID, REMARK, SOURCETEXT, ISSHOW, ISUSES, CREATE_TIME, UPDATE_TIME, END_DATE, YEAR, PROVINCE, DEFAULTVALUE, COMPEL_OR_CHOICE, ELEMENT_ID, ACTUAL_DATATYPE, IS_VIEW, IS_EDIT, IS_KEY, PHYSICS_FIELD)
      values ('''||sys_guid()||''', ''' || t_row.ele_catalog_code || ''', ''BE00001'', ''代码集主键'', ''ELEID'', ''String'', ''38'', ''oracle'', ''32002kttmPxx'', null, ''1'', ''1'', ''1'', to_date(to_char(sysdate, ''yyyyMMddHH24:mm:ss''),''yyyy/MM/dd HH24:mi:ss''), to_date(to_char(sysdate, ''yyyyMMddHH24:mm:ss''),''yyyy/MM/dd HH24:mi:ss''), to_date(to_char(sysdate, ''yyyyMMdd''), ''yyyy/MM/dd''), ''2021'', ''109900000'', null, ''0'', ''00001'', ''varchar2'', ''1'', ''1'', ''0'', ''ELE_ID'')

      into ele_diccolumn_2021 (COL_ID, ELE_SOURCE, ELEMENT_CODE, ELEMENT_NAME, ELEMENT_EL_CODE, ELEMENT_DATATYPE, ELEMENT_DATALENGTH, ELEMENT_DATATYPE_FORMAT, ELE_CATALOG_ID, REMARK, SOURCETEXT, ISSHOW, ISUSES, CREATE_TIME, UPDATE_TIME, END_DATE, YEAR, PROVINCE, DEFAULTVALUE, COMPEL_OR_CHOICE, ELEMENT_ID, ACTUAL_DATATYPE, IS_VIEW, IS_EDIT, IS_KEY, PHYSICS_FIELD)
      values ('''||sys_guid()||''', ''' || t_row.ele_catalog_code || ''', ''BE00008'', ''年'', ''YEAR'', ''NString'', ''4'', ''oracle'', ''32002kttmPxx'', null, ''1'', ''1'', ''1'', to_date(to_char(sysdate, ''yyyyMMddHH24:mm:ss''),''yyyy/MM/dd HH24:mi:ss''), to_date(to_char(sysdate, ''yyyyMMddHH24:mm:ss''),''yyyy/MM/dd HH24:mi:ss''), to_date(to_char(sysdate, ''yyyyMMdd''), ''yyyy/MM/dd''), ''2021'', ''109900000'', null, ''0'', ''00008'', ''varchar2'', ''1'', ''1'', ''0'', ''FISCAL_YEAR'')

      into ele_diccolumn_2021 (COL_ID, ELE_SOURCE, ELEMENT_CODE, ELEMENT_NAME, ELEMENT_EL_CODE, ELEMENT_DATATYPE, ELEMENT_DATALENGTH, ELEMENT_DATATYPE_FORMAT, ELE_CATALOG_ID, REMARK, SOURCETEXT, ISSHOW, ISUSES, CREATE_TIME, UPDATE_TIME, END_DATE, YEAR, PROVINCE, DEFAULTVALUE, COMPEL_OR_CHOICE, ELEMENT_ID, ACTUAL_DATATYPE, IS_VIEW, IS_EDIT, IS_KEY, PHYSICS_FIELD)
      values ('''||sys_guid()||''', ''' || t_row.ele_catalog_code || ''', ''BE00017'', ''财政区划代码'', ''MOFDIVCODE'', ''NString'', ''9'', ''oracle'', ''32002kttmPxx'', null, ''1'', ''1'', ''1'', to_date(to_char(sysdate, ''yyyyMMddHH24:mm:ss''),''yyyy/MM/dd HH24:mi:ss''), to_date(to_char(sysdate, ''yyyyMMddHH24:mm:ss''),''yyyy/MM/dd HH24:mi:ss''), to_date(to_char(sysdate, ''yyyyMMdd''), ''yyyy/MM/dd''), ''2021'', ''109900000'', null, ''0'', ''00017'', ''varchar2'', ''1'', ''1'', ''0'', ''MOF_DIV_CODE'')

      into ele_diccolumn_2021 (COL_ID, ELE_SOURCE, ELEMENT_CODE, ELEMENT_NAME, ELEMENT_EL_CODE, ELEMENT_DATATYPE, ELEMENT_DATALENGTH, ELEMENT_DATATYPE_FORMAT, ELE_CATALOG_ID, REMARK, SOURCETEXT, ISSHOW, ISUSES, CREATE_TIME, UPDATE_TIME, END_DATE, YEAR, PROVINCE, DEFAULTVALUE, COMPEL_OR_CHOICE, ELEMENT_ID, ACTUAL_DATATYPE, IS_VIEW, IS_EDIT, IS_KEY, PHYSICS_FIELD)
      values ('''||sys_guid()||''', ''' || t_row.ele_catalog_code || ''', ''BE00018'', ''级次'', ''LEVELNO'', ''Integer'', ''2'', ''oracle'', ''32002kttmPxx'', null, ''1'', ''1'', ''1'', to_date(to_char(sysdate, ''yyyyMMddHH24:mm:ss''),''yyyy/MM/dd HH24:mi:ss''), to_date(to_char(sysdate, ''yyyyMMddHH24:mm:ss''),''yyyy/MM/dd HH24:mi:ss''), to_date(to_char(sysdate, ''yyyyMMdd''), ''yyyy/MM/dd''), ''2021'', ''109900000'', null, ''0'', ''00018'', ''number'', ''1'', ''1'', ''0'', ''LEVEL_NO'')

      into ele_diccolumn_2021 (COL_ID, ELE_SOURCE, ELEMENT_CODE, ELEMENT_NAME, ELEMENT_EL_CODE, ELEMENT_DATATYPE, ELEMENT_DATALENGTH, ELEMENT_DATATYPE_FORMAT, ELE_CATALOG_ID, REMARK, SOURCETEXT, ISSHOW, ISUSES, CREATE_TIME, UPDATE_TIME, END_DATE, YEAR, PROVINCE, DEFAULTVALUE, COMPEL_OR_CHOICE, ELEMENT_ID, ACTUAL_DATATYPE, IS_VIEW, IS_EDIT, IS_KEY, PHYSICS_FIELD)
      values ('''||sys_guid()||''', ''' || t_row.ele_catalog_code || ''', ''BE00019'', ''是否末级'', ''ISLEAF'', ''Integer'', ''1'', ''oracle'', ''32002kttmPxx'', null, ''1'', ''1'', ''1'', to_date(to_char(sysdate, ''yyyyMMddHH24:mm:ss''),''yyyy/MM/dd HH24:mi:ss''), to_date(to_char(sysdate, ''yyyyMMddHH24:mm:ss''),''yyyy/MM/dd HH24:mi:ss''), to_date(to_char(sysdate, ''yyyyMMdd''), ''yyyy/MM/dd''), ''2021'', ''109900000'', null, ''0'', ''00019'', ''number'', ''1'', ''1'', ''0'', ''IS_LEAF'')

      into ele_diccolumn_2021 (COL_ID, ELE_SOURCE, ELEMENT_CODE, ELEMENT_NAME, ELEMENT_EL_CODE, ELEMENT_DATATYPE, ELEMENT_DATALENGTH, ELEMENT_DATATYPE_FORMAT, ELE_CATALOG_ID, REMARK, SOURCETEXT, ISSHOW, ISUSES, CREATE_TIME, UPDATE_TIME, END_DATE, YEAR, PROVINCE, DEFAULTVALUE, COMPEL_OR_CHOICE, ELEMENT_ID, ACTUAL_DATATYPE, IS_VIEW, IS_EDIT, IS_KEY, PHYSICS_FIELD)
      values ('''||sys_guid()||''', ''' || t_row.ele_catalog_code || ''', ''BE00020'', ''启用日期'', ''STARTDATE'', ''Date'', null, ''oracle'', ''32002kttmPxx'', null, ''1'', ''1'', ''1'', to_date(to_char(sysdate, ''yyyyMMddHH24:mm:ss''),''yyyy/MM/dd HH24:mi:ss''), to_date(to_char(sysdate, ''yyyyMMddHH24:mm:ss''),''yyyy/MM/dd HH24:mi:ss''), to_date(to_char(sysdate, ''yyyyMMdd''), ''yyyy/MM/dd''), ''2021'', ''109900000'', null, ''0'', ''00020'', ''Date'', ''1'', ''1'', ''0'', ''START_DATE'')

      into ele_diccolumn_2021 (COL_ID, ELE_SOURCE, ELEMENT_CODE, ELEMENT_NAME, ELEMENT_EL_CODE, ELEMENT_DATATYPE, ELEMENT_DATALENGTH, ELEMENT_DATATYPE_FORMAT, ELE_CATALOG_ID, REMARK, SOURCETEXT, ISSHOW, ISUSES, CREATE_TIME, UPDATE_TIME, END_DATE, YEAR, PROVINCE, DEFAULTVALUE, COMPEL_OR_CHOICE, ELEMENT_ID, ACTUAL_DATATYPE, IS_VIEW, IS_EDIT, IS_KEY, PHYSICS_FIELD)
      values ('''||sys_guid()||''', ''' || t_row.ele_catalog_code || ''', ''BE00021'', ''停用日期'', ''ENDDATE'', ''Date'', null, ''oracle'', ''32002kttmPxx'', null, ''1'', ''1'', ''1'', to_date(to_char(sysdate, ''yyyyMMddHH24:mm:ss''),''yyyy/MM/dd HH24:mi:ss''), to_date(to_char(sysdate, ''yyyyMMddHH24:mm:ss''),''yyyy/MM/dd HH24:mi:ss''), to_date(to_char(sysdate, ''yyyyMMdd''), ''yyyy/MM/dd''), ''2021'', ''109900000'', null, ''0'', ''00021'', ''Date'', ''1'', ''1'', ''0'', ''END_DATE'')

      into ele_diccolumn_2021 (COL_ID, ELE_SOURCE, ELEMENT_CODE, ELEMENT_NAME, ELEMENT_EL_CODE, ELEMENT_DATATYPE, ELEMENT_DATALENGTH, ELEMENT_DATATYPE_FORMAT, ELE_CATALOG_ID, REMARK, SOURCETEXT, ISSHOW, ISUSES, CREATE_TIME, UPDATE_TIME, END_DATE, YEAR, PROVINCE, DEFAULTVALUE, COMPEL_OR_CHOICE, ELEMENT_ID, ACTUAL_DATATYPE, IS_VIEW, IS_EDIT, IS_KEY, PHYSICS_FIELD)
      values ('''||sys_guid()||''', ''' || t_row.ele_catalog_code || ''', ''BE00022'', ''是否启用'', ''ISENABLED'', ''Integer'', ''1'', ''oracle'', ''32002kttmPxx'', null, ''1'', ''1'', ''1'', to_date(to_char(sysdate, ''yyyyMMddHH24:mm:ss''),''yyyy/MM/dd HH24:mi:ss''), to_date(to_char(sysdate, ''yyyyMMddHH24:mm:ss''),''yyyy/MM/dd HH24:mi:ss''), to_date(to_char(sysdate, ''yyyyMMdd''), ''yyyy/MM/dd''), ''2021'', ''109900000'', null, ''0'', ''00022'', ''number'', ''1'', ''1'', ''0'', ''IS_ENABLED'')

      into ele_diccolumn_2021 (COL_ID, ELE_SOURCE, ELEMENT_CODE, ELEMENT_NAME, ELEMENT_EL_CODE, ELEMENT_DATATYPE, ELEMENT_DATALENGTH, ELEMENT_DATATYPE_FORMAT, ELE_CATALOG_ID, REMARK, SOURCETEXT, ISSHOW, ISUSES, CREATE_TIME, UPDATE_TIME, END_DATE, YEAR, PROVINCE, DEFAULTVALUE, COMPEL_OR_CHOICE, ELEMENT_ID, ACTUAL_DATATYPE, IS_VIEW, IS_EDIT, IS_KEY, PHYSICS_FIELD)
      values ('''||sys_guid()||''', ''' || t_row.ele_catalog_code || ''', ''BE00023'', ''更新时间'', ''UPDATETIME'', ''DateTime'', null, ''oracle'', ''32002kttmPxx'', null, ''1'', ''1'', ''1'', to_date(to_char(sysdate, ''yyyyMMddHH24:mm:ss''),''yyyy/MM/dd HH24:mi:ss''), to_date(to_char(sysdate, ''yyyyMMddHH24:mm:ss''),''yyyy/MM/dd HH24:mi:ss''), to_date(to_char(sysdate, ''yyyyMMdd''), ''yyyy/MM/dd''), ''2021'', ''109900000'', null, ''0'', ''00023'', ''Date'', ''1'', ''1'', ''0'', ''UPDATE_TIME'')

      into ele_diccolumn_2021 (COL_ID, ELE_SOURCE, ELEMENT_CODE, ELEMENT_NAME, ELEMENT_EL_CODE, ELEMENT_DATATYPE, ELEMENT_DATALENGTH, ELEMENT_DATATYPE_FORMAT, ELE_CATALOG_ID, REMARK, SOURCETEXT, ISSHOW, ISUSES, CREATE_TIME, UPDATE_TIME, END_DATE, YEAR, PROVINCE, DEFAULTVALUE, COMPEL_OR_CHOICE, ELEMENT_ID, ACTUAL_DATATYPE, IS_VIEW, IS_EDIT, IS_KEY, PHYSICS_FIELD)
      values ('''||sys_guid()||''', ''' || t_row.ele_catalog_code || ''', ''BE00027'', ''代码集代码'', ''ELECODE'', ''NString'', ''20'', ''oracle'', ''32002kttmPxx'', null, ''1'', ''1'', ''1'', to_date(to_char(sysdate, ''yyyyMMddHH24:mm:ss''),''yyyy/MM/dd HH24:mi:ss''), to_date(to_char(sysdate, ''yyyyMMddHH24:mm:ss''),''yyyy/MM/dd HH24:mi:ss''), to_date(to_char(sysdate, ''yyyyMMdd''), ''yyyy/MM/dd''), ''2021'', ''109900000'', null, ''0'', ''00027'', ''varchar2'', ''1'', ''1'', ''0'', ''ELE_CODE'')

      into ele_diccolumn_2021 (COL_ID, ELE_SOURCE, ELEMENT_CODE, ELEMENT_NAME, ELEMENT_EL_CODE, ELEMENT_DATATYPE, ELEMENT_DATALENGTH, ELEMENT_DATATYPE_FORMAT, ELE_CATALOG_ID, REMARK, SOURCETEXT, ISSHOW, ISUSES, CREATE_TIME, UPDATE_TIME, END_DATE, YEAR, PROVINCE, DEFAULTVALUE, COMPEL_OR_CHOICE, ELEMENT_ID, ACTUAL_DATATYPE, IS_VIEW, IS_EDIT, IS_KEY, PHYSICS_FIELD)
      values ('''||sys_guid()||''', ''' || t_row.ele_catalog_code || ''', ''BE00028'', ''代码集名称'', ''ELENAME'', ''GBString'', ''100'', ''oracle'', ''32002kttmPxx'', null, ''1'', ''1'', ''1'', to_date(to_char(sysdate, ''yyyyMMddHH24:mm:ss''),''yyyy/MM/dd HH24:mi:ss''), to_date(to_char(sysdate, ''yyyyMMddHH24:mm:ss''),''yyyy/MM/dd HH24:mi:ss''), to_date(to_char(sysdate, ''yyyyMMdd''), ''yyyy/MM/dd''), ''2021'', ''109900000'', null, ''0'', ''00028'', ''varchar2'', ''1'', ''1'', ''0'', ''ELE_NAME'')

      into ele_diccolumn_2021 (COL_ID, ELE_SOURCE, ELEMENT_CODE, ELEMENT_NAME, ELEMENT_EL_CODE, ELEMENT_DATATYPE, ELEMENT_DATALENGTH, ELEMENT_DATATYPE_FORMAT, ELE_CATALOG_ID, REMARK, SOURCETEXT, ISSHOW, ISUSES, CREATE_TIME, UPDATE_TIME, END_DATE, YEAR, PROVINCE, DEFAULTVALUE, COMPEL_OR_CHOICE, ELEMENT_ID, ACTUAL_DATATYPE, IS_VIEW, IS_EDIT, IS_KEY, PHYSICS_FIELD)
      values ('''||sys_guid()||''', ''' || t_row.ele_catalog_code || ''', ''BE00030'', ''是否删除'', ''ISDELETED'', ''Integer'', ''1'', ''oracle'', ''32002kttmPxx'', null, ''1'', ''1'', ''1'', to_date(to_char(sysdate, ''yyyyMMddHH24:mm:ss''),''yyyy/MM/dd HH24:mi:ss''), to_date(to_char(sysdate, ''yyyyMMddHH24:mm:ss''),''yyyy/MM/dd HH24:mi:ss''), to_date(to_char(sysdate, ''yyyyMMdd''), ''yyyy/MM/dd''), ''2021'', ''109900000'', null, ''0'', ''00030'', ''number'', ''1'', ''1'', ''0'', ''IS_DELETED'')

      into ele_diccolumn_2021 (COL_ID, ELE_SOURCE, ELEMENT_CODE, ELEMENT_NAME, ELEMENT_EL_CODE, ELEMENT_DATATYPE, ELEMENT_DATALENGTH, ELEMENT_DATATYPE_FORMAT, ELE_CATALOG_ID, REMARK, SOURCETEXT, ISSHOW, ISUSES, CREATE_TIME, UPDATE_TIME, END_DATE, YEAR, PROVINCE, DEFAULTVALUE, COMPEL_OR_CHOICE, ELEMENT_ID, ACTUAL_DATATYPE, IS_VIEW, IS_EDIT, IS_KEY, PHYSICS_FIELD)
      values ('''||sys_guid()||''', ''' || t_row.ele_catalog_code || ''', ''BE00031'', ''父节点ID'', ''PARENTID'', ''String'', ''38'', ''oracle'', ''32002kttmPxx'', null, ''1'', ''1'', ''1'', to_date(to_char(sysdate, ''yyyyMMddHH24:mm:ss''),''yyyy/MM/dd HH24:mi:ss''), to_date(to_char(sysdate, ''yyyyMMddHH24:mm:ss''),''yyyy/MM/dd HH24:mi:ss''), to_date(to_char(sysdate, ''yyyyMMdd''), ''yyyy/MM/dd''), ''2021'', ''109900000'', null, ''0'', ''00031'', ''varchar2'', ''1'', ''1'', ''0'', ''PARENT_ID'')

      into ele_diccolumn_2021 (COL_ID, ELE_SOURCE, ELEMENT_CODE, ELEMENT_NAME, ELEMENT_EL_CODE, ELEMENT_DATATYPE, ELEMENT_DATALENGTH, ELEMENT_DATATYPE_FORMAT, ELE_CATALOG_ID, REMARK, SOURCETEXT, ISSHOW, ISUSES, CREATE_TIME, UPDATE_TIME, END_DATE, YEAR, PROVINCE, DEFAULTVALUE, COMPEL_OR_CHOICE, ELEMENT_ID, ACTUAL_DATATYPE, IS_VIEW, IS_EDIT, IS_KEY, PHYSICS_FIELD)
      values ('''||sys_guid()||''', ''' || t_row.ele_catalog_code || ''', ''BE00035'', ''是否标准'', ''ISSTANDARD'', ''Integer'', ''1'', ''oracle'', ''32002kttmPxx'', null, ''1'', ''1'', ''1'', to_date(to_char(sysdate, ''yyyyMMddHH24:mm:ss''),''yyyy/MM/dd HH24:mi:ss''), to_date(to_char(sysdate, ''yyyyMMddHH24:mm:ss''),''yyyy/MM/dd HH24:mi:ss''), to_date(to_char(sysdate, ''yyyyMMdd''), ''yyyy/MM/dd''), ''2021'', ''109900000'', null, ''0'', ''00035'', ''number'', ''1'', ''1'', ''0'', ''IS_STANDARD'')

      into ele_diccolumn_2021 (COL_ID, ELE_SOURCE, ELEMENT_CODE, ELEMENT_NAME, ELEMENT_EL_CODE, ELEMENT_DATATYPE, ELEMENT_DATALENGTH, ELEMENT_DATATYPE_FORMAT, ELE_CATALOG_ID, REMARK, SOURCETEXT, ISSHOW, ISUSES, CREATE_TIME, UPDATE_TIME, END_DATE, YEAR, PROVINCE, DEFAULTVALUE, COMPEL_OR_CHOICE, ELEMENT_ID, ACTUAL_DATATYPE, IS_VIEW, IS_EDIT, IS_KEY, PHYSICS_FIELD)
      values ('''||sys_guid()||''', ''' || t_row.ele_catalog_code || ''', ''BE00036'', ''创建时间'', ''CREATETIME'', ''DateTime'', null, ''oracle'', ''32002kttmPxx'', null, ''1'', ''1'', ''1'', to_date(to_char(sysdate, ''yyyyMMddHH24:mm:ss''),''yyyy/MM/dd HH24:mi:ss''), to_date(to_char(sysdate, ''yyyyMMddHH24:mm:ss''),''yyyy/MM/dd HH24:mi:ss''), to_date(to_char(sysdate, ''yyyyMMdd''), ''yyyy/MM/dd''), ''2021'', ''109900000'', null, ''0'', ''00036'', ''Date'', ''1'', ''1'', ''0'', ''CREATE_TIME'')
      '
      ||case when t_row.ele_source <> 'ELE_UNION' then '
      into ele_diccolumn_2021 (COL_ID, ELE_SOURCE, ELEMENT_CODE, ELEMENT_NAME, ELEMENT_EL_CODE, ELEMENT_DATATYPE, ELEMENT_DATALENGTH, ELEMENT_DATATYPE_FORMAT, ELE_CATALOG_ID, REMARK, SOURCETEXT, ISSHOW, ISUSES, CREATE_TIME, UPDATE_TIME, END_DATE, YEAR, PROVINCE, DEFAULTVALUE, COMPEL_OR_CHOICE, ELEMENT_ID, ACTUAL_DATATYPE, IS_VIEW, IS_EDIT, IS_KEY, PHYSICS_FIELD)
      values ('''||sys_guid()||''', ''' || t_row.ele_catalog_code || ''', ''REM0001'', ''备注'', ''REMARK'', ''GBString'', ''200'', ''oracle'', ''32002kttmPxx'', null, ''1'', ''1'', ''1'', to_date(to_char(sysdate, ''yyyyMMddHH24:mm:ss''),''yyyy/MM/dd HH24:mi:ss''), to_date(to_char(sysdate, ''yyyyMMddHH24:mm:ss''),''yyyy/MM/dd HH24:mi:ss''), to_date(to_char(sysdate, ''yyyyMMdd''), ''yyyy/MM/dd''), ''2021'', ''109900000'', null, ''0'', ''D82ACDAAEA5D4AD3AB5401042EA44890'', ''varchar2'', ''1'', ''1'', ''0'', ''REMARK'')
     'end ||'
      into ele_diccolumn_2021 (COL_ID, ELE_SOURCE, ELEMENT_CODE, ELEMENT_NAME, ELEMENT_EL_CODE, ELEMENT_DATATYPE, ELEMENT_DATALENGTH, ELEMENT_DATATYPE_FORMAT, ELE_CATALOG_ID, REMARK, SOURCETEXT, ISSHOW, ISUSES, CREATE_TIME, UPDATE_TIME, END_DATE, YEAR, PROVINCE, DEFAULTVALUE, COMPEL_OR_CHOICE, ELEMENT_ID, ACTUAL_DATATYPE, IS_VIEW, IS_EDIT, IS_KEY, PHYSICS_FIELD)
      values ('''||sys_guid()||''', ''' || t_row.ele_catalog_code || ''', ''BE00001'', ''目录编码'', ''ELECATALOGCODE'', ''String'', ''38'', ''oracle'', ''32002kttmPxx'', null, ''1'', ''1'', ''1'', to_date(to_char(sysdate, ''yyyyMMddHH24:mm:ss''),''yyyy/MM/dd HH24:mi:ss''), to_date(to_char(sysdate, ''yyyyMMddHH24:mm:ss''),''yyyy/MM/dd HH24:mi:ss''), to_date(to_char(sysdate, ''yyyyMMdd''), ''yyyy/MM/dd''), ''2021'', ''109900000'', null, ''0'', ''00001'', ''varchar2'', ''1'', ''1'', ''0'', ''ELE_CATALOG_CODE'')       
      select * from dual';
      commit;
      end if;      
  end loop;
end;
