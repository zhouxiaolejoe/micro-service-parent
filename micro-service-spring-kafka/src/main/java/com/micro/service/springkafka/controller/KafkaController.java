package com.micro.service.springkafka.controller;

import com.alibaba.cloud.nacos.NacosConfigManager;
import com.alibaba.nacos.api.config.listener.Listener;
import com.micro.service.tool.untils.FastJsonUtils;
import com.micro.service.tool.untils.ResultBuilder;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import lombok.extern.slf4j.Slf4j;
import org.apache.catalina.startup.UserConfig;
import org.apache.kafka.clients.admin.AdminClient;
import org.apache.kafka.clients.admin.NewTopic;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.boot.ApplicationArguments;
import org.springframework.boot.ApplicationRunner;
import org.springframework.boot.context.properties.ConfigurationProperties;
import org.springframework.boot.context.properties.EnableConfigurationProperties;
import org.springframework.cloud.context.config.annotation.RefreshScope;
import org.springframework.http.MediaType;
import org.springframework.kafka.core.KafkaAdmin;
import org.springframework.kafka.core.KafkaTemplate;
import org.springframework.stereotype.Component;
import org.springframework.web.bind.annotation.*;

import java.io.IOException;
import java.io.StringReader;
import java.util.Arrays;
import java.util.Map;
import java.util.Properties;
import java.util.concurrent.Executor;

/**
 * @ClassName KafkaController
 * @Description TODO
 * @Author ZhouXiaoLe
 * @Date 2019/8/5 9:50
 * @Version 1.0.0
 */
@RestController
@Api(tags = "kafka测试")
@Slf4j
public class KafkaController {

    @Autowired
    KafkaAdmin admin;
    @Autowired
    KafkaTemplate kafkaTemplate;
    /**
    * @Description 创建topic
    * @Method testKafka
    * @return void
    * @Author ZhouXiaoLe
    * @Date  2019-08-05  09:58:07
    **/
    @GetMapping("/testKafka")
    @ApiOperation(value = "创建topic", produces = MediaType.APPLICATION_JSON_VALUE, httpMethod = "GET")
    public void testKafka(){
        AdminClient client = AdminClient.create(admin.getConfig());
        NewTopic topic5 = new NewTopic("topic1", 3, (short) 3);
        client.createTopics(Arrays.asList(topic5));
    }
    /**
     * @Description testKafkaSendData
     * @Method testKafkaSendData
     * @return void
     * @Author ZhouXiaoLe
     * @Date  2019-08-05  09:58:07
     **/
    @PostMapping("/testKafkaSendData")
    @ApiOperation(value = "发送数据", produces = MediaType.APPLICATION_JSON_VALUE, httpMethod = "POST")
    public ResultBuilder testKafkaSendData(@RequestParam("topic")String topic, @RequestBody Map data){
        kafkaTemplate.send(topic, FastJsonUtils.getBeanToJson(data));
        return ResultBuilder.success();
    }
}
