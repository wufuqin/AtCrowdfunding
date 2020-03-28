package com.atguigu.atcrowdfunding.util;

public class CreateFileName {
    public static void main(String[] args) {
        String str = createID();
        System.out.println(str);
    }

    public static String createID () {

        byte[] lock = new byte[0];
        // 位数，默认是8位
        long w = 100000000;
        long r = 0;
        synchronized (lock) {
            r = (long) ((Math.random() + 1) * w);
        }

        return System.currentTimeMillis() + String.valueOf(r).substring(1);
    }
}
