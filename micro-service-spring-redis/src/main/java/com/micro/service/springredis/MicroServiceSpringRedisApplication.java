package com.micro.service.springredis;

import org.mybatis.spring.annotation.MapperScan;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.cache.annotation.EnableCaching;


@SpringBootApplication
@MapperScan({
        "com.micro.service.springredis.mapper"
})
@EnableCaching
//@EnableDiscoveryClient(autoRegister = true)
public class MicroServiceSpringRedisApplication {

    public static void main(String[] args) {
        SpringApplication.run(MicroServiceSpringRedisApplication.class, args);
    }

}
