--��̨��ִ��
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
     execute immediate 'comment on table HW_T_DATARIGHTRP is ''���ܻ�Ϊ���������м��''';
     
     execute immediate 'comment on column HW_T_DATARIGHTRP.guid is ''����Ψһ''';
     
     execute immediate 'comment on column HW_T_DATARIGHTRP.roleid is ''��ɫid''';

     execute immediate 'comment on column HW_T_DATARIGHTRP.menuid is ''�˵�id''';

     execute immediate 'comment on column HW_T_DATARIGHTRP.province is ''����''';

     execute immediate 'comment on column HW_T_DATARIGHTRP.year is ''���''';

     execute immediate 'comment on column HW_T_DATARIGHTRP.userguid is ''�û�id''';
     
     execute immediate 'alter table HW_T_DATARIGHTRP add constraint PK_HW_T_DATARIGHTRP_ID primary key (GUID)';
END;



