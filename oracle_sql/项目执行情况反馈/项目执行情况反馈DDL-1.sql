DECLARE
  tableNames VARCHAR2(4000);
  I INTEGER;
  cursor table_cursor(tableName string ) is
    (select regexp_substr(tableName,'[^,]+', 1, level) tableName from dual
    connect by regexp_substr(tableName, '[^,]+', 1, level) is not NULL);
BEGIN
    tableNames:='PM_HOT_TOPICCATE,BA_BGT_INFO,PAY_VOUCHER,PAY_VOUCHER_BILL,PAY_DETAIL,PAY_ALLOCATION_CERT,INC_APPLY,INC_CERT,INC_DETAIL,BA_BGT_CARRYOVERS,BA_BGT_BALANCE,BA_BGT_CARRYOVERS_AGENCY,BA_BGT_BALANCE_AGENCY,NON_TAX_PAY,NON_TAX_PAY_DETAIL,PAY_BACK_INFO,PAY_PLAN_VOUCHER,BGT_PM_ANNUAL_ZK,BGT_TRA_ZK';
    --BGT_PM_ANNUAL, ÔÝÊ±ÒÆ³ý
    for tb_cur in table_cursor(tableNames) LOOP
      SELECT COUNT(*) INTO I FROM USER_TABLES t WHERE t.TABLE_NAME = UPPER(tb_cur.tableName);
        IF I > 0 THEN
           EXECUTE IMMEDIATE 'DROP TABLE '||tb_cur.tableName;
        END IF;
        dbms_output.put_line(I||'-'||UPPER(tb_cur.tableName));
    end loop;
end;
