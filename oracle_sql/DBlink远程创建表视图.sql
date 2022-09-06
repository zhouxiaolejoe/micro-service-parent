CREATE OR REPLACE PROCEDURE SYNC_NEW_TABLE_INFO (TABLE_CODE IN VARCHAR2,PROVINCE IN VARCHAR2) AS
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
    OPEN USER_NAMES FOR 'SELECT T.USERNAME FROM FASP_T_SYNCDATABASE T WHERE T.PROVINCE = ''' || PROVINCE || '''';
    LOOP
      FETCH USER_NAMES
        INTO USER_NAME;
      EXIT WHEN USER_NAMES%NOTFOUND;
      v_sql:='select count(*) from user_tables@'||USER_NAME||''||PROVINCE||' where table_name = UPPER('''||TABLE_CODE||''')';
      execute immediate v_sql into coun;
      if coun > 0 then
        EXECUTE IMMEDIATE 'DECLARE N_CURSOR INTEGER;NUM_ROWS_PROCESSED INTEGER;P_STMT VARCHAR2(2000) := ''
        drop TABLE '||TABLE_CODE||' purge'';
        BEGIN N_CURSOR := DBMS_SQL.OPEN_CURSOR@'||USER_NAME||''||PROVINCE||';
        DBMS_SQL.PARSE@'||USER_NAME||''||PROVINCE||'(N_CURSOR, P_STMT, DBMS_SQL.NATIVE) ;
        NUM_ROWS_PROCESSED := DBMS_SQL.EXECUTE@'||USER_NAME||''||PROVINCE||'(N_CURSOR) ;
        DBMS_SQL.CLOSE_CURSOR@'||USER_NAME||''||PROVINCE||'(N_CURSOR) ;
        END;';
        commit;
      end if;
      --创建表
      EXECUTE IMMEDIATE 'DECLARE N_CURSOR INTEGER;NUM_ROWS_PROCESSED INTEGER;P_STMT VARCHAR2(2000) := ''
        CREATE TABLE '||TABLE_CODE||'(
        ADMDIV           VARCHAR2(50),
        ELE_CATALOG_ID   VARCHAR2(38) NOT NULL,
        ELE_CATALOG_CODE VARCHAR2(38),
        ELE_ID           VARCHAR2(38) NOT NULL,
        FISCAL_YEAR      VARCHAR2(4),
        MOF_DIV_CODE     VARCHAR2(9) NOT NULL,
        LEVEL_NO         NUMBER(2) NOT NULL,
        IS_LEAF          NUMBER(1) NOT NULL,
        START_DATE       DATE NOT NULL,
        END_DATE         DATE NOT NULL,
        IS_ENABLED       NUMBER(1) NOT NULL,
        UPDATE_TIME      DATE NOT NULL,
        ELE_CODE         VARCHAR2(20) NOT NULL,
        ELE_NAME         VARCHAR2(100) NOT NULL,
        IS_DELETED       NUMBER(1) NOT NULL,
        PARENT_ID        VARCHAR2(38) NOT NULL,
        IS_STANDARD      NUMBER(1) NOT NULL,
        CREATE_TIME      DATE NOT NULL,
        REMARK           VARCHAR2(200),
        ISNORMVERSION    CHAR(1) default 2)'';
        BEGIN N_CURSOR := DBMS_SQL.OPEN_CURSOR@'||USER_NAME||''||PROVINCE||';
        DBMS_SQL.PARSE@'||USER_NAME||''||PROVINCE||'(N_CURSOR, P_STMT, DBMS_SQL.NATIVE) ;
        NUM_ROWS_PROCESSED := DBMS_SQL.EXECUTE@'||USER_NAME||''||PROVINCE||'(N_CURSOR) ;
        DBMS_SQL.CLOSE_CURSOR@'||USER_NAME||''||PROVINCE||'(N_CURSOR) ;
        END;';
        --创建视图
        EXECUTE IMMEDIATE 'DECLARE N_CURSOR INTEGER;NUM_ROWS_PROCESSED INTEGER;P_STMT VARCHAR2(2000) := ''
       CREATE OR REPLACE VIEW V_'||TABLE_CODE||' AS
       SELECT (SELECT ELE_ID FROM ELE_VD08001 A WHERE  A.ELE_CODE = GLOBAL_MULTYEAR_CZ.SECU_F_GLOBAL_PARM(''''DIVID'''')
       AND A.FISCAL_YEAR = GLOBAL_MULTYEAR_CZ.SECU_F_GLOBAL_PARM(''''YEAR'''')) AS ADMDIV ,
       T.ELE_CATALOG_ID,
       T.ELE_CATALOG_CODE,
       T.ELE_CODE AS GUID,
       T.FISCAL_YEAR AS YEAR,
       GLOBAL_MULTYEAR_CZ.SECU_F_GLOBAL_PARM(''''DIVID'''') AS PROVINCE,
       T.LEVEL_NO AS LEVELNO,
       CASE WHEN T.IS_LEAF = 1 THEN 1 WHEN T.IS_LEAF = 2 THEN 0 WHEN T.IS_LEAF = 0 THEN 0 END ISLEAF,
       T.START_DATE,
       T.END_DATE,
       CASE WHEN T.IS_ENABLED = 1 THEN ''''1'''' WHEN T.IS_ENABLED = 2 AND T.IS_DELETED= 2 THEN ''''2''''  WHEN  T.IS_ENABLED = 2 AND T.IS_DELETED= 1 THEN ''''3''''
          END STATUS,
       T.UPDATE_TIME,
       T.ELE_CODE AS CODE,
       T.ELE_NAME AS NAME,
       T.IS_DELETED,
       (SELECT ELE_CODE FROM '||TABLE_CODE||' T1
       WHERE  T.PARENT_ID = T1.ELE_ID AND  T1.MOF_DIV_CODE = GLOBAL_MULTYEAR_CZ.SECU_F_GLOBAL_PARM(''''DIVID'''')
       AND T1.FISCAL_YEAR = GLOBAL_MULTYEAR_CZ.SECU_F_GLOBAL_PARM(''''YEAR'''')) AS SUPERGUID,
       T.IS_STANDARD,
       '''''''' AS  PINYIN,
       T.CREATE_TIME
       FROM '||TABLE_CODE||' T
       WHERE
       T.IS_DELETED = 2 AND T.IS_ENABLED = 1 AND
       T.MOF_DIV_CODE = GLOBAL_MULTYEAR_CZ.SECU_F_GLOBAL_PARM(''''DIVID'''')
       AND T.FISCAL_YEAR = GLOBAL_MULTYEAR_CZ.SECU_F_GLOBAL_PARM(''''YEAR'''')'';
       BEGIN N_CURSOR := DBMS_SQL.OPEN_CURSOR@'||USER_NAME||''||PROVINCE||';
       DBMS_SQL.PARSE@'||USER_NAME||''||PROVINCE||'(N_CURSOR, P_STMT, DBMS_SQL.NATIVE) ;
       NUM_ROWS_PROCESSED := DBMS_SQL.EXECUTE@'||USER_NAME||''||PROVINCE||'(N_CURSOR) ;
       DBMS_SQL.CLOSE_CURSOR@'||USER_NAME||''||PROVINCE||'(N_CURSOR) ;
       END;';
   END LOOP;
   SELECT COUNT (1) INTO H FROM USER_TABLES T WHERE T.TABLE_NAME =TABLE_CODE;
   IF H > 0 THEN
       --向同步表增加同步记录
       SELECT COUNT (1) INTO J FROM FASP_SYNC_TABLE T WHERE T.TABLECODE =''''||TABLE_CODE||'''' AND T.PROVINCE =''''|| PROVINCE||'''';
       IF J < 1 THEN
          EXECUTE IMMEDIATE 'INSERT INTO FASP_SYNC_TABLE (TABLECODE, PROVINCE, SRCVERSION, DESVERSION)VALUES('''||TABLE_CODE||''', '''||PROVINCE||''', ''1'', ''0'')';
       END IF;
       COMMIT;
       --创建新增表的触发器
       /**SELECT COUNT (1) INTO I FROM USER_TRIGGERS T WHERE T.TRIGGER_NAME ='TR_'||TABLE_CODE||'_SYNC';
       IF I < 1 THEN
        EXECUTE IMMEDIATE 'CREATE OR REPLACE TRIGGER TR_'||TABLE_CODE||'_SYNC AFTER INSERT OR UPDATE OR DELETE ON '||TABLE_CODE||' FOR EACH ROW
         BEGIN
          IF INSERTING OR UPDATING THEN
              UPDATE FASP_SYNC_TABLE T SET T.SRCVERSION = (T.SRCVERSION + 1) WHERE T.TABLECODE = '''||TABLE_CODE||''' AND T.PROVINCE = :NEW.MOF_DIV_CODE;
          ELSE
              UPDATE FASP_SYNC_TABLE T SET T.SRCVERSION = (T.SRCVERSION + 1) WHERE T.TABLECODE = '''||TABLE_CODE||''' AND T.PROVINCE = :OLD.MOF_DIV_CODE;
          END IF;
         END;';
       END IF;
       COMMIT;**/
       
       SELECT COUNT (1) INTO I FROM USER_TRIGGERS T WHERE T.TRIGGER_NAME ='TRI_'||TABLE_CODE||'_EASY';
        IF I < 1 THEN
        EXECUTE IMMEDIATE '
          CREATE OR REPLACE TRIGGER TRI_'||TABLE_CODE||'_EASY
          AFTER INSERT OR UPDATE OR DELETE ON '||TABLE_CODE||'
          FOR EACH ROW
            DECLARE  TYPE REF_CURSOR_TYPE IS REF CURSOR;
            PARTITION_CODES REF_CURSOR_TYPE;
            PARTITION_CODE VARCHAR(100);
            V_PROVINCE VARCHAR(100);
            BEGIN
              IF INSERTING OR UPDATING THEN
                 V_PROVINCE:=:NEW.MOF_DIV_CODE;
              ELSE
                V_PROVINCE:=:OLD.MOF_DIV_CODE;
              END IF;

              IF V_PROVINCE = ''109900000'' THEN
                OPEN PARTITION_CODES FOR ''select t.province from FASP_SYNC_TABLE t group by t.province'';
                LOOP
                  FETCH PARTITION_CODES INTO PARTITION_CODE;
                  EXIT WHEN PARTITION_CODES%NOTFOUND;
                  DELETE FROM FASP_SYNC_TABLE WHERE TABLECODE='''||TABLE_CODE||''' AND PROVINCE=PARTITION_CODE;
                  INSERT INTO FASP_SYNC_TABLE(TABLECODE, PROVINCE, SRCVERSION, DESVERSION,ADDCATALOG)
                  SELECT '''||TABLE_CODE||''',PARTITION_CODE, 0, 1, 1 FROM DUAL;
                END LOOP;
              ELSE
                DELETE FROM FASP_SYNC_TABLE WHERE TABLECODE='''||TABLE_CODE||''' AND PROVINCE=V_PROVINCE;
                INSERT INTO FASP_SYNC_TABLE(TABLECODE, PROVINCE, SRCVERSION, DESVERSION,ADDCATALOG)
                SELECT '''||TABLE_CODE||''',V_PROVINCE, 0, 1, 1 FROM DUAL;
              END IF;
            END;';
        END IF;
        COMMIT;
   END IF;
END;
