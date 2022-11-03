package com.micro.service.springquartz.test.functionalinterface;

import java.util.function.Predicate;

public class ConsumerTest1 {
    public static void main(String[] args) {
        boolean string = chenkString("张三", s -> s.equals("张三"));
        System.out.println(string);

        boolean hello = chenkString("hello", s -> s.length() > 8, s -> s.length() < 18);
        System.out.println(hello);
    }

    //判定给定的字符串是否满足要求
//    private static boolean chenkString(String s, Predicate<String> pre){
//        return pre.test(s);
//    }

    private static boolean chenkString(String s, Predicate<String> pre){
        return pre.negate().test(s);
    }

//    private static boolean chenkString(String s, Predicate<String> pre, Predicate<String> pre1){
//        return pre.and(pre1).test(s);
//    }

    private static boolean chenkString(String s, Predicate<String> pre, Predicate<String> pre1){
        return pre.or(pre1).test(s);
    }
}
