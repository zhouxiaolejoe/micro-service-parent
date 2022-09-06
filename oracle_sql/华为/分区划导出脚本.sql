--这个脚本中台库执行，通过dblink连接业务库
CREATE OR REPLACE PACKAGE DATA_PERMISSION AS
  TYPE DATA_PERMISSION_POJO_ONE IS RECORD(
    "relationId"         VARCHAR2(150),
    "privilegeId"        VARCHAR2(150),
    "privilegeCode"      VARCHAR2(150),
    "privilegeSubjectId" VARCHAR2(150),
    "targetId"           VARCHAR2(150),
    "targetType"         VARCHAR2(150),
    "authRelationType"   VARCHAR2(150),
    "privilegeType"      VARCHAR2(150),
    "description"        VARCHAR2(150),
    "regionCode"        VARCHAR2(150));
  TYPE DATA_PERMISSION_TABLE_ONE IS TABLE OF DATA_PERMISSION_POJO_ONE;
  TYPE DATA_PERMISSION_POJO_TWO IS RECORD(
    "privilegeId"         VARCHAR2(150),
    "privilegeCode"        VARCHAR2(150),
    "relationId"      VARCHAR2(150),
    "targetId" VARCHAR2(150),
    "targetType"           VARCHAR2(150),
    "factorValues"         VARCHAR2(4000),
    "authRelationType"   VARCHAR2(150),
    "privilegeType"      VARCHAR2(150),
    "elementDimensionValue"      VARCHAR2(150),
    "elementDimensionName"      VARCHAR2(150),
    "description"        VARCHAR2(150),
    "regionCode"        VARCHAR2(150));
  TYPE DATA_PERMISSION_TABLE_TWO IS TABLE OF DATA_PERMISSION_POJO_TWO;
  FUNCTION GET_ONE(p_province VARCHAR2,
                   p_year     VARCHAR2,
                   p_business VARCHAR2,
                   p_dblink   VARCHAR2) RETURN DATA_PERMISSION_TABLE_ONE
    PIPELINED;
  FUNCTION GET_TWO(p_province VARCHAR2,
                   p_year     VARCHAR2,
                   p_business VARCHAR2,
                   p_dblink   VARCHAR2) RETURN DATA_PERMISSION_TABLE_TWO
    PIPELINED;
  FUNCTION FACTOR_JSON (FACTORVALUES IN VARCHAR2,PROVINCE IN VARCHAR2,YEAR IN VARCHAR2,DBLINK IN VARCHAR2) RETURN  VARCHAR2; 
  PROCEDURE CLEAR_RUBBISH(PROVINCE IN VARCHAR2);
  PROCEDURE WRITE_TEMP_TABLE(p_province VARCHAR2,
                             p_year     VARCHAR2,
                             p_business VARCHAR2,
                             p_dblink   VARCHAR2);
  PROCEDURE WRITE_BGT(p_province VARCHAR2,
                      p_year     VARCHAR2,
                      p_dblink   VARCHAR2);
