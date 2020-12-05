package com.micro.service.tool.until;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

/**
 * @author zhouxiaole
 */
public class JsonLogUtils {

    private static final Logger logger = LoggerFactory.getLogger(JsonLogUtils.class);

    private static String responseFormat(String resString) {

        StringBuffer jsonForMatStr = new StringBuffer();
        int level = 0;
        for (int index = 0; index < resString.length(); index++) {
            char c = resString.charAt(index);

            if (level > 0 && '\n' == jsonForMatStr.charAt(jsonForMatStr.length() - 1)) {
                jsonForMatStr.append(getLevelStr(level));
            }
            switch (c) {
                case '{':
                case '[':
                    jsonForMatStr.append(c + "\n");
                    level++;
                    break;
                case ',':
                    jsonForMatStr.append(c + "\n");
                    break;
                case '}':
                case ']':
                    jsonForMatStr.append("\n");
                    level--;
                    jsonForMatStr.append(getLevelStr(level));
                    jsonForMatStr.append(c);
                    break;
                default:
                    jsonForMatStr.append(c);
                    break;
            }
        }
        return jsonForMatStr.toString();
    }

    private static String getLevelStr(int level) {
        StringBuffer levelStr = new StringBuffer();
        for (int levelI = 0; levelI < level; levelI++) {
            levelStr.append("\t");
        }
        return levelStr.toString();
    }

    public static void print(String resString) {
        logger.info(responseFormat("\n"+resString));
    }
}