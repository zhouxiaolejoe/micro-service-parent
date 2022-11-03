package com.micro.service.springquartz.test.strategy;

public class XiaoMiPayStrategy implements PayStrategy {
    @Override
    public String toPayHtml() {
        return "调用小米支付....";
    }
}