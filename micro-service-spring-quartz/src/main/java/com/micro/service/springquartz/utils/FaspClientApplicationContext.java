package com.micro.service.springquartz.utils;

import org.springframework.context.ApplicationContext;
import org.springframework.stereotype.Component;

/**
 * Created by wengy on 2019/11/21.
 */
@Component
public class FaspClientApplicationContext {

    static private ApplicationContext context;

    public static void setContext(ApplicationContext context) {
        FaspClientApplicationContext.context = context;
    }

    public static ApplicationContext getContext() {
        return context;
    }
}
