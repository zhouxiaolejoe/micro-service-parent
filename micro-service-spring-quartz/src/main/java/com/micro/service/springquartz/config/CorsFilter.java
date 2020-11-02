package com.micro.service.springquartz.config;

import org.springframework.context.annotation.Configuration;

import javax.servlet.*;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;


/**
* @Description 解决web跨域问题
* @Author zxl
* @Date  2020-10-28  16:15:13
**/
@Configuration
public class CorsFilter implements Filter {

    @Override
    public void init(FilterConfig filterConfig) throws ServletException {

    }

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {
        HttpServletResponse resp = (HttpServletResponse) response;
        //指定允许的域
        //一般用法（*，指定域，动态设置）,*不允许携带认证头和cookies
        resp.setHeader("Access-Control-Allow-Origin", "*");
        //是否允许后续请求携带认证信息（cookies）,该值只能是true,否则不返回
        resp.setHeader("Access-Control-Allow-Credentials", "true");
        //预检结果缓存时间,也就是上面说到的缓存啦
        resp.setHeader("Access-Control-Max-Age", "1800");
        //允许的请求类型
        resp.setHeader("Access-Control-Allow-Methods", "POST, GET, OPTIONS, DELETE, PUT");
        //允许的请求头字段
        resp.setHeader("Access-Control-Allow-Headers", "*");
        chain.doFilter(request, response);
    }

    @Override
    public void destroy() {

    }

}
