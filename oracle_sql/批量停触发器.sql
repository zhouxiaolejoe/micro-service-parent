--1.中台执行
--1.
declare
  cursor t_triggers is
    select * from user_Triggers t where t.trigger_name LIKE '%_SYNC' and t.trigger_name like 'TR_ELE_%';
  cursor a_triggers is
    select * from user_Triggers t where t.trigger_name LIKE '%_SYNC';
begin
  for a_row in a_triggers loop
     EXECUTE IMMEDIATE '
        alter trigger '||a_row.trigger_name||' enable
        ';
  end loop;

  for t_row in t_triggers loop

     EXECUTE IMMEDIATE '
        alter trigger '||t_row.trigger_name||' disable
        ';
  end loop;
end;




---批量删除触发器
declare
  cursor t_triggers is
    select * from user_Triggers t where t.trigger_name LIKE '%_SYNC' and t.trigger_name like 'TR_ELE_%';
begin
  for t_row in t_triggers loop

     EXECUTE IMMEDIATE '
        drop trigger '||t_row.trigger_name||'
        ';
  end loop;
end;

