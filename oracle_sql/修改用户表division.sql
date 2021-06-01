declare
  I integer;
  J integer;
  K integer;
  cursor t_tables is select * from mid_test.fasp_t_causer where guid in(
       select userguid from fasp_t_causerrole where roleguid in(select guid from fasp_t_carole where name like '%政府预算%')
);
begin
  for t_row in t_tables loop
     execute immediate 'select count(1) from ELE_VC01004 where ELE_ID = '''||t_row.division ||'''' into I;
     if I > 0 then 
         dbms_output.put_line('处室:'|| t_row.division );
     end if ;
     execute immediate 'select count(1) from ELE_VD00010 where ELE_ID = '''||t_row.division ||'''' into J;
     if J > 0 then 
         dbms_output.put_line('单位:'|| t_row.division );
     end if ; 
     execute immediate 'select count(1) from ELE_VD08002 where ELE_ID = '''||t_row.division ||'''' into K;
     if K > 0 then 
         dbms_output.put_line('区划:'|| t_row.division );
     end if ;
  end loop;
end;






update fasp_t_causer t set t.division=(
select ele_code from ele_vc01004 e where e.ele_id = t.division
)  where guid in(
       select userguid from fasp_t_causerrole where roleguid in(select guid from fasp_t_carole where name like '%政府预算%')
);
