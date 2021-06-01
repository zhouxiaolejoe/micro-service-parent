package com.micro.service.springkafka;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.autoconfigure.jdbc.DataSourceAutoConfiguration;
import org.springframework.cloud.client.discovery.EnableDiscoveryClient;
import org.springframework.cloud.context.config.annotation.RefreshScope;

@SpringBootApplication(exclude = {DataSourceAutoConfiguration.class})
@EnableDiscoveryClient(autoRegister = true)
public class MicroServiceSpringKafkaApplication {
    public static void main(String[] args) {
        SpringApplication.run(MicroServiceSpringKafkaApplication.class, args);
    }
}
