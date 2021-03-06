package com.atguigu.atcrowdfunding.manager.controller;

import com.atguigu.atcrowdfunding.bean.Advertisement;
import com.atguigu.atcrowdfunding.bean.User;
import com.atguigu.atcrowdfunding.manager.service.AdvertisementService;
import com.atguigu.atcrowdfunding.util.*;
import org.apache.commons.fileupload.disk.DiskFileItem;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.multipart.commons.CommonsMultipartFile;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.io.File;
import java.io.FileInputStream;
import java.io.InputStream;
import java.util.HashMap;
import java.util.Map;
import java.util.UUID;

/**
 * 广告管理web控制器
 */
@Controller
@RequestMapping("/advertisement")
public class AdvertisementController {

    @Autowired
    private AdvertisementService advertisementService;

    //去到广告管理首页面
    @RequestMapping("/index")
    public String index(){
        return "advertisement/index";
    }

    //查询广告数据
    @ResponseBody
    @RequestMapping("doIndex")
    public Object doIndex(@RequestParam(value = "pageno", required = false, defaultValue = "1") Integer pageno, @RequestParam(value = "pagesize", required = false, defaultValue = "8") Integer pagesize){
        //创建一个用于存储查询得到的数据集对象
        AjaxResult result = new AjaxResult();
        try {
            //调用service层查询方法，返回一个分页数据对象
            Page page = advertisementService.queryPageAdvertisement(pageno, pagesize);
            //设置查询状态
            result.setSuccess(true);
            //存储查询到的数据
            result.setPage(page);
        } catch (Exception e) {
            result.setSuccess(false);
            result.setMessage("查询数据失败...");
            e.printStackTrace();
        }
        return result;
    }

    //模糊查询
    @ResponseBody
    @RequestMapping("doLike")
    public Object doLike(@RequestParam(value = "pageno", required = false, defaultValue = "1") Integer pageno, @RequestParam(value = "pagesize", required = false, defaultValue = "8") Integer pagesize, String queryText){

        //创建一个用于存储查询得到的数据集对象
        AjaxResult result = new AjaxResult();
        try {
            //创建一个map集合
            HashMap<String, Object> paramMap = new HashMap<String, Object>();
            //将查询条件存入map集合
            paramMap.put("pageno",pageno);
            paramMap.put("pagesize",pagesize);
            paramMap.put("queryText",queryText);

            //调用service层查询方法，返回一个分页数据对象
            Page page = advertisementService.queryPageAdvertisement(paramMap);
            //设置查询状态
            result.setSuccess(true);
            //存储查询到的数据
            result.setPage(page);
        } catch (Exception e) {
            result.setSuccess(false);
            result.setMessage("查询数据失败...");
            e.printStackTrace();
        }
        return result;
    }

    //去到添加页面
    @RequestMapping("/add")
    public String add(){
        return "advertisement/add";
    }

    //删除广告数据
    @ResponseBody
    @RequestMapping("/doDelete")
    public Object doDelete(Integer id){
        //用来封装ajax请求结果
        AjaxResult result = new AjaxResult();
        try {
            //调用业务层方法,返回一个影响数据库行数的int数值
            int count = advertisementService.deleteAdvertisement(id);
            result.setSuccess(true);
        } catch (Exception e) {
            result.setSuccess(false);
            result.setMessage("删除用户数据失败");
            e.printStackTrace();
        }
        return result;
    }

    //批量删除
    @ResponseBody
    @RequestMapping("/doDeleteBatch")
    public Object doDeleteBatch(Integer[] id){
        AjaxResult result = new AjaxResult();
        try {
            int count = advertisementService.deleteBatchAdvertisement(id);
            result.setSuccess(count == id.length);
        } catch (Exception e) {
            result.setSuccess(false);
            result.setMessage("删除数据失败");
            e.printStackTrace();
        }
        return result;
    }

