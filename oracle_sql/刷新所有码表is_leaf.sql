--1.刷新所有码表IS_LEAF
CREATE OR REPLACE PROCEDURE RESET_DATASET_ISLEAF (ELE_CATALOG_CODE IN VARCHAR2,MOF_DIV_CODE IN VARCHAR2,FISCAL_YEAR IN VARCHAR2) AS
  J INTEGER;
  K INTEGER;
  V_SQL VARCHAR2(300);
  ELE_CODE VARCHAR2(80);
  ELE_ID VARCHAR2(80);
  IS_LEAF VARCHAR2(80);
  PARENT_ID VARCHAR2(80);
  TYPE MY_CURSOR_TYPE IS REF CURSOR;
  DICD_CURSOR MY_CURSOR_TYPE;
  CURSOR T_TABLES(ELECATALOGCODE VARCHAR2) IS
    SELECT * FROM ELE_CATALOG T WHERE T.CATALOG_TYPE='1' AND T.ELE_CATALOG_CODE=''||UPPER(ELECATALOGCODE)||'';
BEGIN
  FOR T_ROW IN T_TABLES(ELE_CATALOG_CODE) LOOP
    SELECT COUNT(1) INTO J FROM USER_TABLES WHERE TABLE_NAME=T_ROW.ELE_SOURCE;
    IF J > 0 THEN
      IF 'ELE_UNION' <> T_ROW.ELE_SOURCE THEN
         V_SQL:='SELECT ELE_CODE,ELE_ID,IS_LEAF,PARENT_ID  FROM '|| T_ROW.ELE_SOURCE;
         OPEN DICD_CURSOR FOR V_SQL;
          LOOP
            FETCH DICD_CURSOR INTO ELE_CODE,ELE_ID,IS_LEAF,PARENT_ID;
            EXIT WHEN DICD_CURSOR%NOTFOUND;    
            EXECUTE IMMEDIATE 'SELECT COUNT(1) FROM '|| T_ROW.ELE_SOURCE || ' WHERE IS_DELETED = 2 AND MOF_DIV_CODE ='''||MOF_DIV_CODE||''' AND FISCAL_YEAR ='''||FISCAL_YEAR||''' AND PARENT_ID = '''|| ELE_ID ||'''' INTO K;
            IF K < 1 THEN
              EXECUTE IMMEDIATE 'UPDATE '|| T_ROW.ELE_SOURCE || ' SET IS_LEAF = 1 WHERE MOF_DIV_CODE ='''||MOF_DIV_CODE||''' AND FISCAL_YEAR ='''||FISCAL_YEAR||''' AND ELE_ID = '''|| ELE_ID ||'''';
            ELSE
               EXECUTE IMMEDIATE 'UPDATE '|| T_ROW.ELE_SOURCE || ' SET IS_LEAF = 2 WHERE MOF_DIV_CODE ='''||MOF_DIV_CODE||''' AND FISCAL_YEAR ='''||FISCAL_YEAR||''' AND ELE_ID = '''|| ELE_ID ||'''';
            END IF;
            COMMIT;
          END LOOP; 
      ELSE
         V_SQL:='SELECT ELE_CODE,ELE_ID,IS_LEAF,PARENT_ID  FROM '|| T_ROW.ELE_SOURCE || ' WHERE ELE_CATALOG_CODE ='''||T_ROW.ELE_CATALOG_CODE ||'''';
         OPEN DICD_CURSOR FOR V_SQL;
          LOOP
            FETCH DICD_CURSOR INTO ELE_CODE,ELE_ID,IS_LEAF,PARENT_ID;
            EXIT WHEN DICD_CURSOR%NOTFOUND;
            EXECUTE IMMEDIATE 'SELECT COUNT(1) FROM '|| T_ROW.ELE_SOURCE || ' WHERE IS_DELETED = 2 AND MOF_DIV_CODE ='''||MOF_DIV_CODE||''' AND FISCAL_YEAR ='''||FISCAL_YEAR||''' AND ELE_CATALOG_CODE = '''|| T_ROW.ELE_CATALOG_CODE ||''' AND PARENT_ID = '''|| ELE_ID ||'''' INTO K;
            IF K < 1 THEN
              EXECUTE IMMEDIATE 'UPDATE '|| T_ROW.ELE_SOURCE || ' SET IS_LEAF = 1 WHERE MOF_DIV_CODE ='''||MOF_DIV_CODE||''' AND FISCAL_YEAR ='''||FISCAL_YEAR||''' AND ELE_CATALOG_CODE = '''|| T_ROW.ELE_CATALOG_CODE ||''' AND ELE_ID = '''|| ELE_ID ||'''';
            ELSE
              EXECUTE IMMEDIATE 'UPDATE '|| T_ROW.ELE_SOURCE || ' SET IS_LEAF = 2 WHERE MOF_DIV_CODE ='''||MOF_DIV_CODE||''' AND FISCAL_YEAR ='''||FISCAL_YEAR||''' AND ELE_CATALOG_CODE = '''|| T_ROW.ELE_CATALOG_CODE ||''' AND ELE_ID = '''|| ELE_ID ||'''';
            END IF;
            COMMIT;
          END LOOP;   
      END IF;
    END IF;
  END LOOP;
END;




--1.刷新所有码表is_leaf
declare
  J integer;
  I integer;
  H integer;
  K integer;
  v_sql varchar2(300);
  ele_code varchar2(80);
  ele_id varchar2(80);
  is_leaf varchar2(80);
  parent_id varchar2(80);
  type my_cursor_type is ref cursor;
  dicd_cursor my_cursor_type;
  cursor t_tables is
    select * from ele_catalog t where t.catalog_type='1'  ;
begin
  for t_row in t_tables loop
    select count(1) INTO J from user_tables where table_name=t_row.ele_source;
    IF J > 0 THEN
      IF 'ELE_UNION' <> t_row.ele_source THEN
         v_sql:='select ele_code,ele_id,is_leaf,parent_id  from '|| t_row.ele_source;
         open dicd_cursor for v_sql;
          loop
            fetch dicd_cursor into ele_code,ele_id,is_leaf,parent_id;
            exit when dicd_cursor%notfound;    
            execute immediate 'select count(1) from '|| t_row.ele_source || ' where  parent_id = '''|| ele_id ||'''' into K;
            IF K < 1 THEN
              execute immediate 'update '|| t_row.ele_source || ' set is_leaf = ''1'' where  ele_id = '''|| ele_id ||'''';
            ELSE
               execute immediate 'update '|| t_row.ele_source || ' set is_leaf = ''2'' where  ele_id = '''|| ele_id ||'''';
            END IF;
            commit;
          end loop; 
      ELSE
         v_sql:='select ele_code,ele_id,is_leaf,parent_id  from '|| t_row.ele_source || ' where ele_catalog_code ='''||t_row.ele_catalog_code ||'''';
         open dicd_cursor for v_sql;
          loop
            fetch dicd_cursor into ele_code,ele_id,is_leaf,parent_id;
            exit when dicd_cursor%notfound;
            execute immediate 'select count(1) from '|| t_row.ele_source || ' where ele_catalog_code = '''|| t_row.ele_catalog_code ||''' and parent_id = '''|| ele_id ||'''' into K;
            IF K < 1 THEN
                execute immediate 'update '|| t_row.ele_source || ' set is_leaf = ''1'' where ele_catalog_code = '''|| t_row.ele_catalog_code ||''' and ele_id = '''|| ele_id ||'''';
            ELSE
                execute immediate 'update '|| t_row.ele_source || ' set is_leaf = ''2'' where ele_catalog_code = '''|| t_row.ele_catalog_code ||''' and ele_id = '''|| ele_id ||'''';
            END IF;
           -- commit;
          end loop;   
      END IF;
    END IF;
  end loop;
end;

