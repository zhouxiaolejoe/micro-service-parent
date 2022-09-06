package gov.mof.fasp3.masterdata.maincollector.executive.server.dao;

import gov.mof.fasp3.masterdata.maincollector.executive.server.entity.BaBgtInfoPO;

/**
 * @Description
 * @Project micro-service-parent
 * @Package gov.mof.fasp3.masterdata.maincollector.executive.server.dao
 * @Author zxl
 * @Date 2022-07-25 15:52
 */
public interface BaBgtInfoPOMapper {
    /**
     * delete by primary key
     *
     * @param BGT_ID primaryKey
     * @return deleteCount
     */
    int deleteByPrimaryKey(String BGT_ID);

    /**
     * insert record to table
     *
     * @param record the record
     * @return insert count
     */
    int insert(BaBgtInfoPO record);

    /**
     * insert record to table selective
     *
     * @param record the record
     * @return insert count
     */
    int insertSelective(BaBgtInfoPO record);

    /**
     * select by primary key
     *
     * @param BGT_ID primary key
     * @return object by primary key
     */
    BaBgtInfoPO selectByPrimaryKey(String BGT_ID);

    /**
     * update record selective
     *
     * @param record the updated record
     * @return update count
     */
    int updateByPrimaryKeySelective(BaBgtInfoPO record);

    /**
     * update record
     *
     * @param record the updated record
     * @return update count
     */
    int updateByPrimaryKey(BaBgtInfoPO record);
}