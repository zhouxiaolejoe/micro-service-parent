package com.micro.service.mybatisplus.model;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

/**
 * @Description
 * @Project micro-service-parent
 * @Package com.micro.service.mybatisplus.model
 * @Author zhouxiaole
 * @Date 2020-09-13 21:16
 */
@Data
@Builder
@AllArgsConstructor
@NoArgsConstructor
@TableName(value = "user100w")
public class User100w {
    @TableId(value = "id", type = IdType.AUTO)
    private Integer id;

    @TableField(value = "first_name")
    private String firstName;

    @TableField(value = "last_name")
    private String lastName;

    @TableField(value = "sex")
    private String sex;

    @TableField(value = "score")
    private Integer score;

    @TableField(value = "copy_id")
    private Integer copyId;
}