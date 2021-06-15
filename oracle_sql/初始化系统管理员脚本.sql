-- 1.��������ĸ��ȡ����
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

            IF     V_COMPARE >= F_NLSSORT ('߹')
               AND V_COMPARE <= F_NLSSORT ('�')
            THEN
                V_RETURN := V_RETURN || 'A';
            ELSIF     V_COMPARE >= F_NLSSORT ('��')
                  AND V_COMPARE <= F_NLSSORT ('��')
            THEN
                V_RETURN := V_RETURN || 'B';
            ELSIF     V_COMPARE >= F_NLSSORT ('��')
                  AND V_COMPARE <= F_NLSSORT ('�e')
            THEN
                V_RETURN := V_RETURN || 'C';
            ELSIF     V_COMPARE >= F_NLSSORT ('��')
                  AND V_COMPARE <= F_NLSSORT ('�z')
            THEN
                V_RETURN := V_RETURN || 'D';
            ELSIF     V_COMPARE >= F_NLSSORT ('��')
                  AND V_COMPARE <= F_NLSSORT ('��')
            THEN
                V_RETURN := V_RETURN || 'E';
            ELSIF     V_COMPARE >= F_NLSSORT ('��')
                  AND V_COMPARE <= F_NLSSORT ('�g')
            THEN
                V_RETURN := V_RETURN || 'F';
            ELSIF     V_COMPARE >= F_NLSSORT ('�')
                  AND V_COMPARE <= F_NLSSORT ('�B')
            THEN
                V_RETURN := V_RETURN || 'G';
            ELSIF     V_COMPARE >= F_NLSSORT ('�o')
                  AND V_COMPARE <= F_NLSSORT ('��')
            THEN
                V_RETURN := V_RETURN || 'H';
            ELSIF     V_COMPARE >= F_NLSSORT ('آ')
                  AND V_COMPARE <= F_NLSSORT ('�h')
            THEN
                V_RETURN := V_RETURN || 'J';
            ELSIF     V_COMPARE >= F_NLSSORT ('��')
                  AND V_COMPARE <= F_NLSSORT ('�i')
            THEN
                V_RETURN := V_RETURN || 'K';
            ELSIF     V_COMPARE >= F_NLSSORT ('��')
                  AND V_COMPARE <= F_NLSSORT ('�^')
            THEN
                V_RETURN := V_RETURN || 'L';
            ELSIF     V_COMPARE >= F_NLSSORT ('�`')
                  AND V_COMPARE <= F_NLSSORT ('��')
            THEN
                V_RETURN := V_RETURN || 'M';
            ELSIF     V_COMPARE >= F_NLSSORT ('��')
                  AND V_COMPARE <= F_NLSSORT ('��')
            THEN
                V_RETURN := V_RETURN || 'N';
            ELSIF     V_COMPARE >= F_NLSSORT ('�p')
                  AND V_COMPARE <= F_NLSSORT ('�a')
            THEN
                V_RETURN := V_RETURN || 'O';
            ELSIF     V_COMPARE >= F_NLSSORT ('�r')
                  AND V_COMPARE <= F_NLSSORT ('��')
            THEN
                V_RETURN := V_RETURN || 'P';
            ELSIF     V_COMPARE >= F_NLSSORT ('��')
                  AND V_COMPARE <= F_NLSSORT ('�d')
            THEN
                V_RETURN := V_RETURN || 'Q';
            ELSIF     V_COMPARE >= F_NLSSORT ('��')
                  AND V_COMPARE <= F_NLSSORT ('�U')
            THEN
                V_RETURN := V_RETURN || 'R';
            ELSIF     V_COMPARE >= F_NLSSORT ('��')
                  AND V_COMPARE <= F_NLSSORT ('�R')
            THEN
                V_RETURN := V_RETURN || 'S';
            ELSIF     V_COMPARE >= F_NLSSORT ('�@')
                  AND V_COMPARE <= F_NLSSORT ('�X')
            THEN
                V_RETURN := V_RETURN || 'T';
            ELSIF     V_COMPARE >= F_NLSSORT ('��')
                  AND V_COMPARE <= F_NLSSORT ('�F')
            THEN
                V_RETURN := V_RETURN || 'W';
            ELSIF     V_COMPARE >= F_NLSSORT ('Ϧ')
                  AND V_COMPARE <= F_NLSSORT ('�R')
            THEN
                V_RETURN := V_RETURN || 'X';
            ELSIF     V_COMPARE >= F_NLSSORT ('Ѿ')
                  AND V_COMPARE <= F_NLSSORT ('�')
            THEN
                V_RETURN := V_RETURN || 'Y';
            ELSIF     V_COMPARE >= F_NLSSORT ('��')
                  AND V_COMPARE <= F_NLSSORT ('��')
            THEN
                V_RETURN := V_RETURN || 'Z';
            END IF;
        END LOOP;

        RETURN V_RETURN;
    END;
END;


---2.������ʼ��
declare
  J integer;
  I integer;
  H integer;
  K integer;
  cursor t_tables is select * from ele_vd08001 t where t.ele_code not like '%998';
begin
  for t_row in t_tables loop
      select count (1) into I from fasp_t_causer t where t.code =t_row.ele_code||'_sys_admin'; 
      select count (1) into J from fasp_t_caprovinceapply t where t.usercode =t_row.ele_code||'_sys_admin';   
      if J < 1 then 
          execute immediate '
          insert into fasp_t_caprovinceapply
            (province, name, usercode, application, status, applytime)
          values
            ('''||t_row.ele_code||''', 
             '''||t_row.ele_name||'��������Ա'',
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
         '''||t_row.ele_name||'��������Ա'',
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
         '''||lower(GET_PYJM(t_row.ele_name||'��������Ա'))||''',
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
         ''app1'')';
         execute immediate 'UPDATE ELE_VD08001 SET ISINITIALIZE = ''1'' WHERE ELE_CODE = '''|| t_row.ele_code ||'''';
         commit;
      end if; 
  end loop;
end;
