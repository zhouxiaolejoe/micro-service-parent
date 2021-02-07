
SELECT COUNT(1)
FROM (SELECT GUID, YEAR, PROVINCE
FROM FASP_T_PUBMENU
GROUP BY GUID, YEAR, PROVINCE
HAVING COUNT(GUID) > 1);


DELETE FROM FASP_T_PUBMENU
WHERE (guid,year,province) IN (SELECT guid,year,province FROM FASP_T_PUBMENU GROUP BY guid,year,province HAVING COUNT(guid) > 1)
AND ROWID NOT IN
(SELECT MIN(ROWID) FROM FASP_T_PUBMENU GROUP BY guid,year,province HAVING COUNT(*) > 1);
---
