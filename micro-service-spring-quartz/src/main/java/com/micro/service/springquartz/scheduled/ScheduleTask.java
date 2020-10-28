package com.micro.service.springquartz.scheduled;

import com.micro.service.springquartz.config.log.LoggerMessage;
import com.micro.service.springquartz.config.log.LoggerQueue;
import lombok.AllArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.messaging.simp.SimpMessageSendingOperations;
import org.springframework.stereotype.Component;

import javax.annotation.PostConstruct;
import java.util.concurrent.ExecutorService;

/**
 * @Description
 * @Author zxl
 * @Date 2019/7/17  17:16
 * @Param
 * @return
 **/
@Component
@Slf4j
@AllArgsConstructor
public class ScheduleTask {
    private SimpMessageSendingOperations messagingTemplate;
    ExecutorService syncExecutorService;


    /**
     * 推送日志到/topic/pullLogger
     */
    @PostConstruct
    public void pushLogger() {
        syncExecutorService.submit(() -> {
            while (true) {
                try {
                    LoggerMessage log = LoggerQueue.getInstance().poll();
                    if (log != null) {
                        if (messagingTemplate != null) {
                            messagingTemplate.convertAndSend("/topic/pullLogger", log);
                        }
                    }
                } catch (Exception e) {
                    log.error("推送日志出错" + e.getMessage());
                    ;
                }
            }
        });
    }
}
