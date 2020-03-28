package com.test;

import org.junit.Test;

import javax.xml.crypto.Data;
import java.util.Date;
import java.util.UUID;

/**
 * 测试UUID
 */
public class TestUUID {

    public static void main(String[] args) {
        System.out.println(createID());
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

