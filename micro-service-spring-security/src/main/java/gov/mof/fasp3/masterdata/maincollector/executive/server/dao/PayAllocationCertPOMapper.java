package gov.mof.fasp3.masterdata.maincollector.executive.server.dao;

import gov.mof.fasp3.masterdata.maincollector.executive.server.entity.PayAllocationCertPO;

/**
 * @Description
 * @Project micro-service-parent
 * @Package gov.mof.fasp3.masterdata.maincollector.executive.server.dao
 * @Author zxl
 * @Date 2022-07-26 14:43
 */
public interface PayAllocationCertPOMapper {
    /**
     * delete by primary key
     *
     * @param PAY_ALLOC_CERT_ID primaryKey
     * @return deleteCount
     */
    int deleteByPrimaryKey(String PAY_ALLOC_CERT_ID);

    /**
     * insert record to table
     *
     * @param record the record
     * @return insert count
     */
    int insert(PayAllocationCertPO record);

    /**
     * insert record to table selective
     *
     * @param record the record
     * @return insert count
     */
    int insertSelective(PayAllocationCertPO record);

    /**
     * select by primary key
     *
     * @param PAY_ALLOC_CERT_ID primary key
     * @return object by primary key
     */
    PayAllocationCertPO selectByPrimaryKey(String PAY_ALLOC_CERT_ID);

    /**
     * update record selective
     *
     * @param record the updated record
     * @return update count
     */
    int updateByPrimaryKeySelective(PayAllocationCertPO record);

    /**
     * update record
     *
     * @param record the updated record
     * @return update count
     */
    int updateByPrimaryKey(PayAllocationCertPO record);
}