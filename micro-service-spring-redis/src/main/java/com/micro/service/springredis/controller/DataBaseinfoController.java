package com.micro.service.springredis.controller;

import com.micro.service.springredis.model.DataBaseinfo;
import com.micro.service.springredis.service.DataBaseinfoService;
import com.micro.service.tool.untils.ResultBuilder;
import org.springframework.beans.factory.annotation.Autowired;
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
public class DataBaseinfoController {

    @Autowired
    DataBaseinfoService dataBaseinfoService;

    @GetMapping("/testRedisHashStore")
    public ResultBuilder testRedisHashStore() {
        DataBaseinfo dataBaseinfo = dataBaseinfoService.testRedisHashStore();
        return ResultBuilder.success(dataBaseinfo);
    }
}
