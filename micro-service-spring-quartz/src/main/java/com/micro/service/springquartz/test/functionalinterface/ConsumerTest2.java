package com.micro.service.springquartz.test.functionalinterface;

import java.util.ArrayList;
import java.util.function.Predicate;

public class ConsumerTest2 {
    public static void main(String[] args) {
        String[] strArray = {
                "张三,30", "李四,21", "王五,18"
        };
        ArrayList<String> arrayList = myFilter(strArray,
                s -> s.split(",")[0].length() > 1,
                s -> Integer.parseInt(s.split(",")[1]) > 20
        );
        for (String array : arrayList) {
            System.out.println(array);
        }
    }    
    //通过Predicate接口的拼装将符合要求的字符串筛选到集合Arraylist中    
    private static ArrayList<String> myFilter(String[] strArray, Predicate<String> pre1, Predicate<String> pre2) {        
    	//定义一个集合
        ArrayList<String> array = new ArrayList<>();        
        //遍历数组        
        for (String str : strArray) {
            if (pre1.and(pre2).test(str)) {
                array.add(str);
            }
        }
        return array;
    }
}
