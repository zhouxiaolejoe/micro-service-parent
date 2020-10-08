package com.micro.service.springquartz.exception;

/**
 * @Description 自定义异常
 * @Author ZhouXiaoLe
 * @Date 2019/7/18  14:35
 * @Param
 * @return
 **/
public class CustomException extends RuntimeException {

    public CustomException(String msg) {
        super(msg);
    }

    public CustomException() {
        super();
    }
}
