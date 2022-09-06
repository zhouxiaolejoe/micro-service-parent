package gov.mof.fasp3.masterdata.maincollector.executive.server.dao;

import gov.mof.fasp3.masterdata.maincollector.executive.server.entity.PayDetailPO;

/**
 * @Description
 * @Project micro-service-parent
 * @Package gov.mof.fasp3.masterdata.maincollector.executive.server.dao
 * @Author zxl
 * @Date 2022-07-26 14:31
 */
public interface PayDetailPOMapper {
    /**
     * delete by primary key
     *
     * @param PAY_DETAIL_ID primaryKey
     * @return deleteCount
     */
    int deleteByPrimaryKey(String PAY_DETAIL_ID);

    /**
     * insert record to table
     *
     * @param record the record
     * @return insert count
     */
    int insert(PayDetailPO record);

    /**
     * insert record to table selective
     *
     * @param record the record
     * @return insert count
     */
    int insertSelective(PayDetailPO record);

    /**
     * select by primary key
     *
     * @param PAY_DETAIL_ID primary key
     * @return object by primary key
     */
    PayDetailPO selectByPrimaryKey(String PAY_DETAIL_ID);

    /**
     * update record selective
     *
     * @param record the updated record
     * @return update count
     */
    int updateByPrimaryKeySelective(PayDetailPO record);

    /**
     * update record
     *
     * @param record the updated record
     * @return update count
     */
    int updateByPrimaryKey(PayDetailPO record);
}