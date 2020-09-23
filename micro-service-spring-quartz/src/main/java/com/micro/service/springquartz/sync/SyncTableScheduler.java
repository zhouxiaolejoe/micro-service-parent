package com.micro.service.springquartz.sync;

/**
 * @ClassName SyncTableScheduler
 * @Description TODO
 * @Author zxl
 * @Date 2020/9/23 10:03
 * @Version 1.0.0
 */
public interface SyncTableScheduler {
    /**
     * @return void
     * @Description
     * @Method syncTable
     * @Param origin 源库
     * @Param originTable 源库表
     * @Param targetTable 目标表
     * @Param target 目标库
     * @Author zxl
     * @Date 2020-09-23  10:05:20
     **/
    void syncTable(String origin, String tablename, String target);
}
