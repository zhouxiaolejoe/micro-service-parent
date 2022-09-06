declare
  I integer;
  J integer;
  H integer;
  cursor t_tables is
     select * from fasp_t_causer t WHERE t.code LIKE '%_admin';
begin
  for t_row in t_tables loop   
       SELECT COUNT(*) INTO I FROM fasp_t_causerrole T WHERE T.Userguid = t_row.guid AND t.roleguid ='wu3jBldp' AND t.province=t_row.province AND t.year='2021';
       IF I<=0 THEN
         execute immediate 'insert into fasp_t_causerrole (guid, userguid, roleguid, dbversion, province, year, admdiv) values (sys_guid(), '''||t_row.guid||''', ''wu3jBldp'', sysdate, '''||t_row.province||''', ''2021'', null)';
       END IF;
       SELECT COUNT(*) INTO J FROM fasp_t_causerrole T WHERE T.Userguid = t_row.guid AND t.roleguid ='wu3jBldp' AND t.province=t_row.province AND t.year='2022';
       IF J<=0 THEN
         execute immediate 'insert into fasp_t_causerrole (guid, userguid, roleguid, dbversion, province, year, admdiv) values (sys_guid(), '''||t_row.guid||''', ''wu3jBldp'', sysdate, '''||t_row.province||''', ''2022'', null)';
       END IF;
       SELECT COUNT(*) INTO H FROM fasp_t_causerrole T WHERE T.Userguid = t_row.guid AND t.roleguid ='wu3jBldp' AND t.province=t_row.province AND t.year='2023';
       IF H<=0 THEN
         execute immediate 'insert into fasp_t_causerrole (guid, userguid, roleguid, dbversion, province, year, admdiv) values (sys_guid(), '''||t_row.guid||''', ''wu3jBldp'', sysdate, '''||t_row.province||''', ''2023'', null)';
       END IF;
  end loop;
end;
