package com.micro.service.springquartz.test.functionalinterface;

public class RunnableDemo {
    public static void main(String[] args) {
        startThread(()-> System.out.println(Thread.currentThread().getName()+"线程启动了"));
    }

    private static void startThread(Runnable r){
        new Thread(r).start();
    }
}
