package com.micro.service.gateway;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.cloud.client.discovery.EnableDiscoveryClient;
import org.springframework.cloud.context.config.annotation.RefreshScope;

@SpringBootApplication
@EnableDiscoveryClient(autoRegister = true)
@RefreshScope
public class MicroServiceSpringGatewayApplication {

    public static void main(String[] args) {
        SpringApplication.run(MicroServiceSpringGatewayApplication.class, args);
    }

}
