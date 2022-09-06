package gov.mof.fasp3.masterdata.maincollector.executive.server.dao;

import gov.mof.fasp3.masterdata.maincollector.executive.server.entity.BgtTraZkPO;

/**
 * @Description
 * @Project micro-service-parent
 * @Package gov.mof.fasp3.masterdata.maincollector.executive.server.dao
 * @Author zxl
 * @Date 2022-09-01 14:18
 */
public interface BgtTraZkPOMapper {
    /**
     * delete by primary key
     * @param BGT_PMAN_ID primaryKey
     * @return deleteCount
     */
    int deleteByPrimaryKey(String BGT_PMAN_ID);

    /**
     * insert record to table
     * @param record the record
     * @return insert count
     */
    int insert(BgtTraZkPO record);

    /**
     * insert record to table selective
     * @param record the record
     * @return insert count
     */
    int insertSelective(BgtTraZkPO record);

    /**
     * select by primary key
     * @param BGT_PMAN_ID primary key
     * @return object by primary key
     */
    BgtTraZkPO selectByPrimaryKey(String BGT_PMAN_ID);

    /**
     * update record selective
     * @param record the updated record
     * @return update count
     */
    int updateByPrimaryKeySelective(BgtTraZkPO record);

    /**
     * update record
     * @param record the updated record
     * @return update count
     */
    int updateByPrimaryKey(BgtTraZkPO record);
}