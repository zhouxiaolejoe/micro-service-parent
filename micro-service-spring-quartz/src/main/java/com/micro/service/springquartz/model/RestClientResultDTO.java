package com.micro.service.springquartz.model;

/**
 * Created by wengy on 2019/1/10.
 */
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
