declare
  I integer;

  cursor a_cursor is
    SELECT province from fasp_t_syncdatabase WHERE province IS NOT NULL GROUP BY province ;
begin
  for a_cur in a_cursor LOOP
       dbms_output.put_line('¡¾Çø»®¡¿'|| a_cur.province );
       sync_new_table_info('ELE_ZXLTEST',a_cur.province);
       
  end loop;
end;
