package com.atguigu.atcrowdfunding.manager.controller;

import com.atguigu.atcrowdfunding.bean.Project;
import com.atguigu.atcrowdfunding.bean.User;
import com.atguigu.atcrowdfunding.manager.service.ProjectService;
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
 * 项目管理的web控制层
 */
@Controller
@RequestMapping("/project")
public class ProjectController {

    @Autowired
    private ProjectService projectService;

    //去到项目管理首页面
    @RequestMapping("/index")
    public String index() {
        return "project/index";
    }

    //查询项目数据
    @ResponseBody
    @RequestMapping("/queryPageProject")
    public Object queryPageProject(@RequestParam(value = "pageno", required = false, defaultValue = "1") Integer pageno, @RequestParam(value = "pagesize", required = false, defaultValue = "8") Integer pagesize) {
        //创建一个用于存储查询得到的数据集对象
        AjaxResult result = new AjaxResult();
        try {
            //调用service层查询方法，返回一个分页数据对象
            Page page = projectService.queryPageProject(pageno, pagesize);
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

    //模块查询
    @ResponseBody
    @RequestMapping("queryPageProjectLike")
    public Object queryPageProjectLike(@RequestParam(value = "pageno", required = false, defaultValue = "1") Integer pageno, @RequestParam(value = "pagesize", required = false, defaultValue = "8") Integer pagesize, String queryText) {

        //创建一个用于存储查询得到的数据集对象
        AjaxResult result = new AjaxResult();
        try {
            //创建一个map集合
            HashMap<String, Object> paramMap = new HashMap<String, Object>();
            //将查询条件存入map集合
            paramMap.put("pageno", pageno);
            paramMap.put("pagesize", pagesize);
            paramMap.put("queryText", queryText);

            //调用service层查询方法，返回一个分页数据对象
            Page page = projectService.queryPageProjectLike(paramMap);
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

    //去到添加项目页面
    @RequestMapping("/add")
    public String add() {
        return "project/add";
    }

    //上传图片
    @ResponseBody
    @RequestMapping("/doAdd")
    public Object doAdd(HttpServletRequest request, Project project, HttpSession session) {
        AjaxResult result = new AjaxResult();
        try {
            MultipartHttpServletRequest mreq = (MultipartHttpServletRequest) request;

            MultipartFile mfile = mreq.getFile("projectPicture");  //创建一个文件对象
            String name = mfile.getOriginalFilename();// 获取上传的原始文件名  java.jpg
            String extname = name.substring(name.lastIndexOf(".")); //  截取文件名后缀 ： .jpg
            //String firstPath = CreateFileName.createID();
            String iconpath = UUID.randomUUID().toString() + extname; //生成随机文件名 ： 232243343.jpg

            ServletContext servletContext = session.getServletContext();
            String realpath = servletContext.getRealPath("/picture");  //得到存储文件的路径

            String path = realpath + "/project/" + iconpath;  //生成文件路径
            mfile.transferTo(new File(path));      //将文件添加到对应路径下
            User user = (User) session.getAttribute(Const.LOGIN_USER); //获取当前用户
            project.setMemberid(user.getId());  //获取当前用户id
            project.setFilename(iconpath);    //设置项目图片的名字

            //保存广告
            int count = projectService.saveProject(project);
            result.setSuccess(count == 1);
        } catch (Exception e) {
            e.printStackTrace();
            result.setSuccess(false);
        }
        return result;
    }

    //删除单条数据
    @ResponseBody
    @RequestMapping("/doDelete")
    public Object doDelete(Integer id) {
        //用来封装ajax请求结果
        AjaxResult result = new AjaxResult();
        try {
            //调用业务层方法,返回一个影响数据库行数的int数值
            int count = projectService.deleteProject(id);
            result.setSuccess(count == 1);
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
    public Object doDeleteBatch(Integer[] id) {
        AjaxResult result = new AjaxResult();
        try {
            //调用删除方法
            int count = projectService.deleteBatchProject(id);
            result.setSuccess(count == id.length);
        } catch (Exception e) {
            result.setSuccess(false);
            result.setMessage("删除数据失败");
            e.printStackTrace();
        }
        return result;
    }

    //去到修改项目信息页面
    @RequestMapping("/update")
    public String update(Integer id, Map<String, Object> map) {
        //根据id进行查询项目信息回显
        Project project = projectService.queryProjectById(id);
        map.put("project", project);
        return "project/update";
    }

    //修改项目数据
    @ResponseBody
    @RequestMapping("/doUpdate")
    public Object doUpdate(Project project) {
        AjaxResult result = new AjaxResult();
        try {
            //修改项目信息
            projectService.updateProjectById(project);
            result.setSuccess(true);
        } catch (Exception e) {
            result.setSuccess(false);
            result.setMessage("删除数据失败");
            e.printStackTrace();
        }
        return result;
    }

    //去到发布首页面
    @RequestMapping("/publishIndex")
    public String publishIndex() {
        return "publishProject/index";
    }

    //查询需要发布的项目信息
    @ResponseBody
    @RequestMapping("doPublishIndex")
    public Object doPublishIndex(@RequestParam(value = "pageno", required = false, defaultValue = "1") Integer pageno, @RequestParam(value = "pagesize", required = false, defaultValue = "8") Integer pagesize) {
        //创建一个用于存储查询得到的数据集对象
        AjaxResult result = new AjaxResult();
        try {
            //调用service层查询方法，返回一个分页数据对象
            Page page = projectService.queryPagePublishProject(pageno, pagesize);
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

    //去到查看发布项目页面
    @RequestMapping("/show")
    public String show(Integer id, Map<String, Object> map) {
        //查询项目数据进行回显
        Project project = projectService.queryProjectById(id);
        map.put("project", project);
        return "publishProject/show";
    }

    //发布项目，将项目的status该为 2
    @ResponseBody
    @RequestMapping("publishProject")
    public Object publishProject(Integer id) {
        //创建一个用于存储查询得到的数据集对象
        AjaxResult result = new AjaxResult();
        try {
            //调用service层的方法将项目的status该为 2
            projectService.updateProjectStatusByIdPublish(id);
            result.setSuccess(true);
        } catch (Exception e) {
            result.setSuccess(false);
            result.setMessage("操作失败...");
            e.printStackTrace();
        }
        return result;
    }

    //查询科技类项目数据
    @ResponseBody
    @RequestMapping("publishTechnologyProject")
    public Object publishTechnologyProject(@RequestParam(value = "pageno", required = false, defaultValue = "1") Integer pageno, @RequestParam(value = "pagesize", required = false, defaultValue = "8") Integer pagesize) {
        //创建一个用于存储查询得到的数据集对象
        AjaxResult result = new AjaxResult();
        try {
            //调用service层查询方法，返回一个分页数据对象
            Page page = projectService.queryPublishTechnologyProject(pageno, pagesize);
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

    //查询设计类项目
    @ResponseBody
    @RequestMapping("publishDesignProject")
    public Object publishDesignProject(@RequestParam(value = "pageno", required = false, defaultValue = "1") Integer pageno, @RequestParam(value = "pagesize", required = false, defaultValue = "8") Integer pagesize) {
        //创建一个用于存储查询得到的数据集对象
        AjaxResult result = new AjaxResult();
        try {
            //调用service层查询方法，返回一个分页数据对象
            Page page = projectService.queryPublishDesignProject(pageno, pagesize);
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

    //查询农业类项目
    @ResponseBody
    @RequestMapping("publishAgricultureProject")
    public Object publishAgricultureProject(@RequestParam(value = "pageno", required = false, defaultValue = "1") Integer pageno, @RequestParam(value = "pagesize", required = false, defaultValue = "8") Integer pagesize) {
        //创建一个用于存储查询得到的数据集对象
        AjaxResult result = new AjaxResult();
        try {
            //调用service层查询方法，返回一个分页数据对象
            Page page = projectService.queryPublishAgricultureProject(pageno, pagesize);
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

    //查询其他类项目
    @ResponseBody
    @RequestMapping("publishOthersProject")
    public Object publishOthersProject(@RequestParam(value = "pageno", required = false, defaultValue = "1") Integer pageno, @RequestParam(value = "pagesize", required = false, defaultValue = "8") Integer pagesize) {
        //创建一个用于存储查询得到的数据集对象
        AjaxResult result = new AjaxResult();
        try {
            //调用service层查询方法，返回一个分页数据对象
            Page page = projectService.queryPublishOthersProject(pageno, pagesize);
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





























