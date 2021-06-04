
  J integer;
  I integer;
  H integer;
  cursor t_tables is
    select * from ele_catalog t  where t.catalog_type='1' and ele_catalog_code not in (
    'VD10004','VD10003','VC01004','VD00010','VD08002','VD08001','VD09001'
    );
begin
  for t_row in t_tables loop
   SELECT COUNT(*) INTO J FROM user_tables T WHERE T.TABLE_NAME = t_row.ele_source;
    IF J >0 THEN 
      execute immediate '
      create or replace view "V_'||case 
         when t_row.ele_source <> 'ELE_UNION' then t_row.ele_source 
         when t_row.ele_source = 'ELE_UNION' then t_row.ele_source||'_'||t_row.ele_catalog_code
         end||'"
          AS
    select (select ele_id from ele_vd08001 a where  a.ele_code = global_multyear_cz.Secu_f_GLOBAL_PARM(''DIVID'')
    and a.fiscal_year = global_multyear_cz.Secu_f_GLOBAL_PARM(''YEAR'')) as admdiv ,
         t.ELE_CATALOG_ID,
         t.ELE_CATALOG_CODE,
         t.ele_code as guid,
         t.FISCAL_YEAR as year,
         global_multyear_cz.Secu_f_GLOBAL_PARM(''DIVID'') as province,
         t.level_no as levelno,
         case when t.is_leaf = 1 then 1 when t.is_leaf = 2 then 0 when t.is_leaf = 0 then 0 end isleaf,
         t.START_DATE,
         t.END_DATE,
         case when t.Is_Enabled = 1 then ''1'' when t.Is_Enabled = 2 and t.IS_DELETED= 2 then ''2''  when  t.Is_Enabled = 2 and t.IS_DELETED= 1 then ''3''
            end status,
         t.UPDATE_TIME,
         t.ele_code as code,
         t.ele_name as name,
         t.IS_DELETED,
         (select ele_code from '||t_row.ele_source||' t1 where  t.parent_id = t1.ele_id and  t1.mof_div_code = global_multyear_cz.Secu_f_GLOBAL_PARM(''DIVID'')
     and t1.fiscal_year = global_multyear_cz.Secu_f_GLOBAL_PARM(''YEAR'')) as superguid,
         t.IS_STANDARD,
         '''' as  pinyin,
         t.CREATE_TIME
    from '||t_row.ele_source||' t
   where t.is_Enabled =1 and t.IS_DELETED =2 and
   '||case 
      when t_row.ele_source = 'ELE_UNION' then 't.ele_catalog_code = '''||t_row.ele_catalog_code||''' and'
        end||'
     t.mof_div_code = global_multyear_cz.Secu_f_GLOBAL_PARM(''DIVID'')
     and t.fiscal_year = global_multyear_cz.Secu_f_GLOBAL_PARM(''YEAR'')
      ';
    END IF;
  end loop;
