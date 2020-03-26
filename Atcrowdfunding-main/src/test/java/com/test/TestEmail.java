/*
package com.test;

import org.apache.commons.mail.EmailException;
import org.apache.commons.mail.SimpleEmail;
import org.junit.Test;

*/
/**
 * 测试发送邮件
 *//*

public class TestEmail {

    */
/**
     * 测试commons-email发送和收取邮件
     *      网易发送到QQ
     *//*

    @Test
    public void test01() throws Exception {
        SimpleEmail email = new SimpleEmail();
        //设置主机名，远程服务器的主机名
        email.setHostName("smtp.qq.com");
        //设置端口号
        email.setSmtpPort(25);
        //设置编码格式
        email.setCharset("UTF-8");
        //设置登录服务器的账号和授权码
        email.setAuthentication("1820191171@qq.com","htoclnshpfvhcfdc");
        //发送到那个邮箱
        email.addTo("18377548732@163.com");
        //设置发送人邮箱
        email.setFrom("1820191171@qq.com");
        //设置邮箱的主题
        email.setSubject("试试看");
        //设置邮箱内容
        email.setMsg("试试看");
        //发送邮件
        email.send();
    }

    */
/**
     * 测试commons-email发送和收取邮件
     *      使用本地james服务器发送到网易邮箱和QQ
     *      目前失败：没有对james进行配置
     *//*

    @Test
    public void test02() throws Exception {
        SimpleEmail email = new SimpleEmail();
        //设置主机名，远程服务器的主机名
        email.setHostName("127.0.0.1");
        //设置端口号
        email.setSmtpPort(25);
        //设置登录服务器的账号和授权码
        email.setAuthentication("admin@wufuqin.com","admin");
        //发送到那个邮箱
        email.addTo("18377548732@163.com");
        //设置发送人邮箱
        email.setFrom("admin@wufuqin.com");
        //设置邮箱的主题
        email.setSubject("测试网易邮箱");
        //设置邮箱内容
        email.setMsg("1820191171@qq.com");
        //发送邮件
        email.send();
    }

}



























*/
