package gov.mof.fasp3.masterdata.maincollector.executive.server.dao;

import gov.mof.fasp3.masterdata.maincollector.executive.server.entity.PayPlanVoucherPO;

/**
 * @Description
 * @Project micro-service-parent
 * @Package gov.mof.fasp3.masterdata.maincollector.executive.server.dao
 * @Author zxl
 * @Date 2022-07-26 16:16
 */
public interface PayPlanVoucherPOMapper {
    /**
     * delete by primary key
     * @param PLAN_ID primaryKey
     * @return deleteCount
     */
    int deleteByPrimaryKey(String PLAN_ID);

    /**
     * insert record to table
     * @param record the record
     * @return insert count
     */
    int insert(PayPlanVoucherPO record);

    /**
     * insert record to table selective
     * @param record the record
     * @return insert count
     */
    int insertSelective(PayPlanVoucherPO record);

    /**
     * select by primary key
     * @param PLAN_ID primary key
     * @return object by primary key
     */
    PayPlanVoucherPO selectByPrimaryKey(String PLAN_ID);

    /**
     * update record selective
     * @param record the updated record
     * @return update count
     */
    int updateByPrimaryKeySelective(PayPlanVoucherPO record);

    /**
     * update record
     * @param record the updated record
     * @return update count
     */
    int updateByPrimaryKey(PayPlanVoucherPO record);
}