package com.micro.service.tool.until;

import com.github.pagehelper.PageInfo;
import io.swagger.annotations.ApiModelProperty;
import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

import java.util.ArrayList;
import java.util.List;

/**
 * @Description 用于前端分页返回
 * @Author ZhouXiaoLe
 * @Date 2019/7/17  16:28
 * @Param
 * @return
 **/
@Getter
@Setter
@ToString
public class ResultPageBuilder<T> {
    private static final long serialVersionUID = -602413775193033896L;
    private static final String MSG_SUCCESS = "success";
    private static final String MSG_FAIL = "failure";
    private static final int CODE_SUCCESS = 1;
    private static final int CODE_FAIL = 0;

    private int code;
    private String msg;
    private List<T> result;
    private InnerPageInfo pageInfo = new InnerPageInfo();
    private ResultPageBuilder() {
    }
    private static <T> ResultPageBuilder<T> resultBuilder(int code, String msg, PageInfo<T> pageInfo) {
        ResultPageBuilder<T> resultPageBuilder = new ResultPageBuilder<>();
        resultPageBuilder.code = code;
        resultPageBuilder.msg = msg;
        if(pageInfo == null){
            resultPageBuilder.result = new ArrayList<>();
            resultPageBuilder.pageInfo.currentPage = 0;
            resultPageBuilder.pageInfo.total = 0;
            resultPageBuilder.pageInfo.pages = 0;
            return resultPageBuilder;
        }
        resultPageBuilder.result = pageInfo.getList();
        resultPageBuilder.pageInfo.currentPage = pageInfo.getPageNum();
        resultPageBuilder.pageInfo.total = pageInfo.getTotal();
        resultPageBuilder.pageInfo.pages = pageInfo.getPages();
        return resultPageBuilder;
    }

    public static <T> ResultPageBuilder<T> success(PageInfo<T> pageInfo) {
        return resultBuilder(CODE_SUCCESS, MSG_SUCCESS, pageInfo);
    }

    public static <T> ResultPageBuilder<T> success() {
        return success(null);
    }

    private static <T> ResultPageBuilder<T> fail(PageInfo<T> pageInfo) {
        return resultBuilder(CODE_FAIL, MSG_FAIL, pageInfo);
    }

    public static <T> ResultPageBuilder<T> fail() {
        return resultBuilder(CODE_FAIL, MSG_FAIL, null);
    }

    private static <T> ResultPageBuilder<T> fail(PageInfo<T> pageInfo, String msg) {
        return resultBuilder(CODE_FAIL, msg, pageInfo);
    }

    private static <T> ResultPageBuilder<T> fail(int code, PageInfo<T> pageInfo, String msg) {
        return resultBuilder(code, msg, pageInfo);
    }

    @Getter
    @Setter
    @ToString
    public class InnerPageInfo {
        @ApiModelProperty(value = "当前页")
        int currentPage;
        @ApiModelProperty(value = "总记录数")
        long total;
        @ApiModelProperty(value = "总页数")
        long pages;
    }

}
