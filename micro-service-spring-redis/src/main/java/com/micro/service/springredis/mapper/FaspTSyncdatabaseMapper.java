package com.micro.service.springredis.mapper;


import com.micro.service.springredis.model.DataBaseinfo;
import com.micro.service.springredis.model.FaspTSyncdatabase;

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


    FaspTSyncdatabase selectByPrimaryKey(String guid);

}