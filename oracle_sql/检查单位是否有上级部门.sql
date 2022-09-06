DECLARE
  J INTEGER;
  CURSOR A_CURSOR IS
   select mof_div_code,fiscal_year from bas_agency_info t where t.fiscal_year='2022'  group by mof_div_code,fiscal_year ;
   cursor b_cursor(pro string,yea string) is
    select * from bas_agency_info t WHERE t.mof_div_code=pro AND t.fiscal_year=yea AND parent_id !='0'; 
BEGIN
  FOR A_CUR IN A_CURSOR LOOP
    for b_cur in b_cursor(a_cur.mof_div_code,a_cur.fiscal_year) LOOP
        SELECT COUNT(1) INTO J FROM bas_agency_info WHERE agency_code = b_cur.parent_id AND mof_div_code=b_cur.mof_div_code                         AND fiscal_year = b_cur.fiscal_year ;
        IF J <= 0 THEN
 --           dbms_output.put_line('单位编码: '||b_cur.agency_code||'区划: '||b_cur.mof_div_code|| '年度：'||b_cur.fiscal_year);
            
dbms_output.put_line('or (agency_code ='''||b_cur.agency_code||''' and mof_div_code='''||b_cur.mof_div_code|| ''' and fiscal_year='''||b_cur.fiscal_year||''')');

        END IF ;
    end loop;
  END LOOP;
END;



/**




SELECT * FROM bas_agency_info  WHERE PARENT_id =' ';

--1.
UPDATE bas_agency_info SET PARENT_id ='0' WHERE PARENT_id =' ';

--2.

UPDATE bas_agency_info t SET parent_id = (
CASE LENGTH(t.agency_code) WHEN 3 THEN '0'
 WHEN 6 THEN SUBSTR(t.agency_code,0,3)
 WHEN 9 THEN SUBSTR(t.agency_code,0,6)
 ELSE SUBSTR(t.agency_code,0,3) END
)  WHERE (agency_code ='997002001' and mof_div_code='320114000' and fiscal_year='2022')
or (agency_code ='997007001' and mof_div_code='320114000' and fiscal_year='2022')
or (agency_code ='997009001' and mof_div_code='320114000' and fiscal_year='2022')
or (agency_code ='997003001' and mof_div_code='320114000' and fiscal_year='2022')
or (agency_code ='997010001' and mof_div_code='320114000' and fiscal_year='2022')
or (agency_code ='997006001' and mof_div_code='320114000' and fiscal_year='2022')
or (agency_code ='997008001' and mof_div_code='320114000' and fiscal_year='2022')
or (agency_code ='997004001' and mof_div_code='320114000' and fiscal_year='2022')
or (agency_code ='997001001' and mof_div_code='320114000' and fiscal_year='2022')
or (agency_code ='0010002' and mof_div_code='320281000' and fiscal_year='2022')
or (agency_code ='021' and mof_div_code='325003000' and fiscal_year='2022')
or (agency_code ='105014007' and mof_div_code='320000000' and fiscal_year='2022')
or (agency_code ='105014006' and mof_div_code='320000000' and fiscal_year='2022')
or (agency_code ='046025' and mof_div_code='321283000' and fiscal_year='2022')
or (agency_code ='002111' and mof_div_code='325002000' and fiscal_year='2022')
or (agency_code ='412001' and mof_div_code='320722000' and fiscal_year='2022')
or (agency_code ='412' and mof_div_code='320722000' and fiscal_year='2022')
or (agency_code ='304001' and mof_div_code='320904000' and fiscal_year='2022');

--3.

**/

