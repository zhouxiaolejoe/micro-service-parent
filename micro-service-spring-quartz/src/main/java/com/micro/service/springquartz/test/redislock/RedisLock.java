package com.micro.service.springquartz.test.redislock;//package gov.mof.fasp3.masterdata.test.redislock;
//
//import java.util.concurrent.TimeUnit;
//
//public interface RedisLock {
//
//	/**
//	 * 获取锁
//	 * tryMillSecondsTime 尝试时间 秒
//	 */
//	boolean tryLock(long tryMillSecondsTime);
//
//	/**
//	 * 获取锁
//	 * tryTime 尝试时间
//	 * timeUnit 时间类型
//	 */
//	boolean tryLock(long tryTime, TimeUnit timeUnit);
//
//	/**
//	 * 释放锁
//	 */
//	void unLock();
//
//	/**
//	 * 重制锁
//	 */
//	void reInit();
//}