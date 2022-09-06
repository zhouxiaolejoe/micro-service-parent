package gov.mof.fasp3.masterdata.maincollector.executive.server.dao;

import gov.mof.fasp3.masterdata.maincollector.executive.server.entity.BaBgtBalancePO;

/**
 * @Description
 * @Project micro-service-parent
 * @Package gov.mof.fasp3.masterdata.maincollector.executive.server.dao
 * @Author zxl
 * @Date 2022-07-29 18:06
 */
public interface BaBgtBalancePOMapper {
    /**
     * delete by primary key
     *
     * @param BALANCE_BGT_ID primaryKey
     * @return deleteCount
     */
    int deleteByPrimaryKey(String BALANCE_BGT_ID);

    /**
     * insert record to table
     *
     * @param record the record
     * @return insert count
     */
    int insert(BaBgtBalancePO record);

    /**
     * insert record to table selective
     *
     * @param record the record
     * @return insert count
     */
    int insertSelective(BaBgtBalancePO record);

    /**
     * select by primary key
     *
     * @param BALANCE_BGT_ID primary key
     * @return object by primary key
     */
    BaBgtBalancePO selectByPrimaryKey(String BALANCE_BGT_ID);

    /**
     * update record selective
     *
     * @param record the updated record
     * @return update count
     */
    int updateByPrimaryKeySelective(BaBgtBalancePO record);

    /**
     * update record
     *
     * @param record the updated record
     * @return update count
     */
    int updateByPrimaryKey(BaBgtBalancePO record);
}