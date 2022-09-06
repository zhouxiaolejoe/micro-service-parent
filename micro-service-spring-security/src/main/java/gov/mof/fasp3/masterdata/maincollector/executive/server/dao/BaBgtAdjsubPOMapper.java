package gov.mof.fasp3.masterdata.maincollector.executive.server.dao;

import gov.mof.fasp3.masterdata.maincollector.executive.server.entity.BaBgtAdjsubPO;

/**
 * @Description
 * @Project micro-service-parent
 * @Package gov.mof.fasp3.masterdata.maincollector.executive.server.dao
 * @Author zxl
 * @Date 2022-07-13 10:54
 */
public interface BaBgtAdjsubPOMapper {
    /**
     * delete by primary key
     * @param ADJ_SUB_ID primaryKey
     * @return deleteCount
     */
    int deleteByPrimaryKey(String ADJ_SUB_ID);

    /**
     * insert record to table
     * @param record the record
     * @return insert count
     */
    int insert(BaBgtAdjsubPO record);

    /**
     * insert record to table selective
     * @param record the record
     * @return insert count
     */
    int insertSelective(BaBgtAdjsubPO record);

    /**
     * select by primary key
     * @param ADJ_SUB_ID primary key
     * @return object by primary key
     */
    BaBgtAdjsubPO selectByPrimaryKey(String ADJ_SUB_ID);

    /**
     * update record selective
     * @param record the updated record
     * @return update count
     */
    int updateByPrimaryKeySelective(BaBgtAdjsubPO record);

    /**
     * update record
     * @param record the updated record
     * @return update count
     */
    int updateByPrimaryKey(BaBgtAdjsubPO record);
}