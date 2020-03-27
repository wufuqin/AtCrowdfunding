package com.atguigu.atcrowdfunding.util;

import org.apache.commons.mail.SimpleEmail;

/**
 * 发送邮件工具类
 */
public class SendEmail {

    public static void main(String[] args) {
        try {
            SendEmail.sendEmial("18377548732@163.com","修改密码链接","<a href='https://www.baidu.com'>重置密码</a>");
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public static void sendEmial(String addTo, String subject, String msg) throws Exception {
        SimpleEmail email = new SimpleEmail();
        //设置主机名，远程服务器的主机名
        email.setHostName("smtp.qq.com");
        email.setSSLOnConnect(true);
        //设置端口号
        email.setSslSmtpPort("465");
        //设置编码格式
        email.setCharset("UTF-8");
        //设置登录服务器的账号和授权码
        email.setAuthentication("1820191171@qq.com","htoclnshpfvhcfdc");
        //发送到那个邮箱
        email.addTo(addTo);
        //设置发送人邮箱
        email.setFrom("1820191171@qq.com");
        //设置邮箱的主题
        email.setSubject(subject);
        //设置邮箱内容
        email.setMsg(msg);
        //发送邮件
        email.send();
    }

}
