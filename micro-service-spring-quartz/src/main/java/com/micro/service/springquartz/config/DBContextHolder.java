package com.micro.service.springquartz.config;

import com.micro.service.springquartz.model.ThreadLocalDSInfo;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;


/**
* @Description
* @Author zxl
* @Date  2020-10-28  16:15:42
**/
public class DBContextHolder {
    private final static Logger log = LoggerFactory.getLogger(DBContextHolder.class);
    /**
     * 对当前线程的操作-线程安全的
     */
    private static final ThreadLocal<ThreadLocalDSInfo> contextHolder = new ThreadLocal<>();

    /**
     * 调用此方法，切换数据源
     */
    public static void setDataSource(ThreadLocalDSInfo dsInfo) {
        contextHolder.set(dsInfo);
        log.debug("已切换到数据源:{}", dsInfo.getDatasourceid());
    }

    /**
     * 获取数据源
     */
    public static ThreadLocalDSInfo getDataSource() {
        return contextHolder.get();
    }

    /**
     * 删除数据源
     */
    public static void clearDataSource() {
        contextHolder.remove();
//        log.debug("已切换到主数据源");
    }

}