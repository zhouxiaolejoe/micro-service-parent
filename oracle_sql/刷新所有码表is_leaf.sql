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
    select * from ele_catalog t where t.catalog_type='1';
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
            execute immediate 'select count(1) from '|| t_row.ele_source || ' where parent_id = '''|| ele_id ||'''' into K;
            IF K > 0 THEN
              execute immediate 'update '|| t_row.ele_source || ' set is_leaf = ''0'' where ele_id = '''|| ele_id ||'''';
            ELSE
              execute immediate 'update '|| t_row.ele_source || ' set is_leaf = ''1'' where ele_id = '''|| ele_id ||'''';
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
            IF K > 0 THEN
              execute immediate 'update '|| t_row.ele_source || ' set is_leaf = ''0'' where ele_catalog_code = '''|| t_row.ele_catalog_code ||''' and ele_id = '''|| ele_id ||'''';
            ELSE
              execute immediate 'update '|| t_row.ele_source || ' set is_leaf = ''1'' where ele_catalog_code = '''|| t_row.ele_catalog_code ||''' and ele_id = '''|| ele_id ||'''';
            END IF;
            commit;
          end loop;   
      END IF;
    END IF;
  end loop;
end;

