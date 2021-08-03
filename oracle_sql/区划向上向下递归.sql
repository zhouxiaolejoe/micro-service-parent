--向上递归
SELECT ele_code,ele_name
  FROM (select * from ELE_VD08002 where fiscal_year = '2021')
CONNECT BY PRIOR PARENT_ID = ELE_ID
 START WITH ELE_ID = (SELECT ELE_ID
                        FROM ELE_VD08002
                       WHERE ELE_CODE = '320582000'
                         AND FISCAL_YEAR = '2021');
--向下递归                        
SELECT ele_code,ele_name
  FROM (select * from ELE_VD08001 where fiscal_year = '2021')
CONNECT BY PRIOR ELE_ID = PARENT_ID
 START WITH PARENT_ID = (SELECT ELE_ID
                           FROM ELE_VD08001
                          WHERE ELE_CODE = '320699000'
                            AND FISCAL_YEAR = '2021');
--根据上下级关系 更新级次
update  ELE_VD08002 t1 set t1.level_no = (
select level1 from (
select level as  level1,t.*
       from (select * from ELE_VD08002 where fiscal_year = '2022') t
       start with parent_id='0'
       connect by prior ele_id=parent_id
) b where b.ele_id = t1.ele_id
)where t1.fiscal_year = '2022'
