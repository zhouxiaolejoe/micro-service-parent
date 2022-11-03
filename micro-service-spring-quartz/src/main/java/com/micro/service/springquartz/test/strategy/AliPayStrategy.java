package com.micro.service.springquartz.test.strategy;

public class AliPayStrategy implements PayStrategy {
 
    @Override
    public String toPayHtml() {
        return "调用支付宝接口.....";
    }
}