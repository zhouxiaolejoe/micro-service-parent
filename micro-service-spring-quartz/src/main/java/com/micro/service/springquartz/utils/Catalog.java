package com.micro.service.springquartz.utils;

import lombok.Data;

import java.util.List;
@Data
public class Catalog {

    /**
     * 唯一编号 uuid
     */
    private String id;

    /**
     * 名称
     */
    private String name;

    /**
     * 父节点id
     */
    private String parentId;

    /**
     * 子节点(数据库中不存在该字段，仅用于传输数据使用)
     */
    private List<?> children;

    // 省略 get set
}