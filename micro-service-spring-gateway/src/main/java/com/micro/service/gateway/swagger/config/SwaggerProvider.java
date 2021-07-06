package com.micro.service.gateway.swagger.config;

import com.alibaba.fastjson.JSON;
import lombok.AllArgsConstructor;
import org.springframework.cloud.gateway.config.GatewayProperties;
import org.springframework.cloud.gateway.route.RouteDefinition;
import org.springframework.cloud.gateway.route.RouteLocator;
import org.springframework.cloud.gateway.support.NameUtils;
import org.springframework.context.annotation.Primary;
import org.springframework.data.redis.core.StringRedisTemplate;
import org.springframework.stereotype.Component;
import springfox.documentation.swagger.web.SwaggerResource;
import springfox.documentation.swagger.web.SwaggerResourcesProvider;

import java.util.*;
import java.util.stream.Collectors;

/**
 * @ClassName SwaggerProvider
 * @Description TODO
 * @Author zxl
 * @Date 2020/11/7 13:57
 * @Version 1.0.0
 */
@Component
@Primary
@AllArgsConstructor
public class SwaggerProvider implements SwaggerResourcesProvider {
    private StringRedisTemplate redisTemplate;
    public static final String API_URI = "/v2/api-docs";
    private final RouteLocator routeLocator;
//    private GatewayProperties gatewayProperties;

    @Override
    public List<SwaggerResource> get() {
        List<Object> redisroutes = redisTemplate.opsForHash().values(RedisRouteDefinitionRepository.GATEWAY_ROUTES);
        List<RouteDefinition> redisRoutes = redisroutes.stream().map(x -> JSON.parseObject(x.toString(), RouteDefinition.class)).collect(Collectors.toList());
        GatewayProperties gatewayProperties = new GatewayProperties();
        gatewayProperties.setRoutes(redisRoutes);
        List<SwaggerResource> resources = new ArrayList<>();
        List<String> routes = new ArrayList<>();
        routeLocator.getRoutes().subscribe(route -> routes.add(route.getId()));
        /**
         * 动态路由会导致swagger获取不到路由这里取的配置文件
         */
        gatewayProperties.getRoutes().stream()
                .filter(routeDefinition -> routes.contains(routeDefinition.getId()))
                .forEach(routeDefinition -> routeDefinition.getPredicates().stream()
                        .filter(predicateDefinition -> ("Path").equalsIgnoreCase(predicateDefinition.getName()))
                        .forEach(predicateDefinition -> resources.add(swaggerResource(routeDefinition.getId(),
                                predicateDefinition.getArgs().get(NameUtils.GENERATED_NAME_PREFIX + "0").replace("/**", API_URI)))));
        return resources;
    }

    private SwaggerResource swaggerResource(String name, String location) {
        SwaggerResource swaggerResource = new SwaggerResource();
        swaggerResource.setName(name);
        swaggerResource.setLocation(location);
        swaggerResource.setSwaggerVersion("2.0");
        return swaggerResource;
    }
}
