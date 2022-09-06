--该脚本再省本级预算库执行
CREATE OR REPLACE PROCEDURE WRITE_TEMP_TABLE(p_province VARCHAR2,
                                             p_year     VARCHAR2,
                                             p_business VARCHAR2,
                                             p_dblink   VARCHAR2) AS              
 I integer; 
 V_SQL varchar2(8000);                                           
BEGIN
  SELECT COUNT(1)
    INTO I
    FROM USER_TABLES
   WHERE TABLE_NAME = 'HW_T_DATARIGHTRP';
  IF I <= 0 THEN
    EXECUTE IMMEDIATE '
        create table HW_T_DATARIGHTRP
        (
          guid     VARCHAR2(128) not null,
          roleid   VARCHAR2(32),
          menuid   VARCHAR2(32),
          province VARCHAR2(9) not null,
          year     CHAR(4) not null,
          userguid VARCHAR2(32)
        )
        ';
    EXECUTE IMMEDIATE 'comment on table HW_T_DATARIGHTRP is ''接受华为推送数据中间表''';
    EXECUTE IMMEDIATE 'comment on column HW_T_DATARIGHTRP.guid is ''主键唯一''';
    EXECUTE IMMEDIATE 'comment on column HW_T_DATARIGHTRP.roleid is ''角色id''';
    EXECUTE IMMEDIATE 'comment on column HW_T_DATARIGHTRP.menuid is ''菜单id''';
    EXECUTE IMMEDIATE 'comment on column HW_T_DATARIGHTRP.province is ''区划''';
    EXECUTE IMMEDIATE 'comment on column HW_T_DATARIGHTRP.year is ''年度''';
    EXECUTE IMMEDIATE 'comment on column HW_T_DATARIGHTRP.userguid is ''用户id''';
    EXECUTE IMMEDIATE 'alter table HW_T_DATARIGHTRP add constraint PK_HW_T_DATARIGHTRP_ID primary key (GUID)';
  END IF;
  V_SQL:=' INSERT INTO HW_T_DATARIGHTRP
SELECT guid || ''-'' || '''||p_province||''' || ''-''  || '''||p_business||''' guid,
       roleid,
       menuid,
       province,
       YEAR,
       userguid
  FROM p#fasp_t_datarightrp@'||p_dblink||' t
 WHERE t.province = '''||p_province||'''
   AND t.year = '''||p_year||'''
   AND EXISTS (SELECT 1
          FROM FASP_T_CAUSER@'||p_dblink||' FC
         WHERE FC.GUID = T.USERGUID)
   AND EXISTS (SELECT 1
          FROM FASP_T_PUBMENU@'||p_dblink||' FP
         WHERE FP.GUID = T.MENUID)
   AND (t.userguid, t.menuid) IN
       (SELECT userguid, menuid
          FROM P#FASP_T_DATARIGHTRP@'||p_dblink||'
         WHERE province = '''||p_province||'''
           AND YEAR = '''||p_year||'''
           AND USERGUID IS NOT NULL
         GROUP BY userguid, menuid)
   AND ROWID IN (SELECT MIN(ROWID)
                   FROM P#FASP_T_DATARIGHTRP@'||p_dblink||'
                  WHERE province = '''||p_province||'''
                    AND YEAR = '''||p_year||'''
                    AND USERGUID IS NOT NULL
                  GROUP BY userguid, menuid)
UNION ALL
SELECT guid || ''-'' || '''||p_province||''' || ''-''  || '''||p_business||''' guid,
       roleid,
       menuid,
       province,
       YEAR,
       userguid
  FROM p#fasp_t_datarightrp@'||p_dblink||' t
 WHERE t.province = '''||p_province||'''
   AND t.year = '''||p_year||'''
   AND EXISTS (SELECT 1
          FROM FASP_T_CAROLE@'||p_dblink||' FC
         WHERE FC.GUID = T.ROLEID)
   AND EXISTS (SELECT 1
          FROM FASP_T_PUBMENU@'||p_dblink||' FP
         WHERE FP.GUID = T.MENUID)
   AND (t.roleid, t.menuid) IN
       (SELECT roleid, menuid
          FROM P#FASP_T_DATARIGHTRP@'||p_dblink||'
         WHERE province = '''||p_province||'''
           AND YEAR = '''||p_year||'''
           AND roleid IS NOT NULL
         GROUP BY roleid, menuid)
   AND ROWID IN (SELECT MIN(ROWID)
                   FROM P#FASP_T_DATARIGHTRP@'||p_dblink||'
                  WHERE province = '''||p_province||'''
                    AND YEAR = '''||p_year||'''
                    AND roleid IS NOT NULL
                  GROUP BY roleid, menuid)
        ';
      dbms_output.put_line(V_SQL);
  EXECUTE IMMEDIATE V_SQL;
  COMMIT;
END;


CALL WRITE_TEMP_TABLE('320000000','2022','pdm','pdm_320000320000000');
