package com.micro.service.springquartz.test.functionalinterface;

import java.util.function.Supplier;

public class SupplierTest {
    public static void main(String[] args) {
        int[] i = {3,75,32,76,98,42};
        int maxValue = getMax(()->{
           int max = i[0];
            for (int j = 1; j < i.length; j++) {
                if(i[j]>max){
                    max = i[j];
                }
            }
            return max;
        });

        System.out.println(maxValue);
    }

    private static Integer getMax(Supplier<Integer> sup){
        return sup.get();
    }
}
