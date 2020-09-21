package com.micro.service.springquartz.utils;

import org.springframework.util.CollectionUtils;

import java.util.Map;

/**
 * Created by wengy on 2019/11/28.
 */
public class MapUtils {

    public static Map<String, Object> toLowerMapKey(Map<String, Object> map) {
        if(CollectionUtils.isEmpty(map)){
            return map;
        }

        String[] keys = map.keySet().toArray(new String[] {});
        for (String key : keys) {
            map.put(key.toLowerCase(), map.remove(key));
        }
        return map;
    }
}
