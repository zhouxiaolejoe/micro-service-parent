package com.micro.service.springquartz.model;

import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Builder;
import lombok.Data;

/**
 * @Description
 * @Project micro-service-parent
 * @Package com.micro.service.springquartz.model
 * @Author zxl
 * @Date 2020-11-14 10:16
 */
@Data
@ApiModel("字段属性")
@Builder
public class ColumnInfo {

    @ApiModelProperty(value = "表名", required = true)
    private String tableName;

    @ApiModelProperty(value = "字段名称", required = true)
    private String columnName;

    @ApiModelProperty(value = "新字段名称", required = true)
    private String newColumnName;

    @ApiModelProperty(value = "字段类型", required = true)
    private String columnType;

    @ApiModelProperty(value = "字段长度", required = true)
    private String columnLength;

    @ApiModelProperty(value = "默认值", required = true)
    private String defaulValue;

    @ApiModelProperty(value = "是否为空", required = true,notes = "1是,0否")
    private String empty;
}
