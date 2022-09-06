--中台库执行
DECLARE
  I INTEGER;
  J INTEGER;
BEGIN
   SELECT COUNT(1) INTO I FROM USER_TABLES WHERE TABLE_NAME='BAS_NONTAX_EXEC'; 
     IF I<=0 THEN
        EXECUTE IMMEDIATE '
        create table BAS_NONTAX_EXEC
        (
          action                VARCHAR2(1),
          create_time           VARCHAR2(50),
          exec_agency_code      VARCHAR2(200),
          exec_agency_name      VARCHAR2(500),
          fiscal_year           VARCHAR2(50),
          is_deleted            VARCHAR2(50),
          is_enabled            VARCHAR2(50),
          is_leaf               VARCHAR2(50),
          mof_div_code          VARCHAR2(50),
          nontax_exec_id        VARCHAR2(50),
          parent_nontax_exec_id VARCHAR2(50)
        )
        ';
     END IF;
     
     SELECT COUNT(1) INTO J from  fasp_t_mddicds t WHERE t.elementcode ='NONTAXCOMPANYEXEC'; 
     IF J<=0 THEN
        EXECUTE IMMEDIATE '
        insert into fasp_t_mddicds (GUID, CODE, NAME, ELEMENTCODE, ALIAS, APPLY, CODEMODE, PUBLISHNAME, REMARK, STATUS, CREATETIME, STARTTIME, ENDTIME, PROVINCE, YEAR, VERSION, TYPEGUID, TABLECODE, CRC, ISEXPORTTRANSLATE, EXPORTRANSLATEGUIDFORMAT, ISACROSSFISCAL, ACROSSFISCALFORMAT, CACHETYPE, ISPUBLIC, TRANSACTIONCACHE, CODETYEP, DBVERSION, IMPORTSTANDARD, ISNORMVERSION)
values (''D007D15461EB5C65E0530100007FF4F5'', ''MASTENONTAXCOMPANYEXEC'', ''非税执收单位关系'', ''NONTAXCOMPANYEXEC'', null, ''0'', null, null, null, ''1'', ''20200717110039700'', ''20200717'', null, ''3200'', ''2021'', 1, ''001'', ''BAS_NONTAX_EXEC'', null, null, null, null, null, null, null, null, null, null, null, ''1'')
        ';
     END IF;
   COMMIT;
END;
