package com.micro.service.springsecurity;

import jdk.nashorn.internal.objects.annotations.Getter;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.context.properties.EnableConfigurationProperties;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

/**
 * The type Micro service spring security application.
 *
 * @ConfigurationProperties 配置属性文件 ，需要指定前缀 prefix
 * @EnableConfigurationProperties 启用配置 ，需要指定启用的配置类
 * @NestedConfigurationProperty 当一个类中引用了外部类 ，需要在该属性上加该注解
 */
@SpringBootApplication
@EnableConfigurationProperties({ TestProperties.class })
@RestController
public class MicroServiceSpringSecurityApplication {
    /**
     * The Properties.
     */
    @Autowired
    TestProperties properties;

    /**
     * The entry point of application.
     *
     * @param args the input arguments
     */
    public static void main(String[] args) {
        SpringApplication.run(MicroServiceSpringSecurityApplication.class, args);
    }

    /**
     * Test 1.
     */
    @GetMapping("/test")
    public void test1 (){
        System.err.println(properties);
    }
}
