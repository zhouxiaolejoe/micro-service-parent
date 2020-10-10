package com.micro.service.springquartz.service;

import com.micro.service.springquartz.model.QrtzJobDetails;
import com.micro.service.springquartz.model.QrtzTriggerDetails;
import com.micro.service.springquartz.model.QuartzJobDTO;
import com.micro.service.springquartz.utils.ResultBuilder;
import org.quartz.SchedulerException;

import java.util.List;

public interface JobService {

    List<QrtzTriggerDetails> getJobList(QuartzJobDTO quartzJobDTO);

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
