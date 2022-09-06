UPDATE bas_agency_info t SET t.start_date =(
CASE t.is_enabled 
  WHEN 2 THEN
    (CASE 
      WHEN t.start_date IS NULL THEN 
         to_date(to_char(sysdate, 'yyyyMMddHH24:mi:ss'), 'yyyy/MM/dd HH24:mi:ss')
      ELSE
        to_date(to_char(t.start_date, 'yyyyMMddHH24:mi:ss'), 'yyyy/MM/dd HH24:mi:ss')
     END)
  ELSE 
    (CASE  
      WHEN t.start_date IS NULL THEN 
         to_date(to_char(sysdate, 'yyyyMMddHH24:mi:ss'), 'yyyy/MM/dd HH24:mi:ss')
      ELSE
        to_date(to_char(t.start_date, 'yyyyMMddHH24:mi:ss'), 'yyyy/MM/dd HH24:mi:ss')
      END)
  END

),
t.end_date = (

CASE t.is_enabled 
  WHEN 2 THEN
    CASE  
      WHEN t.start_date IS NULL THEN 
         to_date(to_char(sysdate, 'yyyyMMddHH24:mi:ss'), 'yyyy/MM/dd HH24:mi:ss')
      ELSE
         to_date(to_char(t.start_date, 'yyyyMMddHH24:mi:ss'), 'yyyy/MM/dd HH24:mi:ss')
    END
  ELSE 
    to_date('2099/12/31 23:59:59', 'yyyy/MM/dd HH24:mi:ss')
  END

)  WHERE t.mof_div_code ='320500000';

