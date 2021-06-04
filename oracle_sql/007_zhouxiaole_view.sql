
V_VC01004 VARCHAR2(4000);
V_VD08001 VARCHAR2(4000);
BEGIN
V_VC01004:=q'[
create or replace view v_ele_vc01004 as
select t.ADMDIV,
       t.ELE_CATALOG_ID,
       t.ELE_CATALOG_CODE,
       t.ele_code as guid,
       t.FISCAL_YEAR as year,
       t.MOF_DIV_CODE as province,
       t.level_no as levelno,
       t.is_leaf as isleaf,
       t.START_DATE,
       t.END_DATE,
       t.IS_ENABLED as status,
       t.UPDATE_TIME,
       t.ele_code as code,
       t.ele_name as name,
       t.IS_DELETED,
       decode(t.parent_id, '0', '0', t1.ele_code) as superguid,
       t.IS_STANDARD,
       t.CREATE_TIME,
       t.REMARK
  from ELE_VC01004 t, ELE_VC01004 t1
 where t.is_Enabled =1 
   and t.IS_DELETED =2
   and t.parent_id = t1.ele_id(+)
   and t.mof_div_code = t1.mof_div_code(+)
   and t.fiscal_year = t1.fiscal_year(+)
   and t.mof_div_code = global_multyear_cz.Secu_f_GLOBAL_PARM('DIVID')
   and t.fiscal_year = global_multyear_cz.Secu_f_GLOBAL_PARM('YEAR')
]';


V_VD08001:=q'[
create or replace view v_ele_vd08001 as
select t.ele_code as guid,
       ele_code as code,
       ele_name as name,
       'B0722B53403B7740E0533203A8C0DF7E' as ELE_CATALOG_ID,
       'VD08001' as ele_catalog_code,
       IS_LEAF as isleaf,
       LEVEL_NO as levelno,
       REMARK,
       CREATE_TIME,
       VERSION,
       parent_id as superguid,
       nvl((select ele_code
          from ele_vd08001 f
         where f.fiscal_year = t.fiscal_year
           and f.mof_div_code = t.mof_div_code
           and f.ele_id = t.parent_id),'0') as parent_id,
       PARENT_ADM_DIV_CODE,
       MOF_DIV_TYPE,
       ADM_DIV_CODE,
       IS_ADMDIV,
       IS_DELETED,
       IS_STANDARD,
       UPDATE_TIME,
       IS_ENABLED,
       SRCGUID,
       DESGUID,
       START_DATE,
       PINYIN,
       EMW,
       ALIAS,
       FGDG,
       END_DATE,
       STATUS,
       fiscal_year as year,
       mof_div_code as province,
       ADMDIVGBCODE,
       DIRUNDERFLAG,
       ECONBELT,
       ECONBELTGUID,
       FINADMLEVEL,
       FINADMLEVELMARK,
       FOODREGFLAG,
       GAPDIVFLAG,
       HARDDISFLAG,
       MINORITYDISFLAG,
       OBAORFLAG,
       PLANCITYFLAG,
       POVDEVDISFLAG,
       REVDISFLAG,
       DBVERSION,
       CANCELTIME,
       ISSTRAIGHTCOUNTY
  from ele_vd08001 t
 WHERE t.is_Enabled =1 
   and t.IS_DELETED =2 
   and t.fiscal_year = global_multyear_cz.Secu_f_GLOBAL_PARM('YEAR')
]';
execute immediate V_VC01004;
execute immediate V_VD08001;














