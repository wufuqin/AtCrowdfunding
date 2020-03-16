package com.atguigu.atcrowdfunding.manager.controller;

import com.atguigu.atcrowdfunding.bean.Advertisement;
import com.atguigu.atcrowdfunding.bean.User;
import com.atguigu.atcrowdfunding.manager.service.AdvertisementService;
import com.atguigu.atcrowdfunding.util.AjaxResult;
import com.atguigu.atcrowdfunding.util.Const;
import com.atguigu.atcrowdfunding.util.Page;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.io.File;
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
            String name = mfile.getOriginalFilename();// 获取上传的原始文件名  java.jpg
            String extname = name.substring(name.lastIndexOf(".")); //  截取文件名后缀 ： .jpg
            String iconpath = UUID.randomUUID().toString()+extname; //生成随机问卷名 ： 232243343.jpg

            ServletContext servletContext = session.getServletContext();
            String realpath = servletContext.getRealPath("/advertisementPicture");  //得到存储文件的路径

            String path =realpath+ "\\advertisement\\"+iconpath;  //生成文件路径
            mfile.transferTo(new File(path));      //将文件添加到对应路径下
            User user = (User)session.getAttribute(Const.LOGIN_USER); //获取当前用户
            advertisement.setUserid(user.getId());  //获取当前用户id
            advertisement.setStatus("1");           //将当前的状态设置为未审核
            advertisement.setIconpath(iconpath);    //设置广告图片名字

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

    //修改广告数据
    @ResponseBody
    @RequestMapping("/doUpdate")
    public Object doUpdate(Advertisement advertisement){
        //用来封装ajax请求结果
        AjaxResult result = new AjaxResult();
        try {
            //调用业务层方法,返回一个影响数据库行数的int数值
            int count = advertisementService.updateAdvertisement(advertisement);
            result.setSuccess(count == 1);
        } catch (Exception e) {
            result.setSuccess(false);
            result.setMessage("修改用户数据失败");
            e.printStackTrace();
        }
        return result;
    }

}
