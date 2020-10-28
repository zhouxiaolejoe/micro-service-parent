package com.micro.service.springquartz.model;

/**
* @Description
* @Author zxl
* @Date  2020-10-28  16:23:36
**/
public class RestClientResultDTO<T> {
    private boolean success;
    private T data;
    private String message;

    public boolean isSuccess() {
        return success;
    }
    public void setSuccess(boolean success) {
        this.success = success;
    }
    public String getMessage() {
        return message;
    }
    public void setMessage(String message) {
        this.message = message;
    }
    public T getData() {
        return data;
    }
    public void setData(T data) {
        this.data = data;
    }

    @Override
    public String toString() {
        return "RestResult{" +
            "success=" + success +
            ", message='" + message + '\'' +
            ", data=" + data +
            '}';
    }
}
