package com.micro.service.springquartz.test.chain;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

/**
 * 待检验产品
 */
@AllArgsConstructor
@NoArgsConstructor
@Data
public class Product {

    /**
     * 产品长度
     */
    Integer length;

    /**
     * 产品宽度
     */
    Integer width;
}