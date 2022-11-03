package com.micro.service.springquartz.test;

import cn.hutool.http.HttpRequest;
import cn.hutool.json.JSONUtil;
import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.google.common.collect.Maps;
import org.apache.http.client.methods.CloseableHttpResponse;
import org.apache.http.entity.ContentType;
import org.apache.http.entity.StringEntity;
import org.apache.http.impl.client.CloseableHttpClient;
import org.apache.http.impl.client.HttpClientBuilder;
import org.apache.http.util.EntityUtils;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.web.client.RestTemplate;

import java.util.HashMap;
import java.util.Map;

/**
 * @Description
 * @Project micro-service-parent
 * @Package com.micro.service.springquartz.test
 * @Author zxl
 * @Date 2022-10-18 11:36
 */
public class TestHttp {

    public static void main(String[] args) {
        String url = "https://38h483n043.goho.co/oauth/token";
        Map<String, Object> param = Maps.newHashMap();
        param.put("client_secret", "{noop}fVG7PgdxQYT2IdtUdy");
        param.put("grant_type", "client_credentials");
        param.put("client_id", "4HBcktDQ");
//        String result2 = HttpRequest.get(url)
//                .header("Authorization", "Basic NEhCY2t0RFE6ZlZHN1BnZHhRWVQySWR0VWR5")
//                .header("Content-Type", "application/x-www-form-urlencoded")
//                .form(param)//表单内容
//                .timeout(20000)//超时，毫秒
//                .execute().body();
//        System.err.println(result2);
        sendGet(param, url);
    }

    public static void sendGet(Map<String, Object> param, String url) {
        RestTemplate restTemplate = new RestTemplate();
        String res = restTemplate.getForObject(url, String.class, param);
    }
}
