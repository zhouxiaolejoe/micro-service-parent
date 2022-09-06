--��̨��ִ��
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
     EXECUTE IMMEDIATE 'comment on column FASP_T_AGENCYCHANGE.agency_code is ''��λ����''';
     EXECUTE IMMEDIATE 'comment on column FASP_T_AGENCYCHANGE.agency_name is ''��λ����''';
     EXECUTE IMMEDIATE 'comment on column FASP_T_AGENCYCHANGE.supdep_code is ''���ű�ʶ����''';
     EXECUTE IMMEDIATE 'comment on column FASP_T_AGENCYCHANGE.mof_dep_code is ''�����ڲ�����''';
     EXECUTE IMMEDIATE 'comment on column FASP_T_AGENCYCHANGE.mof_div_code is ''����''';
     EXECUTE IMMEDIATE 'comment on column FASP_T_AGENCYCHANGE.fiscal_year is ''���''';
     EXECUTE IMMEDIATE 'comment on column FASP_T_AGENCYCHANGE.pdm_status is ''��Ŀ��״̬''';
     EXECUTE IMMEDIATE 'comment on column FASP_T_AGENCYCHANGE.bas_status is ''������״̬''';
     EXECUTE IMMEDIATE 'comment on column FASP_T_AGENCYCHANGE.bgt_status is ''Ԥ���״̬''';
     EXECUTE IMMEDIATE 'comment on column FASP_T_AGENCYCHANGE.create_time is ''����ʱ��''';
     EXECUTE IMMEDIATE 'comment on column FASP_T_AGENCYCHANGE.is_sync is ''�Ƿ�ͬ��''';
   END IF;
   COMMIT;
END;
