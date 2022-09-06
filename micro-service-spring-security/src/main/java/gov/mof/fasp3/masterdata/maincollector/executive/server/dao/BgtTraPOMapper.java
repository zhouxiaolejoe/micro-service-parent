package gov.mof.fasp3.masterdata.maincollector.executive.server.dao;

import gov.mof.fasp3.masterdata.maincollector.executive.server.entity.BgtTraPO;

/**
 * @Description
 * @Project micro-service-parent
 * @Package gov.mof.fasp3.masterdata.maincollector.executive.server.dao
 * @Author zxl
 * @Date 2022-07-27 15:08
 */
public interface BgtTraPOMapper {
    /**
     * delete by primary key
     *
     * @param BGT_PMAN_ID primaryKey
     * @return deleteCount
     */
    int deleteByPrimaryKey(String BGT_PMAN_ID);

    /**
     * insert record to table
     *
     * @param record the record
     * @return insert count
     */
    int insert(BgtTraPO record);

    /**
     * insert record to table selective
     *
     * @param record the record
     * @return insert count
     */
    int insertSelective(BgtTraPO record);

    /**
     * select by primary key
     *
     * @param BGT_PMAN_ID primary key
     * @return object by primary key
     */
    BgtTraPO selectByPrimaryKey(String BGT_PMAN_ID);

    /**
     * update record selective
     *
     * @param record the updated record
     * @return update count
     */
    int updateByPrimaryKeySelective(BgtTraPO record);

    /**
     * update record
     *
     * @param record the updated record
     * @return update count
     */
    int updateByPrimaryKey(BgtTraPO record);
}