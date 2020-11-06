package com.micro.service.springkafka.config;

import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.kafka.annotation.KafkaListener;
import org.springframework.kafka.core.KafkaTemplate;
import org.springframework.stereotype.Component;

/**
 * @ClassName Listener
 * @Description TODO
 * @Author ZhouXiaoLe
 * @Date 2019/8/5 10:58
 * @Version 1.0.0
 */
@Slf4j
@Component
public class Listener {
    @Autowired
    KafkaTemplate kafkaTemplate;

    @KafkaListener(groupId = "",id = "foo3", topics = {"topic3","topic2"})
    public void listen3(String data) {
        log.warn("topic3" + data);
    }

    @KafkaListener(id = "foo1", topics = {"topic1"})
    public void listen1(String data) {
        log.warn("topic1" + data);
    }

    @KafkaListener(id = "foo2", topics = {"topic2"})
    public void listen2(String data) {
        log.warn("topic2" + data);
    }

}
