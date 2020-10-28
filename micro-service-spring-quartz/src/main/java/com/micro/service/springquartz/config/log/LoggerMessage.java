package com.micro.service.springquartz.config.log;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

/**
* @Description
* @Author zxl
* @Date  2020-10-28  16:13:40
**/
@Data
@AllArgsConstructor
@NoArgsConstructor
public class LoggerMessage{
    private String body;
    private String timestamp;
    private String threadName;
    private String className;
    private String level;
}