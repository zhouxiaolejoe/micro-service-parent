package com.micro.service.springquartz.test.functionalinterface;

import java.util.function.Function;

public class FunctionTest2 {

    public static void main(String[] args) {
        FunctionTest2 functionTest2 = new FunctionTest2();
        String s = functionTest2.doFunction(FunctionTest2::hasNoParam, functionTest2);
        System.out.println(s);
    }

    public <T, R> R doFunction(Function<T, R> function, T param) {
        return function.apply(param);
    }

    public String hasNoParam() {
        return "A";
    }
}
