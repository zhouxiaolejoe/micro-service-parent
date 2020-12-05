package com.micro.service.tool.until;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.TypeReference;
import com.alibaba.fastjson.serializer.SerializerFeature;

import java.util.List;
import java.util.Map;

/**
 * @Description 基于fastjson封装的json转换工具类
 * @Author ZhouXiaoLe
 * @Date 2018/12/1  11:35
 * @Param
 * @return
 **/
public class FastJsonUtils {

    /**
     * @return java.lang.String JSON数据
     * @Description 功能描述：把java对象转换成JSON数据
     * @Author ZhouXiaoLe
     * @Date 2019/4/2  10:01
     * @Param [object]java对象 SerializerFeature.WriteMapNullValue允许返回null
     **/
    public static String getBeanToJson(Object object) {
        return JSON.toJSONString(object, SerializerFeature.WriteMapNullValue);
    }

    /**
     * 功能描述：把Map转换成java对象
     *
     * @param map
     * @param clazz 指定的java对象
     * @return 指定的java对象
     */
    public static <T> T getMapToBean(Object map, Class<T> clazz) {
        return JSON.parseObject(JSON.toJSONString(map, SerializerFeature.WriteMapNullValue), clazz);
    }

    /**
     * 功能描述：把java对象转换成Map
     *
     * @param bean 指定的java对象
     * @return 指定的java对象
     */
    public static <K, V> Map<K, V> getBeanToMap(Object bean) {
        return JSON.parseObject(JSON.toJSONString(bean, SerializerFeature.WriteMapNullValue), new TypeReference<Map<K, V>>() {
        });
    }

    /**
     * 功能描述：把JSON数据转换成指定的java对象
     *
     * @param jsonData JSON数据
     * @param clazz    指定的java对象
     * @return 指定的java对象
     */
    public static <T> T getJsonToBean(String jsonData, Class<T> clazz) {
        return JSON.parseObject(jsonData, clazz);
    }

    /**
     * @return java.util.List<T>
     * @Description 把JSON数据转换成指定的java对象
     * @Author ZhouXiaoLe
     * @Date 2019/5/10  12:04
     * @Param [jsonData, clazz]JSON数据,指定的java对象
     **/
    public static <T> List<T> getJsonToListBean(String jsonData, Class<T> clazz) {
        return JSON.parseArray(jsonData, clazz);
    }

    /**
     * 功能描述：把JSON数据转换成指定的List<T>
     *
     * @param jsonData JSON数据
     * @return List<T>
     */
    public static <T> List<T> getJsonToList(String jsonData) {
        return JSON.parseObject(jsonData, new TypeReference<List<T>>() {
        });
    }

    /**
     * 功能描述：把JSON数据转换成较为Map<String, Object>
     *
     * @param jsonData JSON数据
     * @return <Map<String, Object>
     */
    public static <K, V> Map<K, V> getJsonToMap(String jsonData) {
        return JSON.parseObject(jsonData, new TypeReference<Map<K, V>>() {
        });
    }

    /**
     * 功能描述：把JSON数据转换成较为复杂的List<Map<String, Object>>
     *
     * @param jsonData JSON数据
     * @return List<Map < String, Object>>
     */
    public static <K, V> List<Map<K, V>> getJsonToListMap(String jsonData) {
        return JSON.parseObject(jsonData, new TypeReference<List<Map<K, V>>>() {
        });
    }
}