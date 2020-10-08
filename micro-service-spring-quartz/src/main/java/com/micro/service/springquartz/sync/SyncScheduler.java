package com.micro.service.springquartz.sync;


/**
 * @author zxl
 */
public interface SyncScheduler {
    void start(String origin, String target);
}