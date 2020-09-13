/**
 *
 */
package com.micro.service.springwebsocket.okhttp3;

import okhttp3.HttpUrl;
import okhttp3.MediaType;
import okhttp3.Request;
import okhttp3.RequestBody;

/**
 * @Description
 * @Author ZhouXiaoLe
 * @Date 2019/7/18  10:02
 * @Param
 * @return
 **/
public class OkHttpRequestUtil {
    private static final MediaType TYPE_JSON = MediaType
            .parse("application/json;charset=utf-8");

    private OkHttpRequestUtil() {
    }

    /**
     * @Description post url参数封装
     * @Author ZhouXiaoLe
     * @Date 2019/7/18  14:32
     * @Param [url, jsonStr:json字符串]
     * @return okhttp3.Request
     **/
    public static Request buildPostJsonRequest(String url, String jsonStr) {
        RequestBody requestBody = RequestBody.create(TYPE_JSON, jsonStr);
        Request request = new Request.Builder().url(url).post(requestBody)
                .build();
        return request;
    }

    /**
     * @Description get 拼接参数
     * @Author ZhouXiaoLe
     * @Date 2019/7/18  14:31
     * @Param [httpUrl：String]
     * @return okhttp3.Request
     **/
    public static Request buildGetRequest(String url) {
        return new Request.Builder()
                .url(url).get().build();
    }

    /**
     * @Description get HttpUrl构建url
     * @Author ZhouXiaoLe
     * @Date 2019/7/18  14:31
     * @Param [httpUrl：HttpUrl]
     * @return okhttp3.Request
     **/
    public static Request buildGetRequestHttpUrl(HttpUrl httpUrl) {
        return new Request.Builder()
                .url(httpUrl).get().build();
    }


}
