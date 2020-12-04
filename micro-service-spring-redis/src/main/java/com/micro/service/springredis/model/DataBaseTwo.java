package com.micro.service.springredis.model;

import com.micro.service.tool.untils.beans.CopyProperty;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

/**
 * @ClassName DataBaseOne
 * @Description TODO
 * @Author zhouxiaole
 * @Date 2020/11/28 17:00
 * @Version 1.0.0
 */

@Data
@Builder
@AllArgsConstructor
@NoArgsConstructor
public class DataBaseTwo {
    @CopyProperty("username")
    private String name;
    @CopyProperty(value = "password")
    private String pwd;
}
