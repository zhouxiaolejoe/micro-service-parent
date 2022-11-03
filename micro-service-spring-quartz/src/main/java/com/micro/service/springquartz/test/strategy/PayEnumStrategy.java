package com.micro.service.springquartz.test.strategy;

//策略枚举类,存放所有策略的实现
public enum PayEnumStrategy {
    
    //支付宝支付
    ALI_PAY("gov.mof.fasp3.masterdata.test.strategy.AliPayStrategy"),
    
    //小米支付
    XIAOMI_PAY("gov.mof.fasp3.masterdata.test.strategy.XiaoMiPayStrategy"),
    
    //微信支付
    WECHAT_PAY("gov.mof.fasp3.masterdata.test.strategy.WeiXinPayStrategy");
    
    PayEnumStrategy(String className){
        this.setClassName(className);
    }
 
    public String getClassName() {
        return className;
    }
 
    public void setClassName(String className) {
        this.className = className;
    }
    
    //class完整地址
    private String className;
}