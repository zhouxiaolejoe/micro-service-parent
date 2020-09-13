package com.micro.service.springwebsocket.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.messaging.simp.SimpMessageSendingOperations;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RestController;

/**
 * @ClassName HelloController
 * @Description TODO
 * @Author ZhouXiaoLe
 * @Date 2019/7/31 16:48
 * @Version 1.0.0
 */
@RestController
public class HelloController {
        @Autowired
        SimpMessageSendingOperations messagingTemplate;
        @GetMapping("/getTime/{time}")
        public void getTime(@PathVariable("time")String time){
            messagingTemplate.convertAndSend("/topic/public", time);
        }
}
