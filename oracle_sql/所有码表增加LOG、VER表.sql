--1.刷新所有码表is_leaf
declare
  J integer;
  I integer;
  H integer;
  K integer;
  v_sql varchar2(300);
  ele_code varchar2(80);
  ele_id varchar2(80);
  is_leaf varchar2(80);
  parent_id varchar2(80);
  type my_cursor_type is ref cursor;
  dicd_cursor my_cursor_type;
  cursor t_tables is
    select * from ele_catalog t where t.catalog_type='1';
begin
  for t_row in t_tables loop
    select count(1) INTO J from user_tables where table_name=t_row.ele_source;
    IF J > 0 THEN
         select count(1) INTO J from user_tables where table_name=t_row.ele_source||'_VER';
         IF J < 1 THEN
           execute immediate '
           create table ' || t_row.ele_source || '_VER
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
              '||case when t_row.ele_source <> 'ELE_UNION' then 'remark VARCHAR2(200),' end ||'
              create_time      DATE,
              update_time      DATE,
              start_date       DATE,
              '||case when t_row.ele_source <> 'ELE_UNION' then 'admdiv VARCHAR2(50),' end ||'
              end_date         DATE,
              version          VARCHAR2(17),
              action           VARCHAR2(10),
              isnormversion    CHAR(1)
              )';
         END IF; 
         select count(1) INTO J from user_tables where table_name=t_row.ele_source||'_LOG';
         IF J < 1 THEN
           execute immediate '
           create table ' || t_row.ele_source || '_LOG
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
              '||case when t_row.ele_source <> 'ELE_UNION' then 'remark VARCHAR2(200),' end ||'
              create_time      DATE,
              update_time      DATE,
              start_date       DATE,
              '||case when t_row.ele_source <> 'ELE_UNION' then 'admdiv VARCHAR2(50),' end ||'
              end_date         DATE,
              version          VARCHAR2(17),
              action           VARCHAR2(10),
              isnormversion    CHAR(1)
              )';
         END IF;
    END IF;
  end loop;
end;
