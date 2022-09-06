package gov.mof.fasp3.masterdata.maincollector.executive.server.dao;

import gov.mof.fasp3.masterdata.maincollector.executive.server.entity.FormerNontaxPO;
import org.apache.ibatis.annotations.Param;

/**
 * @Description
 * @Project micro-service-parent
 * @Package gov.mof.fasp3.masterdata.maincollector.executive.server.dao
 * @Author zxl
 * @Date 2022-07-19 09:22
 */
public interface FormerNontaxPOMapper {
    /**
     * delete by primary key
     * @param FISCAL_YEAR primaryKey
     * @return deleteCount
     */
    int deleteByPrimaryKey(@Param("FISCAL_YEAR") String FISCAL_YEAR, @Param("AGENCY_CODE") String AGENCY_CODE, @Param("NONTAX_PRO_CODE") String NONTAX_PRO_CODE);

    /**
     * insert record to table
     * @param record the record
     * @return insert count
     */
    int insert(FormerNontaxPO record);

    /**
     * insert record to table selective
     * @param record the record
     * @return insert count
     */
    int insertSelective(FormerNontaxPO record);

    /**
     * select by primary key
     * @param FISCAL_YEAR primary key
     * @return object by primary key
     */
    FormerNontaxPO selectByPrimaryKey(@Param("FISCAL_YEAR") String FISCAL_YEAR, @Param("AGENCY_CODE") String AGENCY_CODE, @Param("NONTAX_PRO_CODE") String NONTAX_PRO_CODE);

    /**
     * update record selective
     * @param record the updated record
     * @return update count
     */
    int updateByPrimaryKeySelective(FormerNontaxPO record);

    /**
     * update record
     * @param record the updated record
     * @return update count
     */
    int updateByPrimaryKey(FormerNontaxPO record);
}