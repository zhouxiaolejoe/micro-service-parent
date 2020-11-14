package com.micro.service.springquartz.utils;

import org.json.JSONArray;
import org.json.JSONObject;

import java.util.Iterator;

public class JsonLogUtils {

    private static final char TOP_LEFT_CORNER = '╔';
    private static final char BOTTOM_LEFT_CORNER = '╝';
    private static final String DOUBLE_DIVIDER = "═══════════════════════════════════════════════════════════════════════════════════════";

    public static void println(String content) {
        outp(" ", 0);
        if (content == null || content.isEmpty()) {
            return;
        }
        try {
            outp(TOP_LEFT_CORNER + DOUBLE_DIVIDER, 0);
            if (content.startsWith("{")) {
                setJSONObjectLog(new JSONObject(content), 1);
            } else if (content.startsWith("[")) {
                setJSONArrayLog(new JSONArray(content), 1);
            } else {
                outp(content, 1);
            }
            outp(DOUBLE_DIVIDER + BOTTOM_LEFT_CORNER, 0);
        } catch (Exception e) {
        }
        outp(" ", 0);
    }

    /**
     * 对JSONObject的解析
     */
    private static void setJSONObjectLog(JSONObject jsonObject, int count) throws Exception {
        if (jsonObject == null || jsonObject.length() == 0) {
            outp("{}", count);
            return;
        }
        outp("{", count);
        count = count + 1;
        Iterator<String> msgIterator = jsonObject.keys();
        while (msgIterator.hasNext()) {
            String key = msgIterator.next();
            Object value = jsonObject.get(key);
            if (value.toString().startsWith("{")) {
                JSONObject object = new JSONObject(value.toString());
                if (object == null || object.length() == 0) {
                    outp(key + ":  {}", count);
                } else {
                    outp(key + ":  ", count);
                    setJSONObjectLog(new JSONObject(value.toString()), count + 1);
                }
            } else if (value.toString().startsWith("[")) {
                JSONArray array = new JSONArray(value.toString());
                if (array == null || array.length() == 0) {
                    outp(key + ":  []", count);
                } else {
                    outp(key + ":  ", count);
                    setJSONArrayLog(new JSONArray(value.toString()), count + 1);
                }
            } else {
                if (value instanceof String) {
                    outp(key + ":  " + "\"" + value + "\"" + " ,", count);
                } else {
                    outp(key + ":  " + value + " ,", count);
                }
            }
        }
        outp("}", count - 1);
    }

    /**
     * 对JSONArray的解析
     */
    private static void setJSONArrayLog(JSONArray jsonArray, int count) throws Exception {
        if (jsonArray == null || jsonArray.length() == 0) {
            outp("[]", count);
            return;
        }
        outp("[", count);
        count = count + 1;
        for (int i = 0; i < jsonArray.length(); i++) {
            Object object = jsonArray.get(i);
            String string = object.toString();
            if (string.startsWith("[")) {
                JSONArray jsonArray1 = new JSONArray(string);
                setJSONArrayLog(jsonArray1, count);
            } else if (string.startsWith("{")) {
                JSONObject jsonobject = new JSONObject(string);
                setJSONObjectLog(jsonobject, count);
            } else {
                outp(string + " ,", count);
            }
        }
        outp("]", count - 1);
    }

    /**
     * 打印输出
     */
    private static void outp(String s, int count) {
        StringBuilder builder = new StringBuilder();
        for (int i = 0; i < count; i++) {
            builder.append("    ");
        }
        System.out.println(builder.toString() + s);
    }
}