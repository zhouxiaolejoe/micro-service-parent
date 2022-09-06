--中台库
--解决省本级工作流不能查出数据问题
declare
V_VD10003 VARCHAR2(4000);
V_VD10004 VARCHAR2(4000);
BEGIN
V_VD10003:=q'[
create or replace view v_ele_vd10003 as
select t.ele_code as guid,
       t.ele_code as code,
       t.ele_name as name,
       t.ELE_CATALOG_ID,
       t.MOF_DIV_CODE as PROVINCE,
       decode(t.parent_id, '0', '0', t1.ele_code) as superguid,
       t.level_no as levelno,
       case when t.is_leaf = 1 then 1 when t.is_leaf = 2 then 0 when t.is_leaf = 0 then 0 end isleaf,
       t.START_DATE,
       t.END_DATE,
       t.IS_ENABLED,
       t.UPDATE_TIME,
       t.IS_DELETED,
       t.IS_STANDARD,
       t.CREATE_TIME,
       t.FISCAL_YEAR as year,
       t.FUND_TYPE_CODE
  from ELE_VD10003 t, ELE_VD10003 t1
 where t.is_Enabled =1 and t.IS_DELETED =2 and t.parent_id = t1.ele_id(+)
   and t.mof_div_code = t1.mof_div_code(+)
   and t.fiscal_year = t1.fiscal_year(+)
   and  t.mof_div_code in( SELECT ele_code
     FROM (select * from ELE_VD08001 where fiscal_year=global_multyear_cz.Secu_f_GLOBAL_PARM('YEAR'))
     CONNECT BY PRIOR PARENT_ID = ELE_ID
     START WITH ELE_ID = (SELECT ELE_ID
                        FROM ELE_VD08001
                       WHERE ELE_CODE = global_multyear_cz.Secu_f_GLOBAL_PARM('DIVID')
                         AND FISCAL_YEAR = global_multyear_cz.Secu_f_GLOBAL_PARM('YEAR')))
   and t.fiscal_year = global_multyear_cz.Secu_f_GLOBAL_PARM('YEAR')
]';
V_VD10004:=q'[
create or replace view v_ele_vd10004 as
select t.functype,
       t.ele_code as guid,
       t.ele_code as code,
       t.ele_name as name,
       t.ELE_CATALOG_ID,
       t.MOF_DIV_CODE as PROVINCE,
       decode(t.parent_id, '0', '0', t1.ele_code) as superguid,
       t.level_no as levelno,
       case when t.is_leaf = 1 then 1 when t.is_leaf = 2 then 0 when t.is_leaf = 0 then 0 end isleaf,
       t.START_DATE,
       t.END_DATE,
       t.IS_ENABLED STATUS,
       t.UPDATE_TIME,
       t.IS_DELETED,
       t.IS_STANDARD,
       t.CREATE_TIME,
       t.FISCAL_YEAR,
       t.FISCAL_YEAR as year,
       t.FUND_TYPE_CODE
  from ELE_VD10004 t, ELE_VD10004 t1
 where t.is_Enabled =1 and t.IS_DELETED =2 and t.parent_id = t1.ele_id(+)
   and t.mof_div_code = t1.mof_div_code(+)
   and t.fiscal_year = t1.fiscal_year(+)
   and  t.mof_div_code in( SELECT ele_code
     FROM (select * from ELE_VD08001 where fiscal_year=global_multyear_cz.Secu_f_GLOBAL_PARM('YEAR'))
     CONNECT BY PRIOR PARENT_ID = ELE_ID
     START WITH ELE_ID = (SELECT ELE_ID
                        FROM ELE_VD08001
                       WHERE ELE_CODE = global_multyear_cz.Secu_f_GLOBAL_PARM('DIVID')
                         AND FISCAL_YEAR = global_multyear_cz.Secu_f_GLOBAL_PARM('YEAR')))
   and t.fiscal_year = global_multyear_cz.Secu_f_GLOBAL_PARM('YEAR')
]';
execute immediate V_VD10003;
execute immediate V_VD10004;

end;










