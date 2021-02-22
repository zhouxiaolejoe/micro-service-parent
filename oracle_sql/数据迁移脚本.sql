insert into ele_element_2021
  (element_id,
   element_code,
   element_name,
   element_el_code,
   element_datatype,
   element_datalength,
   element_datatype_format,
   ele_catalog_id,
   remark,
   sourcetext,
   start_date,
   end_date,
   is_enabled,
   update_time,
   is_deleted,
   create_time,
   mof_div_code,
   year,
   typeguid,
   actual_datatype,
   physics_field,
   ele_catalog_code,
   value_ref)
  select guid,
         code,
         name,
         elementcode,
         datatype,
         format,
         'oracle' element_datatype_format,
         '1' ele_catalog_id,
         remark,
         '1' sourcetext,
         to_date(to_char(sysdate, 'yyyyMMdd'), 'yyyy/MM/dd'),
         to_date(to_char(sysdate, 'yyyyMMdd'), 'yyyy/MM/dd'),
         case
           when status = '1' then
            '1'
           when status = '2' then
            '2'
           when status = '3' then
            '2'
         end IS_ENABLED,
         to_date(to_char(sysdate, 'yyyyMMddHH24:mm:ss'),
                 'yyyy/MM/dd HH24:mi:ss'),
         case
           when status = '1' then
            '2'
           when status = '2' then
            '2'
           when status = '3' then
            '1'
         end IS_DELETED,
         to_date(to_char(sysdate, 'yyyyMMddHH24:mm:ss'),
                 'yyyy/MM/dd HH24:mi:ss'),
         province,
         year,
         '1' typeguid,
         (select t.actual_code
            from ele_datatype_enum t
           where t.rule_code = f.datatype) actual_datatype,
         elementcode physics_field,
         substr(replace(f.rangesrc, '"', ''), 0, 7) ele_catalog_code,
         rangesrc
    from fasp_t_dicde f;
