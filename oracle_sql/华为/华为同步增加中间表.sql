--中台库执行
DECLARE
  I INTEGER;
  J INTEGER;
BEGIN
   SELECT COUNT(1) INTO I FROM USER_TABLES WHERE TABLE_NAME='HW_T_DATARIGHTRP'; 
     IF I<=0 THEN
        EXECUTE IMMEDIATE '
        create table HW_T_DATARIGHTRP
        (
          guid     VARCHAR2(128) not null,
          roleid   VARCHAR2(32),
          menuid   VARCHAR2(32),
          province VARCHAR2(9) not null,
          year     CHAR(4) not null,
          userguid VARCHAR2(32)
        )
        ';
     END IF;
     execute immediate 'comment on table HW_T_DATARIGHTRP is ''接受华为推送数据中间表''';
     
     execute immediate 'comment on column HW_T_DATARIGHTRP.guid is ''主键唯一''';
     
     execute immediate 'comment on column HW_T_DATARIGHTRP.roleid is ''角色id''';

     execute immediate 'comment on column HW_T_DATARIGHTRP.menuid is ''菜单id''';

     execute immediate 'comment on column HW_T_DATARIGHTRP.province is ''区划''';

     execute immediate 'comment on column HW_T_DATARIGHTRP.year is ''年度''';

     execute immediate 'comment on column HW_T_DATARIGHTRP.userguid is ''用户id''';
     
     execute immediate 'alter table HW_T_DATARIGHTRP add constraint PK_HW_T_DATARIGHTRP_ID primary key (GUID)';
END;



