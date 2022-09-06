---��˰��Ŀ����ֶ�¼��汾����������
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
        values ('''||sys_guid()||''', ''20210716134105'', ''8269DB583A5544B9ADEA45B7281823E0'', ''ADD'', '''||t_row.fiscal_year||''', ''20200101000000'', ''h9xv7J2N,rIZm5qq2'', ''NONTAXPROGRAM'', '''||t_row.mof_div_code||''', ''03-8�� -20 01.36.28.123797 ����'')';
        commit;
      ELSE
         dbms_output.put_line('�Ѿ�����'||t_row.mof_div_code||'����'||t_row.fiscal_year||'��汾��Ϣ');
      END IF;
  end loop;
end;
/
---��˰��Ŀ�뵥λ��ϵ����ֶ�¼��汾����������
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
values ('''||sys_guid()||''', ''20210716134105'', ''C7207C0B9508CE3BE05017AC02000141'', ''ADD'', '''||t_row.fiscal_year||''', ''20200101000000'', ''bra8mnq8'', ''NONTAXRELATION'', '''||t_row.mof_div_code||''', ''16-7�� -21 01.41.05.587050 ����'')';
        commit;
      ELSE
             dbms_output.put_line('�Ѿ�����'||t_row.mof_div_code||'����'||t_row.fiscal_year||'��汾��Ϣ');
      END IF;
  end loop;
end;
/

---ִ�յ�λ�����ڰ汾������
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
values ('''||sys_guid()||''', ''20210716134105'', ''C7207C0B9508CE3BE05017AC02000141'', ''ADD'', '''||t_row.fiscal_year||''', ''20200101000000'', ''bra8mnq8'', ''NONTAXCOMPANYEXEC'', '''||t_row.mof_div_code||''', ''16-7�� -21 01.41.05.587050 ����'')';
        commit;
      ELSE
             dbms_output.put_line('�Ѿ�����'||t_row.mof_div_code||'����'||t_row.fiscal_year||'��汾��Ϣ');
      END IF;
  end loop;
end;
 
