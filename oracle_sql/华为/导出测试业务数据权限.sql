---1.����ת��json���� bim pdm bdm  ��Ӧ�������ж���Ҫ����
SELECT global_multyear_cz.Secu_f_GLOBAL_SetPARM('','320000000','2022','')  from dual ;

create or replace function FACTOR_JSON (factorValues IN VARCHAR2) return  VARCHAR2 AS
  I integer;
  DGUID VARCHAR2(50);
  DNAME VARCHAR2(50);
  JSON VARCHAR2(4000);
  cursor b_cursor(DATARIGHTID string ) is
    (select regexp_substr(DATARIGHTID,'[^,]+', 1, level) DATARIGHTID from dual
    connect by regexp_substr(DATARIGHTID, '[^,]+', 1, level) is not NULL);
begin
        JSON:='[';
        for b_cur in b_cursor(factorValues) loop
         SELECT COUNT(1) INTO I FROM FASP_T_DATARIGHT t WHERE t.GUID = b_cur.DATARIGHTID;
         IF I > 0 THEN
           SELECT t.GUID,t.NAME INTO DGUID,DNAME FROM FASP_T_DATARIGHT t WHERE t.GUID = b_cur.DATARIGHTID;
           JSON:=JSON||'"{\"factorName\": \"'||DNAME||'\",\"factorValue\": \"'||DGUID||'\",\"factorCode\": \"factorCode\"}",';
         ELSE 
          JSON:=JSON||'"{\"factorName\": \"'||
           CASE b_cur.DATARIGHTID 
             WHEN 'alldatarignt' THEN '����Ȩ��'
             WHEN 'localagencydatarignt' THEN '����Ȩ��'
             WHEN 'loweragencydatarignt' THEN '�¼�Ȩ��'
             WHEN 'finintorg' THEN '����Ȩ��'
             WHEN 'paymentbank' THEN '�����б���' END
               
           ||'\",\"factorValue\": \"'||b_cur.DATARIGHTID||'\",\"factorCode\": \"factorCode\"}",';
         END IF; 
        end loop;
        JSON:=substr(JSON,0,LENGTH(JSON)-1);
        JSON:=JSON||']';
        RETURN JSON;
end;
/


--�˴ε������� Ϊ 001��001001,002,002001,003,003001��C01,C05�漰������Ϣ

