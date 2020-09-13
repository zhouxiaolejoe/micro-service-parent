package com.micro.service.mybatisplus.model;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import java.util.Date;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

/**
 * @Description
 * @Project micro-service-parent
 * @Package com.micro.service.mybatisplus.model
 * @Author zhouxiaole
 * @Date 2020-09-13 20:46
 */
@Data
@Builder
@AllArgsConstructor
@NoArgsConstructor
@TableName(value = "fasp_t_dbinfo")
public class DataBaseinfo {
    @TableId(value = "guid", type = IdType.AUTO)
    private Integer guid;

    @TableField(value = "datasourceid")
    private String datasourceid;

    @TableField(value = "databasetype")
    private Integer databasetype;

    @TableField(value = "url")
    private String url;

    @TableField(value = "username")
    private String username;

    @TableField(value = "password")
    private String password;

    @TableField(value = "driverclassname")
    private String driverclassname;

    @TableField(value = "createtime")
    private Date createtime;

    @TableField(value = "createuser")
    private String createuser;

    @TableField(value = "updatetime")
    private Date updatetime;

    @TableField(value = "updateuser")
    private String updateuser;

    @TableField(value = "dbversion")
    private Date dbversion;

    @TableField(value = "isdelete")
    private Integer isdelete;

    @TableField(value = "publickey")
    private String publickey;
}