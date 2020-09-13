/**
 *
 */
package com.micro.service.springwebsocket.okhttp3;

import okhttp3.HttpUrl;
import okhttp3.OkHttpClient;
import okhttp3.Response;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.io.IOException;
import java.util.concurrent.TimeUnit;

/**
 * @Description
 * @Author ZhouXiaoLe
 * @Date 2019/7/18  10:02
 * @Param
 * @return
 **/
public class OkHttpUtil {
    private static OkHttpClient singleton;
    private static final Logger LOGGER = LoggerFactory.getLogger(OkHttpUtil.class);

    private OkHttpUtil() {
    }

    /**
     * @Description getInstance
     * @Author ZhouXiaoLe
     * @Date 2019/7/18  14:30
     * @Param []
     * @return okhttp3.OkHttpClient
     **/
    public static OkHttpClient getInstance() {
        if (null == singleton) {
            synchronized (OkHttpUtil.class) {
                if (null == singleton) {
                    singleton = new OkHttpClient.Builder()
                            .connectTimeout(10, TimeUnit.SECONDS)
                            .readTimeout(120, TimeUnit.SECONDS).build();
                }
            }
        }
        return singleton;
    }

    /**
     * @Description 通过 url获取string  get请求
     * @Author ZhouXiaoLe
     * @Date 2019/7/18  14:29
     * @Param [url：字符串]
     * @return java.lang.String
     **/
    public static String getStringFromServer(String url) {
        String result = "";
        try {
            Response response = getInstance()
                    .newCall(OkHttpRequestUtil.buildGetRequest(url)).execute();

            if (!response.isSuccessful()) {
                throw new IOException("服务器端错误:" + response);
            }
            result = response.body().string();
        } catch (IOException e) {
            // TODO Auto-generated catch block
            LOGGER.error("getDongHuanInfo error: ", e);
        }
        return result;
    }

    /**
     * @Description 通过 url获取string  get请求
     * @Author ZhouXiaoLe
     * @Date 2019/7/18  14:29
     * @Param [url：HttpUrl]
     * @return java.lang.String
     **/
    public static String getStringFromServerHttpUrl(HttpUrl url) {
        String result = "";
        try {
            Response response = getInstance()
                    .newCall(OkHttpRequestUtil.buildGetRequestHttpUrl(url)).execute();

            if (!response.isSuccessful()) {
                throw new IOException("服务器端错误:" + response);
            }
            result = response.body().string();
        } catch (IOException e) {
            // TODO Auto-generated catch block
            LOGGER.error("getDongHuanInfo error: ", e);
        }
        return result;
    }

    /**
     * @Description 通过 url和parameterJsonType获取string  post请求
     * @Author ZhouXiaoLe
     * @Date 2019/7/18  14:28
     * @Param [url, parameterJsonType:为json字符串]
     * @return java.lang.String
     **/
    public static String getStringFromServerByPost(String url, String parameterJsonType) {
        String result = "";
        try {
            Response response = getInstance()
                    .newCall(OkHttpRequestUtil.buildPostJsonRequest(url, parameterJsonType)).execute();

            if (!response.isSuccessful()) {
                throw new IOException("服务器端错误:" + response);
            }
            result = response.body().string();
        } catch (IOException e) {
            // TODO Auto-generated catch block
            LOGGER.error("getDongHuanInfo error: ", e);
        }
        return result;
    }

}
