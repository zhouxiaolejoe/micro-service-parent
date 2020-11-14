package com.micro.service.springquartz.model;

import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Builder;
import lombok.Data;

import java.util.List;

/**
 * @Description
 * @Project micro-service-parent
 * @Package com.micro.service.springquartz.model
 * @Author zxl
 * @Date 2020-11-14 15:03
 */

@ApiModel("索引信息")
@Data
@Builder
public class IndexesInfo {

    @ApiModelProperty(value = "表名", required = true)
    private String tableName;

    @ApiModelProperty(value = "索引名称", required = true)
    private String indexName;

    @ApiModelProperty(value = "新索引名称", required = true)
    private String newIndexName;

    @ApiModelProperty(value = "建立索引字段列表", required = true)
    private List<String> index;
}
