package com.nucw;

import org.junit.Test;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Random;

/**
 * 测试使用UUID生成订单号
 */
public class TestUUID {

    @Test
    public void createOrderId(){
        SimpleDateFormat sdf=new SimpleDateFormat("yyyyMMddHHmmss");
        String newDate=sdf.format(new Date());
        String result="";
        Random random=new Random();
        for(int i=0;i<3;i++){
            result += random.nextInt(10);
        }
        //return newDate+result;
        System.out.println(newDate+result);

    }

}
