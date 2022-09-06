package gov.mof.fasp3.masterdata.maincollector.executive.server.dao;

import gov.mof.fasp3.masterdata.maincollector.executive.server.entity.FaspTSyncdatabase;

/**
 * @Description
 * @Project micro-service-parent
 * @Package gov.mof.fasp3.masterdata.maincollector.executive.server.dao
 * @Author zxl
 * @Date 2022-08-25 11:26
 */
public interface FaspTSyncdatabaseMapper {
    /**
     * insert record to table
     * @param record the record
     * @return insert count
     */
    int insert(FaspTSyncdatabase record);

    /**
     * insert record to table selective
     * @param record the record
     * @return insert count
     */
    int insertSelective(FaspTSyncdatabase record);
}