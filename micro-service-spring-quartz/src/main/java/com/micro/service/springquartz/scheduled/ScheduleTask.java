package com.micro.service.springquartz.scheduled;

import com.micro.service.springquartz.model.LoggerMessage;
import com.micro.service.springquartz.model.LoggerQueue;
import lombok.AllArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.messaging.simp.SimpMessageSendingOperations;
import org.springframework.scheduling.annotation.Async;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

import javax.annotation.PostConstruct;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;

/**
 * @Description
 * @Author ZhouXiaoLe
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


    @Scheduled(fixedRate = 5000)
    public void outputLogger() {
        SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd hh:mm:ss");
        String time = format.format(new Date());
        log.info("测试日志输出" + time);
    }

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