END DATA_PERMISSION;
/
CREATE OR REPLACE PACKAGE BODY DATA_PERMISSION AS

  PROCEDURE WRITE_BGT(p_province VARCHAR2,
                      p_year     VARCHAR2,
                      p_dblink   VARCHAR2) AS  
   V_SQL varchar2(1000); 
   v_sel varchar2(1000);
   TYPE REF_CURSOR_TYPE IS REF CURSOR;
   USER_NAME   VARCHAR2(50);
   USER_NAMES           REF_CURSOR_TYPE;
   N_CURSOR INTEGER;
   NUM_ROWS_PROCESSED INTEGER; 
   coun  number(38);                                                                      
  BEGIN
      v_sel:='select count(*) from user_tables@'||p_dblink||' where table_name = ''HW_T_DATARIGHTRP''';
      dbms_output.put_line(v_sel);
      execute immediate v_sel into coun;
      if coun < 1 then
        EXECUTE IMMEDIATE 'DECLARE N_CURSOR INTEGER;NUM_ROWS_PROCESSED INTEGER;P_STMT VARCHAR2(2000) := ''
         create table HW_T_DATARIGHTRP
          (
            guid     VARCHAR2(128) not null,
            roleid   VARCHAR2(32),
            menuid   VARCHAR2(32),
            province VARCHAR2(9) not null,
            year     CHAR(4) not null,
            userguid VARCHAR2(32)
          )
        '';
        BEGIN N_CURSOR := DBMS_SQL.OPEN_CURSOR@'||p_dblink||';
        DBMS_SQL.PARSE@'||p_dblink||'(N_CURSOR, P_STMT, DBMS_SQL.NATIVE) ;
        NUM_ROWS_PROCESSED := DBMS_SQL.EXECUTE@'||p_dblink||'(N_CURSOR) ;
        DBMS_SQL.CLOSE_CURSOR@'||p_dblink||'(N_CURSOR) ;
        END;';
        EXECUTE IMMEDIATE 'DECLARE N_CURSOR INTEGER;NUM_ROWS_PROCESSED INTEGER;P_STMT VARCHAR2(2000) := ''
          alter table HW_T_DATARIGHTRP add constraint PK_HW_T_DATARIGHTRP_ID primary key (GUID)
        '';
        BEGIN N_CURSOR := DBMS_SQL.OPEN_CURSOR@'||p_dblink||';
        DBMS_SQL.PARSE@'||p_dblink||'(N_CURSOR, P_STMT, DBMS_SQL.NATIVE) ;
        NUM_ROWS_PROCESSED := DBMS_SQL.EXECUTE@'||p_dblink||'(N_CURSOR) ;
        DBMS_SQL.CLOSE_CURSOR@'||p_dblink||'(N_CURSOR) ;
        END;';
        commit;
      end if;  
    V_SQL:='INSERT INTO HW_T_DATARIGHTRP@'||p_dblink||' SELECT * FROM HW_T_DATARIGHTRP WHERE PROVINCE ='''||p_province||''' AND YEAR ='''||p_year||'''
    ';
    
    EXECUTE IMMEDIATE V_SQL;
    COMMIT;
  END;

  PROCEDURE WRITE_TEMP_TABLE(p_province VARCHAR2,
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

  PROCEDURE CLEAR_RUBBISH(PROVINCE IN VARCHAR2) IS
    TYPE REF_CURSOR_TYPE IS REF CURSOR;
    USER_NAME   VARCHAR2(50);
    USER_NAMES           REF_CURSOR_TYPE;
    N_CURSOR INTEGER;
    NUM_ROWS_PROCESSED INTEGER;
    coun           number(38);
    I INTEGER;
    J INTEGER;
    H INTEGER;
    v_sql varchar2(4000);
    BEGIN
        OPEN USER_NAMES FOR 'SELECT T.USERNAME FROM FASP_T_SYNCDATABASE T WHERE T.PROVINCE = '''||PROVINCE||'''';
        LOOP
          FETCH USER_NAMES
            INTO USER_NAME;
          EXIT WHEN USER_NAMES%NOTFOUND;
          --创建表
          EXECUTE IMMEDIATE 'DECLARE N_CURSOR INTEGER;NUM_ROWS_PROCESSED INTEGER;P_STMT VARCHAR2(2000) := ''
            CREATE TABLE Datarightrp_''||to_char(SYSDATE,''yyyyMMddhh24miss'')||'' AS SELECT * FROM P#fasp_t_Datarightrp
            '';
            BEGIN N_CURSOR := DBMS_SQL.OPEN_CURSOR@'||USER_NAME||''||PROVINCE||';
            DBMS_SQL.PARSE@'||USER_NAME||''||PROVINCE||'(N_CURSOR, P_STMT, DBMS_SQL.NATIVE) ;
            NUM_ROWS_PROCESSED := DBMS_SQL.EXECUTE@'||USER_NAME||''||PROVINCE||'(N_CURSOR) ;
            DBMS_SQL.CLOSE_CURSOR@'||USER_NAME||''||PROVINCE||'(N_CURSOR) ;
            END;';
            dbms_output.put_line('【备份表完成】');
            EXECUTE IMMEDIATE 'DECLARE N_CURSOR INTEGER;NUM_ROWS_PROCESSED INTEGER;P_STMT VARCHAR2(2000) := ''
            DELETE FROM P#fasp_t_Datarightrp t WHERE t.roleid IS NULL AND t.userguid IS NULL
            '';
            BEGIN N_CURSOR := DBMS_SQL.OPEN_CURSOR@'||USER_NAME||''||PROVINCE||';
            DBMS_SQL.PARSE@'||USER_NAME||''||PROVINCE||'(N_CURSOR, P_STMT, DBMS_SQL.NATIVE) ;
            NUM_ROWS_PROCESSED := DBMS_SQL.EXECUTE@'||USER_NAME||''||PROVINCE||'(N_CURSOR) ;
            DBMS_SQL.CLOSE_CURSOR@'||USER_NAME||''||PROVINCE||'(N_CURSOR) ;
            END;';
            dbms_output.put_line('【清除业务系统库中数据权限重复数据用户角色id为空垃圾数据】');
            EXECUTE IMMEDIATE 'DECLARE N_CURSOR INTEGER;NUM_ROWS_PROCESSED INTEGER;P_STMT VARCHAR2(2000) := ''
            DELETE from P#fasp_t_Datarightrp t WHERE NOT EXISTS(SELECT 1 FROM FASP_T_DATARIGHT t2 WHERE t2.GUID=t.datarightid
            ) AND LENGTH(t.datarightid) =32
            '';
            BEGIN N_CURSOR := DBMS_SQL.OPEN_CURSOR@'||USER_NAME||''||PROVINCE||';
            DBMS_SQL.PARSE@'||USER_NAME||''||PROVINCE||'(N_CURSOR, P_STMT, DBMS_SQL.NATIVE) ;
            NUM_ROWS_PROCESSED := DBMS_SQL.EXECUTE@'||USER_NAME||''||PROVINCE||'(N_CURSOR) ;
            DBMS_SQL.CLOSE_CURSOR@'||USER_NAME||''||PROVINCE||'(N_CURSOR) ;
            END;';
            dbms_output.put_line('【删除数据库中不存在的数据权限关系】');
            EXECUTE IMMEDIATE 'DECLARE N_CURSOR INTEGER;NUM_ROWS_PROCESSED INTEGER;P_STMT VARCHAR2(2000) := ''
            DELETE FROM P#fasp_t_Datarightrp WHERE (guid,province,YEAR) IN (SELECT guid,province,YEAR FROM 
            P#fasp_t_Datarightrp GROUP BY guid,province,YEAR HAVING COUNT(guid) > 1) AND ROWID NOT IN
            (SELECT MIN(ROWID) FROM P#fasp_t_Datarightrp GROUP BY guid,province,YEAR HAVING COUNT(*) > 1)
            '';
            BEGIN N_CURSOR := DBMS_SQL.OPEN_CURSOR@'||USER_NAME||''||PROVINCE||';
            DBMS_SQL.PARSE@'||USER_NAME||''||PROVINCE||'(N_CURSOR, P_STMT, DBMS_SQL.NATIVE) ;
            NUM_ROWS_PROCESSED := DBMS_SQL.EXECUTE@'||USER_NAME||''||PROVINCE||'(N_CURSOR) ;
            DBMS_SQL.CLOSE_CURSOR@'||USER_NAME||''||PROVINCE||'(N_CURSOR) ;
            END;';
            dbms_output.put_line('【删除guid重复的数据权限关系】');
            EXECUTE IMMEDIATE 'DECLARE N_CURSOR INTEGER;NUM_ROWS_PROCESSED INTEGER;P_STMT VARCHAR2(2000) := ''
            DELETE FROM P#fasp_t_Datarightrp WHERE (roleid,menuid,datarightid,province,YEAR) IN 
            (SELECT roleid,menuid,datarightid,province,YEAR FROM 
            P#fasp_t_Datarightrp GROUP BY roleid,menuid,datarightid,province,YEAR HAVING COUNT(guid) > 1) AND ROWID NOT IN
            (SELECT MIN(ROWID) FROM P#fasp_t_Datarightrp GROUP BY roleid,menuid,datarightid,province,YEAR HAVING COUNT(*) > 1)
            '';
            BEGIN N_CURSOR := DBMS_SQL.OPEN_CURSOR@'||USER_NAME||''||PROVINCE||';
            DBMS_SQL.PARSE@'||USER_NAME||''||PROVINCE||'(N_CURSOR, P_STMT, DBMS_SQL.NATIVE) ;
            NUM_ROWS_PROCESSED := DBMS_SQL.EXECUTE@'||USER_NAME||''||PROVINCE||'(N_CURSOR) ;
            DBMS_SQL.CLOSE_CURSOR@'||USER_NAME||''||PROVINCE||'(N_CURSOR) ;
            END;';
            dbms_output.put_line('【删除重复角色数据权限关系】');
            EXECUTE IMMEDIATE 'DECLARE N_CURSOR INTEGER;NUM_ROWS_PROCESSED INTEGER;P_STMT VARCHAR2(2000) := ''
            DELETE FROM P#fasp_t_Datarightrp WHERE (userguid,menuid,datarightid,province,YEAR) IN 
            (SELECT userguid,menuid,datarightid,province,YEAR FROM 
            P#fasp_t_Datarightrp GROUP BY userguid,menuid,datarightid,province,YEAR HAVING COUNT(guid) > 1) AND ROWID NOT IN
            (SELECT MIN(ROWID) FROM P#fasp_t_Datarightrp GROUP BY userguid,menuid,datarightid,province,YEAR HAVING COUNT(*) > 1)
            '';
            BEGIN N_CURSOR := DBMS_SQL.OPEN_CURSOR@'||USER_NAME||''||PROVINCE||';
            DBMS_SQL.PARSE@'||USER_NAME||''||PROVINCE||'(N_CURSOR, P_STMT, DBMS_SQL.NATIVE) ;
            NUM_ROWS_PROCESSED := DBMS_SQL.EXECUTE@'||USER_NAME||''||PROVINCE||'(N_CURSOR) ;
            DBMS_SQL.CLOSE_CURSOR@'||USER_NAME||''||PROVINCE||'(N_CURSOR) ;
            END;';
            dbms_output.put_line('【删除重复用户数据权限关系】');
            EXECUTE IMMEDIATE 'DECLARE N_CURSOR INTEGER;NUM_ROWS_PROCESSED INTEGER;P_STMT VARCHAR2(2000) := ''
            DELETE from p#fasp_t_datarightrp t WHERE t.roleid IS NOT NULL AND NOT EXISTS(SELECT 1 FROM 
            fasp_t_carole fcr WHERE fcr.guid=t.roleid)
            '';
            BEGIN N_CURSOR := DBMS_SQL.OPEN_CURSOR@'||USER_NAME||''||PROVINCE||';
            DBMS_SQL.PARSE@'||USER_NAME||''||PROVINCE||'(N_CURSOR, P_STMT, DBMS_SQL.NATIVE) ;
            NUM_ROWS_PROCESSED := DBMS_SQL.EXECUTE@'||USER_NAME||''||PROVINCE||'(N_CURSOR) ;
            DBMS_SQL.CLOSE_CURSOR@'||USER_NAME||''||PROVINCE||'(N_CURSOR) ;
            END;';
            dbms_output.put_line('【删除角色id无效数据权限关系】');
            EXECUTE IMMEDIATE 'DECLARE N_CURSOR INTEGER;NUM_ROWS_PROCESSED INTEGER;P_STMT VARCHAR2(2000) := ''
            DELETE from p#fasp_t_datarightrp t WHERE t.userguid IS NOT NULL AND NOT EXISTS(SELECT 1 
            FROM fasp_t_causer fcr WHERE fcr.guid=t.userguid)
            '';
            BEGIN N_CURSOR := DBMS_SQL.OPEN_CURSOR@'||USER_NAME||''||PROVINCE||';
            DBMS_SQL.PARSE@'||USER_NAME||''||PROVINCE||'(N_CURSOR, P_STMT, DBMS_SQL.NATIVE) ;
            NUM_ROWS_PROCESSED := DBMS_SQL.EXECUTE@'||USER_NAME||''||PROVINCE||'(N_CURSOR) ;
            DBMS_SQL.CLOSE_CURSOR@'||USER_NAME||''||PROVINCE||'(N_CURSOR) ;
            END;';
            dbms_output.put_line('【删除用户id无效数据权限关系】');
            EXECUTE IMMEDIATE 'DECLARE N_CURSOR INTEGER;NUM_ROWS_PROCESSED INTEGER;P_STMT VARCHAR2(2000) := ''
            DELETE from p#fasp_t_datarightrp t WHERE NOT EXISTS(SELECT 1 FROM fasp_t_pubmenu fpb WHERE fpb.guid=t.menuid)
            '';
            BEGIN N_CURSOR := DBMS_SQL.OPEN_CURSOR@'||USER_NAME||''||PROVINCE||';
            DBMS_SQL.PARSE@'||USER_NAME||''||PROVINCE||'(N_CURSOR, P_STMT, DBMS_SQL.NATIVE) ;
            NUM_ROWS_PROCESSED := DBMS_SQL.EXECUTE@'||USER_NAME||''||PROVINCE||'(N_CURSOR) ;
            DBMS_SQL.CLOSE_CURSOR@'||USER_NAME||''||PROVINCE||'(N_CURSOR) ;
            END;';
            dbms_output.put_line('【删除菜单id无效数据权限关系】');
            EXECUTE IMMEDIATE 'DECLARE N_CURSOR INTEGER;NUM_ROWS_PROCESSED INTEGER;P_STMT VARCHAR2(2000) := ''
            DELETE from p#fasp_t_datarightrp t WHERE length(t.datarightid)=32 and  
            NOT EXISTS(SELECT 1 FROM P#FASP_T_DATARIGHTRP fpb WHERE fpb.guid=t.datarightid)
            '';
            BEGIN N_CURSOR := DBMS_SQL.OPEN_CURSOR@'||USER_NAME||''||PROVINCE||';
            DBMS_SQL.PARSE@'||USER_NAME||''||PROVINCE||'(N_CURSOR, P_STMT, DBMS_SQL.NATIVE) ;
            NUM_ROWS_PROCESSED := DBMS_SQL.EXECUTE@'||USER_NAME||''||PROVINCE||'(N_CURSOR) ;
            DBMS_SQL.CLOSE_CURSOR@'||USER_NAME||''||PROVINCE||'(N_CURSOR) ;
            END;';
            dbms_output.put_line('【删除数据权限id无效数据权限关系】');
            dbms_output.put_line('【清除垃圾数据完成】');
         END LOOP; 
    END;

  FUNCTION FACTOR_JSON (FACTORVALUES IN VARCHAR2,PROVINCE IN VARCHAR2,YEAR IN VARCHAR2,DBLINK IN VARCHAR2) RETURN  VARCHAR2 IS
    I integer;
    DGUID VARCHAR2(50);
    DNAME VARCHAR2(50);
    JSON VARCHAR2(4000);
    cursor b_cursor(DATARIGHTID string ) is
      (select regexp_substr(DATARIGHTID,'[^,]+', 1, level) DATARIGHTID from dual
      connect by regexp_substr(DATARIGHTID, '[^,]+', 1, level) is not NULL);
  BEGIN
          JSON:='[';
          for b_cur in b_cursor(factorValues) loop
           EXECUTE IMMEDIATE 'SELECT COUNT(1) FROM p#FASP_T_DATARIGHT@'||DBLINK||' t WHERE t.province = '''||province||''' and t.year = '''||YEAR||''' AND t.GUID = '''||b_cur.DATARIGHTID||'''' INTO I;
           IF I > 0 THEN
 --            SELECT t.GUID,t.NAME INTO DGUID,DNAME FROM FASP_T_DATARIGHT@pdm_320000320000000 t WHERE t.GUID = b_cur.DATARIGHTID;
             EXECUTE IMMEDIATE 'SELECT t.GUID,t.NAME FROM p#FASP_T_DATARIGHT@'||DBLINK||' t WHERE t.province = '''||province||''' and t.year = '''||YEAR||''' AND t.GUID = '''||b_cur.DATARIGHTID||'''' INTO DGUID,DNAME;
             JSON:=JSON||'"{\"factorName\": \"'||DNAME||'\",\"factorValue\": \"'||DGUID||'\",\"factorCode\": \"factorCode\"}",';
           ELSE 
            JSON:=JSON||'"{\"factorName\": \"'||
             CASE b_cur.DATARIGHTID 
               WHEN 'alldatarignt' THEN '所有权限'
               WHEN 'localagencydatarignt' THEN '本级权限'
               WHEN 'loweragencydatarignt' THEN '下级权限'
               WHEN 'finintorg' THEN '处室权限'
               WHEN 'paymentbank' THEN '开户行本行' END
                 
             ||'\",\"factorValue\": \"'||b_cur.DATARIGHTID||'\",\"factorCode\": \"factorCode\"}",';
           END IF; 
          end loop;
          JSON:=substr(JSON,0,LENGTH(JSON)-1);
          JSON:=JSON||']';
          RETURN JSON;
  END;


  FUNCTION GET_ONE(p_province VARCHAR2,
                          p_year     VARCHAR2,
                          p_business VARCHAR2,
                          p_dblink   VARCHAR2) RETURN DATA_PERMISSION_TABLE_ONE
    PIPELINED IS
    DATA_PERMISSION_RESULT DATA_PERMISSION_POJO_ONE;
    V_SQL varchar2(8000);
    TYPE DATA_ACCESS_TYPE IS REF CURSOR;
    MY_DATA_CURSOR DATA_ACCESS_TYPE;
  BEGIN
    V_SQL := ' 
      SELECT *
               FROM (( SELECT t.guid || ''-'' || '''||p_province||''' || ''-''  || '''||p_business||''' || ''-1''  "relationId",
                        t.MENUID "privilegeId",
                        t.MENUID "privilegeCode",
                        (SELECT fp.appid
                           FROM fasp_t_pubmenu@'||p_dblink||' fp
                          WHERE fp.guid = t.menuid
                            AND rownum = 1) "privilegeSubjectId",
                        CASE
                          WHEN t.ROLEID IS NULL THEN
                           t.USERGUID
                          ELSE
                           t.ROLEID
                        END "targetId",
                        CASE
                          WHEN t.ROLEID IS NULL THEN
                           ''1''
                          ELSE
                           ''2''
                        END "targetType",
                        ''1'' "authRelationType",
                        ''1'' "privilegeType",
                        '''' "description",
                        t.province "regionCode"
                   FROM P#FASP_T_DATARIGHTRP@'||p_dblink||' t
                  WHERE t.roleid IS NOT NULL
                    AND EXISTS (SELECT 1 FROM FASP_T_CAROLE@'||p_dblink||' FC WHERE FC.GUID = T.ROLEID)
                    AND EXISTS (SELECT 1 FROM FASP_T_PUBMENU@'||p_dblink||' FP WHERE FP.GUID = T.MENUID)
                    AND t.year = '''||p_year||'''
                    AND t.province = '''||p_province||'''
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
                                   GROUP BY roleid, menuid)) UNION ALL
                (SELECT t.guid || ''-'' || '''||p_province||''' || ''-''  || '''||p_business||''' || ''-1''  "relationId",
                        t.MENUID "privilegeId",
                        t.MENUID "privilegeCode",
                        (SELECT fp.appid
                           FROM fasp_t_pubmenu@'||p_dblink||' fp
                          WHERE fp.guid = t.menuid
                            AND rownum = 1) "privilegeSubjectId",
                        CASE
                          WHEN t.ROLEID IS NULL THEN
                           t.USERGUID
                          ELSE
                           t.ROLEID
                        END "targetId",
                        CASE
                          WHEN t.ROLEID IS NULL THEN
                           ''1''
                          ELSE
                           ''2''
                        END "targetType",
                        ''1'' "authRelationType",
                        ''1'' "privilegeType",                      
                        '''' "description",
                        t.province "regionCode"
                   FROM P#FASP_T_DATARIGHTRP@'||p_dblink||' t
                  WHERE t.USERGUID IS NOT NULL
                    AND EXISTS (SELECT 1 FROM FASP_T_CAUSER@'||p_dblink||' FC WHERE FC.GUID = T.USERGUID)
                    AND EXISTS (SELECT 1 FROM FASP_T_PUBMENU @'||p_dblink||' FP WHERE FP.GUID = T.MENUID)
                    AND t.year = '''||p_year||'''
                    AND t.province = '''||p_province||'''
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
                                   GROUP BY userguid, menuid)))
  ';
      dbms_output.put_line(V_SQL);

  open MY_DATA_CURSOR for V_SQL;
  loop
    fetch MY_DATA_CURSOR into DATA_PERMISSION_RESULT;
    exit when MY_DATA_CURSOR%notfound;
    pipe row(DATA_PERMISSION_RESULT);
  end loop;
  close MY_DATA_CURSOR;
  return;
  END;

  FUNCTION GET_TWO(p_province VARCHAR2,
                  p_year     VARCHAR2,
                  p_business VARCHAR2,
                  p_dblink   VARCHAR2) RETURN DATA_PERMISSION_TABLE_TWO
    PIPELINED IS
    DATA_PERMISSION_RESULT_TWO DATA_PERMISSION_POJO_TWO;
    V_SQL varchar2(8000);
    TYPE DATA_ACCESS_TYPE IS REF CURSOR;
    MY_DATA_CURSOR DATA_ACCESS_TYPE;
  BEGIN
    V_SQL := '
    
    SELECT *
  FROM ((SELECT NVL((SELECT appid
                      FROM p#fasp_t_dataright@'||p_dblink||'
                     WHERE GUID = t.datarightid and province = t.province and year = t.year),
                    '''||p_business||''') "privilegeId",
                NVL((SELECT appid
                      FROM p#fasp_t_dataright@'||p_dblink||'
                     WHERE GUID = t.datarightid and province = t.province and year = t.year),
                    '''||p_business||''') "privilegeCode",
                 CASE
                  WHEN t.ROLEID IS NULL THEN
                   t.userguid || ''-'' || t.menuid || ''-'' || t.province || ''-1'' || ''-'' ||
                   NVL((SELECT appid
                         FROM p#fasp_t_dataright@'||p_dblink||'
                        WHERE GUID = t.datarightid and province = t.province and year = t.year),
                       '''||p_business||''') || ''-2''
                  ELSE
                   t.roleid || ''-'' || t.menuid || ''-'' || t.province || ''-2'' || ''-'' ||
                   NVL((SELECT appid
                         FROM p#fasp_t_dataright@'||p_dblink||'
                        WHERE GUID = t.datarightid and province = t.province and year = t.year),
                       '''||p_business||''') || ''-2''
                END "relationId",
                t.guid || ''-'' || '''||p_province||''' || ''-''  || '''||p_business||''' || ''-1''  "targetId",
                ''3'' targetType,
                DATA_PERMISSION.FACTOR_JSON((SELECT listagg(T5.DATARIGHTID, '','') WITHIN GROUP(ORDER BY T5.DATARIGHTID) factorValues
                              FROM P#FASP_T_DATARIGHTRP@'||p_dblink||' T5
                             WHERE T.ROLEID IS NOT NULL
                               AND t5.province = '''||p_province||'''
                               AND t5.year = '''||p_year||'''
                               AND (T5.ROLEID, T5.MENUID) IN
                                   (SELECT T.ROLEID, T.MENUID FROM dual)
                             GROUP BY T5.ROLEID, T5.MENUID),T.PROVINCE,T.YEAR,'''||p_dblink||''') "factorValues",
                ''1'' "authRelationType",
                ''2'' "privilegeType",
                T.YEAR "elementDimensionValue",
                T.YEAR || ''财年''  "elementDimensionName",
                '''' "description",
                t.province "regionCode"
           FROM P#FASP_T_DATARIGHTRP@'||p_dblink||' t
          WHERE T.ROLEID IS NOT NULL
            AND EXISTS (SELECT 1 FROM FASP_T_CAROLE@'||p_dblink||' FC WHERE FC.GUID = T.ROLEID)
            AND EXISTS (SELECT 1 FROM FASP_T_PUBMENU@'||p_dblink||' FP WHERE FP.GUID = T.MENUID)
            AND t.year = '''||p_year||'''
            AND t.province = '''||p_province||'''
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
                           GROUP BY roleid, menuid)) UNION ALL
        (SELECT NVL((SELECT appid
                      FROM p#fasp_t_dataright@'||p_dblink||'
                     WHERE GUID = t.datarightid and province = t.province and year = t.year),
                    '''||p_business||''') "privilegeId",
                NVL((SELECT appid
                      FROM p#fasp_t_dataright@'||p_dblink||'
                     WHERE GUID = t.datarightid and province = t.province and year = t.year),
                    '''||p_business||''') "privilegeCode",
                 CASE
                  WHEN t.ROLEID IS NULL THEN
                   t.userguid || ''-'' || t.menuid || ''-'' || t.province || ''-1'' || ''-'' ||
                   NVL((SELECT appid
                         FROM P#fasp_t_dataright@'||p_dblink||'
                        WHERE GUID = t.datarightid and province = t.province and year = t.year),
                       '''||p_business||''') || ''-2''
                  ELSE
                   t.roleid || ''-'' || t.menuid || ''-'' || t.province || ''-2'' || ''-'' ||
                   NVL((SELECT appid
                         FROM p#fasp_t_dataright@'||p_dblink||'
                        WHERE GUID = t.datarightid and province = t.province and year = t.year),
                       '''||p_business||''') || ''-2''
                END "relationId",
                t.guid || ''-'' || '''||p_province||''' || ''-''  || '''||p_business||''' || ''-1''  "targetId",
                ''3'' targetType,
                DATA_PERMISSION.FACTOR_JSON((SELECT listagg(T5.DATARIGHTID, '','') WITHIN GROUP(ORDER BY T5.DATARIGHTID) factorValues
                              FROM P#FASP_T_DATARIGHTRP@'||p_dblink||' T5
                             WHERE T.USERGUID IS NOT NULL
                               AND t5.province = '''||p_province||'''
                               AND t5.year = '''||p_year||'''
                               AND (T5.USERGUID, T5.MENUID) IN
                                   (SELECT T.USERGUID, T.MENUID FROM dual)
                             GROUP BY T5.USERGUID, T5.MENUID),T.PROVINCE,T.YEAR,'''||p_dblink||''') "factorValues",
                ''1'' "authRelationType",
                ''2'' "privilegeType",
                T.YEAR "elementDimensionValue",
                T.YEAR || ''财年''  "elementDimensionName",
                '''' "description",
                t.province "regionCode"
           FROM P#FASP_T_DATARIGHTRP@'||p_dblink||' t
          WHERE t.USERGUID IS NOT NULL
            AND EXISTS (SELECT 1 FROM FASP_T_CAUSER@'||p_dblink||' FC WHERE FC.GUID = T.USERGUID)
            AND EXISTS (SELECT 1 FROM FASP_T_PUBMENU@'||p_dblink||' FP WHERE FP.GUID = T.MENUID)
            AND t.year = '''||p_year||'''
            AND t.province = '''||p_province||'''
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
                           GROUP BY userguid, menuid)))
    
  ';
  open MY_DATA_CURSOR for V_SQL;
  loop
    fetch MY_DATA_CURSOR into DATA_PERMISSION_RESULT_TWO;
    exit when MY_DATA_CURSOR%notfound;
    pipe row(DATA_PERMISSION_RESULT_TWO);
  end loop;
  close MY_DATA_CURSOR;
  return;
  END;
END DATA_PERMISSION;
/
--功能：清除传入区划编码各个业务库中数据权限垃圾数据
--参数解释：第一个参数：区划编码
CALL DATA_PERMISSION.CLEAR_RUBBISH('320000000');


--功能：创建临时表 插入临时表数据
--说明：注意需要将所有业务库数据都抽取到中台  才能执行【抽取权限零时数据到省本级预算库】这个方法
--参数解释：第一个参数：区划编码，第二个参数：年度 第三个参数：业务标识 例如:pdm,bdm,bim,pmkpi) 第四个参数dblink名称
CALL DATA_PERMISSION.WRITE_TEMP_TABLE('320000000','2022','pdm','pdm_320000320000000');

--功能：抽取权限零时数据到省本级预算库
--说明：注意这个脚本是向省本级预算库写入全区划的数据
--参数解释：第一个参数：区划编码，第二个参数：年度 第三个参数：dblink名称 这个固定写省本级预算库dblink名称
CALL DATA_PERMISSION.WRITE_BGT('320000000','2022','bgt_320000320000000');


--功能：查询第一次数据权限数据 
--参数解释：第一个参数：区划编码，第二个参数：年度 第三个参数：业务标识 例如:pdm,bdm,bim,pmkpi) 第四个参数dblink名称
SELECT * FROM TABLE(DATA_PERMISSION.GET_ONE('320000000','2022','pdm','pdm_320000320000000'));


--功能：查询第二次数据权限数据
--参数解释：第一个参数：区划编码，第二个参数：年度 第三个参数：业务标识 例如:pdm,bdm,bim,pmkpi) 第四个参数dblink名称
SELECT * FROM TABLE(DATA_PERMISSION.GET_TWO('320000000','2022','pdm','pdm_320000320000000'));

