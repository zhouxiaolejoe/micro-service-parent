SELECT t.*,t.rowid
  FROM fasp_t_pubmenu t
 WHERE t.guid IN
       (SELECT t.menuguid
          FROM fasp_t_carolemenu t
         WHERE t.roleguid IN (SELECT t1.roleguid
                                FROM fasp_t_causerrole t1
                               WHERE t1.userguid =
                                     (SELECT GUID
                                        FROM fasp_t_causer t2
                                       WHERE t2.code IN ('001')
                                         AND t2.province = '320000000')
                                 AND t1.province = '320000000'
                                 AND t1.year = '2022')
           AND t.province = '320000000'
           AND t.year = '2022')
   AND t.appid = 'bdm';
