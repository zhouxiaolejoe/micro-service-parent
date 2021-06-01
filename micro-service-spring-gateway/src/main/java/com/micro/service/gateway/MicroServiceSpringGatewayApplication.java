package com.micro.service.gateway;

import org.hibernate.validator.constraints.pl.REGON;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.cloud.client.discovery.DiscoveryClient;
import org.springframework.cloud.client.discovery.EnableDiscoveryClient;
import org.springframework.cloud.context.config.annotation.RefreshScope;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

import javax.annotation.Resource;
import java.util.List;

@SpringBootApplication
@EnableDiscoveryClient(autoRegister = true)
@RefreshScope
@RestController
public class MicroServiceSpringGatewayApplication {
    @Resource
    private DiscoveryClient disClient;

    public static void main(String[] args) {
        SpringApplication.run(MicroServiceSpringGatewayApplication.class, args);

    }
    @GetMapping("/test1")
    public List<String> test1(){
        return disClient.getServices();
    }

}
