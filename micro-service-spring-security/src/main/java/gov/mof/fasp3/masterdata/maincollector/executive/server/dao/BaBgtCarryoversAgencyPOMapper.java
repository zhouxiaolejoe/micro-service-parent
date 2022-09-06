package gov.mof.fasp3.masterdata.maincollector.executive.server.dao;

import gov.mof.fasp3.masterdata.maincollector.executive.server.entity.BaBgtCarryoversAgencyPO;

/**
 * @Description
 * @Project micro-service-parent
 * @Package gov.mof.fasp3.masterdata.maincollector.executive.server.dao
 * @Author zxl
 * @Date 2022-07-25 15:21
 */
public interface BaBgtCarryoversAgencyPOMapper {
    /**
     * delete by primary key
     * @param CARRYOVERS_BGT_ID primaryKey
     * @return deleteCount
     */
    int deleteByPrimaryKey(String CARRYOVERS_BGT_ID);

    /**
     * insert record to table
     * @param record the record
     * @return insert count
     */
    int insert(BaBgtCarryoversAgencyPO record);

    /**
     * insert record to table selective
     * @param record the record
     * @return insert count
     */
    int insertSelective(BaBgtCarryoversAgencyPO record);

    /**
     * select by primary key
     * @param CARRYOVERS_BGT_ID primary key
     * @return object by primary key
     */
    BaBgtCarryoversAgencyPO selectByPrimaryKey(String CARRYOVERS_BGT_ID);

    /**
     * update record selective
     * @param record the updated record
     * @return update count
     */
    int updateByPrimaryKeySelective(BaBgtCarryoversAgencyPO record);

    /**
     * update record
     * @param record the updated record
     * @return update count
     */
    int updateByPrimaryKey(BaBgtCarryoversAgencyPO record);
}