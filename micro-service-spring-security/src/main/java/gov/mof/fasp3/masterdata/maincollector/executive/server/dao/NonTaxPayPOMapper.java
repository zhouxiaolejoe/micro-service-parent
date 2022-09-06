package gov.mof.fasp3.masterdata.maincollector.executive.server.dao;

import gov.mof.fasp3.masterdata.maincollector.executive.server.entity.NonTaxPayPO;

/**
 * @Description
 * @Project micro-service-parent
 * @Package gov.mof.fasp3.masterdata.maincollector.executive.server.dao
 * @Author zxl
 * @Date 2022-07-26 15:33
 */
public interface NonTaxPayPOMapper {
    /**
     * delete by primary key
     * @param NT_PAY_VOUCHER_ID primaryKey
     * @return deleteCount
     */
    int deleteByPrimaryKey(String NT_PAY_VOUCHER_ID);

    /**
     * insert record to table
     * @param record the record
     * @return insert count
     */
    int insert(NonTaxPayPO record);

    /**
     * insert record to table selective
     * @param record the record
     * @return insert count
     */
    int insertSelective(NonTaxPayPO record);

    /**
     * select by primary key
     * @param NT_PAY_VOUCHER_ID primary key
     * @return object by primary key
     */
    NonTaxPayPO selectByPrimaryKey(String NT_PAY_VOUCHER_ID);

    /**
     * update record selective
     * @param record the updated record
     * @return update count
     */
    int updateByPrimaryKeySelective(NonTaxPayPO record);

    /**
     * update record
     * @param record the updated record
     * @return update count
     */
    int updateByPrimaryKey(NonTaxPayPO record);
}