    //上传图片
    @ResponseBody
    @RequestMapping("/doAdd")
    public Object doAdd(HttpServletRequest request, Advertisement advertisement, HttpSession session) {
        AjaxResult result = new AjaxResult();
        try {
            MultipartHttpServletRequest mreq = (MultipartHttpServletRequest)request;

            MultipartFile mfile = mreq.getFile("advertPicture");  //创建一个文件对象
            CommonsMultipartFile cFile = (CommonsMultipartFile)mfile;
            DiskFileItem fileItem = (DiskFileItem) cFile.getFileItem();
            InputStream inputStream = fileItem.getInputStream();

            String name = mfile.getOriginalFilename();// 获取上传的原始文件名  java.jpg
            String extname = name.substring(name.lastIndexOf(".")); //  截取文件名后缀 ： .jpg
            String iconpath = UUID.randomUUID().toString() + extname; //生成随机文件名 ： 232243343.jpg

            //将图片保存至本地tomcat服务器
            //ServletContext servletContext = session.getServletContext();
            //String realpath = servletContext.getRealPath("/picture");  //得到存储文件的路径
            //String path =realpath+ "/advertisement/"+iconpath;  //生成文件路径
            //mfile.transferTo(new File(path));      //将文件添加到对应路径下


            //将图片保存至云服务器（解决分布式系统部署环境下的文件共享问题）
            boolean status = FtpUtil.uploadFile("47.95.223.197", 21, "userftp", "userftp", "/home/userftp/test", "pic", iconpath, inputStream);
            if ("false".equals(status)){
                result.setSuccess(false);
                return result;
            }

            User user = (User)session.getAttribute(Const.LOGIN_USER); //获取当前用户
            advertisement.setUserid(user.getId());  //获取当前用户id
            advertisement.setStatus("1");           //将当前的状态设置为未审核
            advertisement.setIconpath(iconpath);    //设置广告图片的名字

            //保存广告
            int count = advertisementService.insertAdvertisement(advertisement);
            result.setSuccess(count==1);
        } catch ( Exception e ) {
            e.printStackTrace();
            result.setSuccess(false);
        }
        return result;
    }

    //去到修改页面
    @RequestMapping("/update")
    public String update(Integer id, Map map){
        Advertisement advertisement = advertisementService.getAdvertisementById(id);
        map.put("advertisement",advertisement);
        return "advertisement/update";
    }

    //修改广告数据(目前不支持修改广告图片)
    @ResponseBody
    @RequestMapping("/doUpdate")
    public Object doUpdate(Advertisement advertisement, HttpSession session, HttpServletRequest request){
        //用来封装ajax请求结果
        AjaxResult result = new AjaxResult();
        try {

            User user = (User)session.getAttribute(Const.LOGIN_USER); //获取当前用户
            advertisement.setUserid(user.getId());  //获取当前用户id
            advertisement.setStatus("1");           //将当前的状态设置为未审核

            //调用业务层方法,返回一个影响数据库行数的int数值
            int count = advertisementService.updateAdvertisement(advertisement);
            result.setSuccess(count == 1);
        } catch (Exception e) {
            result.setSuccess(false);
            result.setMessage("修改广告数据失败");
            e.printStackTrace();
        }
        return result;
    }

    //去到发布广告页面
    @RequestMapping("/publishIndex")
    public String publishIndex(){
        return "publishAdvertisement/index";
    }

    //查询需要发布的广告
    @ResponseBody
    @RequestMapping("doPublishIndex")
    public Object doPublishIndex(@RequestParam(value = "pageno", required = false, defaultValue = "1") Integer pageno, @RequestParam(value = "pagesize", required = false, defaultValue = "8") Integer pagesize){
        //创建一个用于存储查询得到的数据集对象
        AjaxResult result = new AjaxResult();
        try {
            //调用service层查询方法，返回一个分页数据对象
            Page page = advertisementService.queryPagePublishAdvertisement(pageno, pagesize);
            //设置查询状态
            result.setSuccess(true);
            //存储查询到的数据
            result.setPage(page);
        } catch (Exception e) {
            result.setSuccess(false);
            result.setMessage("查询数据失败...");
            e.printStackTrace();
        }
        return result;
    }

