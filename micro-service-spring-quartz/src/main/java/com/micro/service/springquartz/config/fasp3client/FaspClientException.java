package com.micro.service.springquartz.config.fasp3client;

/**
 * Created by wengy on 2019/10/22.
 */
public class FaspClientException extends RuntimeException {

    public FaspClientException() {
        super();
    }

    public FaspClientException(String message) {
        super(message);
    }

    public FaspClientException(Throwable cause) {
        super(cause);
    }

    public FaspClientException(String message, Throwable cause) {
        super(message, cause);
    }

    public FaspClientException(String format, String... args) {
        super(String.format(format, args));
    }
}
