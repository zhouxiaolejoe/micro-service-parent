package com.micro.service.springquartz.config;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.util.List;
import java.util.Map;

/**
 * @ClassName TableContextHolder
 * @Description TODO
 * @Author zxl
 * @Date 2020/9/18 8:49
 * @Version 1.0.0
 */
public class TableContextHolder {

    private final static Logger log = LoggerFactory.getLogger(TableContextHolder.class);

    private static final ThreadLocal<Map<String,List<String>>> contextHolder = new ThreadLocal<>();


    public static void setTableData(Map<String, List<String>> map) {
        contextHolder.set(map);
    }


    public static Map<String,List<String>> getTableData() {
        return contextHolder.get();
    }


    public static void clearTableData() {
        contextHolder.remove();
    }
}