    //模糊查询需要发布的广告
    @ResponseBody
    @RequestMapping("doPublishLike")
    public Object doPublishLike(@RequestParam(value = "pageno", required = false, defaultValue = "1") Integer pageno, @RequestParam(value = "pagesize", required = false, defaultValue = "8") Integer pagesize, String queryText){

        //创建一个用于存储查询得到的数据集对象
        AjaxResult result = new AjaxResult();
        try {
            //创建一个map集合
            HashMap<String, Object> paramMap = new HashMap<String, Object>();
            //将查询条件存入map集合
            paramMap.put("pageno",pageno);
            paramMap.put("pagesize",pagesize);
            paramMap.put("queryText",queryText);

            //调用service层查询方法，返回一个分页数据对象
            Page page = advertisementService.queryPagePublishLikeAdvertisement(paramMap);
            //设置查询状态
            result.setSuccess(true);
            //存储查询到的数据
            result.setPage(page);
        } catch (Exception e) {
            result.setSuccess(false);
            result.setMessage("查询数据失败...");
            e.printStackTrace();
        }
        return result;
    }

    //去到查看广告发布页面
    @RequestMapping("/show")
    public String show(Integer id, Map map){
        Advertisement advertisement = advertisementService.getAdvertisementById(id);
        map.put("advertisement",advertisement);
        return "publishAdvertisement/show";
    }

    //发布广告将广告的status改为 3
    @ResponseBody
    @RequestMapping("publishAdvertisement")
    public Object publishAdvertisement(Integer id){
        //创建一个用于存储查询得到的数据集对象
        AjaxResult result = new AjaxResult();
        try {
            //调用service层的方法发布广告将广告的status改为 3
            advertisementService.updateAdvertisementStatusByIdPublish(id);
            result.setSuccess(true);
        } catch (Exception e) {
            result.setSuccess(false);
            result.setMessage("操作失败...");
            e.printStackTrace();
        }
        return result;
    }

    //查询轮播图数据
    @ResponseBody
    @RequestMapping("selectPublishCarouse")
    public Object selectPublishCarouse(@RequestParam(value = "pageno", required = false, defaultValue = "1") Integer pageno, @RequestParam(value = "pagesize", required = false, defaultValue = "8") Integer pagesize){
        //创建一个用于存储查询得到的数据集对象
        AjaxResult result = new AjaxResult();
        try {
            //调用service层查询方法，返回一个分页数据对象
            Page page = advertisementService.queryPublishCarouseAdvertisement(pageno, pagesize);
            //System.out.println("轮播图"+page.toString());
            //设置查询状态
            result.setSuccess(true);
            //存储查询到的数据
            result.setPage(page);
        } catch (Exception e) {
            result.setMessage("查询数据失败...");
            result.setSuccess(false);
            e.printStackTrace();
        }
        return result;
    }

    //查询一般广告
    @ResponseBody
    @RequestMapping("selectPublish")
    public Object selectPublish(@RequestParam(value = "pageno", required = false, defaultValue = "1") Integer pageno, @RequestParam(value = "pagesize", required = false, defaultValue = "8") Integer pagesize){
        //创建一个用于存储查询得到的数据集对象
        AjaxResult result = new AjaxResult();
        try {
            //调用service层查询方法，返回一个分页数据对象
            Page page = advertisementService.queryPublishAdvertisement(pageno, pagesize);
           // System.out.println("一般广告"+page.toString());
            //设置查询状态
            result.setSuccess(true);
            //存储查询到的数据
            result.setPage(page);
        } catch (Exception e) {
            result.setMessage("查询数据失败...");
            result.setSuccess(false);
            e.printStackTrace();
        }
        return result;
    }

}



