--2.��������(ָ���û�  ��λ���� ���ң� app_orgnization

SELECT t.ele_id AS "orgId",
       t.ele_code AS "orgCode",
       t.ele_name AS "orgName",
       (SELECT ele_id
          FROM ele_vc01004 t2
         WHERE t2.ele_code = t.finintorg
           AND t2.mof_div_code = t.mof_div_code
           AND t2.fiscal_year = t.fiscal_year
           AND rownum = 1) AS "manageOrgId",
       (SELECT ele_name
          FROM ele_vc01004 t2
         WHERE t2.ele_code = t.finintorg
           AND t2.mof_div_code = t.mof_div_code
           AND t2.fiscal_year = t.fiscal_year
           AND rownum = 1) AS "manageOrgName",
       t.parent_id AS "parentOrgId",
       CASE T.IS_LEAF WHEN 1  THEN 'Y' WHEN 2 THEN 'N' WHEN 0 THEN 'N' END "isLeaf",
       (CASE
         WHEN LENGTH(t.ele_code) = 3 THEN
          '1'
         ELSE
          '3'
       END) AS "orgType",
       (CASE
         WHEN LENGTH(t.ele_code) = 3 THEN
          '����'
         ELSE
          'Ԥ�㵥λ'
       END) AS "orgTypeName",
       '' AS "sysOrgId",
       '' AS "sysOrgName",
       '' AS "bindOrigin",
       '' AS "bindRegionId",
       '' AS "sysOrgIdSync",
       '' AS "applicationId"
  FROM ele_vd00010 t
 WHERE t.mof_div_code = '320000000'
   AND t.fiscal_year = '2022'
   AND t.ele_code IN
       (
        
        SELECT CASE
                  WHEN LENGTH(t.upagencyid) = 9 THEN
                   t.division
                  ELSE
                   t.upagencyid
                END
          FROM fasp_t_causer t
         WHERE t.guid IN ('CFCEDB24EC5CD782947CE1F6EED2438E',
                          '5F4C737E540471CA270E27A96386EFB5',
                          '7565696F25091D2BF6AD6A129F2BFF22',
                          'A3F3AB3DBA8C17B8D43BD31179A232AC',
                          '084D694FFBE34B1E4A98304B141BFAF9',
                          '7669623C8AF44AAD35CA07C43DE3BA86'))
UNION ALL
SELECT t.ele_id AS "orgId",
       t.ele_code AS "orgCode",
       t.ele_name AS "orgName",
       '' AS "manageOrgId",
       '' AS "manageOrgName",
       t.parent_id AS "parentOrgId",
       CASE T.IS_LEAF WHEN 1  THEN 'Y' WHEN 2 THEN 'N' WHEN 0 THEN 'N' END "isLeaf",
       '2' AS "orgType",
       '����' AS "orgTypeName",
       '' AS "sysOrgId",
       '' AS "sysOrgName",
       '' AS "bindOrigin",
       '' AS "bindRegionId",
       '' AS "sysOrgIdSync",
       '' AS "applicationId"
  FROM ele_vc01004 t
 WHERE t.mof_div_code = '320000000'
   AND t.fiscal_year = '2022'
   AND t.ele_code IN
       (
        
        SELECT CASE
                  WHEN LENGTH(t.upagencyid) = 9 THEN
                   t.division
                  ELSE
                   t.upagencyid
                END
          FROM fasp_t_causer t
         WHERE t.guid IN ('AD8C3FD77803C808E053040213231234',
                          'ADEC33908860AB60E05308031323BD9E'));


--3.Ӧ��Ȩ����������app_subject
SELECT 'D8C09D0669BEEFD8E050A8C0022034CB' "subjectId",'HQ_MENU' "subjectCode",'����˵�' "subjectName",'' "applicationId",'����˵�' "description" FROM dual;

--4.����Ȩ��Ҫ��app_factor
SELECT 'DD0008A0026A294AE050A8C0052000AD' "guid", 'data_permission'"elementCode",'����Ȩ��'"elementName",'Y'"isSupportDimension",'N'"isSystemRegion",'N'"isAllowSelectAllLevels",''"regionId",'0'"isTree",''"applicationId" from dual;


--5.Ȩ������(��̨���ѯ) app_privilege
SELECT t.guid "privilegeId",
       t.code "privilegeCode",
       t.name "privilegeName",
       'D8C09D0669BEEFD8E050A8C0022034CB' "subjectId",
       '����˵�' "subjectName",
       t.province "regionCode",
       (SELECT ele_name
          FROM ele_vd08001
         WHERE ele_code = t.province
           AND fiscal_year = '2022') "regionName",
       '' "applicationName",
       '' "applicationId",
       '' "description"
  FROM fasp_t_pubmenu t
 WHERE t.guid IN
       (SELECT t.menuguid
          FROM fasp_t_carolemenu t
         WHERE t.roleguid IN
               (SELECT r.guid
                  FROM fasp_t_carole r
                 WHERE r.guid IN (SELECT t1.roleguid
                                    FROM fasp_t_causerrole t1
                                   WHERE t1.userguid IN
                                         (SELECT GUID
                                            FROM fasp_t_causer t2
                                           WHERE t2.code IN ('001',
                                                             '001001',
                                                             '002',
                                                             '002001',
                                                             '003',
                                                             '003001',
                                                             'C01',
                                                             'C05')
                                             AND t2.province = '320000000')
                                     AND t1.province = '320000000'
                                     AND t1.year = '2022')
                   AND r.province = '320000000'
                   AND r.year = '2022')
           AND t.province = '320000000'
           AND t.year = '2022');





--6.������ʱ������   (���sql��Ҫ��ʡ��������ҵ��ϵͳ  bim bdm pdm  �ж�����һ������)
SELECT guid|| '-320000000-bim', roleid, menuid, province, YEAR, userguid
  FROM (SELECT t.*, t.rowid
          FROM p#fasp_t_datarightrp t
         WHERE t.roleid IN (SELECT t.guid
                              FROM fasp_t_carole t
                             WHERE t.guid IN
                                   (SELECT t.roleguid
                                      FROM fasp_t_causerrole t
                                     WHERE t.userguid IN
                                           ('CFCEDB24EC5CD782947CE1F6EED2438E',
                                            '5F4C737E540471CA270E27A96386EFB5',
                                            'ADEC33908860AB60E05308031323BD9E',
                                            '7565696F25091D2BF6AD6A129F2BFF22',
                                            'A3F3AB3DBA8C17B8D43BD31179A232AC',
                                            'AD8C3FD77803C808E053040213231234',
                                            '084D694FFBE34B1E4A98304B141BFAF9',
                                            '7669623C8AF44AAD35CA07C43DE3BA86'))
                               AND t.province = '320000000'
                               AND t.year = '2022')
           AND t.province = '320000000'
           AND t.year = '2022'
        UNION ALL
        SELECT t.*, t.rowid
          FROM p#fasp_t_datarightrp t
         WHERE t.userguid IN
               ('CFCEDB24EC5CD782947CE1F6EED2438E',
                '5F4C737E540471CA270E27A96386EFB5',
                'ADEC33908860AB60E05308031323BD9E',
                '7565696F25091D2BF6AD6A129F2BFF22',
                'A3F3AB3DBA8C17B8D43BD31179A232AC',
                'AD8C3FD77803C808E053040213231234',
                '084D694FFBE34B1E4A98304B141BFAF9',
                '7669623C8AF44AAD35CA07C43DE3BA86')
           AND t.province = '320000000'
           AND t.year = '2022');





--7.����sql�е�������ָ���û�������Ȩ������
--�л�����Ӧʡ����320000000ҵ��ϵͳ��    ִ�������Ӧ��ҵ��ϵͳsql   �������ݺ��һ�ε�ȫ������һ���ļ� �ڶ���Ҳ������һ��
--bim
--��һ��

SELECT *
  FROM ((SELECT t.guid || '-320000000-bim-1' "relationId",
                t.MENUID "privilegeId",
                t.MENUID "privilegeCode",
                'D8C09D0669BEEFD8E050A8C0022034CB' "privilegeSubjectId",
                CASE
                  WHEN t.ROLEID IS NULL THEN
                   t.USERGUID
                  ELSE
                   t.ROLEID
                END "targetId",
                CASE
                  WHEN t.ROLEID IS NULL THEN
                   '1'
                  ELSE
                   '2'
                END "targetType",
                '1' "authRelationType",
                '1' "privilegeType",
                '' "description"
           FROM (SELECT t.*, t.rowid
                   FROM p#fasp_t_datarightrp t
                  WHERE t.roleid IN (SELECT t.guid
                                       FROM fasp_t_carole t
                                      WHERE t.guid IN
                                            (SELECT t.roleguid
                                               FROM fasp_t_causerrole t
                                              WHERE t.userguid IN
                                                    ('CFCEDB24EC5CD782947CE1F6EED2438E',
                                                     '5F4C737E540471CA270E27A96386EFB5',
                                                     'ADEC33908860AB60E05308031323BD9E',
                                                     '7565696F25091D2BF6AD6A129F2BFF22',
                                                     'A3F3AB3DBA8C17B8D43BD31179A232AC',
                                                     'AD8C3FD77803C808E053040213231234',
                                                     '084D694FFBE34B1E4A98304B141BFAF9',
                                                     '7669623C8AF44AAD35CA07C43DE3BA86'))
                                        AND t.province = '320000000'
                                        AND t.year = '2022')
                    AND t.province = '320000000'
                    AND t.year = '2022'
                 UNION ALL
                 SELECT t.*, t.rowid
                   FROM p#fasp_t_datarightrp t
                  WHERE t.userguid IN
                        ('CFCEDB24EC5CD782947CE1F6EED2438E',
                         '5F4C737E540471CA270E27A96386EFB5',
                         'ADEC33908860AB60E05308031323BD9E',
                         '7565696F25091D2BF6AD6A129F2BFF22',
                         'A3F3AB3DBA8C17B8D43BD31179A232AC',
                         'AD8C3FD77803C808E053040213231234',
                         '084D694FFBE34B1E4A98304B141BFAF9',
                         '7669623C8AF44AAD35CA07C43DE3BA86')
                    AND t.province = '320000000'
                    AND t.year = '2022') t
          WHERE t.roleid IS NOT NULL
            AND t.year = '2022') UNION ALL
        (SELECT t.guid || '-320000000-bim-1' "relationId",
                t.MENUID "privilegeId",
                
                t.MENUID "privilegeCode",
                
                'D8C09D0669BEEFD8E050A8C0022034CB' "privilegeSubjectId",
                CASE
                  WHEN t.ROLEID IS NULL THEN
                   t.USERGUID
                  ELSE
                   t.ROLEID
                END "targetId",
                CASE
                  WHEN t.ROLEID IS NULL THEN
                   '1'
                  ELSE
                   '2'
                END "targetType",
                '1' "authRelationType",
                '1' "privilegeType",
                '' "description"
           FROM (SELECT t.*, t.rowid
                   FROM p#fasp_t_datarightrp t
                  WHERE t.roleid IN (SELECT t.guid
                                       FROM fasp_t_carole t
                                      WHERE t.guid IN
                                            (SELECT t.roleguid
                                               FROM fasp_t_causerrole t
                                              WHERE t.userguid IN
                                                    ('CFCEDB24EC5CD782947CE1F6EED2438E',
                                                     '5F4C737E540471CA270E27A96386EFB5',
                                                     'ADEC33908860AB60E05308031323BD9E',
                                                     '7565696F25091D2BF6AD6A129F2BFF22',
                                                     'A3F3AB3DBA8C17B8D43BD31179A232AC',
                                                     'AD8C3FD77803C808E053040213231234',
                                                     '084D694FFBE34B1E4A98304B141BFAF9',
                                                     '7669623C8AF44AAD35CA07C43DE3BA86'))
                                        AND t.province = '320000000'
                                        AND t.year = '2022')
                    AND t.province = '320000000'
                    AND t.year = '2022'
                 UNION ALL
                 SELECT t.*, t.rowid
                   FROM p#fasp_t_datarightrp t
                  WHERE t.userguid IN
                        ('CFCEDB24EC5CD782947CE1F6EED2438E',
                         '5F4C737E540471CA270E27A96386EFB5',
                         'ADEC33908860AB60E05308031323BD9E',
                         '7565696F25091D2BF6AD6A129F2BFF22',
                         'A3F3AB3DBA8C17B8D43BD31179A232AC',
                         'AD8C3FD77803C808E053040213231234',
                         '084D694FFBE34B1E4A98304B141BFAF9',
                         '7669623C8AF44AAD35CA07C43DE3BA86')
                    AND t.province = '320000000'
                    AND t.year = '2022') t
          WHERE t.USERGUID IS NOT NULL
            AND t.year = '2022'));

--�ڶ���

  
SELECT *
  FROM ((SELECT 'DD0008A0026A294AE050A8C0052000AD' "privilegeId",
                'data_permission' "privilegeCode",
                CASE
                  WHEN t.ROLEID IS NULL THEN
                   t.userguid || '-' || t.menuid || '-' || t.province || '-1' || '-' ||
                   NVL((SELECT appid
                         FROM fasp_t_dataright
                        WHERE GUID = t.datarightid),
                       'bim') || '-2'
                
                  ELSE
                   t.roleid || '-' || t.menuid || '-' || t.province || '-2' || '-' ||
                   NVL((SELECT appid
                         FROM fasp_t_dataright
                        WHERE GUID = t.datarightid),
                       'bim') || '-2'
                END "relationId",
                
                t.guid || '-320000000-bim-1' "targetId",
                
                '3' targetType,
                
                FACTOR_JSON((SELECT listagg(T5.DATARIGHTID, ',') WITHIN GROUP(ORDER BY T5.DATARIGHTID) factorValues
                              FROM (SELECT t.*, t.rowid
                                      FROM p#fasp_t_datarightrp t
                                     WHERE t.roleid IN
                                           (SELECT t.guid
                                              FROM fasp_t_carole t
                                             WHERE t.guid IN
                                                   (SELECT t.roleguid
                                                      FROM fasp_t_causerrole t
                                                     WHERE t.userguid IN
                                                           ('CFCEDB24EC5CD782947CE1F6EED2438E',
                                                            '5F4C737E540471CA270E27A96386EFB5',
                                                            'ADEC33908860AB60E05308031323BD9E',
                                                            '7565696F25091D2BF6AD6A129F2BFF22',
                                                            'A3F3AB3DBA8C17B8D43BD31179A232AC',
                                                            'AD8C3FD77803C808E053040213231234',
                                                            '084D694FFBE34B1E4A98304B141BFAF9',
                                                            '7669623C8AF44AAD35CA07C43DE3BA86'))
                                               AND t.province = '320000000'
                                               AND t.year = '2022')
                                       AND t.province = '320000000'
                                       AND t.year = '2022'
                                    UNION ALL
                                    SELECT t.*, t.rowid
                                      FROM p#fasp_t_datarightrp t
                                     WHERE t.userguid IN
                                           ('CFCEDB24EC5CD782947CE1F6EED2438E',
                                            '5F4C737E540471CA270E27A96386EFB5',
                                            'ADEC33908860AB60E05308031323BD9E',
                                            '7565696F25091D2BF6AD6A129F2BFF22',
                                            'A3F3AB3DBA8C17B8D43BD31179A232AC',
                                            'AD8C3FD77803C808E053040213231234',
                                            '084D694FFBE34B1E4A98304B141BFAF9',
                                            '7669623C8AF44AAD35CA07C43DE3BA86')
                                       AND t.province = '320000000'
                                       AND t.year = '2022') T5
                             WHERE T.roleid IS NOT NULL
                               AND (T5.ROLEID, T5.MENUID) IN
                                   (SELECT T.ROLEID, T.MENUID FROM dual)
                             GROUP BY T5.ROLEID, T5.MENUID)) "factorValues",
                '1' "authRelationType",
                '2' "privilegeType",
                NVL((SELECT appid
                      FROM fasp_t_dataright
                     WHERE GUID = t.datarightid),
                    'bim') "elementDimensionValue",
                (SELECT t.appname
                   FROM FW_T_SYSAPP t
                  WHERE appid = (NVL((SELECT NAME
                                       FROM fasp_t_dataright
                                      WHERE GUID = t.datarightid),
                                     'bim'))) "elementDimensionName",
                '' "description"
           FROM (SELECT t.*, t.rowid
                   FROM p#fasp_t_datarightrp t
                  WHERE t.roleid IN (SELECT t.guid
                                       FROM fasp_t_carole t
                                      WHERE t.guid IN
                                            (SELECT t.roleguid
                                               FROM fasp_t_causerrole t
                                              WHERE t.userguid IN
                                                    ('CFCEDB24EC5CD782947CE1F6EED2438E',
                                                     '5F4C737E540471CA270E27A96386EFB5',
                                                     'ADEC33908860AB60E05308031323BD9E',
                                                     '7565696F25091D2BF6AD6A129F2BFF22',
                                                     'A3F3AB3DBA8C17B8D43BD31179A232AC',
                                                     'AD8C3FD77803C808E053040213231234',
                                                     '084D694FFBE34B1E4A98304B141BFAF9',
                                                     '7669623C8AF44AAD35CA07C43DE3BA86'))
                                        AND t.province = '320000000'
                                        AND t.year = '2022')
                    AND t.province = '320000000'
                    AND t.year = '2022'
                 UNION ALL
                 SELECT t.*, t.rowid
                   FROM p#fasp_t_datarightrp t
                  WHERE t.userguid IN
                        ('CFCEDB24EC5CD782947CE1F6EED2438E',
                         '5F4C737E540471CA270E27A96386EFB5',
                         'ADEC33908860AB60E05308031323BD9E',
                         '7565696F25091D2BF6AD6A129F2BFF22',
                         'A3F3AB3DBA8C17B8D43BD31179A232AC',
                         'AD8C3FD77803C808E053040213231234',
                         '084D694FFBE34B1E4A98304B141BFAF9',
                         '7669623C8AF44AAD35CA07C43DE3BA86')
                    AND t.province = '320000000'
                    AND t.year = '2022') t
          WHERE t.roleid IS NOT NULL
            AND t.year = '2022') UNION ALL
        (SELECT 'DD0008A0026A294AE050A8C0052000AD' "privilegeId",
                'data_permission' "privilegeCode",
                
                CASE
                  WHEN t.ROLEID IS NULL THEN
                   t.userguid || '-' || t.menuid || '-' || t.province || '-1' || '-' ||
                   NVL((SELECT appid
                         FROM fasp_t_dataright
                        WHERE GUID = t.datarightid),
                       'bim') || '-2'
                
                  ELSE
                   t.userguid || '-' || t.menuid || '-' || t.province || '-2' || '-' ||
                   NVL((SELECT appid
                         FROM fasp_t_dataright
                        WHERE GUID = t.datarightid),
                       'bim') || '-2'
                END "relationId",
                
                t.guid || '-320000000-bim-1' "targetId",
                '3' targetType,
                FACTOR_JSON((SELECT listagg(T5.DATARIGHTID, ',') WITHIN GROUP(ORDER BY T5.DATARIGHTID) factorValues
                              FROM (SELECT t.*, t.rowid
                                      FROM p#fasp_t_datarightrp t
                                     WHERE t.roleid IN
                                           (SELECT t.guid
                                              FROM fasp_t_carole t
                                             WHERE t.guid IN
                                                   (SELECT t.roleguid
                                                      FROM fasp_t_causerrole t
                                                     WHERE t.userguid IN
                                                           ('CFCEDB24EC5CD782947CE1F6EED2438E',
                                                            '5F4C737E540471CA270E27A96386EFB5',
                                                            'ADEC33908860AB60E05308031323BD9E',
                                                            '7565696F25091D2BF6AD6A129F2BFF22',
                                                            'A3F3AB3DBA8C17B8D43BD31179A232AC',
                                                            'AD8C3FD77803C808E053040213231234',
                                                            '084D694FFBE34B1E4A98304B141BFAF9',
                                                            '7669623C8AF44AAD35CA07C43DE3BA86'))
                                               AND t.province = '320000000'
                                               AND t.year = '2022')
                                       AND t.province = '320000000'
                                       AND t.year = '2022'
                                    UNION ALL
                                    SELECT t.*, t.rowid
                                      FROM p#fasp_t_datarightrp t
                                     WHERE t.userguid IN
                                           ('CFCEDB24EC5CD782947CE1F6EED2438E',
                                            '5F4C737E540471CA270E27A96386EFB5',
                                            'ADEC33908860AB60E05308031323BD9E',
                                            '7565696F25091D2BF6AD6A129F2BFF22',
                                            'A3F3AB3DBA8C17B8D43BD31179A232AC',
                                            'AD8C3FD77803C808E053040213231234',
                                            '084D694FFBE34B1E4A98304B141BFAF9',
                                            '7669623C8AF44AAD35CA07C43DE3BA86')
                                       AND t.province = '320000000'
                                       AND t.year = '2022') T5
                             WHERE T.USERGUID IS NOT NULL
                               AND (T5.USERGUID, T5.MENUID) IN
                                   (SELECT T.USERGUID, T.MENUID FROM dual)
                             GROUP BY T5.USERGUID, T5.MENUID)) "factorValues",
                '1' "authRelationType",
                '2' "privilegeType",
                NVL((SELECT appid
                      FROM fasp_t_dataright
                     WHERE GUID = t.datarightid),
                    'bim') "elementDimensionValue",
                (SELECT t.appname
                   FROM FW_T_SYSAPP t
                  WHERE appid = (NVL((SELECT NAME
                                       FROM fasp_t_dataright
                                      WHERE GUID = t.datarightid),
                                     'bim'))) "elementDimensionName",
                '' "description"
           FROM (SELECT t.*, t.rowid
                   FROM p#fasp_t_datarightrp t
                  WHERE t.roleid IN (SELECT t.guid
                                       FROM fasp_t_carole t
                                      WHERE t.guid IN
                                            (SELECT t.roleguid
                                               FROM fasp_t_causerrole t
                                              WHERE t.userguid IN
                                                    ('CFCEDB24EC5CD782947CE1F6EED2438E',
                                                     '5F4C737E540471CA270E27A96386EFB5',
                                                     'ADEC33908860AB60E05308031323BD9E',
                                                     '7565696F25091D2BF6AD6A129F2BFF22',
                                                     'A3F3AB3DBA8C17B8D43BD31179A232AC',
                                                     'AD8C3FD77803C808E053040213231234',
                                                     '084D694FFBE34B1E4A98304B141BFAF9',
                                                     '7669623C8AF44AAD35CA07C43DE3BA86'))
                                        AND t.province = '320000000'
                                        AND t.year = '2022')
                    AND t.province = '320000000'
                    AND t.year = '2022'
                 UNION ALL
                 SELECT t.*, t.rowid
                   FROM p#fasp_t_datarightrp t
                  WHERE t.userguid IN
                        ('CFCEDB24EC5CD782947CE1F6EED2438E',
                         '5F4C737E540471CA270E27A96386EFB5',
                         'ADEC33908860AB60E05308031323BD9E',
                         '7565696F25091D2BF6AD6A129F2BFF22',
                         'A3F3AB3DBA8C17B8D43BD31179A232AC',
                         'AD8C3FD77803C808E053040213231234',
                         '084D694FFBE34B1E4A98304B141BFAF9',
                         '7669623C8AF44AAD35CA07C43DE3BA86')
                    AND t.province = '320000000'
                    AND t.year = '2022') t
          WHERE t.USERGUID IS NOT NULL
            AND t.year = '2022'));


--pdm
--��һ��

SELECT *
  FROM ((SELECT t.guid || '-320000000-pdm-1' "relationId",
                t.MENUID "privilegeId",
                t.MENUID "privilegeCode",
                'D8C09D0669BEEFD8E050A8C0022034CB' "privilegeSubjectId",
                CASE
                  WHEN t.ROLEID IS NULL THEN
                   t.USERGUID
                  ELSE
                   t.ROLEID
                END "targetId",
                CASE
                  WHEN t.ROLEID IS NULL THEN
                   '1'
                  ELSE
                   '2'
                END "targetType",
                '1' "authRelationType",
                '1' "privilegeType",
                '' "description"
           FROM (SELECT t.*, t.rowid
                   FROM p#fasp_t_datarightrp t
                  WHERE t.roleid IN (SELECT t.guid
                                       FROM fasp_t_carole t
                                      WHERE t.guid IN
                                            (SELECT t.roleguid
                                               FROM fasp_t_causerrole t
                                              WHERE t.userguid IN
                                                    ('CFCEDB24EC5CD782947CE1F6EED2438E',
                                                     '5F4C737E540471CA270E27A96386EFB5',
                                                     'ADEC33908860AB60E05308031323BD9E',
                                                     '7565696F25091D2BF6AD6A129F2BFF22',
                                                     'A3F3AB3DBA8C17B8D43BD31179A232AC',
                                                     'AD8C3FD77803C808E053040213231234',
                                                     '084D694FFBE34B1E4A98304B141BFAF9',
                                                     '7669623C8AF44AAD35CA07C43DE3BA86'))
                                        AND t.province = '320000000'
                                        AND t.year = '2022')
                    AND t.province = '320000000'
                    AND t.year = '2022'
                 UNION ALL
                 SELECT t.*, t.rowid
                   FROM p#fasp_t_datarightrp t
                  WHERE t.userguid IN
                        ('CFCEDB24EC5CD782947CE1F6EED2438E',
                         '5F4C737E540471CA270E27A96386EFB5',
                         'ADEC33908860AB60E05308031323BD9E',
                         '7565696F25091D2BF6AD6A129F2BFF22',
                         'A3F3AB3DBA8C17B8D43BD31179A232AC',
                         'AD8C3FD77803C808E053040213231234',
                         '084D694FFBE34B1E4A98304B141BFAF9',
                         '7669623C8AF44AAD35CA07C43DE3BA86')
                    AND t.province = '320000000'
                    AND t.year = '2022') t
          WHERE t.roleid IS NOT NULL
            AND t.year = '2022') UNION ALL
        (SELECT t.guid || '-320000000-pdm-1' "relationId",
                t.MENUID "privilegeId",
                
                t.MENUID "privilegeCode",
                
                'D8C09D0669BEEFD8E050A8C0022034CB' "privilegeSubjectId",
                CASE
                  WHEN t.ROLEID IS NULL THEN
                   t.USERGUID
                  ELSE
                   t.ROLEID
                END "targetId",
                CASE
                  WHEN t.ROLEID IS NULL THEN
                   '1'
                  ELSE
                   '2'
                END "targetType",
                '1' "authRelationType",
                '1' "privilegeType",
                '' "description"
           FROM (SELECT t.*, t.rowid
                   FROM p#fasp_t_datarightrp t
                  WHERE t.roleid IN (SELECT t.guid
                                       FROM fasp_t_carole t
                                      WHERE t.guid IN
                                            (SELECT t.roleguid
                                               FROM fasp_t_causerrole t
                                              WHERE t.userguid IN
                                                    ('CFCEDB24EC5CD782947CE1F6EED2438E',
                                                     '5F4C737E540471CA270E27A96386EFB5',
                                                     'ADEC33908860AB60E05308031323BD9E',
                                                     '7565696F25091D2BF6AD6A129F2BFF22',
                                                     'A3F3AB3DBA8C17B8D43BD31179A232AC',
                                                     'AD8C3FD77803C808E053040213231234',
                                                     '084D694FFBE34B1E4A98304B141BFAF9',
                                                     '7669623C8AF44AAD35CA07C43DE3BA86'))
                                        AND t.province = '320000000'
                                        AND t.year = '2022')
                    AND t.province = '320000000'
                    AND t.year = '2022'
                 UNION ALL
                 SELECT t.*, t.rowid
                   FROM p#fasp_t_datarightrp t
                  WHERE t.userguid IN
                        ('CFCEDB24EC5CD782947CE1F6EED2438E',
                         '5F4C737E540471CA270E27A96386EFB5',
                         'ADEC33908860AB60E05308031323BD9E',
                         '7565696F25091D2BF6AD6A129F2BFF22',
                         'A3F3AB3DBA8C17B8D43BD31179A232AC',
                         'AD8C3FD77803C808E053040213231234',
                         '084D694FFBE34B1E4A98304B141BFAF9',
                         '7669623C8AF44AAD35CA07C43DE3BA86')
                    AND t.province = '320000000'
                    AND t.year = '2022') t
          WHERE t.USERGUID IS NOT NULL
            AND t.year = '2022'));

--�ڶ���

  
SELECT *
  FROM ((SELECT 'DD0008A0026A294AE050A8C0052000AD' "privilegeId",
                'data_permission' "privilegeCode",
                CASE
                  WHEN t.ROLEID IS NULL THEN
                   t.userguid || '-' || t.menuid || '-' || t.province || '-1' || '-' ||
                   NVL((SELECT appid
                         FROM fasp_t_dataright
                        WHERE GUID = t.datarightid),
                       'pdm') || '-2'
                
                  ELSE
                   t.roleid || '-' || t.menuid || '-' || t.province || '-2' || '-' ||
                   NVL((SELECT appid
                         FROM fasp_t_dataright
                        WHERE GUID = t.datarightid),
                       'pdm') || '-2'
                END "relationId",
                
                t.guid || '-320000000-pdm-1' "targetId",
                
                '3' targetType,
                
                FACTOR_JSON((SELECT listagg(T5.DATARIGHTID, ',') WITHIN GROUP(ORDER BY T5.DATARIGHTID) factorValues
                              FROM (SELECT t.*, t.rowid
                                      FROM p#fasp_t_datarightrp t
                                     WHERE t.roleid IN
                                           (SELECT t.guid
                                              FROM fasp_t_carole t
                                             WHERE t.guid IN
                                                   (SELECT t.roleguid
                                                      FROM fasp_t_causerrole t
                                                     WHERE t.userguid IN
                                                           ('CFCEDB24EC5CD782947CE1F6EED2438E',
                                                            '5F4C737E540471CA270E27A96386EFB5',
                                                            'ADEC33908860AB60E05308031323BD9E',
                                                            '7565696F25091D2BF6AD6A129F2BFF22',
                                                            'A3F3AB3DBA8C17B8D43BD31179A232AC',
                                                            'AD8C3FD77803C808E053040213231234',
                                                            '084D694FFBE34B1E4A98304B141BFAF9',
                                                            '7669623C8AF44AAD35CA07C43DE3BA86'))
                                               AND t.province = '320000000'
                                               AND t.year = '2022')
                                       AND t.province = '320000000'
                                       AND t.year = '2022'
                                    UNION ALL
                                    SELECT t.*, t.rowid
                                      FROM p#fasp_t_datarightrp t
                                     WHERE t.userguid IN
                                           ('CFCEDB24EC5CD782947CE1F6EED2438E',
                                            '5F4C737E540471CA270E27A96386EFB5',
                                            'ADEC33908860AB60E05308031323BD9E',
                                            '7565696F25091D2BF6AD6A129F2BFF22',
                                            'A3F3AB3DBA8C17B8D43BD31179A232AC',
                                            'AD8C3FD77803C808E053040213231234',
                                            '084D694FFBE34B1E4A98304B141BFAF9',
                                            '7669623C8AF44AAD35CA07C43DE3BA86')
                                       AND t.province = '320000000'
                                       AND t.year = '2022') T5
                             WHERE T.roleid IS NOT NULL
                               AND (T5.ROLEID, T5.MENUID) IN
                                   (SELECT T.ROLEID, T.MENUID FROM dual)
                             GROUP BY T5.ROLEID, T5.MENUID)) "factorValues",
                '1' "authRelationType",
                '2' "privilegeType",
                NVL((SELECT appid
                      FROM fasp_t_dataright
                     WHERE GUID = t.datarightid),
                    'pdm') "elementDimensionValue",
                (SELECT t.appname
                   FROM FW_T_SYSAPP t
                  WHERE appid = (NVL((SELECT NAME
                                       FROM fasp_t_dataright
                                      WHERE GUID = t.datarightid),
                                     'pdm'))) "elementDimensionName",
                '' "description"
           FROM (SELECT t.*, t.rowid
                   FROM p#fasp_t_datarightrp t
                  WHERE t.roleid IN (SELECT t.guid
                                       FROM fasp_t_carole t
                                      WHERE t.guid IN
                                            (SELECT t.roleguid
                                               FROM fasp_t_causerrole t
                                              WHERE t.userguid IN
                                                    ('CFCEDB24EC5CD782947CE1F6EED2438E',
                                                     '5F4C737E540471CA270E27A96386EFB5',
                                                     'ADEC33908860AB60E05308031323BD9E',
                                                     '7565696F25091D2BF6AD6A129F2BFF22',
                                                     'A3F3AB3DBA8C17B8D43BD31179A232AC',
                                                     'AD8C3FD77803C808E053040213231234',
                                                     '084D694FFBE34B1E4A98304B141BFAF9',
                                                     '7669623C8AF44AAD35CA07C43DE3BA86'))
                                        AND t.province = '320000000'
                                        AND t.year = '2022')
                    AND t.province = '320000000'
                    AND t.year = '2022'
                 UNION ALL
                 SELECT t.*, t.rowid
                   FROM p#fasp_t_datarightrp t
                  WHERE t.userguid IN
                        ('CFCEDB24EC5CD782947CE1F6EED2438E',
                         '5F4C737E540471CA270E27A96386EFB5',
                         'ADEC33908860AB60E05308031323BD9E',
                         '7565696F25091D2BF6AD6A129F2BFF22',
                         'A3F3AB3DBA8C17B8D43BD31179A232AC',
                         'AD8C3FD77803C808E053040213231234',
                         '084D694FFBE34B1E4A98304B141BFAF9',
                         '7669623C8AF44AAD35CA07C43DE3BA86')
                    AND t.province = '320000000'
                    AND t.year = '2022') t
          WHERE t.roleid IS NOT NULL
            AND t.year = '2022') UNION ALL
        (SELECT 'DD0008A0026A294AE050A8C0052000AD' "privilegeId",
                'data_permission' "privilegeCode",
                
                CASE
                  WHEN t.ROLEID IS NULL THEN
                   t.userguid || '-' || t.menuid || '-' || t.province || '-1' || '-' ||
                   NVL((SELECT appid
                         FROM fasp_t_dataright
                        WHERE GUID = t.datarightid),
                       'pdm') || '-2'
                
                  ELSE
                   t.userguid || '-' || t.menuid || '-' || t.province || '-2' || '-' ||
                   NVL((SELECT appid
                         FROM fasp_t_dataright
                        WHERE GUID = t.datarightid),
                       'pdm') || '-2'
                END "relationId",
                
                t.guid || '-320000000-pdm-1' "targetId",
                '3' targetType,
                FACTOR_JSON((SELECT listagg(T5.DATARIGHTID, ',') WITHIN GROUP(ORDER BY T5.DATARIGHTID) factorValues
                              FROM (SELECT t.*, t.rowid
                                      FROM p#fasp_t_datarightrp t
                                     WHERE t.roleid IN
                                           (SELECT t.guid
                                              FROM fasp_t_carole t
                                             WHERE t.guid IN
                                                   (SELECT t.roleguid
                                                      FROM fasp_t_causerrole t
                                                     WHERE t.userguid IN
                                                           ('CFCEDB24EC5CD782947CE1F6EED2438E',
                                                            '5F4C737E540471CA270E27A96386EFB5',
                                                            'ADEC33908860AB60E05308031323BD9E',
                                                            '7565696F25091D2BF6AD6A129F2BFF22',
                                                            'A3F3AB3DBA8C17B8D43BD31179A232AC',
                                                            'AD8C3FD77803C808E053040213231234',
                                                            '084D694FFBE34B1E4A98304B141BFAF9',
                                                            '7669623C8AF44AAD35CA07C43DE3BA86'))
                                               AND t.province = '320000000'
                                               AND t.year = '2022')
                                       AND t.province = '320000000'
                                       AND t.year = '2022'
                                    UNION ALL
                                    SELECT t.*, t.rowid
                                      FROM p#fasp_t_datarightrp t
                                     WHERE t.userguid IN
                                           ('CFCEDB24EC5CD782947CE1F6EED2438E',
                                            '5F4C737E540471CA270E27A96386EFB5',
                                            'ADEC33908860AB60E05308031323BD9E',
                                            '7565696F25091D2BF6AD6A129F2BFF22',
                                            'A3F3AB3DBA8C17B8D43BD31179A232AC',
                                            'AD8C3FD77803C808E053040213231234',
                                            '084D694FFBE34B1E4A98304B141BFAF9',
                                            '7669623C8AF44AAD35CA07C43DE3BA86')
                                       AND t.province = '320000000'
                                       AND t.year = '2022') T5
                             WHERE T.USERGUID IS NOT NULL
                               AND (T5.USERGUID, T5.MENUID) IN
                                   (SELECT T.USERGUID, T.MENUID FROM dual)
                             GROUP BY T5.USERGUID, T5.MENUID)) "factorValues",
                '1' "authRelationType",
                '2' "privilegeType",
                NVL((SELECT appid
                      FROM fasp_t_dataright
                     WHERE GUID = t.datarightid),
                    'pdm') "elementDimensionValue",
                (SELECT t.appname
                   FROM FW_T_SYSAPP t
                  WHERE appid = (NVL((SELECT NAME
                                       FROM fasp_t_dataright
                                      WHERE GUID = t.datarightid),
                                     'pdm'))) "elementDimensionName",
                '' "description"
           FROM (SELECT t.*, t.rowid
                   FROM p#fasp_t_datarightrp t
                  WHERE t.roleid IN (SELECT t.guid
                                       FROM fasp_t_carole t
                                      WHERE t.guid IN
                                            (SELECT t.roleguid
                                               FROM fasp_t_causerrole t
                                              WHERE t.userguid IN
                                                    ('CFCEDB24EC5CD782947CE1F6EED2438E',
                                                     '5F4C737E540471CA270E27A96386EFB5',
                                                     'ADEC33908860AB60E05308031323BD9E',
                                                     '7565696F25091D2BF6AD6A129F2BFF22',
                                                     'A3F3AB3DBA8C17B8D43BD31179A232AC',
                                                     'AD8C3FD77803C808E053040213231234',
                                                     '084D694FFBE34B1E4A98304B141BFAF9',
                                                     '7669623C8AF44AAD35CA07C43DE3BA86'))
                                        AND t.province = '320000000'
                                        AND t.year = '2022')
                    AND t.province = '320000000'
                    AND t.year = '2022'
                 UNION ALL
                 SELECT t.*, t.rowid
                   FROM p#fasp_t_datarightrp t
                  WHERE t.userguid IN
                        ('CFCEDB24EC5CD782947CE1F6EED2438E',
                         '5F4C737E540471CA270E27A96386EFB5',
                         'ADEC33908860AB60E05308031323BD9E',
                         '7565696F25091D2BF6AD6A129F2BFF22',
                         'A3F3AB3DBA8C17B8D43BD31179A232AC',
                         'AD8C3FD77803C808E053040213231234',
                         '084D694FFBE34B1E4A98304B141BFAF9',
                         '7669623C8AF44AAD35CA07C43DE3BA86')
                    AND t.province = '320000000'
                    AND t.year = '2022') t
          WHERE t.USERGUID IS NOT NULL
            AND t.year = '2022'));

--bdm
--��һ��

SELECT *
  FROM ((SELECT t.guid || '-320000000-bdm-1' "relationId",
                t.MENUID "privilegeId",
                t.MENUID "privilegeCode",
                'D8C09D0669BEEFD8E050A8C0022034CB' "privilegeSubjectId",
                CASE
                  WHEN t.ROLEID IS NULL THEN
                   t.USERGUID
                  ELSE
                   t.ROLEID
                END "targetId",
                CASE
                  WHEN t.ROLEID IS NULL THEN
                   '1'
                  ELSE
                   '2'
                END "targetType",
                '1' "authRelationType",
                '1' "privilegeType",
                '' "description"
           FROM (SELECT t.*, t.rowid
                   FROM p#fasp_t_datarightrp t
                  WHERE t.roleid IN (SELECT t.guid
                                       FROM fasp_t_carole t
                                      WHERE t.guid IN
                                            (SELECT t.roleguid
                                               FROM fasp_t_causerrole t
                                              WHERE t.userguid IN
                                                    ('CFCEDB24EC5CD782947CE1F6EED2438E',
                                                     '5F4C737E540471CA270E27A96386EFB5',
                                                     'ADEC33908860AB60E05308031323BD9E',
                                                     '7565696F25091D2BF6AD6A129F2BFF22',
                                                     'A3F3AB3DBA8C17B8D43BD31179A232AC',
                                                     'AD8C3FD77803C808E053040213231234',
                                                     '084D694FFBE34B1E4A98304B141BFAF9',
                                                     '7669623C8AF44AAD35CA07C43DE3BA86'))
                                        AND t.province = '320000000'
                                        AND t.year = '2022')
                    AND t.province = '320000000'
                    AND t.year = '2022'
                 UNION ALL
                 SELECT t.*, t.rowid
                   FROM p#fasp_t_datarightrp t
                  WHERE t.userguid IN
                        ('CFCEDB24EC5CD782947CE1F6EED2438E',
                         '5F4C737E540471CA270E27A96386EFB5',
                         'ADEC33908860AB60E05308031323BD9E',
                         '7565696F25091D2BF6AD6A129F2BFF22',
                         'A3F3AB3DBA8C17B8D43BD31179A232AC',
                         'AD8C3FD77803C808E053040213231234',
                         '084D694FFBE34B1E4A98304B141BFAF9',
                         '7669623C8AF44AAD35CA07C43DE3BA86')
                    AND t.province = '320000000'
                    AND t.year = '2022') t
          WHERE t.roleid IS NOT NULL
            AND t.year = '2022') UNION ALL
        (SELECT t.guid || '-320000000-bdm-1' "relationId",
                t.MENUID "privilegeId",
                
                t.MENUID "privilegeCode",
                
                'D8C09D0669BEEFD8E050A8C0022034CB' "privilegeSubjectId",
                CASE
                  WHEN t.ROLEID IS NULL THEN
                   t.USERGUID
                  ELSE
                   t.ROLEID
                END "targetId",
                CASE
                  WHEN t.ROLEID IS NULL THEN
                   '1'
                  ELSE
                   '2'
                END "targetType",
                '1' "authRelationType",
                '1' "privilegeType",
                '' "description"
           FROM (SELECT t.*, t.rowid
                   FROM p#fasp_t_datarightrp t
                  WHERE t.roleid IN (SELECT t.guid
                                       FROM fasp_t_carole t
                                      WHERE t.guid IN
                                            (SELECT t.roleguid
                                               FROM fasp_t_causerrole t
                                              WHERE t.userguid IN
                                                    ('CFCEDB24EC5CD782947CE1F6EED2438E',
                                                     '5F4C737E540471CA270E27A96386EFB5',
                                                     'ADEC33908860AB60E05308031323BD9E',
                                                     '7565696F25091D2BF6AD6A129F2BFF22',
                                                     'A3F3AB3DBA8C17B8D43BD31179A232AC',
                                                     'AD8C3FD77803C808E053040213231234',
                                                     '084D694FFBE34B1E4A98304B141BFAF9',
                                                     '7669623C8AF44AAD35CA07C43DE3BA86'))
                                        AND t.province = '320000000'
                                        AND t.year = '2022')
                    AND t.province = '320000000'
                    AND t.year = '2022'
                 UNION ALL
                 SELECT t.*, t.rowid
                   FROM p#fasp_t_datarightrp t
                  WHERE t.userguid IN
                        ('CFCEDB24EC5CD782947CE1F6EED2438E',
                         '5F4C737E540471CA270E27A96386EFB5',
                         'ADEC33908860AB60E05308031323BD9E',
                         '7565696F25091D2BF6AD6A129F2BFF22',
                         'A3F3AB3DBA8C17B8D43BD31179A232AC',
                         'AD8C3FD77803C808E053040213231234',
                         '084D694FFBE34B1E4A98304B141BFAF9',
                         '7669623C8AF44AAD35CA07C43DE3BA86')
                    AND t.province = '320000000'
                    AND t.year = '2022') t
          WHERE t.USERGUID IS NOT NULL
            AND t.year = '2022'));

--�ڶ���

  
SELECT *
  FROM ((SELECT 'DD0008A0026A294AE050A8C0052000AD' "privilegeId",
                'data_permission' "privilegeCode",
                CASE
                  WHEN t.ROLEID IS NULL THEN
                   t.userguid || '-' || t.menuid || '-' || t.province || '-1' || '-' ||
                   NVL((SELECT appid
                         FROM fasp_t_dataright
                        WHERE GUID = t.datarightid),
                       'bdm') || '-2'
                
                  ELSE
                   t.roleid || '-' || t.menuid || '-' || t.province || '-2' || '-' ||
                   NVL((SELECT appid
                         FROM fasp_t_dataright
                        WHERE GUID = t.datarightid),
                       'bdm') || '-2'
                END "relationId",
                
                t.guid || '-320000000-bdm-1' "targetId",
                
                '3' targetType,
                
                FACTOR_JSON((SELECT listagg(T5.DATARIGHTID, ',') WITHIN GROUP(ORDER BY T5.DATARIGHTID) factorValues
                              FROM (SELECT t.*, t.rowid
                                      FROM p#fasp_t_datarightrp t
                                     WHERE t.roleid IN
                                           (SELECT t.guid
                                              FROM fasp_t_carole t
                                             WHERE t.guid IN
                                                   (SELECT t.roleguid
                                                      FROM fasp_t_causerrole t
                                                     WHERE t.userguid IN
                                                           ('CFCEDB24EC5CD782947CE1F6EED2438E',
                                                            '5F4C737E540471CA270E27A96386EFB5',
                                                            'ADEC33908860AB60E05308031323BD9E',
                                                            '7565696F25091D2BF6AD6A129F2BFF22',
                                                            'A3F3AB3DBA8C17B8D43BD31179A232AC',
                                                            'AD8C3FD77803C808E053040213231234',
                                                            '084D694FFBE34B1E4A98304B141BFAF9',
                                                            '7669623C8AF44AAD35CA07C43DE3BA86'))
                                               AND t.province = '320000000'
                                               AND t.year = '2022')
                                       AND t.province = '320000000'
                                       AND t.year = '2022'
                                    UNION ALL
                                    SELECT t.*, t.rowid
                                      FROM p#fasp_t_datarightrp t
                                     WHERE t.userguid IN
                                           ('CFCEDB24EC5CD782947CE1F6EED2438E',
                                            '5F4C737E540471CA270E27A96386EFB5',
                                            'ADEC33908860AB60E05308031323BD9E',
                                            '7565696F25091D2BF6AD6A129F2BFF22',
                                            'A3F3AB3DBA8C17B8D43BD31179A232AC',
                                            'AD8C3FD77803C808E053040213231234',
                                            '084D694FFBE34B1E4A98304B141BFAF9',
                                            '7669623C8AF44AAD35CA07C43DE3BA86')
                                       AND t.province = '320000000'
                                       AND t.year = '2022') T5
                             WHERE T.roleid IS NOT NULL
                               AND (T5.ROLEID, T5.MENUID) IN
                                   (SELECT T.ROLEID, T.MENUID FROM dual)
                             GROUP BY T5.ROLEID, T5.MENUID)) "factorValues",
                '1' "authRelationType",
                '2' "privilegeType",
                NVL((SELECT appid
                      FROM fasp_t_dataright
                     WHERE GUID = t.datarightid),
                    'bdm') "elementDimensionValue",
                (SELECT t.appname
                   FROM FW_T_SYSAPP t
                  WHERE appid = (NVL((SELECT NAME
                                       FROM fasp_t_dataright
                                      WHERE GUID = t.datarightid),
                                     'bdm'))) "elementDimensionName",
                '' "description"
           FROM (SELECT t.*, t.rowid
                   FROM p#fasp_t_datarightrp t
                  WHERE t.roleid IN (SELECT t.guid
                                       FROM fasp_t_carole t
                                      WHERE t.guid IN
                                            (SELECT t.roleguid
                                               FROM fasp_t_causerrole t
                                              WHERE t.userguid IN
                                                    ('CFCEDB24EC5CD782947CE1F6EED2438E',
                                                     '5F4C737E540471CA270E27A96386EFB5',
                                                     'ADEC33908860AB60E05308031323BD9E',
                                                     '7565696F25091D2BF6AD6A129F2BFF22',
                                                     'A3F3AB3DBA8C17B8D43BD31179A232AC',
                                                     'AD8C3FD77803C808E053040213231234',
                                                     '084D694FFBE34B1E4A98304B141BFAF9',
                                                     '7669623C8AF44AAD35CA07C43DE3BA86'))
                                        AND t.province = '320000000'
                                        AND t.year = '2022')
                    AND t.province = '320000000'
                    AND t.year = '2022'
                 UNION ALL
                 SELECT t.*, t.rowid
                   FROM p#fasp_t_datarightrp t
                  WHERE t.userguid IN
                        ('CFCEDB24EC5CD782947CE1F6EED2438E',
                         '5F4C737E540471CA270E27A96386EFB5',
                         'ADEC33908860AB60E05308031323BD9E',
                         '7565696F25091D2BF6AD6A129F2BFF22',
                         'A3F3AB3DBA8C17B8D43BD31179A232AC',
                         'AD8C3FD77803C808E053040213231234',
                         '084D694FFBE34B1E4A98304B141BFAF9',
                         '7669623C8AF44AAD35CA07C43DE3BA86')
                    AND t.province = '320000000'
                    AND t.year = '2022') t
          WHERE t.roleid IS NOT NULL
            AND t.year = '2022') UNION ALL
        (SELECT 'DD0008A0026A294AE050A8C0052000AD' "privilegeId",
                'data_permission' "privilegeCode",
                
                CASE
                  WHEN t.ROLEID IS NULL THEN
                   t.userguid || '-' || t.menuid || '-' || t.province || '-1' || '-' ||
                   NVL((SELECT appid
                         FROM fasp_t_dataright
                        WHERE GUID = t.datarightid),
                       'bdm') || '-2'
                
                  ELSE
                   t.userguid || '-' || t.menuid || '-' || t.province || '-2' || '-' ||
                   NVL((SELECT appid
                         FROM fasp_t_dataright
                        WHERE GUID = t.datarightid),
                       'bdm') || '-2'
                END "relationId",
                
                t.guid || '-320000000-bdm-1' "targetId",
                '3' targetType,
                FACTOR_JSON((SELECT listagg(T5.DATARIGHTID, ',') WITHIN GROUP(ORDER BY T5.DATARIGHTID) factorValues
                              FROM (SELECT t.*, t.rowid
                                      FROM p#fasp_t_datarightrp t
                                     WHERE t.roleid IN
                                           (SELECT t.guid
                                              FROM fasp_t_carole t
                                             WHERE t.guid IN
                                                   (SELECT t.roleguid
                                                      FROM fasp_t_causerrole t
                                                     WHERE t.userguid IN
                                                           ('CFCEDB24EC5CD782947CE1F6EED2438E',
                                                            '5F4C737E540471CA270E27A96386EFB5',
                                                            'ADEC33908860AB60E05308031323BD9E',
                                                            '7565696F25091D2BF6AD6A129F2BFF22',
                                                            'A3F3AB3DBA8C17B8D43BD31179A232AC',
                                                            'AD8C3FD77803C808E053040213231234',
                                                            '084D694FFBE34B1E4A98304B141BFAF9',
                                                            '7669623C8AF44AAD35CA07C43DE3BA86'))
                                               AND t.province = '320000000'
                                               AND t.year = '2022')
                                       AND t.province = '320000000'
                                       AND t.year = '2022'
                                    UNION ALL
                                    SELECT t.*, t.rowid
                                      FROM p#fasp_t_datarightrp t
                                     WHERE t.userguid IN
                                           ('CFCEDB24EC5CD782947CE1F6EED2438E',
                                            '5F4C737E540471CA270E27A96386EFB5',
                                            'ADEC33908860AB60E05308031323BD9E',
                                            '7565696F25091D2BF6AD6A129F2BFF22',
                                            'A3F3AB3DBA8C17B8D43BD31179A232AC',
                                            'AD8C3FD77803C808E053040213231234',
                                            '084D694FFBE34B1E4A98304B141BFAF9',
                                            '7669623C8AF44AAD35CA07C43DE3BA86')
                                       AND t.province = '320000000'
                                       AND t.year = '2022') T5
                             WHERE T.USERGUID IS NOT NULL
                               AND (T5.USERGUID, T5.MENUID) IN
                                   (SELECT T.USERGUID, T.MENUID FROM dual)
                             GROUP BY T5.USERGUID, T5.MENUID)) "factorValues",
                '1' "authRelationType",
                '2' "privilegeType",
                NVL((SELECT appid
                      FROM fasp_t_dataright
                     WHERE GUID = t.datarightid),
                    'bdm') "elementDimensionValue",
                (SELECT t.appname
                   FROM FW_T_SYSAPP t
                  WHERE appid = (NVL((SELECT NAME
                                       FROM fasp_t_dataright
                                      WHERE GUID = t.datarightid),
                                     'bdm'))) "elementDimensionName",
                '' "description"
           FROM (SELECT t.*, t.rowid
                   FROM p#fasp_t_datarightrp t
                  WHERE t.roleid IN (SELECT t.guid
                                       FROM fasp_t_carole t
                                      WHERE t.guid IN
                                            (SELECT t.roleguid
                                               FROM fasp_t_causerrole t
                                              WHERE t.userguid IN
                                                    ('CFCEDB24EC5CD782947CE1F6EED2438E',
                                                     '5F4C737E540471CA270E27A96386EFB5',
                                                     'ADEC33908860AB60E05308031323BD9E',
                                                     '7565696F25091D2BF6AD6A129F2BFF22',
                                                     'A3F3AB3DBA8C17B8D43BD31179A232AC',
                                                     'AD8C3FD77803C808E053040213231234',
                                                     '084D694FFBE34B1E4A98304B141BFAF9',
                                                     '7669623C8AF44AAD35CA07C43DE3BA86'))
                                        AND t.province = '320000000'
                                        AND t.year = '2022')
                    AND t.province = '320000000'
                    AND t.year = '2022'
                 UNION ALL
                 SELECT t.*, t.rowid
                   FROM p#fasp_t_datarightrp t
                  WHERE t.userguid IN
                        ('CFCEDB24EC5CD782947CE1F6EED2438E',
                         '5F4C737E540471CA270E27A96386EFB5',
                         'ADEC33908860AB60E05308031323BD9E',
                         '7565696F25091D2BF6AD6A129F2BFF22',
                         'A3F3AB3DBA8C17B8D43BD31179A232AC',
                         'AD8C3FD77803C808E053040213231234',
                         '084D694FFBE34B1E4A98304B141BFAF9',
                         '7669623C8AF44AAD35CA07C43DE3BA86')
                    AND t.province = '320000000'
                    AND t.year = '2022') t
          WHERE t.USERGUID IS NOT NULL
            AND t.year = '2022'));
