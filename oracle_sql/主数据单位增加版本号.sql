--中台库执行
DECLARE
  I INTEGER;
  J INTEGER;
   cursor t_tables is
    select * from ele_vd08001 t WHERE t.fiscal_year='2022';
BEGIN
 for t_row in t_tables LOOP
   dbms_output.put_line('【区划】'|| t_row.ele_code );
   
   execute immediate '
   insert into fasp_t_mdversion (GUID, VERSION, DATASETGUID, ACTION, YEAR, CREATETIME, RANGEGUIDS, ELEMENTCODE, PROVINCE, DBVERSION)
values (sys_guid(), ''20200905205406'', ''8231073D518E4B79807C72BEFD0FCFC0'', ''ADD'', ''2022'', ''20200905205411'', ''a7SuUsb6,xo4akUNV,fbEvcwr3,v9BhhXih,LwFwUmuE,mfCHQcng,rFUpEeod,wCcoCHeZ,IeOx1QvW,ugbxbUXy,ZDMPadSl,veJRDmwX,RpryzGoZ,NR4i7lXi,KtQ0ZiXL,BPV9u6ub,VjkTVS0j,NprSpQlt,rS2RHRqp,AafjDhf7'', ''AGENCY'', '''|| t_row.ele_code||''', SYSTIMESTAMP)
      ';
  end loop;
end;
