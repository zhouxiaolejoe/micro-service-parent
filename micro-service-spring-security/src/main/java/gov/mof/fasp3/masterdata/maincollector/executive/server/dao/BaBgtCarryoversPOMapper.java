package gov.mof.fasp3.masterdata.maincollector.executive.server.dao;

import gov.mof.fasp3.masterdata.maincollector.executive.server.entity.BaBgtCarryoversPO;

/**
 * @Description
 * @Project micro-service-parent
 * @Package gov.mof.fasp3.masterdata.maincollector.executive.server.dao
 * @Author zxl
 * @Date 2022-07-25 15:00
 */
public interface BaBgtCarryoversPOMapper {
    /**
     * delete by primary key
     *
     * @param CARRYOVERS_BGT_ID primaryKey
     * @return deleteCount
     */
    int deleteByPrimaryKey(String CARRYOVERS_BGT_ID);

    /**
     * insert record to table
     *
     * @param record the record
     * @return insert count
     */
    int insert(BaBgtCarryoversPO record);

    /**
     * insert record to table selective
     *
     * @param record the record
     * @return insert count
     */
    int insertSelective(BaBgtCarryoversPO record);

    /**
     * select by primary key
     *
     * @param CARRYOVERS_BGT_ID primary key
     * @return object by primary key
     */
    BaBgtCarryoversPO selectByPrimaryKey(String CARRYOVERS_BGT_ID);

    /**
     * update record selective
     *
     * @param record the updated record
     * @return update count
     */
    int updateByPrimaryKeySelective(BaBgtCarryoversPO record);

    /**
     * update record
     *
     * @param record the updated record
     * @return update count
     */
    int updateByPrimaryKey(BaBgtCarryoversPO record);
}