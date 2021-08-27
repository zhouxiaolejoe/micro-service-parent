package com.micro.service.oauthserver.controller;

import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

/**
 * HelloController
 *
 * @author zxl
 * @date 2021/08/27
 */
@RestController
@RequestMapping(value = "hello")
public class HelloController {


    public static void main(String[] args){

        System.out.println(new BCryptPasswordEncoder().encode("user-secret-8888"));
        System.out.println(new BCryptPasswordEncoder().encode("client-secret-8888"));
        System.out.println(new BCryptPasswordEncoder().encode("code-secret-8888"));
    }

}
