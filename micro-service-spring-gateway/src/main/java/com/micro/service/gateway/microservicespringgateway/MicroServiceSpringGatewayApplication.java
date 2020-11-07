package com.micro.service.gateway.microservicespringgateway;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.cloud.client.discovery.EnableDiscoveryClient;

@SpringBootApplication
@EnableDiscoveryClient(autoRegister = true)
public class MicroServiceSpringGatewayApplication {

    public static void main(String[] args) {
        SpringApplication.run(MicroServiceSpringGatewayApplication.class, args);
    }

}
