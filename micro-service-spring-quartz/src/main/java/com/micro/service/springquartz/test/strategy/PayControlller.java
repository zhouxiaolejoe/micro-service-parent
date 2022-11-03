package com.micro.service.springquartz.test.strategy;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class PayControlller {
 
    @Autowired
    private PayContextStrategy payContextStrategy;
 
    @GetMapping("/toPayHtml")
    public String toPayHtml(String payCode){
        return payContextStrategy.toPayHtml(payCode);
    }
}