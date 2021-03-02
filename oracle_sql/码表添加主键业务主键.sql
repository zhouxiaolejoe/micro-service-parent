declare
  J integer;
  I integer;
  H integer;
  cursor t_tables is
    select * from ele_catalog t where t.catalog_type='1';
begin
  for t_row in t_tables loop
    SELECT COUNT(*)INTO I FROM USER_TABLES T WHERE T.TABLE_NAME = t_row.ele_source;
    IF I > 0 THEN
       select count(1) into J from user_constraints t where t.table_name = upper(t_row.ele_source) and t.constraint_type = 'P';
       IF J < 1 THEN
          execute immediate 'alter table '|| t_row.ele_source ||' add constraint PK_'|| t_row.ele_source ||'_ID primary key (ELE_ID)';
       END IF;
       select COUNT(*)INTO H from user_cons_columns cu, user_constraints au where cu.constraint_name = au.constraint_name and au.constraint_type = 'U' and au.table_name = t_row.ele_source ;
       IF H < 1 THEN
         dbms_output.put_line(t_row.ele_source);
         execute immediate 'alter table '|| t_row.ele_source ||' add constraint UK_'|| t_row.ele_source ||'_ID unique (ELE_CODE, MOF_DIV_CODE,ELE_CATALOG_ID,ELE_ID)';
       ELSE
         execute immediate 'alter table '|| t_row.ele_source ||' drop constraint UK_'|| t_row.ele_source ||'_ID cascade drop index';
       END IF;
       execute immediate '
        comment on column '|| t_row.ele_source ||'.ELE_ID
          is ''����''';
            execute immediate '
        comment on column '|| t_row.ele_source ||'.FISCAL_YEAR
          is ''��''';
            execute immediate '
        comment on column '|| t_row.ele_source ||'.MOF_DIV_CODE
          is ''����������������''';
            execute immediate '
        comment on column '|| t_row.ele_source ||'.LEVEL_NO
          is ''��ǰ��Ϣ���''';
            execute immediate '
        comment on column '|| t_row.ele_source ||'.IS_LEAF
          is ''��ǰ��Ϣ���Ƿ�Ϊĩ���ڵ�''';
            execute immediate '
        comment on column '|| t_row.ele_source ||'.START_DATE
          is ''��������yyyymmdd''';
            execute immediate '
        comment on column '|| t_row.ele_source ||'.END_DATE
          is ''ͣ������yyyymmdd''';
            execute immediate '
        comment on column '|| t_row.ele_source ||'.IS_ENABLED
          is ''�Ƿ�����''';
            execute immediate '
        comment on column '|| t_row.ele_source ||'.UPDATE_TIME
          is ''ά��������Ϣ��ĸ���ʱ��''';
            execute immediate '
        comment on column '|| t_row.ele_source ||'.ELE_CODE
          is ''��Ӧ������еĴ���''';
            execute immediate '
        comment on column '|| t_row.ele_source ||'.ELE_NAME
          is ''��Ӧ������е�����''';
            execute immediate '
        comment on column '|| t_row.ele_source ||'.ELE_CATALOG_ID
          is ''��Ӧ����������Ŀ¼����Ŀ¼����''';
            execute immediate '
        comment on column '|| t_row.ele_source ||'.IS_DELETED
          is ''�߼�ɾ����ʶ''';
            execute immediate '
        comment on column '|| t_row.ele_source ||'.PARENT_ID
          is ''������Ϣ��������һ����ʱ��Ϊ��''';
            execute immediate '
        comment on column '|| t_row.ele_source ||'.IS_STANDARD
          is ''�Ƿ��׼''';
            execute immediate '
        comment on column '|| t_row.ele_source ||'.CREATE_TIME
          is ''����ʱ��''';
            execute immediate '
        comment on column '|| t_row.ele_source ||'.ELE_CATALOG_CODE
          is ''Ŀ¼����''';
    END IF;
  end loop;
end;
