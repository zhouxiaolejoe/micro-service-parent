package com.micro.service.springquartz.service;

import com.micro.service.springquartz.model.QrtzJobDetails;
import com.micro.service.springquartz.model.QuartzJobDTO;
import com.micro.service.springquartz.utils.ResultBuilder;
import org.quartz.SchedulerException;

import java.util.List;

public interface JobService {

    List<QrtzJobDetails> getJobList(QuartzJobDTO quartzJobDTO);

    ResultBuilder addJob(QuartzJobDTO quartzJobDTO) throws SchedulerException;

    ResultBuilder triggerJob(String jobName, String jobGroup) throws SchedulerException;

    ResultBuilder pauseJob(String jobName, String jobGroup) throws SchedulerException;

    ResultBuilder resumeJob(String jobName, String jobGroup) throws SchedulerException;

    ResultBuilder removeJob(String jobName, String jobGroup) throws SchedulerException;

    ResultBuilder jobStatus(String triggerName, String triggerGroup) throws SchedulerException;

    ResultBuilder rescheduleJob(QuartzJobDTO quartzJobDTO) throws SchedulerException;
}
