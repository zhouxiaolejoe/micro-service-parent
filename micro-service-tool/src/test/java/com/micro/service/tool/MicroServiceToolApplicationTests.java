package com.micro.service.tool;

import lombok.extern.slf4j.Slf4j;
import org.apache.commons.beanutils.BeanUtils;
import org.junit.Test;
import org.springframework.boot.autoconfigure.security.SecurityProperties;
import org.springframework.boot.test.context.SpringBootTest;
import com.micro.service.tool.model.User;
import java.util.Map;

@SpringBootTest
@Slf4j
public class MicroServiceToolApplicationTests {

    @Test
    public void contextLoads() {
    }


    @Test
    public void beanUtils() throws Exception {
        User user = User.builder().name("joe").password("123456").build();
        Map<String, String> describe = BeanUtils.describe(user);
        log.warn(describe.toString());
        User populate = User.builder().build();
        BeanUtils.populate(populate, describe);
        System.err.println();
        log.warn(populate.toString());
    }




}

