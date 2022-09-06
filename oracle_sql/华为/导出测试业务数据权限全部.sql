---1.创建转换json函数 bim pdm bdm  对应区划库中都需要创建
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

/
--每个区划每个业务库都要备份P#fasp_t_Datarightrp  再执行以下操作
declare 
  -- Local variables here
  i integer;
begin
  execute immediate '
  CREATE TABLE Datarightrp_'||to_char(SYSDATE,'yyyyMMddhh24miss')||' AS SELECT * FROM P#fasp_t_Datarightrp
';
end;
/

---清除业务系统（bim,pdm，bdm）库中数据权限重复数据 垃圾数据
--删除垃圾数据
DELETE FROM P#fasp_t_Datarightrp t WHERE t.roleid IS NULL AND t.userguid IS NULL;

--删除数据库中不存在的数据权限关系
DELETE from P#fasp_t_Datarightrp t WHERE NOT EXISTS(
SELECT 1 FROM FASP_T_DATARIGHT t2 WHERE t2.GUID=t.datarightid
) AND LENGTH(t.datarightid) =32;

---删除guid重复的
DELETE FROM P#fasp_t_Datarightrp
WHERE (guid,province,YEAR) IN (SELECT guid,province,YEAR FROM P#fasp_t_Datarightrp GROUP BY guid,province,YEAR HAVING COUNT(guid) > 1)
AND ROWID NOT IN
(SELECT MIN(ROWID) FROM P#fasp_t_Datarightrp GROUP BY guid,province,YEAR HAVING COUNT(*) > 1);

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

--删除无效数据       
DELETE from p#fasp_t_datarightrp t WHERE t.roleid IS NOT NULL AND LENGTH(t.datarightid) =32 AND NOT EXISTS(SELECT 1 FROM fasp_t_carole fcr WHERE fcr.guid=t.roleid) AND 
NOT EXISTS(SELECT 1 FROM fasp_t_pubmenu fpb WHERE fpb.guid=t.menuid) AND NOT EXISTS(SELECT 1 FROM FASP_T_DATARIGHT fdr WHERE fdr.GUID=t.datarightid);

DELETE from p#fasp_t_datarightrp t WHERE t.roleid IS NOT NULL AND LENGTH(t.datarightid) =32 AND NOT EXISTS(SELECT 1 FROM fasp_t_causer fcu WHERE fcu.guid=t.userguid) AND 
NOT EXISTS(SELECT 1 FROM fasp_t_pubmenu fpb WHERE fpb.guid=t.menuid) AND NOT EXISTS(SELECT 1 FROM FASP_T_DATARIGHT fdr WHERE fdr.GUID=t.datarightid);




--此次导出数据 为 001，001001,002,002001,003,003001，C01,C05涉及到的信息

--2.机构数据(中台库查询)

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
          '部门'
         ELSE
          '预算单位'
       END) AS "orgTypeName",
       '' AS "sysOrgId",
       '' AS "sysOrgName",
       '' AS "bindOrigin",
       '' AS "bindRegionId",
       '' AS "sysOrgIdSync",
       '' AS "applicationId"
  FROM ele_vd00010 t WHERE t.mof_div_code='320000000' AND t.fiscal_year='2022'
  UNION ALL
SELECT t.ele_id AS "orgId",
       t.ele_code AS "orgCode",
       t.ele_name AS "orgName",
       '' AS "manageOrgId",
       '' AS "manageOrgName",
       t.parent_id AS "parentOrgId",
       CASE T.IS_LEAF WHEN 1  THEN 'Y' WHEN 2 THEN 'N' WHEN 0 THEN 'N' END "isLeaf",
       '2' AS "orgType",
       '处室' AS "orgTypeName",
       '' AS "sysOrgId",
       '' AS "sysOrgName",
       '' AS "bindOrigin",
       '' AS "bindRegionId",
       '' AS "sysOrgIdSync",
       '' AS "applicationId"
  FROM ele_vc01004 t WHERE t.mof_div_code='320000000' AND t.fiscal_year='2022'
;


--3.应用权限主体数据(中台库查询)
SELECT t.appid||'_budgetplan' "subjectId",
       t.appid||'_budgetplan' "subjectCode",
       t.name "subjectName",
       '' "applicationId",
       '' "description"
  FROM fasp_t_pubmenu t
 WHERE t.parentid = '0'
   AND t.appid IN ('pdm', 'bdm', 'bim', 'pmkpi', 'buscommon', 'yjs') AND t.name IN('预决算公开','预算编制','项目库','基础信息','系统管理','预算绩效');

--4.数据权限要素(中台库查询)
SELECT 'DD0008A0026A294AE050A8C0052000AD' "guid", 'data_permission'"elementCode",'数据权限'"elementName",'Y'"isSupportDimension",'Y'"isSystemRegion",'N'"isAllowSelectAllLevels",''"regionId",'0'"isTree",''"applicationId" from dual;


--5.权限数据(中台库查询)
SELECT t.guid "privilegeId",
       t.guid "privilegeCode",
       t.name "privilegeName",
       t.appid "subjectId",
       (SELECT fs.appname from FW_T_SYSAPP fs WHERE fs.appid=t.appid AND ROWNUM=1) "subjectName",
       t.province "regionCode",
       (SELECT ele_name
          FROM ele_vd08001
         WHERE ele_code = t.province
           AND fiscal_year = '2022') "regionName",
       '' "applicationName",
       '' "applicationId",
       '' "description"
  FROM fasp_t_pubmenu t WHERE t.appid <> 'yjs' AND  NOT EXISTS
 (SELECT 1 FROM fasp_t_pubmenu p WHERE p.parentid = t.guid);




--插入临时表数据   (这个sql需要在省本级三个业务系统  bim bdm pdm  中都导出一份数据) 这个表数据不用给华为                      
SELECT guid|| '-320000000-bim', roleid, menuid, province, YEAR, userguid
  FROM p#fasp_t_datarightrp t WHERE t.province='320000000' AND t.year='2022';

SELECT * FROM Fasp_t_Pubmenu t WHERE t.guid='bdm004063';



--切换到对应业务系统库   导出不同区划的数据  需要修改业务系统标识（bim ,bdm pdm），区划参数  province ，  '-320000000-bim-1' 
--下面的单独'bim'也需要替换
--导出数据后第一次的全部整到一个文件 第二次也是整到一个文件
--bim


--第一次

SELECT *
  FROM ((SELECT t.guid || '-320000000-bim-1' "relationId",
                t.MENUID "privilegeId",
                t.MENUID "privilegeCode",
                (SELECT fp.appid FROM fasp_t_pubmenu fp WHERE fp.guid=t.menuid) "privilegeSubjectId",
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
          WHERE t.roleid IS NOT NULL
            AND t.year = '2022'
            AND t.province = '320000000'
            AND (t.roleid, t.menuid) IN
                (SELECT roleid, menuid
                   FROM P#FASP_T_DATARIGHTRP
                  WHERE province = '320000000'
                    AND YEAR = '2022'
                    AND roleid IS NOT NULL
                  GROUP BY roleid, menuid)
            AND ROWID IN (SELECT MIN(ROWID)
                            FROM P#FASP_T_DATARIGHTRP
                           WHERE province = '320000000'
                             AND YEAR = '2022'
                             AND roleid IS NOT NULL
                           GROUP BY roleid, menuid)) UNION ALL
        (SELECT t.guid || '-320000000-bim-1' "relationId",
                t.MENUID "privilegeId",
                t.MENUID "privilegeCode",
                (SELECT fp.appid FROM fasp_t_pubmenu fp WHERE fp.guid=t.menuid) "privilegeSubjectId",
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
          WHERE t.USERGUID IS NOT NULL
            AND t.year = '2022'
            AND t.province = '320000000'
            AND (t.userguid, t.menuid) IN
                (SELECT userguid, menuid
                   FROM P#FASP_T_DATARIGHTRP
                  WHERE province = '320000000'
                    AND YEAR = '2022'
                    AND USERGUID IS NOT NULL
                  GROUP BY userguid, menuid)
            AND ROWID IN (SELECT MIN(ROWID)
                            FROM P#FASP_T_DATARIGHTRP
                           WHERE province = '320000000'
                             AND YEAR = '2022'
                             AND USERGUID IS NOT NULL
                           GROUP BY userguid, menuid)));

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
                              FROM P#FASP_T_DATARIGHTRP T5
                             WHERE T.roleid IS NOT NULL
                               AND t5.province = '320000000'
                               AND t5.year = '2022'
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
           FROM P#FASP_T_DATARIGHTRP t
          WHERE t.roleid IS NOT NULL
            AND t.year = '2022'
            AND t.province = '320000000'
            AND (t.roleid, t.menuid) IN
                (SELECT roleid, menuid
                   FROM P#FASP_T_DATARIGHTRP
                  WHERE province = '320000000'
                    AND YEAR = '2022'
                    AND roleid IS NOT NULL
                  GROUP BY roleid, menuid)
            AND ROWID IN (SELECT MIN(ROWID)
                            FROM P#FASP_T_DATARIGHTRP
                           WHERE province = '320000000'
                             AND YEAR = '2022'
                             AND roleid IS NOT NULL
                           GROUP BY roleid, menuid)) UNION ALL
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
                              FROM P#FASP_T_DATARIGHTRP T5
                             WHERE T.USERGUID IS NOT NULL
                               AND t5.province = '320000000'
                               AND t5.year = '2022'
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
           FROM P#FASP_T_DATARIGHTRP t
          WHERE t.USERGUID IS NOT NULL
            AND t.year = '2022'
            AND t.province = '320000000'
            AND (t.userguid, t.menuid) IN
                (SELECT userguid, menuid
                   FROM P#FASP_T_DATARIGHTRP
                  WHERE province = '320000000'
                    AND YEAR = '2022'
                    AND USERGUID IS NOT NULL
                  GROUP BY userguid, menuid)
            AND ROWID IN (SELECT MIN(ROWID)
                            FROM P#FASP_T_DATARIGHTRP
                           WHERE province = '320000000'
                             AND YEAR = '2022'
                             AND USERGUID IS NOT NULL
                           GROUP BY userguid, menuid)));
