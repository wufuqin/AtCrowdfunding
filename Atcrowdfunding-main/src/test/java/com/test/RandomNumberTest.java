
package com.test;

import com.atguigu.atcrowdfunding.util.RandomNumber;

import java.util.ArrayList;
import java.util.Collections;
import java.util.List;
import java.util.Random;


/**
 * 生成指定范围之内的随机数
 */

public class RandomNumberTest {

    public static void main(String[] args) {
        System.out.println(RandomNumberTest.rand());

    }

    public static List rand(){
        List<Integer> numberList = new ArrayList<Integer>();

        for (int i = 1; i<=38; i++){
            numberList.add(i);
        }
        System.out.println(numberList);
        Collections.shuffle(numberList);

        return numberList;

    }

}

