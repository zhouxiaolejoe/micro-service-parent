package com.micro.service.springredis.model;

import java.util.Date;

import com.fasterxml.jackson.annotation.JsonFormat;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.springframework.format.annotation.DateTimeFormat;

/**
 * @Description
 * @Project micro-service-parent
 * @Package com.micro.service.springredis.model
 * @Author zhouxiaole
 * @Date 2020-09-13 12:05
 */
@Data
@Builder
@AllArgsConstructor
@NoArgsConstructor
public class DataBaseinfo {
    private Integer guid;

    private String datasourceid;

    private Integer databasetype;

    private String url;

    private String username;

    private String password;

    private String driverclassname;
    @DateTimeFormat(pattern="yyyy-MM-dd HH:mm:ss")
    @JsonFormat(pattern="yyyy-MM-dd HH:mm:ss")
    private Date createtime;

    private String createuser;
    @DateTimeFormat(pattern="yyyy-MM-dd HH:mm:ss")
    @JsonFormat(pattern="yyyy-MM-dd HH:mm:ss")
    private Date updatetime;

    private String updateuser;
    @DateTimeFormat(pattern="yyyy-MM-dd HH:mm:ss")
    @JsonFormat(pattern="yyyy-MM-dd HH:mm:ss")
    private Date dbversion;

    private Integer isdelete;

    private String publickey;
}