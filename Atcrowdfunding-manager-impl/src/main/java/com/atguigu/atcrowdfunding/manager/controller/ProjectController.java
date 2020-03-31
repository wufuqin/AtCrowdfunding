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

import javax.servlet.http.HttpSession;
import java.util.HashMap;
import java.util.Map;

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
    public String index(){
        return "project/index";
    }

    //查询项目数据
    @ResponseBody
    @RequestMapping("/queryPageProject")
    public Object queryPageProject(@RequestParam(value = "pageno", required = false, defaultValue = "1") Integer pageno, @RequestParam(value = "pagesize", required = false, defaultValue = "8") Integer pagesize){
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
    public Object queryPageProjectLike(@RequestParam(value = "pageno", required = false, defaultValue = "1") Integer pageno, @RequestParam(value = "pagesize", required = false, defaultValue = "8") Integer pagesize, String queryText){

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
    public String add(){
        return "project/add";
    }

    //添加项目
    @ResponseBody
    @RequestMapping("/addProject")
    public Object doAdd(Project project, HttpSession session) {
        AjaxResult result = new AjaxResult();

        try {
            User user = (User)session.getAttribute(Const.LOGIN_USER); //获取当前用户
            project.setMemberid(user.getId());  //获取当前用户id

            //保存项目
            int count = projectService.saveProject(project);
            result.setSuccess(count==1);
        } catch ( Exception e ) {
            e.printStackTrace();
            result.setSuccess(false);
        }

        return result;
    }

    //删除单条数据
    @ResponseBody
    @RequestMapping("/doDelete")
    public Object doDelete(Integer id){
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
    public Object doDeleteBatch(Integer[] id){
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
    public String update(Integer id, Map<String, Object> map){
        //根据id进行查询项目信息回显
        Project project = projectService.queryProjectById(id);
        map.put("project", project);
        return "project/update";
    }

    //修改项目数据
    @ResponseBody
    @RequestMapping("/doUpdate")
    public Object doUpdate(Project project){
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


}





























