--1.恢复 删表 数据
declare
  J integer;
  I integer;
  H integer;
  ele_code varchar2(30);
  type my_cursor_type is ref cursor;
  dicd_cursor my_cursor_type;
  cursor t_tables is
    select * from recyclebin  where droptime > ='2021-03-29:11:39' and original_name not like '%SYS%' order by droptime desc;
begin
  for t_row in t_tables loop
    dbms_output.put_line('【表名】'|| t_row.original_name );
     begin    
        execute immediate 'flashback table '|| t_row.original_name ||' to before drop';
        EXCEPTION WHEN others THEN NULL;
    
     end;
  end loop;
end;
