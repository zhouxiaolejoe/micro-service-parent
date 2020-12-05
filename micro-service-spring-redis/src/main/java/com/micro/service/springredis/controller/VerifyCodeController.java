package com.micro.service.springredis.controller;

import com.micro.service.tool.until.VerifyCodeUtils;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

/**
 * @ClassName VerifyCodeController
 * @Description TODO
 * @Author zhouxiaole
 * @Date 2020/12/5 19:03
 * @Version 1.0.0
 */
@Controller
@Api(tags = "验证码")
public class VerifyCodeController {
    @GetMapping("/getVerifyCode")
    @ApiOperation(value = "验证码",  httpMethod = "GET")
    public void getVerifyCode(HttpSession session, HttpServletResponse response) throws IOException {
        //生成验证码
        String verifyCode = VerifyCodeUtils.generateVerifyCode(4);
        //验证码放入session
        session.setAttribute("verifyCode", verifyCode);
        //验证码存入图片
        response.setContentType("image/png");
        ServletOutputStream outputStream = response.getOutputStream();
        VerifyCodeUtils.outputImage(105, 35, outputStream, verifyCode);
    }
}
