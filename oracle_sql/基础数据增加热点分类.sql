--1.基础数据增加热点分类
declare
  I integer;
BEGIN
  select count(1) into I from fasp_t_secappidaccesspower t where t.CATALOG_CODE = 'VD09003';
   IF I < 1 THEN
     execute immediate '
     insert into fasp_t_secappidaccesspower (GUID, APPID, CATALOG_CODE, PROVINCE, YEAR, STATUS, STARTTIME, ENDTIMME, CREATETIME, APINAME)
values (''C6080576720C6047E153511A122346D9'', ''zkjnyth'', ''VD09003'', ''320000000'', ''2021'', ''1'', sysdate, sysdate, sysdate, ''ranges'')
     ';
   END IF;
end;
