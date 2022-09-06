package gov.mof.fasp3.masterdata.maincollector.executive.server.dao;

import gov.mof.fasp3.masterdata.maincollector.executive.server.entity.BaBgtBalanceAgencyPO;

/**
 * @Description
 * @Project micro-service-parent
 * @Package gov.mof.fasp3.masterdata.maincollector.executive.server.dao
 * @Author zxl
 * @Date 2022-07-25 15:22
 */
public interface BaBgtBalanceAgencyPOMapper {
    /**
     * delete by primary key
     * @param BALANCE_BGT_ID primaryKey
     * @return deleteCount
     */
    int deleteByPrimaryKey(String BALANCE_BGT_ID);

    /**
     * insert record to table
     * @param record the record
     * @return insert count
     */
    int insert(BaBgtBalanceAgencyPO record);

    /**
     * insert record to table selective
     * @param record the record
     * @return insert count
     */
    int insertSelective(BaBgtBalanceAgencyPO record);

    /**
     * select by primary key
     * @param BALANCE_BGT_ID primary key
     * @return object by primary key
     */
    BaBgtBalanceAgencyPO selectByPrimaryKey(String BALANCE_BGT_ID);

    /**
     * update record selective
     * @param record the updated record
     * @return update count
     */
    int updateByPrimaryKeySelective(BaBgtBalanceAgencyPO record);

    /**
     * update record
     * @param record the updated record
     * @return update count
     */
    int updateByPrimaryKey(BaBgtBalanceAgencyPO record);
}