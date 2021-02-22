declare
  J integer;
  I integer;
  cursor t_tables is
    select * from ele_catalog where ele_catalog_code = 'VD99999';
begin
  for t_row in t_tables loop
    --如果财政部规范表不存在创建通用表结构
    SELECT COUNT(*)
      INTO I
      FROM USER_TABLES T
     WHERE T.TABLE_NAME = 'ELE_' || t_row.ele_catalog_code;
    IF I < 1 THEN
      execute immediate '
     create table ELE_' || t_row.ele_catalog_code || '
      ( 
        ele_id           VARCHAR2(38),
        ele_code         VARCHAR2(20),
        ele_name         VARCHAR2(100),
        ele_catalog_code VARCHAR2(38),
        parent_id        VARCHAR2(38),
        mof_div_code     VARCHAR2(9),
        fiscal_year      VARCHAR2(4),
        level_no         NUMBER(2),
        is_leaf          NUMBER(1),    
        is_enabled       NUMBER(1),
        is_deleted       NUMBER(1),
        is_standard      NUMBER(1),
        ele_catalog_id   VARCHAR2(38),
        remark           VARCHAR2(200),
        create_time      DATE,
        update_time      DATE,
        start_date       DATE,
        end_date         DATE,
        admdiv           VARCHAR2(50)
        )';
    END IF;
    --迁移原先码表数据 
  
    SELECT COUNT(*)
      INTO J
      FROM USER_TABLES T
     WHERE T.TABLE_NAME = 'FASP_T_PUP' || t_row.ele_catalog_code;
    IF J > 0 THEN
    execute immediate '
    insert into ELE_' || t_row.ele_catalog_code || '
    (admdiv,
     ele_catalog_id,
     ele_catalog_code,
     ele_id,
     fiscal_year,
     mof_div_code,
     level_no,
     is_leaf,
     start_date,
     end_date,
     is_enabled,
     update_time,
     ele_code,
     ele_name,
     is_deleted,
     parent_id,
     is_standard,
     create_time,
     remark)
    select admdiv,
           ''' || t_row.ele_catalog_id || ''',
           ''' || t_row.ele_catalog_code || ''',
           guid,
           year,
           province,
           levelno,
           isleaf,
           to_date(to_char(sysdate, ''yyyyMMdd''), ''yyyy/MM/dd''),
           to_date(to_char(sysdate, ''yyyyMMdd''), ''yyyy/MM/dd''),
           case
             when status = ''1'' then
              ''1''
             when status = ''2'' then
              ''2''
             when status = ''3'' then
              ''2''
           end IS_ENABLED,
           to_date(to_char(sysdate, ''yyyyMMddHH24:mm:ss''),
                   ''yyyy/MM/dd HH24:mi:ss''),
           code,
           name,
           case
             when status = ''1'' then
              ''2''
             when status = ''2'' then
              ''2''
             when status = ''3'' then
              ''1''
           end IS_DELETED,
           superguid,
           ''1'' is_standard,
           to_date(to_char(sysdate, ''yyyyMMddHH24:mm:ss''),
                   ''yyyy/MM/dd HH24:mi:ss''),
           remark
      from FASP_T_PUP'|| t_row.ele_catalog_code||' where year =''2021'' and province=''870000000''';
      commit;
    END IF;
  end loop;
end;
