package com.micro.service.springquartz.syncapi;

/**
 * @Description
 * @Author zxl
 * @Date 2020-10-28  16:28:19
 **/
public interface IFaspClientScheduler {
    void start(String origin, String target);
}