package com.micro.service.springquartz.utils;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.util.CollectionUtils;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.*;

/**
 * Created by wengy on 2019/12/2.
 */
public class SyncDataUtils {
    private static final Logger logger = LoggerFactory.getLogger(SyncDataUtils.class);

    public static final String DEFAULT_DBVERSION = "20000101000000";

    /**
     * 按DBVersion排序
     *
     * @param datas
     */
    public static void sortSyncDataByDBVersion(List<Map<String, Object>> datas) {
        if (CollectionUtils.isEmpty(datas)) {
            return;
        }
        String dbVersionKey = "dbversion";
        for (String key : datas.get(0).keySet()) {
            if (dbVersionKey.equalsIgnoreCase(key)) {
                dbVersionKey = key;
                break;
            }
        }

        final String sortKey = dbVersionKey;
        Collections.sort(datas, new Comparator<Map<String, Object>>() {
            @Override
            public int compare(Map<String, Object> data1, Map<String, Object> data2) {
                String dbversion = (String)data1.get(sortKey);
                if (dbversion == null) {
                    return -1;
                }
                return dbversion.compareTo((String)data2.get(sortKey));
            }
        });
    }

    public static Date parentVersion(String version) {
        SimpleDateFormat format = new SimpleDateFormat("yyyyMMddhhmmss");
        try {
            Date date = format.parse(version);
            return date;
        } catch (ParseException e) {
            logger.warn("验证版本格式出错version:" + version, e);
        }
        return null;
    }
}
