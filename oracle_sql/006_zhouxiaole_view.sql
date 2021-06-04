
V_SQL VARCHAR2(4000);
V_SQL1 VARCHAR2(4000);
V_SQL2 VARCHAR2(4000);
V_SQL3 VARCHAR2(4000);
BEGIN
V_SQL:=q'[
create or replace view v_ele_vd00010 as
select t.ele_code as guid,
       ele_code as code,
       ele_name as name,
       '8700XJ0ktnqH' as ELE_CATALOG_ID,
       'VD00010' as ele_catalog_code,
       mof_div_code as province,
       (select ele_code
          from ele_vd00010 f
         where f.fiscal_year = t.fiscal_year
           and f.mof_div_code = t.mof_div_code
           and f.ele_id = t.parent_id) as SUPERGUID,
       LEVEL_NO as levelno,
       case when t.is_leaf = 1 then 1 when t.is_leaf = 2 then 0 when t.is_leaf = 0 then 0 end isleaf,
       ADMDIV,
       REMARK,
       ORGSPEC,
       ZIP,
       VERSION,
       TEL,
       INTORG,
       FAX,
       SRCGUID,
       DESGUID,
       ADDRESS,
       SRCSCALE,
       PINYIN,
       '' as AGENCYATTRIB,
       '' as ISBENJIDANWEI,
       '' as AGENCY_ABBREVIATION,
       '' as AGENCY_LEADER_PER_NAME,
       '' as AGENCY_ADD,
       '' as LOCATION,
       '' as CAPITAL_TYPE,
       '' as EXECUTIVE_ACC,
       '' as IS_PRE_DEPAR_FIN_ACCOUNTS,
       '' as IS_PRE_FIN_REP_GOV_DEP,
       '' as IS_PRE_STA_OWN_ASSE_REP_ADM,
       '' as IS_VIRTUAL_UNIT,
       '' as AGENCY_LEVEL_CODE,
       '' as ADMIN_STAF_NUM,
       '' as INST_STAF_NUM,
       '' as WORKER_STAF_NUM,
       '' as ACTU_STAF_NUM,
       '' as ACTUNOW_STAF_NUM,
       '' as DR_NUM,
       '' as MASTER_NUM,
       '' as UNDERGR_NUM,
       '' as ACADEMY_NUM,
       '' as ORDINARY_HIGH_SCH_STUD_NUM,
       '' as JUNIOR_HIGH_SCH_STUD_NUM,
       '' as PRIARY_SCH_STUD_NUM,
       '' as KINDERGARTEN_CHILDREN_NUM,
       '' as OTHER_STUD_NUM,
       FUNDSUP,
       ALIAS,
       fiscal_year as year,
       DBVERSION,
       CANCELTIME,
       PAYTYPEFLAG,
       SALARYTYPEFLAG,
       SPEACCTTYPEFLAG,
       GLTYPEFLAG,
       BGTTYPEFLAG,
       ISTOWN,
       TOWNCODE,
       DWSXBS,
       FPCOL1,
       FPCOL2,
       FPCOL3,
       FPCOL4,
       FPCOL5,
       AAORDERNO,
       ISCZAGENCY,
       LEADERNAME,
       UNIFSOC_CRED_CODE as UNIFSOCCREDCODE,
       FININTORG,
       IND as IND_CODE,
       SUPDEP,
       AGENCY_ADM_LEVEL_CODE,
       AGENCYTYPE,
       AGENCYLEVEL,
       to_date(to_char(sysdate, 'yyyyMMddHH24:mm:ss'),
               'yyyy/MM/dd HH24:mi:ss') as START_DATE,
       '' as END_DATE,
       to_date(to_char(sysdate, 'yyyyMMddHH24:mm:ss'),
               'yyyy/MM/dd HH24:mi:ss') as UPDATE_TIME,
       to_date(to_char(sysdate, 'yyyyMMddHH24:mm:ss'),
               'yyyy/MM/dd HH24:mi:ss') as CREATE_TIME,
       to_char(IS_ENABLED) as STATUS,
       case
         when IS_DELETED = 1 then
          2
         when IS_DELETED = 2 then
          2
         when IS_DELETED = 3 then
          1
       end IS_DELETED,
       1 as IS_STANDARD
  from ele_vd00010 t
 where t.is_Enabled =1 and t.IS_DELETED =2 and t.mof_div_code = global_multyear_cz.Secu_f_GLOBAL_PARM('DIVID')
   and t.fiscal_year = global_multyear_cz.Secu_f_GLOBAL_PARM('YEAR')
]';


V_SQL1:=q'[
create or replace view v_ele_vd09001 as
select t.ele_code pro_cat_code,
       t.ele_code as guid,
       t.ele_code as code,
       t.ele_name as name,
       t.ELE_CATALOG_ID,
       t.MOF_DIV_CODE province,
       decode(t.parent_id, '0', '0', t1.ele_code) as superguid,
       t.level_no as levelno,
       case when t.is_leaf = 1 then 1 when t.is_leaf = 2 then 0 when t.is_leaf = 0 then 0 end isleaf,
       t.START_DATE,
       t.END_DATE,
       t.IS_ENABLED,
       t.UPDATE_TIME,
       t.IS_DELETED status,
       t.IS_STANDARD,
       t.CREATE_TIME,
       t.FISCAL_YEAR year,
       t.pro_jtype projtype
  from ELE_VD09001 t, ELE_VD09001 t1
 where t.is_Enabled =1 and t.IS_DELETED =2 and t.parent_id = t1.ele_id(+)
   and t.mof_div_code = t1.mof_div_code(+)
   and t.fiscal_year = t1.fiscal_year(+)
   and t.mof_div_code = global_multyear_cz.Secu_f_GLOBAL_PARM('DIVID')
   and t.fiscal_year = global_multyear_cz.Secu_f_GLOBAL_PARM('YEAR')
]';
V_SQL2:=q'[
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
   and t.mof_div_code = global_multyear_cz.Secu_f_GLOBAL_PARM('DIVID')
   and t.fiscal_year = global_multyear_cz.Secu_f_GLOBAL_PARM('YEAR')
]';
V_SQL3:=q'[
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
   and t.mof_div_code = global_multyear_cz.Secu_f_GLOBAL_PARM('DIVID')
   and t.fiscal_year = global_multyear_cz.Secu_f_GLOBAL_PARM('YEAR')
]';
execute immediate V_SQL;
execute immediate V_SQL1;
execute immediate V_SQL2;
execute immediate V_SQL3;













