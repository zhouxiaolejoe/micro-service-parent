package gov.mof.fasp3.masterdata.maincollector.executive.server.dao;

import gov.mof.fasp3.masterdata.maincollector.executive.server.entity.PayVoucherPO;

/**
 * @Description
 * @Project micro-service-parent
 * @Package gov.mof.fasp3.masterdata.maincollector.executive.server.dao
 * @Author zxl
 * @Date 2022-07-26 14:18
 */
public interface PayVoucherPOMapper {
    /**
     * delete by primary key
     *
     * @param PAY_APP_ID primaryKey
     * @return deleteCount
     */
    int deleteByPrimaryKey(String PAY_APP_ID);

    /**
     * insert record to table
     *
     * @param record the record
     * @return insert count
     */
    int insert(PayVoucherPO record);

    /**
     * insert record to table selective
     *
     * @param record the record
     * @return insert count
     */
    int insertSelective(PayVoucherPO record);

    /**
     * select by primary key
     *
     * @param PAY_APP_ID primary key
     * @return object by primary key
     */
    PayVoucherPO selectByPrimaryKey(String PAY_APP_ID);

    /**
     * update record selective
     *
     * @param record the updated record
     * @return update count
     */
    int updateByPrimaryKeySelective(PayVoucherPO record);

    /**
     * update record
     *
     * @param record the updated record
     * @return update count
     */
    int updateByPrimaryKey(PayVoucherPO record);
}