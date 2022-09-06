package gov.mof.fasp3.masterdata.maincollector.executive.server.dao;

import gov.mof.fasp3.masterdata.maincollector.executive.server.entity.PayBackInfoPO;

/**
 * @Description
 * @Project micro-service-parent
 * @Package gov.mof.fasp3.masterdata.maincollector.executive.server.dao
 * @Author zxl
 * @Date 2022-07-26 16:16
 */
public interface PayBackInfoPOMapper {
    /**
     * delete by primary key
     * @param REF_ID primaryKey
     * @return deleteCount
     */
    int deleteByPrimaryKey(String REF_ID);

    /**
     * insert record to table
     * @param record the record
     * @return insert count
     */
    int insert(PayBackInfoPO record);

    /**
     * insert record to table selective
     * @param record the record
     * @return insert count
     */
    int insertSelective(PayBackInfoPO record);

    /**
     * select by primary key
     * @param REF_ID primary key
     * @return object by primary key
     */
    PayBackInfoPO selectByPrimaryKey(String REF_ID);

    /**
     * update record selective
     * @param record the updated record
     * @return update count
     */
    int updateByPrimaryKeySelective(PayBackInfoPO record);

    /**
     * update record
     * @param record the updated record
     * @return update count
     */
    int updateByPrimaryKey(PayBackInfoPO record);
}