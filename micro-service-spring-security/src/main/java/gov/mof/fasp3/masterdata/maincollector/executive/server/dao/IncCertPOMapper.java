package gov.mof.fasp3.masterdata.maincollector.executive.server.dao;

import gov.mof.fasp3.masterdata.maincollector.executive.server.entity.IncCertPO;

/**
 * @Description
 * @Project micro-service-parent
 * @Package gov.mof.fasp3.masterdata.maincollector.executive.server.dao
 * @Author zxl
 * @Date 2022-07-26 15:02
 */
public interface IncCertPOMapper {
    /**
     * delete by primary key
     *
     * @param PAY_CERT_ID primaryKey
     * @return deleteCount
     */
    int deleteByPrimaryKey(String PAY_CERT_ID);

    /**
     * insert record to table
     *
     * @param record the record
     * @return insert count
     */
    int insert(IncCertPO record);

    /**
     * insert record to table selective
     *
     * @param record the record
     * @return insert count
     */
    int insertSelective(IncCertPO record);

    /**
     * select by primary key
     *
     * @param PAY_CERT_ID primary key
     * @return object by primary key
     */
    IncCertPO selectByPrimaryKey(String PAY_CERT_ID);

    /**
     * update record selective
     *
     * @param record the updated record
     * @return update count
     */
    int updateByPrimaryKeySelective(IncCertPO record);

    /**
     * update record
     *
     * @param record the updated record
     * @return update count
     */
    int updateByPrimaryKey(IncCertPO record);
}