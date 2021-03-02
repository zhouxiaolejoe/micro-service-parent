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
          is ''主键''';
            execute immediate '
        comment on column '|| t_row.ele_source ||'.FISCAL_YEAR
          is ''年''';
            execute immediate '
        comment on column '|| t_row.ele_source ||'.MOF_DIV_CODE
          is ''所属财政区划代码''';
            execute immediate '
        comment on column '|| t_row.ele_source ||'.LEVEL_NO
          is ''当前信息项级次''';
            execute immediate '
        comment on column '|| t_row.ele_source ||'.IS_LEAF
          is ''当前信息项是否为末级节点''';
            execute immediate '
        comment on column '|| t_row.ele_source ||'.START_DATE
          is ''启用日期yyyymmdd''';
            execute immediate '
        comment on column '|| t_row.ele_source ||'.END_DATE
          is ''停用日期yyyymmdd''';
            execute immediate '
        comment on column '|| t_row.ele_source ||'.IS_ENABLED
          is ''是否启用''';
            execute immediate '
        comment on column '|| t_row.ele_source ||'.UPDATE_TIME
          is ''维护本条信息项的更新时间''';
            execute immediate '
        comment on column '|| t_row.ele_source ||'.ELE_CODE
          is ''对应代码表中的代码''';
            execute immediate '
        comment on column '|| t_row.ele_source ||'.ELE_NAME
          is ''对应代码表中的名称''';
            execute immediate '
        comment on column '|| t_row.ele_source ||'.ELE_CATALOG_ID
          is ''对应《基础代码目录表》的目录主键''';
            execute immediate '
        comment on column '|| t_row.ele_source ||'.IS_DELETED
          is ''逻辑删除标识''';
            execute immediate '
        comment on column '|| t_row.ele_source ||'.PARENT_ID
          is ''父级信息项主键，一级的时候为空''';
            execute immediate '
        comment on column '|| t_row.ele_source ||'.IS_STANDARD
          is ''是否标准''';
            execute immediate '
        comment on column '|| t_row.ele_source ||'.CREATE_TIME
          is ''创建时间''';
            execute immediate '
        comment on column '|| t_row.ele_source ||'.ELE_CATALOG_CODE
          is ''目录编码''';
    END IF;
  end loop;
end;
