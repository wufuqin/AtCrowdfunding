package com.atguigu.atcrowdfunding.util;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Random;

/**
 * 生成订单号工具类
 */
public class CreateOrderIdUtil {

    public static void main(String[] args) {
        System.out.println(createOrderId());
    }

    public static String createOrderId(){
        SimpleDateFormat sdf=new SimpleDateFormat("yyyyMMddHHmmss");
        String newDate=sdf.format(new Date());
        String result="";
        Random random=new Random();
        for(int i=0;i<3;i++){
            result += random.nextInt(10);
        }
        return newDate+result;
    }

}
