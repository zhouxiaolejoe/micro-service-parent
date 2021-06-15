--向上递归
SELECT ele_code
  FROM (select * from ELE_VD08001 where fiscal_year = '2021')
CONNECT BY PRIOR PARENT_ID = ELE_ID
 START WITH ELE_ID = (SELECT ELE_ID
                        FROM ELE_VD08001
                       WHERE ELE_CODE = '320000000'
                         AND FISCAL_YEAR = '2021');
--向下递归                        
SELECT ele_code
  FROM (select * from ELE_VD08001 where fiscal_year = '2021')
CONNECT BY PRIOR ELE_ID = PARENT_ID
 START WITH PARENT_ID = (SELECT ELE_ID
                           FROM ELE_VD08001
                          WHERE ELE_CODE = '320699000'
                            AND FISCAL_YEAR = '2021');
