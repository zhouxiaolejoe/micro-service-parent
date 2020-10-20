package com.micro.service.springquartz.model;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

/**
 * @author zxl
 */
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