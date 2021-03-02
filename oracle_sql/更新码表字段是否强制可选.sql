declare
  I integer;
  J integer;
  cursor a_cursor is
    select * from ele_catalog t where t.catalog_type='1' ;
  cursor b_cursor(tablename string ) is
    select column_name from USER_TAB_COLUMNS t  where t.TABLE_NAME = tablename and column_name not in ('ADMDIV','REMARK','FISCAL_YEAR','ELE_CATALOG_CODE');
begin
  for a_cur in a_cursor loop
   select count(1) INTO J from user_tables where table_name=a_cur.ele_source;  
   IF J > 0 THEN
        execute immediate 'select count(1) from '|| a_cur.ele_source ||' where parent_id is null' into I;
        IF I > 0 THEN
           dbms_output.put_line(a_cur.ele_source || '数量:'||I);
           execute immediate 'update '|| a_cur.ele_source ||' set parent_id =''0'' where parent_id is null';
           commit;
        END IF;
        
        begin
        for b_cur in b_cursor(a_cur.ele_source) loop
           begin
              execute immediate 'alter table '|| a_cur.ele_source ||' modify '|| b_cur.column_name ||' not null';
              EXCEPTION WHEN others THEN NULL;
           end;   
         end loop;
         EXCEPTION WHEN others THEN NULL;
         end;
   END IF;
  end loop;
end;
/*declare
  J integer;
  I integer;
  H integer;
  column_name varchar2(500);
  type my_cursor_type is ref cursor;
  dicd_cursor my_cursor_type;
  cursor t_tables is
    select * from ele_catalog t where t.catalog_type='1' and t.ele_source='ELE_VC01002';
begin
for t_row in t_tables loop
    --增加物理表ELE_CATALOG_CODE
   select count(1) INTO J from user_tables where table_name=t_row.ele_source;
   IF J > 0 THEN
      select count(1) into I from user_TAB_COLUMNS t where t.TABLE_NAME =t_row.ele_source and  COLUMN_NAME='ADMDIV';  
      IF I > 0 THEN
         --open dicd_cursor for 'select column_name from user_TAB_COLUMNS t where t.TABLE_NAME =' || '''' || t_row.ele_source || '''' ;  
         open dicd_cursor for 'select column_name from user_TAB_COLUMNS t where t.TABLE_NAME ='''|| t_row.ele_source ||''' and column_name not in (''ADMDIV'',''REMARK'')' ;  
         loop
          fetch dicd_cursor into column_name;
          exit when dicd_cursor%notfound;
          execute immediate '
          alter table '|| t_row.ele_source ||' modify '|| column_name ||' not null
          ';
          dbms_output.put_line(column_name);
        end loop;    
      END IF;
   END IF;
  end loop;
end;*/


declare
  I integer;
  J integer;
  cursor a_cursor is
    select * from ele_catalog t where t.catalog_type='1' ;
begin
  for a_cur in a_cursor loop
   --增加物理表ELE_CATALOG_CODE
   select count(1) INTO J from user_tables where table_name=a_cur.ele_source;  
   IF J > 0 THEN
    -- begin
      --select count(1) into I from USER_TAB_COLUMNS t where t.TABLE_NAME =a_cur.ele_source;  
      --IF I > 0 THEN
       begin
         -- dbms_output.put_line(b_cur.column_name);
          execute immediate 'alter table '|| a_cur.ele_source ||' modify ELE_ID not null';
          EXCEPTION WHEN others THEN NULL;
       end;    
       
       begin
         -- dbms_output.put_line(b_cur.column_name);
          execute immediate 'alter table '|| a_cur.ele_source ||' modify ELE_CODE not null';
          EXCEPTION WHEN others THEN NULL;
       end;
       
       begin
         -- dbms_output.put_line(b_cur.column_name);
          execute immediate 'alter table '|| a_cur.ele_source ||' modify ele_name not null';
          EXCEPTION WHEN others THEN NULL;
       end;
     
       begin
         -- dbms_output.put_line(b_cur.column_name);
          execute immediate 'alter table '|| a_cur.ele_source ||' modify ele_catalog_id not null';
          EXCEPTION WHEN others THEN NULL;
       end;
       
       begin
         -- dbms_output.put_line(b_cur.column_name);
          execute immediate 'alter table '|| a_cur.ele_source ||' modify mof_div_code not null';
          EXCEPTION WHEN others THEN NULL;
       end;
       
       begin
         -- dbms_output.put_line(b_cur.column_name);
          execute immediate 'alter table '|| a_cur.ele_source ||' modify PARENT_ID not null';
          EXCEPTION WHEN others THEN NULL;
       end;
  
       
       begin
         -- dbms_output.put_line(b_cur.column_name);
          execute immediate 'alter table '|| a_cur.ele_source ||' modify level_no not null';
          EXCEPTION WHEN others THEN NULL;
       end;
       
       begin
         -- dbms_output.put_line(b_cur.column_name);
          execute immediate 'alter table '|| a_cur.ele_source ||' modify is_leaf not null';
          EXCEPTION WHEN others THEN NULL;
       end;
       
       begin
         -- dbms_output.put_line(b_cur.column_name);
          execute immediate 'alter table '|| a_cur.ele_source ||' modify start_date not null';
          EXCEPTION WHEN others THEN NULL;
       end;
       
       begin
         -- dbms_output.put_line(b_cur.column_name);
          execute immediate 'alter table '|| a_cur.ele_source ||' modify end_date not null';
          EXCEPTION WHEN others THEN NULL;
       end;
 
        begin
         -- dbms_output.put_line(b_cur.column_name);
          execute immediate 'alter table '|| a_cur.ele_source ||' modify is_enabled not null';
          EXCEPTION WHEN others THEN NULL;
       end;
       
        begin
         -- dbms_output.put_line(b_cur.column_name);
          execute immediate 'alter table '|| a_cur.ele_source ||' modify update_time not null';
          EXCEPTION WHEN others THEN NULL;
       end;
       
        begin
         -- dbms_output.put_line(b_cur.column_name);
          execute immediate 'alter table '|| a_cur.ele_source ||' modify is_deleted not null';
          EXCEPTION WHEN others THEN NULL;
       end;
       
        begin
         -- dbms_output.put_line(b_cur.column_name);
          execute immediate 'alter table '|| a_cur.ele_source ||' modify is_standard not null';
          EXCEPTION WHEN others THEN NULL;
       end;
       
        begin
         -- dbms_output.put_line(b_cur.column_name);
          execute immediate 'alter table '|| a_cur.ele_source ||' modify create_time not null';
          EXCEPTION WHEN others THEN NULL;
       end;
       
         begin
         -- dbms_output.put_line(b_cur.column_name);
          execute immediate 'alter table '|| a_cur.ele_source ||' modify fiscal_year not null';
          EXCEPTION WHEN others THEN NULL;
       end;
       
         begin
         -- dbms_output.put_line(b_cur.column_name);
          execute immediate 'alter table '|| a_cur.ele_source ||' modify ele_catalog_code not null';
          EXCEPTION WHEN others THEN NULL;
       end;
       
      --END IF;
      --EXCEPTION WHEN others THEN NULL;
   --end;
   END IF;
  end loop;
end;         
