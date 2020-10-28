package com.micro.service.springquartz.model;

import java.util.Date;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

/**
 * @Description
 * @Project micro-service-parent
 * @Package com.micro.service.springquartz.model
 * @Author zxl
 * @Date 2020-09-20 17:57
 */
@Data
@Builder
@AllArgsConstructor
@NoArgsConstructor
public class FaspTPubmenu {
    private String guid;

    private Short levelno;

    private Short isleaf;

    private String status;

    private String code;

    private String name;

    private String parentid;

    private String url;

    private Integer menuorder;

    private String remark;

    private Date dbversion;

    private Short appsysid;

    private String province;

    private String year;

    private String appid;

    private String param1;

    private String param2;

    private String param3;

    private String param4;

    private String param5;

    private String ssoflag;

    private Short admintype;

    private String alias;

    private String isptadmin;

    private String admdiv;
}