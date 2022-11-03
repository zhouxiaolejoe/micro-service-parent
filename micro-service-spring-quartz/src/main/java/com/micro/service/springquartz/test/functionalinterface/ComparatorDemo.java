package com.micro.service.springquartz.test.functionalinterface;

import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;

public class ComparatorDemo {
    public static void main(String[] args) {
        ArrayList<String> list = new ArrayList<>();
        list.add("cccc");
        list.add("aa");
        list.add("b");
        list.add("ddd");

        System.out.println("排序前" + list);
        Collections.sort(list, getComparator());
        System.out.println("排序后" + list);
    }

    //如果一个方法的返回值是一个函数式接口，我们可以把一个Lambda表达式作为结果返回
    private static Comparator<String> getComparator() {
        //使用匿名内部类实现
//        return new Comparator<String>() {
//            @Override
//            public int compare(String s1, String s2) {
//                return s1.length()-s2.length();
//            }
//        };

        //Lambda表达式写法
        return (s1, s2) -> s1.length() - s2.length();
    }
}
