package com.micro.service.springquartz.test.strategy;

import org.springframework.stereotype.Component;
import org.springframework.util.StringUtils;

@Component
public class PayContextStrategy {
 
    public String toPayHtml(String payCode){
        if(StringUtils.isEmpty(payCode)){
            return "payCode不能为空!...";
        }
        PayStrategy payStrategy = StrategyFactory.getPayStrategy(payCode);
        if(payStrategy==null){
            return "没有找到具体策略的实现";
        }
        return payStrategy.toPayHtml();
    }
}