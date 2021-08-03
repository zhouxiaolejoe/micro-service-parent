package com.micro.service.springsecurity;

import lombok.Data;
import org.springframework.boot.context.properties.ConfigurationProperties;
import org.springframework.boot.context.properties.NestedConfigurationProperty;

@Data
@ConfigurationProperties(prefix = "test")
public class TestProperties {
    private String name;
    private String nameCn;
    private String nameEn;
    private String[] hobbies;
    private SexEnum sexEnum;
    private boolean single;
    @NestedConfigurationProperty
    private School school;
    private City city;
 
    enum SexEnum {
        MAN, WOMAN
    }
 
    @Data
    static class City {
        private Integer nol;
        private String name;
    }
}