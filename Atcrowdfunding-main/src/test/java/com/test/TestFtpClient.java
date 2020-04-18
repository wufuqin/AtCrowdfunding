/*
package com.test;

import com.atguigu.atcrowdfunding.util.FtpUtil;
import org.apache.commons.net.ftp.FTPClient;
import org.junit.Test;

import java.io.File;
import java.io.FileInputStream;

*/
/**
 * 测试使用svftp上传文件到 47.95.223.197 云服务器
 *//*

public class TestFtpClient {

    @Test
    public void testFtpClient() throws Exception {
        //创建一个FtpClient对象
        FTPClient ftpClient = new FTPClient();
        //创建ftp连接。默认21端口
        ftpClient.connect("47.95.223.197",21);
        //设置用户名密码
        ftpClient.login("userftp","userftp");
        //上传图片
        //读取本地文件
        FileInputStream inputStream = new FileInputStream(new File("C:\\Users\\wfq\\Desktop\\p1.jpg"));
        //设置上传的路径
        ftpClient.changeWorkingDirectory("/home/userftp/test");
        //设置图片上传的格式
        ftpClient.setFileType(FTPClient.BINARY_FILE_TYPE);
        //第一个参数：上传服务器之后的文件名  第二个参数：上传文件的inputStream流
        ftpClient.storeFile("test.jpg",inputStream);
        //关闭连接
        ftpClient.logout();

    }

    */
/**
     * 测试工具类
     *//*

    @Test
    public void testFtpUtil() throws Exception {
        //读取本地文件
        FileInputStream inputStream = new FileInputStream(new File("C:\\Users\\wfq\\Desktop\\p1.jpg"));
        //上传文件到云服务器
        FtpUtil.uploadFile("47.95.223.197",21,"userftp","userftp","/home/userftp/test","pic","test02.jpg",inputStream);

    }

}








































*/
