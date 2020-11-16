package com.micro.service.springquartz.model;

import com.fasterxml.jackson.annotation.JsonIgnore;
import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import jdk.nashorn.internal.ir.annotations.Ignore;
import lombok.Data;
import lombok.ToString;

import java.util.Date;
import java.util.List;

/**
 * @Description
 * @Project micro-service-parent
 * @Package com.micro.service.springquartz.model
 * @Author zxl
 * @Date 2020-11-16 11:07
 */
@Data
@ToString
//@JsonIgnoreProperties(value = {"createtime","createuser","dbversion",})
public class FaspTDicdstype {
    private String guid;

    private String name;
    @JsonIgnore
    private String createtime;
    @JsonIgnore
    private String createuser;

    private String superguid;
    @JsonIgnore
    private Date dbversion;

    private List<?> children;

}