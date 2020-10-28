package com.micro.service.springquartz.service;

import com.micro.service.springquartz.model.QuartzJobDTO;
import com.micro.service.springquartz.utils.ResultBuilder;
import org.quartz.SchedulerException;

import java.util.Map;

public interface JobService {

    Map<String, Object> getJobList(Integer pageNo, Integer pageSize);

    ResultBuilder addJob(QuartzJobDTO quartzJobDTO) throws SchedulerException;

    ResultBuilder triggerJob(String jobName) throws SchedulerException;

    ResultBuilder pauseJob(String jobName) throws SchedulerException;

    ResultBuilder resumeJob(String jobName) throws SchedulerException;

    ResultBuilder removeJob(String jobName) throws SchedulerException;

    ResultBuilder jobStatus(String jobName) throws SchedulerException;

    ResultBuilder rescheduleJob(QuartzJobDTO quartzJobDTO) throws SchedulerException;

    ResultBuilder pauseJobAll() throws SchedulerException;

    ResultBuilder removeJobAll() throws SchedulerException;

    ResultBuilder resumeJobAll() throws SchedulerException;
}
