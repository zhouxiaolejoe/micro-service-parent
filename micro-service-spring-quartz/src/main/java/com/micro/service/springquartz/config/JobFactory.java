package com.micro.service.springquartz.config;

import lombok.AllArgsConstructor;
import org.quartz.spi.TriggerFiredBundle;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.config.AutowireCapableBeanFactory;
import org.springframework.scheduling.quartz.AdaptableJobFactory;
import org.springframework.stereotype.Component;

/**
* @Description
* @Author zxl
* @Date  2020-10-28  16:16:48
**/
@Component
@AllArgsConstructor
public class JobFactory extends AdaptableJobFactory {
      
    private AutowireCapableBeanFactory capableBeanFactory;
  
    @Override  
    protected Object createJobInstance(TriggerFiredBundle bundle) throws Exception {
        //调用父类的方法  
        Object jobInstance = super.createJobInstance(bundle);  
        //进行注入  
        capableBeanFactory.autowireBean(jobInstance);  
        return jobInstance;  
    }  
      
}  