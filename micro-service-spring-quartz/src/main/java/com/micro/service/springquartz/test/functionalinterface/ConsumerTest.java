package com.micro.service.springquartz.test.functionalinterface;

import java.util.function.Consumer;

public class ConsumerTest {
    public static void main(String[] args) {
        String[] strArray = {"张三,30", "李四,21", "王五,18"};
        printInfo(strArray,
                s1 -> System.out.print("姓名：" + s1.split(",")[0] + ","),
                s2 -> System.out.println("年龄：" + s2.split(",")[1]));
    }

    private static void printInfo(String[] strArray, Consumer<String> con1, Consumer<String> con2) {
        for (String str :
                strArray) {
            con1.andThen(con2).accept(str);
        }
    }
}
