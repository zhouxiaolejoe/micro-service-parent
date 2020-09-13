package com.micro.service.springwebsocket.schedule;

import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.messaging.simp.SimpMessageSendingOperations;
import org.springframework.scheduling.annotation.Async;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

import java.text.SimpleDateFormat;
import java.util.Date;

/**
 * @Description
 * @Author ZhouXiaoLe
 * @Date 2019/7/17  17:16
 * @Param
 * @return
 **/
@Component
@Slf4j
public class ScheduleTask {

    @Autowired
    private SimpMessageSendingOperations messagingTemplate;


    /**
     * @return void
     * @Description @Async多线程定时任务
     * @Author ZhouXiaoLe
     * @Date 2019/7/17  17:27
     * @Param []
     **/
    @Scheduled(cron = "0/1 * * * * *")
    @Async
    public void scheduled() {
        SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd hh:mm:ss");
        String time = format.format(new Date());
        messagingTemplate.convertAndSend("/topic/public", time);
    }
//	@Scheduled(fixedRate = 5000)
//	@Async
//	public void scheduled1() {
//		log.info("=====>>>>>使用fixedRate{}", System.currentTimeMillis());
//	}
//	@Scheduled(fixedDelay = 5000)
//	@Async
//	public void scheduled2() {
//		log.info("=====>>>>>fixedDelay{}",System.currentTimeMillis());
//	}

}
