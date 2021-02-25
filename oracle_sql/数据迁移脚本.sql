--逻辑库表要素迁移
--脚本执行前需要导入ele_datatype_enum数据类型表
insert into ele_element
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
           where lower(t.rule_code) = lower(f.datatype)) actual_datatype,
         elementcode physics_field,
         substr(replace(f.rangesrc, '"', ''), 0, 7) ele_catalog_code,
         rangesrc
    from fasp_t_dicde f;
--代码集迁移
insert into ele_catalog
  (ele_catalog_id,
   ele_catalog_code,
   ele_catalog_name,
   mof_div_code,
   ele_source,
   ele_extend_type,
   ele_manage_type,
   start_date,
   end_date,
   is_enabled,
   update_time,
   is_standard,
   is_deleted,
   create_time,
   hq_type,
   fiscal_year,
   elementcode,
   codemode,
   catalog_type,
   is_vindicate,
   is_masterdata,
   typeguid,
   apply,
   remark)
  select guid,
         code,
         name,
         province,
         'ELE_'||code,
         '1' ele_extend_type,
         '1' ele_manage_type,
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
         '1' is_standard,
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
         '1' hq_type,
         year,
         elementcode,
         codemode,
         '1' catalog_type,
         '1' is_vindicate,
         '1' is_masterdata,
         '1' typeguid,
         apply,
         remark
    from fasp_t_dicds f;
--逻辑库表迁移
insert into ele_dictable
  (tab_id,
   ele_source,
   tab_name,
   tab_viewname,
   remark,
   isshow,
   isuses,
   create_time,
   update_time,
   end_date,
   year,
   province,
   appid,
   catalog_type_id,
   codemode,
   apply,
   element_el_code,
   col_view,
   entity_number,
   catalog_type)
 select 
   SYS_GUID(),
   TABLECODE,
   name,
   TABLECODE,
   REMARK,
   '1' ISSHOW,
   '1' ISUSES,
    to_date(to_char(sysdate, 'yyyyMMddHH24:mm:ss'),
                 'yyyy/MM/dd HH24:mi:ss'),
    to_date(to_char(sysdate, 'yyyyMMddHH24:mm:ss'),
                 'yyyy/MM/dd HH24:mi:ss'),   
    to_date(to_char(sysdate, 'yyyyMMdd'), 'yyyy/MM/dd'),    
    NVL(YEAR,'2021'),
    NVL(PROVINCE,'87'),
    APPID,
    '1' catalog_type_id,
    '' codemode,
    '1' apply,
    '1' element_el_code,
    '1' col_view,
    '1' entity_number,
    '0' catalog_type
    from fasp_t_dictable f where f.name is not null;









