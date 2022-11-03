package com.micro.service.springquartz.test.strategy;

public class StrategyFactory {
 
    public static PayStrategy getPayStrategy(String stratrgyType){
        try {
            String className = PayEnumStrategy.valueOf(stratrgyType).getClassName();
            return  (PayStrategy)Class.forName(className).newInstance();
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }
}