package gov.mof.fasp3.masterdata.maincollector.executive.server.dao;

import gov.mof.fasp3.masterdata.maincollector.executive.server.entity.IncApplyPO;

/**
 * @Description
 * @Project micro-service-parent
 * @Package gov.mof.fasp3.masterdata.maincollector.executive.server.dao
 * @Author zxl
 * @Date 2022-07-26 14:52
 */
public interface IncApplyPOMapper {
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
    int insert(IncApplyPO record);

    /**
     * insert record to table selective
     *
     * @param record the record
     * @return insert count
     */
    int insertSelective(IncApplyPO record);

    /**
     * select by primary key
     *
     * @param PAY_APP_ID primary key
     * @return object by primary key
     */
    IncApplyPO selectByPrimaryKey(String PAY_APP_ID);

    /**
     * update record selective
     *
     * @param record the updated record
     * @return update count
     */
    int updateByPrimaryKeySelective(IncApplyPO record);

    /**
     * update record
     *
     * @param record the updated record
     * @return update count
     */
    int updateByPrimaryKey(IncApplyPO record);
}