package com.atguigu.atcrowdfunding.util;

public class TestCheckCode {
    public static void main(String[] args) {
        //生成随机验证码
        String str = "";
        for (int i = 0; i < 6; i++){
            str += (int)Math.floor(Math.random()*10);
        }
        System.out.println(str);
    }
}
