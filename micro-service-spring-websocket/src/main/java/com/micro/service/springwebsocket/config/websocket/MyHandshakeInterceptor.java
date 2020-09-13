package com.micro.service.springwebsocket.config.websocket;

import org.springframework.http.server.ServerHttpRequest;
import org.springframework.http.server.ServerHttpResponse;
import org.springframework.http.server.ServletServerHttpRequest;
import org.springframework.web.socket.WebSocketHandler;
import org.springframework.web.socket.server.HandshakeInterceptor;

import java.util.Map;

/**
 * @Description 检查握手请求和响应Interceptor
 * @Author ZhouXiaoLe
 * @Date 2019/7/19  11:34
 * @Param
 * @return
 **/
public class MyHandshakeInterceptor implements HandshakeInterceptor {

    @Override
    public boolean beforeHandshake(ServerHttpRequest serverHttpRequest, ServerHttpResponse serverHttpResponse, WebSocketHandler webSocketHandler, Map<String, Object> map) throws Exception {
        String name = ((ServletServerHttpRequest) serverHttpRequest).getServletRequest().getParameter("name");
        System.out.println("======================Interceptor" + name);
        //保存客户端标识
        map.put("name", "8888");
        return true;
    }

    @Override
    public void afterHandshake(ServerHttpRequest serverHttpRequest, ServerHttpResponse serverHttpResponse, WebSocketHandler webSocketHandler, Exception e) {

    }
}
