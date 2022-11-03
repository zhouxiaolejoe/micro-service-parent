package com.micro.service.springquartz.test.redissonlock;

import cn.hutool.core.util.StrUtil;
import com.baomidou.mybatisplus.core.toolkit.ArrayUtils;
import lombok.extern.slf4j.Slf4j;
import org.aspectj.lang.ProceedingJoinPoint;
import org.aspectj.lang.annotation.Around;
import org.aspectj.lang.annotation.Aspect;
import org.aspectj.lang.reflect.MethodSignature;
import org.redisson.api.RLock;
import org.redisson.api.RedissonClient;
import org.springframework.core.annotation.Order;
import org.springframework.stereotype.Component;

import java.util.HashMap;
import java.util.Map;

/**
 * 分布式锁注解实现
 *
 * @author HaiDi
 */
@Aspect
@Component
@Order(1)
@Slf4j
public class RedissonLockAspect {
    RedissonClient redissonClient;

    public RedissonLockAspect() {
        this.redissonClient = ApplicationContextUtil.getBean(RedissonClient.class);
    }

    @Around("@annotation(distributedLock)")
    public Object lock(ProceedingJoinPoint joinPoint, RedissonLock distributedLock) {
        String[] names = ((MethodSignature) joinPoint.getSignature()).getParameterNames();
        String key = null;
        Map params = new HashMap();
        if (ArrayUtils.isNotEmpty(names)) {
            Object[] values = joinPoint.getArgs();
            for (int i = 0; i < names.length; i++) {
                params.put(names[i], values[i]);
            }
            String province = (String) params.get("province");
            key = String.format("distributedLock_%s", province);
        }

        if (StrUtil.isNotBlank(distributedLock.keyPrefix())) {
            key = String.format("distributedLock_%s", distributedLock.keyPrefix());
        }

        RLock lock = redissonClient.getLock(key);
        boolean hasLock = false;
        try {
            hasLock = lock.tryLock(distributedLock.waitTime(), distributedLock.expire(), distributedLock.timeUnit());
            if (hasLock) {
                log.info("get distributedLock success ，key={}", key);
                return joinPoint.proceed();
            } else {
                log.info("get distributedLock error");
            }
        } catch (Throwable e) {
            log.error("aspect distributedLock error:{}", e);
        } finally {
            if (hasLock) {
                lock.unlock();
                log.info("unlock success:{}", key);
            }
        }
        return null;
    }
}