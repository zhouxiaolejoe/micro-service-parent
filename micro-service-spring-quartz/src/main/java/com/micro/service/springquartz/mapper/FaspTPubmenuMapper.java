package com.micro.service.springquartz.mapper;
import org.apache.ibatis.annotations.Param;
import java.util.List;

import com.micro.service.springquartz.model.FaspTPubmenu;

/**
 * @Description
 * @Project micro-service-parent
 * @Package com.micro.service.springquartz.mapper
 * @Author Administrator
 * @Date 2020-09-20 17:57
 */
public interface FaspTPubmenuMapper {
    int insert(FaspTPubmenu record);

    int insertSelective(FaspTPubmenu record);

    FaspTPubmenu selectOneByGuid(@Param("guid")String guid);




}