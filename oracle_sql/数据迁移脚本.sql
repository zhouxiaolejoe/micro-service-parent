--逻辑库表要素迁移
--脚本执行前需要导入ele_datatype_enum数据类型表
DECLARE
  I INTEGER;
  J INTEGER;
  H INTEGER;
  CURSOR T_DICDES IS
    SELECT * FROM FASP_T_DICDE T;
BEGIN
  SELECT COUNT(1) INTO H FROM USER_TABLES T WHERE T.TABLE_NAME ='ELE_ELEMENT_0517';
  IF H < 1 THEN 
    EXECUTE IMMEDIATE 'CREATE TABLE ELE_ELEMENT_0517 AS SELECT * FROM ELE_ELEMENT';
    COMMIT;
  END IF;
  FOR T_DICDE IN T_DICDES LOOP
    SELECT COUNT(1) INTO I FROM ELE_ELEMENT T WHERE T.ELEMENT_CODE = T_DICDE.CODE;
    SELECT COUNT(1) INTO J FROM ELE_ELEMENT T WHERE T.ELEMENT_ID = T_DICDE.GUID;
    IF I < 1 and J < 1 THEN
       DBMS_OUTPUT.PUT_LINE(T_DICDE.CODE);
       EXECUTE IMMEDIATE 'INSERT INTO ELE_ELEMENT
          (ELEMENT_ID,
           ELEMENT_CODE,
           ELEMENT_NAME,
           ELEMENT_EL_CODE,
           ELEMENT_DATATYPE,
           ELEMENT_DATALENGTH,
           ELEMENT_DATATYPE_FORMAT,
           ELE_CATALOG_ID,
           REMARK,
           SOURCETEXT,
           START_DATE,
           END_DATE,
           IS_ENABLED,
           UPDATE_TIME,
           IS_DELETED,
           CREATE_TIME,
           MOF_DIV_CODE,
           YEAR,
           TYPEGUID,
           ACTUAL_DATATYPE,
           PHYSICS_FIELD,
           ELE_CATALOG_CODE,
           VALUE_REF)
          SELECT GUID,
                 CODE,
                 NAME,
                 ELEMENTCODE,
                 DATATYPE,
                 FORMAT,
                 ''oracle'' ELEMENT_DATATYPE_FORMAT,
                 ''1'' ELE_CATALOG_ID,
                 REMARK,
                 ''1'' SOURCETEXT,
                 TO_DATE(TO_CHAR(SYSDATE, ''yyyyMMdd''), ''yyyy/MM/dd''),
                 TO_DATE(TO_CHAR(SYSDATE, ''yyyyMMdd''), ''yyyy/MM/dd''),
                 CASE
                   WHEN STATUS = ''1'' THEN
                    ''1''
                   WHEN STATUS = ''2'' THEN
                    ''2''
                   WHEN STATUS = ''3'' THEN
                    ''2''
                 END IS_ENABLED,
                 TO_DATE(TO_CHAR(SYSDATE, ''yyyyMMddHH24:mi:ss''),
                         ''yyyy/MM/dd HH24:mi:ss''),
                 CASE
                   WHEN STATUS = ''1'' THEN
                    ''2''
                   WHEN STATUS = ''2'' THEN
                    ''2''
                   WHEN STATUS = ''3'' THEN
                    ''1''
                 END IS_DELETED,
                 TO_DATE(TO_CHAR(SYSDATE, ''yyyyMMddHH24:mi:ss''),
                         ''yyyy/MM/dd HH24:mi:ss''),
                 PROVINCE,
                 YEAR,
                 ''1'' TYPEGUID,
                 (SELECT T.ACTUAL_CODE
                    FROM ELE_DATATYPE_ENUM T
                   WHERE LOWER(T.RULE_CODE) = LOWER(F.DATATYPE)) ACTUAL_DATATYPE,
                 ELEMENTCODE PHYSICS_FIELD,
                 SUBSTR(REPLACE(F.RANGESRC, ''"'', ''''), 0, 7) ELE_CATALOG_CODE,
                 RANGESRC
            FROM FASP_T_DICDE F where F.CODE = '''||T_DICDE.CODE||'''';
       COMMIT;
    END IF;
  END LOOP;
END;

--代码集迁移
DECLARE
  I INTEGER;
  J INTEGER;
  H INTEGER;
  CURSOR T_DICDSS IS
    SELECT * FROM FASP_T_DICDS T;
BEGIN
  SELECT COUNT(1) INTO H FROM USER_TABLES T WHERE T.TABLE_NAME ='ELE_CATALOG_0517';
  IF H < 1 THEN 
    EXECUTE IMMEDIATE 'CREATE TABLE ELE_CATALOG_0517 AS SELECT * FROM ELE_CATALOG';
    COMMIT;
  END IF;
  FOR T_DICDS IN T_DICDSS LOOP
    SELECT COUNT(1) INTO I FROM ELE_CATALOG T WHERE T.ELE_CATALOG_CODE = T_DICDS.CODE;
    SELECT COUNT(1) INTO J FROM ELE_CATALOG T WHERE T.ELE_CATALOG_ID = T_DICDS.GUID;
    IF I < 1 AND J < 1 THEN
      DBMS_OUTPUT.PUT_LINE(T_DICDS.CODE);
      EXECUTE IMMEDIATE '
      INSERT INTO ELE_CATALOG
        (ELE_CATALOG_ID,
         ELE_CATALOG_CODE,
         ELE_CATALOG_NAME,
         MOF_DIV_CODE,
         ELE_SOURCE,
         ELE_EXTEND_TYPE,
         ELE_MANAGE_TYPE,
         START_DATE,
         END_DATE,
         IS_ENABLED,
         UPDATE_TIME,
         IS_STANDARD,
         IS_DELETED,
         CREATE_TIME,
         HQ_TYPE,
         FISCAL_YEAR,
         ELEMENTCODE,
         CODEMODE,
         CATALOG_TYPE,
         IS_VINDICATE,
         IS_MASTERDATA,
         TYPEGUID,
         APPLY,
         REMARK)
        SELECT GUID,
               CODE,
               NAME,
               PROVINCE,
               ''ELE_''||CODE,
               ''1'' ELE_EXTEND_TYPE,
               ''1'' ELE_MANAGE_TYPE,
               TO_DATE(TO_CHAR(SYSDATE, ''YYYYMMDD''), ''YYYY/MM/DD''),
               TO_DATE(TO_CHAR(SYSDATE, ''YYYYMMDD''), ''YYYY/MM/DD''),
               CASE
                 WHEN STATUS = ''1'' THEN
                  ''1''
                 WHEN STATUS = ''2'' THEN
                  ''2''
                 WHEN STATUS = ''3'' THEN
                  ''2''
               END IS_ENABLED,
               TO_DATE(TO_CHAR(SYSDATE, ''YYYYMMDDHH24:MI:SS''),
                       ''YYYY/MM/DD HH24:MI:SS''),
               ''1'' IS_STANDARD,
               CASE
                 WHEN STATUS = ''1'' THEN
                  ''2''
                 WHEN STATUS = ''2'' THEN
                  ''2''
                 WHEN STATUS = ''3'' THEN
                  ''1''
               END IS_DELETED,
               TO_DATE(TO_CHAR(SYSDATE, ''YYYYMMDDHH24:MI:SS''),
                       ''YYYY/MM/DD HH24:MI:SS''),
               ''1'' HQ_TYPE,
               YEAR,
               ELEMENTCODE,
               CODEMODE,
               ''1'' CATALOG_TYPE,
               ''1'' IS_VINDICATE,
               ''1'' IS_MASTERDATA,
               ''1'' TYPEGUID,
               APPLY,
               REMARK
          FROM FASP_T_DICDS F WHERE F.CODE = '''||T_DICDS.CODE||'''';
      COMMIT;
    END IF;
  END LOOP;
END;
--逻辑库表迁移
DECLARE
  I INTEGER;
  H INTEGER;
  CURSOR T_DICTABLES IS
    SELECT * FROM FASP_T_DICTABLE T;
BEGIN
  SELECT COUNT(1) INTO H FROM USER_TABLES T WHERE T.TABLE_NAME ='ELE_DICTABLE_0517';
  IF H < 1 THEN 
    EXECUTE IMMEDIATE 'CREATE TABLE ELE_DICTABLE_0517 AS SELECT * FROM ELE_DICTABLE';
    COMMIT;
  END IF;
  FOR T_DICTABLE IN T_DICTABLES LOOP
    SELECT COUNT(1) INTO I FROM ELE_DICTABLE T WHERE T.ELE_SOURCE = T_DICTABLE.TABLECODE;
    IF I < 1 THEN
      DBMS_OUTPUT.PUT_LINE(T_DICTABLE.TABLECODE);
      EXECUTE IMMEDIATE 'insert into ele_dictable
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
           SYS_GUID(),
           TABLECODE,
           name,
           TABLECODE,
           REMARK,
           ''1'' ISSHOW,
           ''1'' ISUSES,
            to_date(to_char(sysdate, ''yyyyMMddHH24:mi:ss''),
                         ''yyyy/MM/dd HH24:mi:ss''),
            to_date(to_char(sysdate, ''yyyyMMddHH24:mi:ss''),
                         ''yyyy/MM/dd HH24:mi:ss''),   
            to_date(to_char(sysdate, ''yyyyMMdd''), ''yyyy/MM/dd''),    
            NVL(YEAR,''2021''),
            NVL(PROVINCE,''87''),
            APPID,
            ''1'' catalog_type_id,
            '''' codemode,
            ''1'' apply,
            ''1'' element_el_code,
            ''1'' col_view,
            ''1'' entity_number,
            ''0'' catalog_type
            from fasp_t_dictable f where f.name is not null and f.TABLECODE = '''||T_DICTABLE.TABLECODE||'''';
      COMMIT;
    END IF;
  END LOOP;
END;


select t.*,t.rowid from fasp_t_dicds t  where t.code not in (
select ele_catalog_code from ele_catalog
);
select t.*,t.rowid from fasp_t_dicde t  where t.code not in (
select element_code from ele_element
);
select t.*,t.rowid from  fasp_t_dictable t where t.tablecode not in (
select ele_source from ele_dictable
);






