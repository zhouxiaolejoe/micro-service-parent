package com.micro.service.springredis.controller;

import com.micro.service.springredis.model.DataBaseinfo;
import com.micro.service.springredis.service.DataBaseinfoService;
import com.micro.service.tool.until.api.ResultBuilder;
import com.micro.service.tool.until.api.ResultPageBuilder;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestParam;
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
     * @return com.micro.service.tool.untils.ResultBuilder
     * @throws
     * @Description 测试存储Hash数据
     * @Method testRedisHashStore
     * @Author zxl
     * @Date 2020-11-07  13:56:11
     **/
    @GetMapping("/testRedisHashStore/{id}")
    @ApiOperation(value = "测试存储Hash数据", produces = MediaType.APPLICATION_JSON_VALUE, httpMethod = "GET")
    public ResultBuilder<DataBaseinfo> testRedisHashStore(@PathVariable("id") Integer id) {
        DataBaseinfo dataBaseinfo = dataBaseinfoService.testRedisHashStore(id);
        return ResultBuilder.success(dataBaseinfo);
    }

    /**
     * @return com.micro.service.tool.untils.ResultBuilder
     * @throws
     * @Description 测试存储Json数据
     * @Method testRedisJsonStore
     * @Author zxl
     * @Date 2020-11-07  14:24:19
     **/
    @GetMapping("/testRedisJsonStore/{id}")
    @ApiOperation(value = "测试存储Json数据", produces = MediaType.APPLICATION_JSON_VALUE, httpMethod = "GET")
    public ResultBuilder<DataBaseinfo> testRedisJsonStore(@PathVariable("id") Integer id) {
        DataBaseinfo dataBaseinfo = dataBaseinfoService.testRedisJsonStore(id);
        return ResultBuilder.success(dataBaseinfo);
    }

    /**
     * @return com.micro.service.tool.untils.ResultBuilder
     * @throws
     * @Description 测试存储Bean数据
     * @Method testRedisBeanStore
     * @Author zxl
     * @Date 2020-11-07  14:24:54
     **/
    @GetMapping("/testRedisBeanStore")
    @ApiOperation(value = "测试存储Bean数据", produces = MediaType.APPLICATION_JSON_VALUE, httpMethod = "GET")
    public ResultBuilder<DataBaseinfo> testRedisBeanStore(@RequestParam("id") Integer id) {
        DataBaseinfo dataBaseinfo = dataBaseinfoService.testRedisBeanStore(id);
        return ResultBuilder.success(dataBaseinfo);
    }


    /**
     * @return com.micro.service.tool.untils.ResultBuilder
     * @throws
     * @Description 分页返回数据测试
     * @Method testRedisBeanStore
     * @Author zxl
     * @Date 2020-11-07  14:24:54
     **/
    @GetMapping("/testPage")
    @ApiOperation(value = "分页返回数据测试", produces = MediaType.APPLICATION_JSON_VALUE, httpMethod = "GET")
    public ResultPageBuilder<DataBaseinfo> testPage(@RequestParam("page") Integer page, @RequestParam("pageSize") Integer pageSize) {
        ResultPageBuilder resultPageBuilder = dataBaseinfoService.testPage(page, pageSize);
        return resultPageBuilder;
    }

}

