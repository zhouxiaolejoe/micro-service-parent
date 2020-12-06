package com.micro.service.springredis.controller;

import com.micro.service.tool.until.VerifyCodeUtils;
import com.wf.captcha.ArithmeticCaptcha;
import com.wf.captcha.ChineseGifCaptcha;
import com.wf.captcha.GifCaptcha;
import com.wf.captcha.utils.CaptchaUtil;
import io.protostuff.Response;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
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


    @GetMapping("/captcha")
    @ApiOperation(value = "captcha验证码",  httpMethod = "GET")
    public void captcha(HttpServletRequest request, HttpServletResponse response) throws Exception {
//        // 设置位数
//        CaptchaUtil.out(5, request, response);
//        // 设置宽、高、位数
//        CaptchaUtil.out(130, 48, 5, request, response);
//
//        // 使用gif验证码
//        GifCaptcha gifCaptcha = new GifCaptcha(130,48,4);
//        CaptchaUtil.out(gifCaptcha, request, response);

//        ChineseGifCaptcha chineseGifCaptcha = new ChineseGifCaptcha(130, 48, 4);
//        CaptchaUtil.out(chineseGifCaptcha, request, response);

        ArithmeticCaptcha arithmeticCaptcha = new ArithmeticCaptcha(130, 48, 2);
        CaptchaUtil.out(arithmeticCaptcha, request, response);
    }

    @GetMapping("/toBase64Captcha")
    @ApiOperation(value = "toBase64Captcha",  httpMethod = "GET")
    @ResponseBody
    public Object toBase64Captcha() throws Exception {
        ArithmeticCaptcha arithmeticCaptcha = new ArithmeticCaptcha(130, 48, 2);
        String text = arithmeticCaptcha.text();
        return arithmeticCaptcha.toBase64();
    }
}
