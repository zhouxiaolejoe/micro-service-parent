package com.micro.service.springquartz.mapper;
import org.apache.ibatis.annotations.Param;
import java.util.List;

import com.micro.service.springquartz.model.FaspTDicdstype;

/**
 * @Description
 * @Project micro-service-parent
 * @Package com.micro.service.springquartz.mapper
 * @Author zxl
 * @Date 2020-11-16 11:07
 */
public interface FaspTDicdstypeMapper {
    int insert(FaspTDicdstype record);

    int insertSelective(FaspTDicdstype record);

    List<FaspTDicdstype> selectAll();


}