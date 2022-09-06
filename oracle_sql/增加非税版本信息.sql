---非税项目解决手动录入版本不存在问题
declare
  J integer;
  I integer;
  H integer;
  cursor t_tables is
     select ele_code mof_div_code,fiscal_year from ele_vd08001 t WHERE t.fiscal_year='2023';
begin
  for t_row in t_tables loop
      select count(1) into I from fasp_t_mdversion where year=t_row.fiscal_year and province =  t_row.mof_div_code and elementcode='NONTAXPROGRAM';
      IF I <= 0 THEN
        execute immediate 'insert into fasp_t_mdversion (GUID, VERSION, DATASETGUID, ACTION, YEAR, CREATETIME, RANGEGUIDS, ELEMENTCODE, PROVINCE, DBVERSION)
        values ('''||sys_guid()||''', ''20210716134105'', ''8269DB583A5544B9ADEA45B7281823E0'', ''ADD'', '''||t_row.fiscal_year||''', ''20200101000000'', ''h9xv7J2N,rIZm5qq2'', ''NONTAXPROGRAM'', '''||t_row.mof_div_code||''', ''03-8月 -20 01.36.28.123797 上午'')';
        commit;
      ELSE
         dbms_output.put_line('已经存在'||t_row.mof_div_code||'区划'||t_row.fiscal_year||'年版本信息');
      END IF;
  end loop;
end;
/
---非税项目与单位关系解决手动录入版本不存在问题
declare
  J integer;
  I integer;
  H integer;
  cursor t_tables is
     select ele_code mof_div_code,fiscal_year from ele_vd08001 t WHERE t.fiscal_year='2023';
begin
  for t_row in t_tables loop
      select count(1) into I from fasp_t_mdversion where year=t_row.fiscal_year and province =  t_row.mof_div_code and elementcode='NONTAXRELATION';
      IF I <= 0 THEN
        execute immediate 'insert into fasp_t_mdversion (GUID, VERSION, DATASETGUID, ACTION, YEAR, CREATETIME, RANGEGUIDS, ELEMENTCODE, PROVINCE, DBVERSION)
values ('''||sys_guid()||''', ''20210716134105'', ''C7207C0B9508CE3BE05017AC02000141'', ''ADD'', '''||t_row.fiscal_year||''', ''20200101000000'', ''bra8mnq8'', ''NONTAXRELATION'', '''||t_row.mof_div_code||''', ''16-7月 -21 01.41.05.587050 下午'')';
        commit;
      ELSE
             dbms_output.put_line('已经存在'||t_row.mof_div_code||'区划'||t_row.fiscal_year||'年版本信息');
      END IF;
  end loop;
end;
/

---执收单位不存在版本号问题
declare
  J integer;
  I integer;
  H integer;
  cursor t_tables is
     select ele_code mof_div_code,fiscal_year from ele_vd08001 t WHERE t.fiscal_year='2023';
begin
  for t_row in t_tables loop
      select count(1) into I from fasp_t_mdversion where year=t_row.fiscal_year and province =  t_row.mof_div_code and elementcode='NONTAXRELATION';
      IF I <= 0 THEN
        execute immediate 'insert into fasp_t_mdversion (GUID, VERSION, DATASETGUID, ACTION, YEAR, CREATETIME, RANGEGUIDS, ELEMENTCODE, PROVINCE, DBVERSION)
values ('''||sys_guid()||''', ''20210716134105'', ''C7207C0B9508CE3BE05017AC02000141'', ''ADD'', '''||t_row.fiscal_year||''', ''20200101000000'', ''bra8mnq8'', ''NONTAXCOMPANYEXEC'', '''||t_row.mof_div_code||''', ''16-7月 -21 01.41.05.587050 下午'')';
        commit;
      ELSE
             dbms_output.put_line('已经存在'||t_row.mof_div_code||'区划'||t_row.fiscal_year||'年版本信息');
      END IF;
  end loop;
end;
 
