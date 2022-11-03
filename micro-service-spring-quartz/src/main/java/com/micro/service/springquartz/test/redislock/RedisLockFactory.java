package com.micro.service.springquartz.test.redislock;//package gov.mof.fasp3.masterdata.test.redislock;
//
//import java.util.concurrent.TimeUnit;
//
//public interface RedisLockFactory {
//	/**
//	 * 获取锁
//	 * @param key redis锁key
//	 * @return
//	 */
//	RedisLock getLock(String key);
//
//	/**
//	 * 获取锁
//	 * @param key redis锁key
//	 * @param tryTime 尝试时间
//	 * @param timeUnit 时间类型
//	 * @return
//	 */
//	RedisLock getLock(String key, int tryTime, TimeUnit timeUnit);
//}