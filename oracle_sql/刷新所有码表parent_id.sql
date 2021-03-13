--1.刷新所有码表parent_id 为0
declare
  J integer;
  I integer;
  H integer;
  ele_code varchar2(30);
  type my_cursor_type is ref cursor;
  dicd_cursor my_cursor_type;
  cursor t_tables is
    select * from ele_catalog t where t.catalog_type='1';
begin
  for t_row in t_tables loop
    select count(1) INTO J from user_tables where table_name=t_row.ele_source;
    IF J > 0 THEN
      IF 'ELE_UNION' <> t_row.ele_source THEN
         execute immediate 'select count(1) from '|| t_row.ele_source ||' where parent_id =''#''' into I;
         IF I > 0 then 
           execute immediate 'update '||t_row.ele_source || ' set parent_id =''0'' where parent_id =''#''';
         end if ;
      ELSE
         execute immediate 'select count(1) from '|| t_row.ele_source ||' where ele_catalog_id = '''|| t_row.ele_catalog_id ||'''and  parent_id =''#''' into H;
         IF H > 0 then
           execute immediate 'update '||t_row.ele_source || ' set parent_id =''0'' where ele_catalog_id = '''|| t_row.ele_catalog_id ||''' and parent_id =''#''';
         end if ;   
      END IF;
    END IF;
  end loop;
end;
