package gov.mof.fasp3.masterdata.maincollector.executive.server.dao;

import gov.mof.fasp3.masterdata.maincollector.executive.server.entity.PmbgtHotTopiccatePO;

/**
 * @Description
 * @Project micro-service-parent
 * @Package gov.mof.fasp3.masterdata.maincollector.executive.server.dao
 * @Author zxl
 * @Date 2022-07-13 10:53
 */
public interface PmbgtHotTopiccatePOMapper {
    /**
     * delete by primary key
     * @param PRO_HOT_TOPIC_ID primaryKey
     * @return deleteCount
     */
    int deleteByPrimaryKey(String PRO_HOT_TOPIC_ID);

    /**
     * insert record to table
     * @param record the record
     * @return insert count
     */
    int insert(PmbgtHotTopiccatePO record);

    /**
     * insert record to table selective
     * @param record the record
     * @return insert count
     */
    int insertSelective(PmbgtHotTopiccatePO record);

    /**
     * select by primary key
     * @param PRO_HOT_TOPIC_ID primary key
     * @return object by primary key
     */
    PmbgtHotTopiccatePO selectByPrimaryKey(String PRO_HOT_TOPIC_ID);

    /**
     * update record selective
     * @param record the updated record
     * @return update count
     */
    int updateByPrimaryKeySelective(PmbgtHotTopiccatePO record);

    /**
     * update record
     * @param record the updated record
     * @return update count
     */
    int updateByPrimaryKey(PmbgtHotTopiccatePO record);
}