package com.micro.service.springredis.model;

import com.fasterxml.jackson.annotation.JsonFormat;
import io.swagger.annotations.ApiModelProperty;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.springframework.format.annotation.DateTimeFormat;

import java.util.Date;

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
public class DataBaseOne {
    private String username;
    private String password;
}
