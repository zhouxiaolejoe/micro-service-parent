-- 1.汉字首字母提取方法
CREATE OR REPLACE FUNCTION GET_PYJM (P_NAME IN VARCHAR2)
    RETURN VARCHAR2
AS
    V_COMPARE   VARCHAR2 (100);
    V_RETURN    VARCHAR2 (4000);
BEGIN
    DECLARE
        FUNCTION F_NLSSORT (P_WORD IN VARCHAR2)
            RETURN VARCHAR2
        AS
        BEGIN
            RETURN NLSSORT (P_WORD, 'NLS_SORT=SCHINESE_PINYIN_M');
        END;
    BEGIN
        FOR I IN 1 .. LENGTH (P_NAME)
        LOOP
            V_COMPARE := F_NLSSORT (SUBSTR (P_NAME, I, 1));

            IF     V_COMPARE >= F_NLSSORT ('吖')
               AND V_COMPARE <= F_NLSSORT ('驁')
            THEN
                V_RETURN := V_RETURN || 'A';
            ELSIF     V_COMPARE >= F_NLSSORT ('八')
                  AND V_COMPARE <= F_NLSSORT ('簿')
            THEN
                V_RETURN := V_RETURN || 'B';
            ELSIF     V_COMPARE >= F_NLSSORT ('嚓')
                  AND V_COMPARE <= F_NLSSORT ('錯')
            THEN
                V_RETURN := V_RETURN || 'C';
            ELSIF     V_COMPARE >= F_NLSSORT ('咑')
                  AND V_COMPARE <= F_NLSSORT ('鵽')
            THEN
                V_RETURN := V_RETURN || 'D';
            ELSIF     V_COMPARE >= F_NLSSORT ('妸')
                  AND V_COMPARE <= F_NLSSORT ('樲')
            THEN
                V_RETURN := V_RETURN || 'E';
            ELSIF     V_COMPARE >= F_NLSSORT ('发')
                  AND V_COMPARE <= F_NLSSORT ('猤')
            THEN
                V_RETURN := V_RETURN || 'F';
            ELSIF     V_COMPARE >= F_NLSSORT ('旮')
                  AND V_COMPARE <= F_NLSSORT ('腂')
            THEN
                V_RETURN := V_RETURN || 'G';
            ELSIF     V_COMPARE >= F_NLSSORT ('妎')
                  AND V_COMPARE <= F_NLSSORT ('夻')
            THEN
                V_RETURN := V_RETURN || 'H';
            ELSIF     V_COMPARE >= F_NLSSORT ('丌')
                  AND V_COMPARE <= F_NLSSORT ('攈')
            THEN
                V_RETURN := V_RETURN || 'J';
            ELSIF     V_COMPARE >= F_NLSSORT ('咔')
                  AND V_COMPARE <= F_NLSSORT ('穒')
            THEN
                V_RETURN := V_RETURN || 'K';
            ELSIF     V_COMPARE >= F_NLSSORT ('垃')
                  AND V_COMPARE <= F_NLSSORT ('擽')
            THEN
                V_RETURN := V_RETURN || 'L';
            ELSIF     V_COMPARE >= F_NLSSORT ('嘸')
                  AND V_COMPARE <= F_NLSSORT ('椧')
            THEN
                V_RETURN := V_RETURN || 'M';
            ELSIF     V_COMPARE >= F_NLSSORT ('拏')
                  AND V_COMPARE <= F_NLSSORT ('瘧')
            THEN
                V_RETURN := V_RETURN || 'N';
            ELSIF     V_COMPARE >= F_NLSSORT ('筽')
                  AND V_COMPARE <= F_NLSSORT ('漚')
            THEN
                V_RETURN := V_RETURN || 'O';
            ELSIF     V_COMPARE >= F_NLSSORT ('妑')
                  AND V_COMPARE <= F_NLSSORT ('曝')
            THEN
                V_RETURN := V_RETURN || 'P';
            ELSIF     V_COMPARE >= F_NLSSORT ('七')
                  AND V_COMPARE <= F_NLSSORT ('裠')
            THEN
                V_RETURN := V_RETURN || 'Q';
            ELSIF     V_COMPARE >= F_NLSSORT ('亽')
                  AND V_COMPARE <= F_NLSSORT ('鶸')
            THEN
                V_RETURN := V_RETURN || 'R';
            ELSIF     V_COMPARE >= F_NLSSORT ('仨')
                  AND V_COMPARE <= F_NLSSORT ('蜶')
            THEN
                V_RETURN := V_RETURN || 'S';
            ELSIF     V_COMPARE >= F_NLSSORT ('侤')
                  AND V_COMPARE <= F_NLSSORT ('籜')
            THEN
                V_RETURN := V_RETURN || 'T';
            ELSIF     V_COMPARE >= F_NLSSORT ('屲')
                  AND V_COMPARE <= F_NLSSORT ('鶩')
            THEN
                V_RETURN := V_RETURN || 'W';
            ELSIF     V_COMPARE >= F_NLSSORT ('夕')
                  AND V_COMPARE <= F_NLSSORT ('鑂')
            THEN
                V_RETURN := V_RETURN || 'X';
            ELSIF     V_COMPARE >= F_NLSSORT ('丫')
                  AND V_COMPARE <= F_NLSSORT ('韻')
            THEN
                V_RETURN := V_RETURN || 'Y';
            ELSIF     V_COMPARE >= F_NLSSORT ('帀')
                  AND V_COMPARE <= F_NLSSORT ('咗')
            THEN
                V_RETURN := V_RETURN || 'Z';
            END IF;
        END LOOP;

        RETURN V_RETURN;
    END;
