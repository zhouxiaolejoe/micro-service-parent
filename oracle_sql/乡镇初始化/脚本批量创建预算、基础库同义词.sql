-- Created on 2022/8/12 by ADMINISTRATOR
DECLARE
TYPE REF_CURSOR_TYPE IS REF CURSOR;
    USER_NAME   VARCHAR2(50);
    PROVINCE    VARCHAR2(50);
    BAS_USER_NAME   VARCHAR2(50);
    USER_NAMES           REF_CURSOR_TYPE;
    N_CURSOR INTEGER;
    NUM_ROWS_PROCESSED INTEGER;
    coun           number(38);
    I INTEGER;
    J INTEGER;
    H INTEGER;
    syncdatabase_sql varchar2(400);
    bas_sql varchar2(400);
    v_sql varchar2(4000);
BEGIN
      syncdatabase_sql:='SELECT T.USERNAME,T.PROVINCE FROM FASP_T_SYNCDATABASE T WHERE T.Username LIKE ''BGT%'' or T.Username LIKE ''bgt%'' AND province IN(SELECT ele_code FROM ele_vd08001_town)' ;
OPEN USER_NAMES FOR syncdatabase_sql;
LOOP
FETCH USER_NAMES INTO USER_NAME,PROVINCE;
        EXIT WHEN USER_NAMES%NOTFOUND;
        dbms_output.put_line(syncdatabase_sql);
        bas_sql:='SELECT username FROM FASP_T_SYNCDATABASE T WHERE (T.Username LIKE ''BAS%'' or T.Username LIKE ''bas%'') AND T.province='||PROVINCE||'';
        dbms_output.put_line(bas_sql);
EXECUTE IMMEDIATE bas_sql INTO BAS_USER_NAME;
v_sql:='
        declare
          i integer;
        begin
          init_synonym_create@'||USER_NAME||''||PROVINCE||'('''||BAS_USER_NAME||''');
        end;
        ';
          dbms_output.put_line(v_sql);
EXECUTE IMMEDIATE v_sql;
END LOOP;
END;
