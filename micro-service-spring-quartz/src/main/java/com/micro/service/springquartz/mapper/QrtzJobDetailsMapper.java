package com.micro.service.springquartz.mapper;
import java.util.List;

import com.micro.service.springquartz.model.QrtzJobDetails;
import com.micro.service.springquartz.model.QrtzTriggerDetails;
import org.apache.ibatis.annotations.Param;

/**
 * @Description
 * @Project micro-service-parent
 * @Package com.micro.service.springquartz.mapper
 * @Author zxl
 * @Date 2020-09-20 16:11
 */
public interface QrtzJobDetailsMapper {
    int deleteByPrimaryKey(@Param("schedName") String schedName, @Param("jobName") String jobName, @Param("jobGroup") String jobGroup);

    int insert(QrtzJobDetails record);

    int insertSelective(QrtzJobDetails record);

    QrtzJobDetails selectByPrimaryKey(@Param("schedName") String schedName, @Param("jobName") String jobName, @Param("jobGroup") String jobGroup);

    int updateByPrimaryKeySelective(QrtzJobDetails record);

    int updateByPrimaryKey(QrtzJobDetails record);

    List<QrtzTriggerDetails> selectAll();


}