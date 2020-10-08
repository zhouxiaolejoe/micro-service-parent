package com.micro.service.springquartz.exception;


import com.google.common.collect.Maps;
import com.micro.service.springquartz.utils.ResultBuilder;
import org.springframework.dao.DuplicateKeyException;
import org.springframework.http.HttpStatus;
import org.springframework.validation.FieldError;
import org.springframework.validation.ObjectError;
import org.springframework.web.bind.MethodArgumentNotValidException;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.ResponseStatus;
import org.springframework.web.bind.annotation.RestControllerAdvice;
import org.springframework.web.multipart.MaxUploadSizeExceededException;
import org.springframework.web.servlet.NoHandlerFoundException;

import javax.servlet.http.HttpServletRequest;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * @Description 全局异常控制处理器
 * @Author ZhouXiaoLe
 * @Date 2019/7/17  16:34
 * @Param
 * @return
 **/
@RestControllerAdvice
public class ExceptionAdvice {

    /**
     * @return com.hiynn.dynamic.datasource.untils.ResultBuilder
     * @Description 捕捉全局参数验证异常
     * @Author ZhouXiaoLe
     * @Date 2019/7/17  23:12
     * @Param [ex]
     **/
    @ResponseStatus(HttpStatus.BAD_REQUEST)
    @ExceptionHandler({MethodArgumentNotValidException.class})
    public ResultBuilder handleBindException(MethodArgumentNotValidException ex) {
        List<Map<String, String>> result = new ArrayList<>();
        List<ObjectError> allErrors = ex.getBindingResult().getAllErrors();
        allErrors.stream().forEach(error ->
        {
            HashMap<String, String> map = Maps.newHashMapWithExpectedSize(2);
            map.put("field", ((FieldError) error).getField());
            map.put("exception", error.getDefaultMessage());
            result.add(map);
//                    System.err.println(String.format("Field: %s\nException: %s",((FieldError) error).getField(),error.getDefaultMessage()));
        });

        return ResultBuilder.fail(result);
    }

    /**
     * @return com.hiynn.gybigdata.shiro.util.ResultBuilder
     * @Description 捕捉所有唯一约束异常
     * @Author ZhouXiaoLe
     * @Date 2019/6/25  11:20
     * @Param [e]
     **/
    @ResponseStatus(HttpStatus.BAD_REQUEST)
    @ExceptionHandler(DuplicateKeyException.class)
    public ResultBuilder handle401(DuplicateKeyException e) {
        return ResultBuilder.fail(null, "记录已经存在,违反唯一约束!");
    }

    /**
     * @return com.hiynn.dynamic.datasource.untils.ResultBuilder
     * @Description 捕捉其他自定义异常
     * @Author ZhouXiaoLe
     * @Date 2019/7/17  16:34
     * @Param [e]
     **/
    @ResponseStatus(HttpStatus.BAD_REQUEST)
    @ExceptionHandler(CustomException.class)
    public ResultBuilder handle(CustomException e) {
        return ResultBuilder.fail(null, e.getMessage());
    }

    /**
     * @return com.hiynn.dynamic.datasource.untils.ResultBuilder
     * @Description 捕捉404异常
     * @Author ZhouXiaoLe
     * @Date 2019/7/17  16:34
     * @Param [e]
     **/
    @ResponseStatus(HttpStatus.NOT_FOUND)
    @ExceptionHandler(NoHandlerFoundException.class)
    public ResultBuilder handle(NoHandlerFoundException e) {
        return ResultBuilder.fail(null, e.getMessage());
    }

    /**
     * @return com.hiynn.dynamic.datasource.untils.ResultBuilder
     * @Description 文件异常
     * @Author ZhouXiaoLe
     * @Date 2019/7/17  16:35
     * @Param [request, ex]
     **/
    @ResponseStatus(HttpStatus.INTERNAL_SERVER_ERROR)
    @ExceptionHandler(MaxUploadSizeExceededException.class)
    public ResultBuilder MaxUploadSizeExceededException(HttpServletRequest request, Throwable ex) {
        return ResultBuilder.fail(null, "上传文件不能大于10M");
    }

    /**
     * @return com.hiynn.dynamic.datasource.untils.ResultBuilder
     * @Description 捕捉所有异常
     * @Author ZhouXiaoLe
     * @Date 2019/7/17  16:35
     * @Param [request, ex]
     **/
    @ResponseStatus(HttpStatus.INTERNAL_SERVER_ERROR)
    @ExceptionHandler(Throwable.class)
    public ResultBuilder globalException(HttpServletRequest request, Throwable ex) {
        return ResultBuilder.fail(null, ex.toString() + ": " + ex.getMessage());
    }
}
