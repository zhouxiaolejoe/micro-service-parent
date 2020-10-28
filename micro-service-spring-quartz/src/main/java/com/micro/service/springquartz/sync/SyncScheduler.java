package com.micro.service.springquartz.sync;


/**
* @Description
* @Author zxl
* @Date  2020-10-28  16:27:41
**/
public interface SyncScheduler {
    void start(String origin, String target);
}