CREATE OR REPLACE PROCEDURE UPDATE_PARENTID (PROVINCE IN VARCHAR2,oldYear IN VARCHAR2,newYear IN VARCHAR2) AS
begin
  EXECUTE IMMEDIATE '
  update ele_vd09001 t1
     set t1.PARENT_ID =
         (select nvl((select ele_id
                       from ele_vd09001 t2
                      where t2.ele_code =
                            (select ele_code
                               from ele_vd09001 t3
                              where t3.ELE_ID = t.PARENT_ID
                                and t3.mof_div_code = '||PROVINCE||'
                                and t3.FISCAL_YEAR = '||oldYear||')
                        and t2.mof_div_code = '||PROVINCE||'
                        and t2.FISCAL_YEAR = '||newYear||'),
                     ''0'')
            from ele_vd09001 t
           where t.ELE_CODE = t1.ELE_CODE
             and t.mof_div_code = '||PROVINCE||'
             and t.FISCAL_YEAR = '||oldYear||')
     where t1.mof_div_code = '||PROVINCE||'
     and t1.FISCAL_YEAR = '||newYear||'';
     commit;
end;


call UPDATE_PARENTID(320000000,2021,2022);


select t.*,t.rowid from ele_vd09001 t where t.mof_div_code='320000000' and t.fiscal_year='2022'
