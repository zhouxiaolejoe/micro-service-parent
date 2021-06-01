//package com.micro.service.springkafka;
//
//import org.apache.kafka.clients.admin.AdminClient;
//import org.apache.kafka.clients.admin.NewTopic;
//import org.junit.jupiter.api.Test;
//import org.springframework.beans.factory.annotation.Autowired;
//import org.springframework.boot.test.context.SpringBootTest;
//import org.springframework.kafka.core.KafkaAdmin;
//import org.springframework.kafka.core.KafkaTemplate;
//import org.springframework.kafka.support.KafkaHeaders;
//import org.springframework.messaging.MessageHeaders;
//import org.springframework.messaging.support.GenericMessage;
//
//import java.util.Arrays;
//import java.util.HashMap;
//import java.util.Map;
//
//@SpringBootTest
//public class MicroServiceSpringKafkaApplicationTests {
//    @Autowired
//    KafkaTemplate kafkaTemplate;
//    @Autowired
//    KafkaAdmin admin;
//    @Test
//    void contextLoads() {
//
//
//
//
//    }
//    @Test
//    public void testAdmin(){
//        AdminClient client = AdminClient.create(admin.getConfig());
//        NewTopic topic2 = new NewTopic("topic2", 3, (short) 3);
//        client.createTopics(Arrays.asList(topic2));
//    }
//
//
//    @Test
//    public void testTransaction() throws InterruptedException {
//        Map map = new HashMap<>();
//        map.put(KafkaHeaders.TOPIC,"topic3");
//        map.put(KafkaHeaders.PARTITION_ID,0);
//        map.put(KafkaHeaders.MESSAGE_KEY,"0");
//        map.put(KafkaHeaders.TIMESTAMP,System.currentTimeMillis());
//        MessageHeaders messageHeaders = new MessageHeaders(map);
//        GenericMessage message = new GenericMessage("今天是个好日子", messageHeaders);
//        for (int i = 0; i < 1000; i++) {
//            kafkaTemplate.send(message);
//            Thread.sleep(2000l);
//        }
//    }
//
//
//}
