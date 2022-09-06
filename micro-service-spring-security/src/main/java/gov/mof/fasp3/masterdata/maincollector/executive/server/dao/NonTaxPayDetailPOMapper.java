package gov.mof.fasp3.masterdata.maincollector.executive.server.dao;

import gov.mof.fasp3.masterdata.maincollector.executive.server.entity.NonTaxPayDetailPO;

/**
 * @Description
 * @Project micro-service-parent
 * @Package gov.mof.fasp3.masterdata.maincollector.executive.server.dao
 * @Author zxl
 * @Date 2022-07-26 15:50
 */
public interface NonTaxPayDetailPOMapper {
    /**
     * delete by primary key
     * @param SORT_NO primaryKey
     * @return deleteCount
     */
    int deleteByPrimaryKey(String SORT_NO);

    /**
     * insert record to table
     * @param record the record
     * @return insert count
     */
    int insert(NonTaxPayDetailPO record);

    /**
     * insert record to table selective
     * @param record the record
     * @return insert count
     */
    int insertSelective(NonTaxPayDetailPO record);

    /**
     * select by primary key
     * @param SORT_NO primary key
     * @return object by primary key
     */
    NonTaxPayDetailPO selectByPrimaryKey(String SORT_NO);

    /**
     * update record selective
     * @param record the updated record
     * @return update count
     */
    int updateByPrimaryKeySelective(NonTaxPayDetailPO record);

    /**
     * update record
     * @param record the updated record
     * @return update count
     */
    int updateByPrimaryKey(NonTaxPayDetailPO record);
}