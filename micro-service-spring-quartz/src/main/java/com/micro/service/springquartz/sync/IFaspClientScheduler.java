package com.micro.service.springquartz.sync;


/**
 * @author zxl
 */
public interface IFaspClientScheduler {
    void start(String origin, String target);
}