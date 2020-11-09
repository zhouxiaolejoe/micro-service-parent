package com.micro.service.springredis.model;

import java.util.Date;

import com.fasterxml.jackson.annotation.JsonFormat;
import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
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
@ApiModel("数据库连接信息")
public class DataBaseinfo {
    @ApiModelProperty(value="主键",required = true)
    private Integer guid;
    @ApiModelProperty(value="数据源id",required = true)
    private String datasourceid;
    @ApiModelProperty(value="数据源类型",required = true)
    private Integer databasetype;
    @ApiModelProperty(value="数据源URL",required = true)
    private String url;
    @ApiModelProperty(value="用户",required = true)
    private String username;
    @ApiModelProperty(value="密码",required = true)
    private String password;
    @ApiModelProperty(value="数据库连接驱动",required = true)
    private String driverclassname;
    @DateTimeFormat(pattern="yyyy-MM-dd HH:mm:ss")
    @JsonFormat(pattern="yyyy-MM-dd HH:mm:ss")
    @ApiModelProperty(value="创建时间",required = true)
    private Date createtime;
    @ApiModelProperty(value="创建人",required = true)
    private String createuser;
    @DateTimeFormat(pattern="yyyy-MM-dd HH:mm:ss")
    @JsonFormat(pattern="yyyy-MM-dd HH:mm:ss")
    @ApiModelProperty(value="更新时间",required = true)
    private Date updatetime;
    @ApiModelProperty(value="更新人",required = true)
    private String updateuser;
    @DateTimeFormat(pattern="yyyy-MM-dd HH:mm:ss")
    @JsonFormat(pattern="yyyy-MM-dd HH:mm:ss")
    @ApiModelProperty(value="版本",required = true)
    private Date dbversion;
    @ApiModelProperty(value="是否删除",required = true)
    private Integer isdelete;
    @ApiModelProperty(value="KEY",required = true)
    private String publickey;
}