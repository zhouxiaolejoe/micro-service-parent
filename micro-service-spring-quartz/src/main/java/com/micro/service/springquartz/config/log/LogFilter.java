package com.micro.service.springquartz.config.log;

import ch.qos.logback.classic.spi.ILoggingEvent;
import ch.qos.logback.core.filter.Filter;
import ch.qos.logback.core.spi.FilterReply;

import java.text.DateFormat;
import java.util.Date;
/**
* @Description  接受输出日志
* @Author zxl
* @Date  2020-10-21  19:11:57
**/
public class LogFilter extends Filter<ILoggingEvent> {

    @Override
    public FilterReply decide(ILoggingEvent  event) {
        LoggerMessage loggerMessage = new LoggerMessage(
                event.getMessage()
                , DateFormat.getDateTimeInstance().format(new Date(event.getTimeStamp())),
                event.getThreadName(),
                event.getLoggerName(),
                event.getLevel().levelStr
        );
        LoggerQueue.getInstance().push(loggerMessage);
        return FilterReply.ACCEPT;
    }

}