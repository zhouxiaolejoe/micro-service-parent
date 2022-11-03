package com.micro.service.springquartz.test.strategy;

public class WeiXinPayStrategy implements PayStrategy {
 
    @Override
    public String toPayHtml() {
        return "调用微信支付....";
    }
}