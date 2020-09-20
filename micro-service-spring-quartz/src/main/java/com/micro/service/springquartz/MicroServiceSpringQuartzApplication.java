package com.micro.service.springquartz;

import org.mybatis.spring.annotation.MapperScan;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;

/**
 * @author Administrator
 */
@SpringBootApplication
@MapperScan(basePackages = {"com.micro.service.springquartz.mapper"})
public class MicroServiceSpringQuartzApplication {
    public static void main(String[] args) {
        SpringApplication.run(MicroServiceSpringQuartzApplication.class, args);
    }

}
