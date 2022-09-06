--中台库执行
DECLARE
  I INTEGER;
  J INTEGER;
  H INTEGER;
BEGIN
   SELECT COUNT(1) INTO I FROM USER_TABLES WHERE TABLE_NAME='FASP_T_AGENCYCHANGE';  
   IF I<=0 THEN
     DBMS_OUTPUT.PUT_LINE(I);
     EXECUTE IMMEDIATE '
    create table FASP_T_AGENCYCHANGE
    (
      change_id    VARCHAR2(38) not null,
      agency_code  VARCHAR2(20) not null,
      agency_name  VARCHAR2(100) not null,
      supdep_code  VARCHAR2(20) not null,
      mof_dep_code VARCHAR2(20) not null,
      mof_div_code VARCHAR2(9) not null,
      fiscal_year  VARCHAR2(4) not null,
      pdm_status   VARCHAR2(1),
      bas_status   VARCHAR2(1),
      bgt_status   VARCHAR2(1),
      create_time  VARCHAR2(50),
      param1       VARCHAR2(20),
      param2       VARCHAR2(20),
      param3       VARCHAR2(20),
      param4       VARCHAR2(20),
      param5       VARCHAR2(20),
      is_sync       VARCHAR2(1)
    )
     ';
     EXECUTE IMMEDIATE 'comment on column FASP_T_AGENCYCHANGE.change_id is ''id''';
     EXECUTE IMMEDIATE 'comment on column FASP_T_AGENCYCHANGE.agency_code is ''单位编码''';
     EXECUTE IMMEDIATE 'comment on column FASP_T_AGENCYCHANGE.agency_name is ''单位名称''';
     EXECUTE IMMEDIATE 'comment on column FASP_T_AGENCYCHANGE.supdep_code is ''部门标识代码''';
     EXECUTE IMMEDIATE 'comment on column FASP_T_AGENCYCHANGE.mof_dep_code is ''财政内部机构''';
     EXECUTE IMMEDIATE 'comment on column FASP_T_AGENCYCHANGE.mof_div_code is ''区划''';
     EXECUTE IMMEDIATE 'comment on column FASP_T_AGENCYCHANGE.fiscal_year is ''年度''';
     EXECUTE IMMEDIATE 'comment on column FASP_T_AGENCYCHANGE.pdm_status is ''项目库状态''';
     EXECUTE IMMEDIATE 'comment on column FASP_T_AGENCYCHANGE.bas_status is ''基础库状态''';
     EXECUTE IMMEDIATE 'comment on column FASP_T_AGENCYCHANGE.bgt_status is ''预算库状态''';
     EXECUTE IMMEDIATE 'comment on column FASP_T_AGENCYCHANGE.create_time is ''创建时间''';
     EXECUTE IMMEDIATE 'comment on column FASP_T_AGENCYCHANGE.is_sync is ''是否同步''';
   END IF;
   COMMIT;
END;
