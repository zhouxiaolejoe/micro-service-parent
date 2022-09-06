package gov.mof.fasp3.masterdata.maincollector.executive.server.dao;

import gov.mof.fasp3.masterdata.maincollector.executive.server.entity.PmHotTopiccatePO;import java.util.List;

/**
 * @Description
 * @Project micro-service-parent
 * @Package gov.mof.fasp3.masterdata.maincollector.executive.server.dao
 * @Author zxl
 * @Date 2022-07-25 10:47
 */
public interface PmHotTopiccatePOMapper {
    /**
     * delete by primary key
     *
     * @param PRO_HOT_TOPIC_ID primaryKey
     * @return deleteCount
     */
    int deleteByPrimaryKey(String PRO_HOT_TOPIC_ID);

    /**
     * insert record to table
     *
     * @param record the record
     * @return insert count
     */
    int insert(PmHotTopiccatePO record);

    /**
     * insert record to table selective
     *
     * @param record the record
     * @return insert count
     */
    int insertSelective(PmHotTopiccatePO record);

    /**
     * select by primary key
     *
     * @param PRO_HOT_TOPIC_ID primary key
     * @return object by primary key
     */
    PmHotTopiccatePO selectByPrimaryKey(String PRO_HOT_TOPIC_ID);

    /**
     * update record selective
     *
     * @param record the updated record
     * @return update count
     */
    int updateByPrimaryKeySelective(PmHotTopiccatePO record);

    /**
     * update record
     *
     * @param record the updated record
     * @return update count
     */
    int updateByPrimaryKey(PmHotTopiccatePO record);

}