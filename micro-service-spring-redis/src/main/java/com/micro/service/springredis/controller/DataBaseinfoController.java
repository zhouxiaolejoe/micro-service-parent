package com.micro.service.springredis.controller;

import com.micro.service.springredis.model.DataBaseinfo;
import com.micro.service.springredis.service.DataBaseinfoService;
import com.micro.service.tool.untils.ResultBuilder;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

/**
 * @ClassName DataBaseinfoController
 * @Description TODO
 * @Author zhouxiaole
 * @Date 2020/9/13 12:51
 * @Version 1.0.0
 */
@RestController
@Api(tags = "redis测试")
public class DataBaseinfoController {

    @Autowired
    DataBaseinfoService dataBaseinfoService;
    /**
    * @Description 测试存储Hash数据
    * @Method testRedisHashStore
    * @return com.micro.service.tool.untils.ResultBuilder
    * @throws
    * @Author zxl
    * @Date  2020-11-07  13:56:11
    **/
    @GetMapping("/testRedisHashStore")
    @ApiOperation(value = "测试存储Hash数据", produces = MediaType.APPLICATION_JSON_VALUE, httpMethod = "GET")
    public ResultBuilder testRedisHashStore() {
        DataBaseinfo dataBaseinfo = dataBaseinfoService.testRedisHashStore();
        return ResultBuilder.success(dataBaseinfo);
    }
    /**
    * @Description  测试存储Json数据
    * @Method testRedisJsonStore
    * @return com.micro.service.tool.untils.ResultBuilder
    * @throws
    * @Author zxl
    * @Date  2020-11-07  14:24:19
    **/
    @GetMapping("/testRedisHashStore")
    @ApiOperation(value = "测试存储Json数据", produces = MediaType.APPLICATION_JSON_VALUE, httpMethod = "GET")
    public ResultBuilder testRedisJsonStore() {
        DataBaseinfo dataBaseinfo = dataBaseinfoService.testRedisJsonStore();
        return ResultBuilder.success(dataBaseinfo);
    }
    /**
    * @Description 测试存储Bean数据
    * @Method testRedisBeanStore
    * @return com.micro.service.tool.untils.ResultBuilder
    * @throws
    * @Author zxl
    * @Date  2020-11-07  14:24:54
    **/
    @GetMapping("/testRedisBeanStore")
    @ApiOperation(value = "测试存储Bean数据", produces = MediaType.APPLICATION_JSON_VALUE, httpMethod = "GET")
    public ResultBuilder testRedisBeanStore() {
        DataBaseinfo dataBaseinfo = dataBaseinfoService.testRedisBeanStore();
        return ResultBuilder.success(dataBaseinfo);
    }
}
