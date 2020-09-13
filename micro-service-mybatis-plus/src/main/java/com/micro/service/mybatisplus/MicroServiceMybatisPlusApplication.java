package com.micro.service.mybatisplus;

import org.mybatis.spring.annotation.MapperScan;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;

@SpringBootApplication
@MapperScan({"com.micro.service.mybatisplus.mapper"})

public class MicroServiceMybatisPlusApplication {

    public static void main(String[] args) {
        SpringApplication.run(MicroServiceMybatisPlusApplication.class, args);
    }

}
