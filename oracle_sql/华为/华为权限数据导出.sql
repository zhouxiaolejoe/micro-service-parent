SELECT global_multyear_cz.Secu_f_GLOBAL_SetPARM('','320000000','2022','')  from dual ;  
--数据权限分配(账号授权数据)
/**
SELECT * FROM (
(SELECT t.guid "relationId",
       '' "privilegeId",
       t.MENUID "privilegeSubjectId",
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
       FACTOR_JSON(
       (SELECT listagg(T5.DATARIGHTID, ',') WITHIN GROUP(ORDER BY T5.DATARIGHTID) factorValues
          FROM FASP_T_DATARIGHTRP T5
         WHERE T.roleid IS NOT NULL
           AND (T5.ROLEID, T5.MENUID) IN
               (SELECT T.ROLEID, T.MENUID FROM dual)
         GROUP BY T5.ROLEID, T5.MENUID)) "factorValues",
       '1' "authRelationType",
       '2' "privilegeType",
       NVL((SELECT appid FROM fasp_t_dataright WHERE GUID = t.datarightid),'pdm') "elementDimensionValue",
       '' "description" 
  FROM (SELECT *
          FROM (SELECT t1.*,
                       row_number() over(PARTITION BY t1.roleid, t1.menuid ORDER BY 1) rn
                  FROM FASP_T_DATARIGHTRP t1) t1
         WHERE t1.rn = 1
           AND t1.roleid IS NOT NULL) t)
UNION ALL
(SELECT t.guid "relationId",
       '' "privilegeId",
       t.MENUID "privilegeSubjectId",
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
       FACTOR_JSON(
       (SELECT listagg(T5.DATARIGHTID, ',') WITHIN GROUP(ORDER BY T5.DATARIGHTID) factorValues
          FROM FASP_T_DATARIGHTRP T5
         WHERE T.USERGUID IS NOT NULL
           AND (T5.USERGUID, T5.MENUID) IN
               (SELECT T.USERGUID, T.MENUID FROM dual)
         GROUP BY T5.USERGUID, T5.MENUID)) "factorValues",
       '1' "authRelationType",
       '2' "privilegeType",
       NVL((SELECT appid FROM fasp_t_dataright WHERE GUID = t.datarightid),'pdm') "elementDimensionValue",
       '' "description" 
  FROM (SELECT *
          FROM (SELECT t1.*,
                       row_number() over(PARTITION BY t1.roleid, t1.menuid ORDER BY 1) rn
                  FROM FASP_T_DATARIGHTRP t1) t1
         WHERE t1.rn = 1
           AND t1.USERGUID IS NOT NULL) t)
           ) 
           
           WHERE "targetId" ='SsGoZ4RU';
           ;

/

*/
create or replace function FACTOR_JSON (factorValues IN VARCHAR2) return  VARCHAR2 AS
  I integer;
  DGUID VARCHAR2(50);
  DNAME VARCHAR2(50);
  JSON VARCHAR2(500);
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
             WHEN 'alldatarignt' THEN '所有权限'
             WHEN 'localagencydatarignt' THEN '本级权限'
             WHEN 'loweragencydatarignt' THEN '下级权限'
             WHEN 'finintorg' THEN '处室权限'
             WHEN 'paymentbank' THEN '开户行本行' END
               
           ||'\",\"factorValue\": \"'||b_cur.DATARIGHTID||'\",\"factorCode\": \"factorCode\"}",';
         END IF; 
        end loop;
        JSON:=substr(JSON,0,LENGTH(JSON)-1);
        JSON:=JSON||']';
        RETURN JSON;
end;





--应用权限主体数据
SELECT 'D8C09D0669BEEFD8E050A8C0022034CB' "subjectId",'HQ_MENU' "subjectCode",'华清菜单' "subjectName",'' "applicationId",'华清菜单' "description" FROM dual;

--权限数据
SELECT t.guid "privilegeId",t.code "privilegeCode",t.name "privilegeName",'D8C09D0669BEEFD8E050A8C0022034CB' "subjectId",'华清菜单' "subjectName",t.province "regionCode",(SELECT ele_name FROM ele_vd08001 WHERE ele_code=t.province AND fiscal_year='2022' ) "regionName",'' "applicationName" ,'' "applicationId" ,'' "description" FROM fasp_t_pubmenu t ;
--数据权限要素
SELECT 'DD0008A0026A294AE050A8C0052000AD' "guid", 'data_permission'"elementCode",'数据权限'"elementName",'Y'"isSupportDimension",'Y'"isSystemRegion",'N'"isAllowSelectAllLevels",''"regionId",'0'"isTree",''"applicationId" from dual;



SELECT sys_guid() from dual;                                                                                                                                                     