END;

/

---2.区划初始化
declare
  J integer;
  I integer;
  H integer;
  K integer;
  A integer;
  B integer;
  C integer;
  D integer;
  userguid VARCHAR2(50);
  cursor t_tables is select * from ele_vd08001_town t;
begin
  for t_row in t_tables LOOP
    --初始化超级管理员用户
      dbms_output.put_line('【t_row.ele_code】'|| t_row.ele_code);
      select count (1) into I from fasp_t_causer t where t.code =t_row.ele_code||'_sys_admin'; 
      select count (1) into J from fasp_t_caprovinceapply t where t.usercode =t_row.ele_code||'_sys_admin'; 
      dbms_output.put_line('【I】'|| I);
      dbms_output.put_line('【J】'|| J);

      if J < 1 then 
          execute immediate '
          insert into fasp_t_caprovinceapply
            (province, name, usercode, application, status, applytime)
          values
            ('''||t_row.ele_code||''', 
             '''||t_row.ele_name||'超级管理员'',
             '''||t_row.ele_code||'_sys_admin'',
              ''app1,app2,app3,app4'', 
              ''1'',
             systimestamp)'; 
           commit;    
      end if;
      if I < 1 then 
        execute immediate '
        insert into FASP_T_CAUSER
        (ISSYS,
         GUID,
         ADMINTYPE,
         USERTYPE,
         STATUS,
         LOGINMODE,
         CODE,
         NAME,
         CREATEDATE,
         UPDATEDATE,
         OVERDUEDATE,
         PASSWORD,
         AGENCY,
         LOGINDATE,
         IDCODE,
         PHONENUMBER,
         EMAIL,
         DIVISION,
         REMARK,
         YEAR,
         PROVINCE,
         PWOUTDATE,
         UPAGENCYID,
         DBVERSION,
         BANK,
         ADMDIV,
         PINYIN,
         PWMODDATE,
         INITIALPASSWORD,
         ORDERNUM,
         PAYTYPEFLAG,
         SALARYTYPEFLAG,
         SPEACCTTYPEFLAG,
         BGTTYPEFLAG,
         ISTOWN,
         ENTRUSTGUID,
         STARTDATE,
         ENDDATE,
         AK,
         APPTYPES,
         APPIDSS)
      values
        (1,
         '''||sys_guid()||''',
         0,
         -1,
         ''1'',
         2,
         '''||t_row.ele_code||'_sys_admin'',
         '''||t_row.ele_name||'超级管理员'',
         to_char(sysdate, ''yyyyMMddHH24miss''),
         null,
         null,
         ''tmds2021'',
         '''||t_row.ele_id||''',
         null,
         null,
         null,
         null,
         null,
         null,
         '''||t_row.fiscal_year||''',
         '''||t_row.ele_code||''',
         null,
         '''||t_row.ele_id||''',
         systimestamp,
         null,
         '''||t_row.ele_id||''',
         '''||lower(GET_PYJM(t_row.ele_name||'超级管理员'))||''',
         ''20210419142147'',
         ''c4ca4238a0b923820dcc509a6f75849b'',
         null,
         null,
         null,
         null,
         null,
         ''0'',
         null,
         null,
         null,
         null,
         null,
         ''app1,app2,app3,app4'')';
         execute immediate 'UPDATE ELE_VD08001 SET ISINITIALIZE = ''1'' WHERE ELE_CODE = '''|| t_row.ele_code ||'''';
         commit;
      end if; 
      
      --初始化管理员角色
      select count (1) into H from fasp_t_carole t where t.guid ='wu3jBldp' AND t.year='2023' AND t.province=''||t_row.ele_code||''; 
      select count (1) into K from fasp_t_carole t where t.guid ='wu3jBldp' AND t.year='2022' AND t.province=''||t_row.ele_code||'';  
      dbms_output.put_line('【H】'||H);
      dbms_output.put_line('【K】'|| K);
      
     
      IF H < 1 THEN
         execute immediate 'insert into fasp_t_carole (AGENCY, REMARK1, REMARK2, REMARK3, YEAR, PROVINCE, ROLETYPE, ROLENATURE, DBVERSION,STATUS,DIVISION, BANK, ADMDIV, ROLELEVEL, GUID, CODE, NAME, REMARK, ISSYS, ORDERNUM, PAYTYPEFLAG, SALARYTYPEFLAG, SPEACCTTYPEFLAG,   BGTTYPEFLAG, ISPUBLICED, BDMTYPEFLAG)
values (null, null, null, null, ''2023'', '''|| t_row.ele_code ||''', -1, null, SYSDATE, ''1'', null, null, null, null, ''wu3jBldp'', ''F53'', ''预算-中台管理员角色'', null, null, null, null, null, null, null, null, null)';
      COMMIT;
      END IF;
      IF K < 1 THEN
         execute immediate 'insert into fasp_t_carole (AGENCY, REMARK1, REMARK2, REMARK3, YEAR, PROVINCE, ROLETYPE, ROLENATURE, DBVERSION,STATUS,DIVISION, BANK, ADMDIV, ROLELEVEL, GUID, CODE, NAME, REMARK, ISSYS, ORDERNUM, PAYTYPEFLAG, SALARYTYPEFLAG, SPEACCTTYPEFLAG,   BGTTYPEFLAG, ISPUBLICED, BDMTYPEFLAG)
values (null, null, null, null, ''2022'', '''|| t_row.ele_code ||''', -1, null, SYSDATE, ''1'', null, null, null, null, ''wu3jBldp'', ''F53'', ''预算-中台管理员角色'', null, null, null, null, null, null, null, null, null)';
      COMMIT;
      END IF;
       
      --初始化管理员用户角色关系
      dbms_output.put_line('【code】'|| ''||t_row.ele_code||'_sys_admin');
      SELECT GUID INTO userguid FROM fasp_t_causer t WHERE t.code = ''||t_row.ele_code||'_sys_admin';
      execute immediate '
      select count (1) from fasp_t_causerrole t where t.userguid ='''||userguid||''' AND t.roleguid=''wu3jBldp'' AND t.province='''||t_row.ele_code||''' AND t.year=''2023''
      ' INTO A;
      execute immediate '
      select count (1) from fasp_t_causerrole t where t.userguid ='''||userguid||''' AND t.roleguid=''wu3jBldp'' AND t.province='''||t_row.ele_code||''' AND t.year=''2022''
      ' INTO B;
      dbms_output.put_line('【A】'|| A);
      dbms_output.put_line('【B】'|| B);
      IF A < 1 THEN
         execute immediate 'insert into fasp_t_causerrole (GUID, USERGUID, ROLEGUID, DBVERSION, PROVINCE, YEAR, ADMDIV)
values (sys_guid(), '''||userguid||''', ''wu3jBldp'', SYSDATE, '''||t_row.ele_code||''', ''2023'', ''3A101C17CD6C4CE395C1D841F0821234'')';
       COMMIT;
      END IF;
      IF B < 1 THEN
         execute immediate 'insert into fasp_t_causerrole (GUID, USERGUID, ROLEGUID, DBVERSION, PROVINCE, YEAR, ADMDIV)
values (sys_guid(), '''||userguid||''', ''wu3jBldp'', SYSDATE, '''||t_row.ele_code||''', ''2022'', ''3A101C17CD6C4CE395C1D841F0821234'')';
       COMMIT;
      END IF;
      
      dbms_output.put_line('【userguid】'|| userguid);

      
      
      --初始化管理员角色菜单关系
       execute immediate '
      select count (1) from fasp_t_carolemenu t where t.roleguid =''wu3jBldp'' AND t.menuguid=''05'' AND t.province='''||t_row.ele_code||''' AND t.year=''2023''
      ' INTO C;
      
 execute immediate '
      select count (1) from fasp_t_carolemenu t where t.roleguid =''wu3jBldp'' AND t.menuguid=''05'' AND t.province='''||t_row.ele_code||''' AND t.year=''2022''
      ' INTO D;
  
      dbms_output.put_line('【C】'|| C);
      dbms_output.put_line('【D】'|| D);
      IF C < 1 THEN
         execute immediate 'insert into fasp_t_carolemenu (GUID, ROLEGUID, MENUGUID, DBVERSION, PROVINCE, YEAR, ADMDIV)
values (sys_guid(), ''wu3jBldp'', ''05'', SYSDATE, '''||t_row.ele_code||''', ''2023'', null)';
       COMMIT;
      END IF;
      IF D < 1 THEN
         execute immediate 'insert into fasp_t_carolemenu (GUID, ROLEGUID, MENUGUID, DBVERSION, PROVINCE, YEAR, ADMDIV)
values (sys_guid(), ''wu3jBldp'', ''05'', SYSDATE, '''||t_row.ele_code||''', ''2022'', null)';
       COMMIT;
      END IF;
      
  end loop;
end;



/**



select * from fasp_t_causer t WHERE t.code IN('325099000_sys_admin','321292000_sys_admin');
SELECT t.*,t.rowid FROM fasp_t_caprovinceapply t WHERE t.usercode IN('325099000_sys_admin','321292000_sys_admin');
select * from fasp_t_carole t where t.guid ='wu3jBldp' AND t.year IN('2022','2023') AND t.province='321292000'; 
select * from fasp_t_carole t where t.guid ='wu3jBldp' AND t.year IN('2022','2023') AND t.province='325099000'; 
select * from fasp_t_causerrole t where t.userguid =(SELECT GUID FROM fasp_t_causer WHERE CODE = '321292000_sys_admin') AND t.roleguid='wu3jBldp' AND t.province='321292000' AND t.year IN('2022','2023'); 
select * from fasp_t_causerrole t where t.userguid =(SELECT GUID FROM fasp_t_causer WHERE CODE ='325099000_sys_admin') AND t.roleguid='wu3jBldp' AND t.province='325099000' AND t.year IN('2022','2023'); 
select * from fasp_t_carolemenu t where t.roleguid ='wu3jBldp' AND t.menuguid='05' AND t.province='321292000' AND t.year IN('2022','2023');
select * from fasp_t_carolemenu t where t.roleguid ='wu3jBldp' AND t.menuguid='05' AND t.province='325099000' AND t.year IN('2022','2023');



DELETE from fasp_t_causer t WHERE t.code IN('325099000_sys_admin','321292000_sys_admin');
DELETE from fasp_t_caprovinceapply t WHERE t.usercode IN('325099000_sys_admin','321292000_sys_admin');
DELETE from fasp_t_carole t where t.guid ='wu3jBldp' AND t.year IN('2022','2023') AND t.province='321292000'; 
DELETE from fasp_t_carole t where t.guid ='wu3jBldp' AND t.year IN('2022','2023') AND t.province='325099000'; 
DELETE from fasp_t_causerrole t where t.userguid =(SELECT GUID FROM fasp_t_causer WHERE CODE = '321292000_sys_admin') AND t.roleguid='wu3jBldp' AND t.province='321292000' AND t.year IN('2022','2023'); 
DELETE from fasp_t_causerrole t where t.userguid =(SELECT GUID FROM fasp_t_causer WHERE CODE ='325099000_sys_admin') AND t.roleguid='wu3jBldp' AND t.province='325099000' AND t.year IN('2022','2023'); 
DELETE from fasp_t_carolemenu t where t.roleguid ='wu3jBldp' AND t.menuguid='05' AND t.province='321292000' AND t.year IN('2022','2023');
DELETE from fasp_t_carolemenu t where t.roleguid ='wu3jBldp' AND t.menuguid='05' AND t.province='325099000' AND t.year IN('2022','2023');
COMMIT;


*/
