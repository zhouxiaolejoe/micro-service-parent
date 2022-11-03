package com.micro.service.springquartz.test.chain;

/**
 * 处理器接口定义
 */
public interface Processor {
    boolean process(Product request, ProcessorChain chain);
}