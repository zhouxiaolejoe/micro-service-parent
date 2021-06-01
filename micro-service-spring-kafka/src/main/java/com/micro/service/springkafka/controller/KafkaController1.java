package com.micro.service.springkafka.controller;

import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.MediaType;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

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
public class KafkaController1 {

    /**
    * @Description 创建topic
    * @Method testKafka
    * @return void
    * @Author ZhouXiaoLe
    * @Date  2019-08-05  09:58:07
    **/
    @GetMapping("/testKafka")
    @ApiOperation(value = "创建topic", produces = MediaType.APPLICATION_JSON_VALUE, httpMethod = "GET")
    public String testKafka(){
      return "SUCCES";
    }

}
