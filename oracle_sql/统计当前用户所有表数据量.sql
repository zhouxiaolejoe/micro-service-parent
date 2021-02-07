declare
  t_count   number(10);
  t_str VARCHAR2(500);
  cursor t_tables is select table_name from user_tables;
begin
  for t_row in t_tables loop
    t_str := 'select count(*) from '|| t_row.table_name;
    execute immediate t_str into t_count;
    dbms_output.put_line('【表名】'|| t_row.table_name || '  数量:' || to_char(t_count));
  end loop;
end;
