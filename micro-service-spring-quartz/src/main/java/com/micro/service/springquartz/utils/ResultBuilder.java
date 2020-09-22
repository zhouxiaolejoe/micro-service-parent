package com.micro.service.springquartz.utils;

import lombok.Data;

import java.io.Serializable;

/**
 * @Description 统一返回值
 * @Author ZhouXiaoLe
 * @Date 2019/7/17  16:22
 * @Param
 * @return
 **/
@Data
public class ResultBuilder<T> implements Serializable {

    private static final long serialVersionUID = -602413775193033896L;
    private static final String MSG_SUCCESS = "success";
    private static final String MSG_FAIL = "failure";
    private static final int CODE_SUCCESS = 1;
    private static final int CODE_FAIL = 0;

    private int code;
    private String msg;
    private T result;

    private ResultBuilder() {
    }

    private static <T> ResultBuilder<T> resultBuilder(int code, String msg, T result) {
        ResultBuilder<T> resultBuilder = new ResultBuilder<>();
        resultBuilder.code = code;
        resultBuilder.msg = msg;
        resultBuilder.result = result;
        return resultBuilder;
    }

    public static <T> ResultBuilder<T> success(T result) {
        return resultBuilder(CODE_SUCCESS, MSG_SUCCESS, result);
    }

    public static <T> ResultBuilder<T> success() {
        return success(null);
    }

    public static <T> ResultBuilder<T> fail(T result) {
        return resultBuilder(CODE_FAIL, MSG_FAIL, result);
    }

    public static <T> ResultBuilder<T> fail() {
        return fail(null);
    }

    public static <T> ResultBuilder<T> fail(T result, String msg) {
        return resultBuilder(CODE_FAIL, msg, result);
    }

    public static <T> ResultBuilder<T> fail(int code, T result, String msg) {
        return resultBuilder(code, msg, result);
    }

}
