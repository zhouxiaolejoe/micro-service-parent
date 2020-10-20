package com.micro.service.springquartz.model;

import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.*;

/**
 * @ClassName DataSourceDTO
 * @Description TODO
 * @Author Administrator
 * @Date 2020/10/13 15:11
 * @Version 1.0.0
 */
@Data
@ToString
@NoArgsConstructor
@AllArgsConstructor
@ApiModel("com.micro.service.springquartz.model.DataSourceDTO")
@Builder
public class DataSourceDTO {
    @ApiModelProperty(value = "数据库唯一标识",required = true)
    String datasourceid;
    @ApiModelProperty(value = "数据库唯URL",required = true)
    String url;
    @ApiModelProperty(value = "用户名",required = true)
    String username;
    @ApiModelProperty(value = "密码",required = true)
    String password;
    @ApiModelProperty(value = "业务名称",required = true)
    String businessname;
    @ApiModelProperty(value = "年度",required = false)
    String province;
    @ApiModelProperty(value = "区划",required = false)
    String year;
}
