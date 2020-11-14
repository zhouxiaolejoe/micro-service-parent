package com.micro.service.springquartz.enu;

import lombok.Data;
import oracle.sql.NUMBER;

/**
 * @Description
 * @Project micro-service-parent
 * @Package com.micro.service.springquartz.enu
 * @Author zxl
 * @Date 2020-11-14 14:27
 */
public enum TypeEnum {
    VARCHAR("字符串",""),
    NUMBER("数字","");
    String name;
    String value;

    TypeEnum(String name, String value) {
        this.name = name;
        this.value = value;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getValue() {
        return value;
    }

    public void setValue(String value) {
        this.value = value;
    }
}
