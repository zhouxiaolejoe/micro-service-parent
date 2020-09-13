package com.micro.service.springwebsocket.config.websocket;

import lombok.extern.slf4j.Slf4j;
import org.springframework.context.annotation.Configuration;
import org.springframework.messaging.simp.config.MessageBrokerRegistry;
import org.springframework.web.socket.config.annotation.EnableWebSocketMessageBroker;
import org.springframework.web.socket.config.annotation.StompEndpointRegistry;
import org.springframework.web.socket.config.annotation.WebSocketMessageBrokerConfigurer;

/**
 * @Description
 * @Author ZhouXiaoLe
 * @Date 2019/7/19  11:04
 * @Param
 * @return
 **/
@Configuration
@EnableWebSocketMessageBroker
@Slf4j
public class WebSocketConfig implements WebSocketMessageBrokerConfigurer {

    @Override
    public void registerStompEndpoints(StompEndpointRegistry registry) {
        registry.addEndpoint("/ws")//项目设置名称在客户端也要加上
                .setAllowedOrigins("*")//跨域支持
//                .setHandshakeHandler(new DefaultHandshakeHandler(){
//                    @Override
//                    protected Principal determineUser(ServerHttpRequest request, WebSocketHandler wsHandler, Map<String, Object> attributes) {
//                        Object o = attributes.get("name");
//                        return new FastPrincipal(o.toString());
//                    }
//                })
//                .addInterceptors()
                .withSockJS();
    }

    @Override
    public void configureMessageBroker(MessageBrokerRegistry registry) {
        //客户端发送消息的请求前缀
        registry.setApplicationDestinationPrefixes("/app");
        //客户端订阅消息的请求前缀，topic一般用于广播推送，queue用于点对点推送
        registry.enableSimpleBroker("/topic", "/queue");
        //服务端通知客户端的前缀，可以不设置，默认为user
        registry.setUserDestinationPrefix("/user");
        /*  如果是用自己的消息中间件，则按照下面的去配置，删除上面的配置
         *   registry.enableStompBrokerRelay("/topic", "/queue")
            .setRelayHost("rabbit.someotherserver")
            .setRelayPort(62623)
            .setClientLogin("marcopolo")
            .setClientPasscode("letmein01");
            registry.setApplicationDestinationPrefixes("/app", "/foo");
         * */
    }
}
//class FastPrincipal implements Principal {
//
//    private final String name;
//
//    public FastPrincipal(String name) {
//        this.name = name;
//    }
//
//    @Override
//    public String getName() {
//        return name;
//    }
//}