--机构表数据
/**
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
       t.is_leaf AS "isLeaf",
       (CASE WHEN LENGTH(t.ele_code) =3 THEN '1' ELSE '3' END) AS "orgType",
       (CASE WHEN LENGTH(t.ele_code) =3 THEN '部门' ELSE '预算单位' END) AS "orgTypeName",
       '' AS "sysOrgId",
       '' AS "sysOrgName",
       '' AS "bindOrigin",
       '' AS "bindRegionId",
       '' AS "sysOrgIdSync",
       '' AS "applicationId"
  FROM ele_vd00010 t WHERE t.mof_div_code='320000000';
*/







---数据权限数据割接




--第一次


SELECT *
  FROM ((SELECT t.guid || '-pdm-1' "relationId",
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
           FROM P#FASP_T_DATARIGHTRP t
          WHERE t.roleid IS NOT NULL AND t.year='2022') UNION ALL
        (SELECT t.guid || '-pdm-1' "relationId",
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
           FROM P#FASP_T_DATARIGHTRP t
          WHERE t.USERGUID IS NOT NULL AND t.year='2022'));

--第二次

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
                
                t.guid || '-1' "targetId",
                
                '3' targetType,
                
                FACTOR_JSON((SELECT listagg(T5.DATARIGHTID, ',') WITHIN GROUP(ORDER BY T5.DATARIGHTID) factorValues
                              FROM FASP_T_DATARIGHTRP T5
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
           FROM P#FASP_T_DATARIGHTRP t
          WHERE t.roleid IS NOT NULL AND t.year='2022') UNION ALL
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
                
                t.guid || '-1' "targetId",
                '3' targetType,
                FACTOR_JSON((SELECT listagg(T5.DATARIGHTID, ',') WITHIN GROUP(ORDER BY T5.DATARIGHTID) factorValues
                              FROM FASP_T_DATARIGHTRP T5
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
           FROM P#FASP_T_DATARIGHTRP t 
          WHERE t.USERGUID IS NOT NULL AND t.year='2022'));

;

---导出001、001001、002001、002、003、003001、C01、C05 数据权限 sql



select t.*, t.rowid
  from p#fasp_t_datarightrp t
 where t.roleid in (select t.guid
                      from fasp_t_carole t
                     where t.guid in
                           (select t.roleguid
                              from fasp_t_causerrole t
                             where t.userguid in
                                   ('CFCEDB24EC5CD782947CE1F6EED2438E',
                                    '5F4C737E540471CA270E27A96386EFB5',
                                    'ADEC33908860AB60E05308031323BD9E',
                                    '7565696F25091D2BF6AD6A129F2BFF22',
                                    'A3F3AB3DBA8C17B8D43BD31179A232AC',
                                    'AD8C3FD77803C808E053040213231234',
                                    '084D694FFBE34B1E4A98304B141BFAF9',
                                    '7669623C8AF44AAD35CA07C43DE3BA86'))
                       and t.province = '320000000'
                       and t.year = '2022')
   and t.province = '320000000'
   and t.year = '2022'
union all
select t.*, t.rowid
  from p#fasp_t_datarightrp t
 where t.userguid in ('CFCEDB24EC5CD782947CE1F6EED2438E',
                      '5F4C737E540471CA270E27A96386EFB5',
                      'ADEC33908860AB60E05308031323BD9E',
                      '7565696F25091D2BF6AD6A129F2BFF22',
                      'A3F3AB3DBA8C17B8D43BD31179A232AC',
                      'AD8C3FD77803C808E053040213231234',
                      '084D694FFBE34B1E4A98304B141BFAF9',
                      '7669623C8AF44AAD35CA07C43DE3BA86') and t.province = '320000000'
   and t.year = '2022';
                         
                          
--删除重复角色数据权限
DELETE FROM P#fasp_t_Datarightrp
WHERE (roleid,menuid,datarightid,province,YEAR) IN (SELECT roleid,menuid,datarightid,province,YEAR FROM P#fasp_t_Datarightrp GROUP BY roleid,menuid,datarightid,province,YEAR HAVING COUNT(guid) > 1)
AND ROWID NOT IN
(SELECT MIN(ROWID) FROM P#fasp_t_Datarightrp GROUP BY roleid,menuid,datarightid,province,YEAR HAVING COUNT(*) > 1);
---

--删除重复用户数据权限
DELETE FROM P#fasp_t_Datarightrp
WHERE (userguid,menuid,datarightid,province,YEAR) IN (SELECT userguid,menuid,datarightid,province,YEAR FROM P#fasp_t_Datarightrp GROUP BY userguid,menuid,datarightid,province,YEAR HAVING COUNT(guid) > 1)
AND ROWID NOT IN
(SELECT MIN(ROWID) FROM P#fasp_t_Datarightrp GROUP BY userguid,menuid,datarightid,province,YEAR HAVING COUNT(*) > 1);
---
                         

--往临时表增加数据

INSERT INTO hw_t_datarightrp select guid, roleid, menuid,  province, year, userguid from p#fasp_t_datarightrp t WHERE t.year ='2022';




----此处开始给华为提供业务测试数据
----
----
--机构数据  单位部门 处室BAS_DEV 

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
       t.is_leaf AS "isLeaf",
       (CASE WHEN LENGTH(t.ele_code) =3 THEN '1' ELSE '3' END) AS "orgType",
       (CASE WHEN LENGTH(t.ele_code) =3 THEN '部门' ELSE '预算单位' END) AS "orgTypeName",
       '' AS "sysOrgId",
       '' AS "sysOrgName",
       '' AS "bindOrigin",
       '' AS "bindRegionId",
       '' AS "sysOrgIdSync",
       '' AS "applicationId"
  FROM ele_vd00010 t WHERE t.mof_div_code='320000000' AND t.fiscal_year='2022' AND t.ele_code IN (
  
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
                  '7669623C8AF44AAD35CA07C43DE3BA86')
  )
UNION ALL   
SELECT t.ele_id AS "orgId",
       t.ele_code AS "orgCode",
       t.ele_name AS "orgName",
       '' AS "manageOrgId",
       '' AS "manageOrgName",
       t.parent_id AS "parentOrgId",
       t.is_leaf AS "isLeaf",
       '2' AS "orgType",
       '处室' AS "orgTypeName",
       '' AS "sysOrgId",
       '' AS "sysOrgName",
       '' AS "bindOrigin",
       '' AS "bindRegionId",
       '' AS "sysOrgIdSync",
       '' AS "applicationId"
  FROM ele_vc01004 t WHERE t.mof_div_code='320000000' AND t.fiscal_year='2022' AND t.ele_code IN (
  
  SELECT CASE
         WHEN LENGTH(t.upagencyid) = 9 THEN
          t.division
         ELSE
          t.upagencyid
       END
  FROM fasp_t_causer t
 WHERE t.guid IN ('AD8C3FD77803C808E053040213231234',
                  'ADEC33908860AB60E05308031323BD9E')
  );




--应用权限主体数据
SELECT 'D8C09D0669BEEFD8E050A8C0022034CB' "subjectId",'HQ_MENU' "subjectCode",'华清菜单' "subjectName",'' "applicationId",'华清菜单' "description" FROM dual;

--数据权限要素
SELECT 'DD0008A0026A294AE050A8C0052000AD' "guid", 'data_permission'"elementCode",'数据权限'"elementName",'Y'"isSupportDimension",'Y'"isSystemRegion",'N'"isAllowSelectAllLevels",''"regionId",'0'"isTree",''"applicationId" from dual;


--权限数据
SELECT t.guid "privilegeId",
       t.code "privilegeCode",
       t.name "privilegeName",
       'D8C09D0669BEEFD8E050A8C0022034CB' "subjectId",
       '华清菜单' "subjectName",
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
           
--插入临时表数据                             
INSERT INTO hw_t_datarightrp select guid, roleid, menuid,  province, year, userguid from (
   select t.*, t.rowid
  from pdm_320000.p#fasp_t_datarightrp t
 where t.roleid in (select t.guid
                      from pdm_320000.fasp_t_carole t
                     where t.guid in
                           (select t.roleguid
                              from pdm_320000.fasp_t_causerrole t
                             where t.userguid in
                                   ('CFCEDB24EC5CD782947CE1F6EED2438E',
                                    '5F4C737E540471CA270E27A96386EFB5',
                                    'ADEC33908860AB60E05308031323BD9E',
                                    '7565696F25091D2BF6AD6A129F2BFF22',
                                    'A3F3AB3DBA8C17B8D43BD31179A232AC',
                                    'AD8C3FD77803C808E053040213231234',
                                    '084D694FFBE34B1E4A98304B141BFAF9',
                                    '7669623C8AF44AAD35CA07C43DE3BA86'))
                       and t.province = '320000000'
                       and t.year = '2022')
   and t.province = '320000000'
   and t.year = '2022'
union all
select t.*, t.rowid
  from pdm_320000.p#fasp_t_datarightrp t
 where t.userguid in ('CFCEDB24EC5CD782947CE1F6EED2438E',
                      '5F4C737E540471CA270E27A96386EFB5',
                      'ADEC33908860AB60E05308031323BD9E',
                      '7565696F25091D2BF6AD6A129F2BFF22',
                      'A3F3AB3DBA8C17B8D43BD31179A232AC',
                      'AD8C3FD77803C808E053040213231234',
                      '084D694FFBE34B1E4A98304B141BFAF9',
                      '7669623C8AF44AAD35CA07C43DE3BA86') and t.province = '320000000'
   and t.year = '2022'
   
   
   );
