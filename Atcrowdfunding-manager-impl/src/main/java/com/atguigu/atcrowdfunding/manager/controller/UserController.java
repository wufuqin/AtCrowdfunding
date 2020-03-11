package com.atguigu.atcrowdfunding.manager.controller;

import com.atguigu.atcrowdfunding.bean.Role;
import com.atguigu.atcrowdfunding.bean.User;
import com.atguigu.atcrowdfunding.manager.service.UserService;
import com.atguigu.atcrowdfunding.util.AjaxResult;
import com.atguigu.atcrowdfunding.util.Page;
import com.atguigu.atcrowdfunding.vo.Data;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.*;

/**
 * 用户角色维护模块的controller
 */
@Controller
@RequestMapping("/user")
public class UserController {

    @Autowired
    private UserService userService;

    //去到用户维护模块首页面
    @RequestMapping("/index")
    public String index(){
        return "user/index";
    }

    //查询用户数据
    /**
     * 查询用户数据
     * @param pageno    当前页数
     * @param pagesize  每页显示的数据条数
     */
    @ResponseBody
    @RequestMapping("doIndex")
    public Object doIndex(@RequestParam(value = "pageno", required = false, defaultValue = "1") Integer pageno, @RequestParam(value = "pagesize", required = false, defaultValue = "5") Integer pagesize){
        //创建一个用于存储查询得到的数据集对象
        AjaxResult result = new AjaxResult();
        try {
            //调用service层查询方法，返回一个分页数据对象
            Page page = userService.queryPage(pageno, pagesize);
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
    public Object doLike(@RequestParam(value = "pageno", required = false, defaultValue = "1") Integer pageno, @RequestParam(value = "pagesize", required = false, defaultValue = "5") Integer pagesize, String queryText){

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
            Page page = userService.queryPage(paramMap);
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

    //去到添加用户页面
    @RequestMapping("/add")
    public String add(){
        return "user/add";
    }

    //添加用户数据
    /**
     * 添加用户
     * @param user 将前台返回的数据使用user实体对象封装
     */
    @ResponseBody
    @RequestMapping("/doAdd")
    public Object doAdd(User user){
        //用来封装ajax请求结果
        AjaxResult result = new AjaxResult();
        try {
            //调用业务层方法,返回一个影响数据库行数的int数值
            int count = userService.saveUser(user);
            result.setSuccess(true);
        } catch (Exception e) {
            result.setSuccess(false);
            result.setMessage("保存用户数据失败");
            e.printStackTrace();
        }
        return result;
    }

    //去到修改页面
    /**
     * 去到修改页面
     * @param id   需要修改的用户id
     * @param map  封装根据id从数据库将用户信息查询出来的用户信息
     */
    @RequestMapping("/update")
    public String update(Integer id, Map map){
        User user = userService.getUserById(id);
        //将查询到的用户信息封装到map集合中
        map.put("user",user);
        return "user/update";
    }

    //修改用户数据
    /**
     * 修改用户数据
     * @param user 将前台返回的数据使用user实体对象封装
     */
    @ResponseBody
    @RequestMapping("/doUpdate")
    public Object doUpdate(User user){
        //用来封装ajax请求结果
        AjaxResult result = new AjaxResult();
        try {
            //调用业务层方法,返回一个影响数据库行数的int数值
            int count = userService.updateUser(user);
            result.setSuccess(true);
        } catch (Exception e) {
            result.setSuccess(false);
            result.setMessage("修改用户数据失败");
            e.printStackTrace();
        }
        return result;
    }

    //删除用户数据
    @ResponseBody
    @RequestMapping("/doDelete")
    public Object doDelete(Integer id){
        //用来封装ajax请求结果
        AjaxResult result = new AjaxResult();
        try {
            //调用业务层方法,返回一个影响数据库行数的int数值
            int count = userService.deleteUser(id);
            result.setSuccess(true);
        } catch (Exception e) {
            result.setSuccess(false);
            result.setMessage("删除用户数据失败");
            e.printStackTrace();
        }
        return result;
    }

    //批量删除用户
    /**
     * 批量删除用户
     * @param id  选中的用户id
     */
    @ResponseBody
    @RequestMapping("/doDeleteBatch")
    public Object doDeleteBatch(Integer[] id){
        AjaxResult result = new AjaxResult();
        try {
            int count = userService.deleteBatchUser(id);
            result.setSuccess(count == id.length);
        } catch (Exception e) {
            result.setSuccess(false);
            result.setMessage("删除数据失败");
            e.printStackTrace();
        }
        return result;
    }

    //去到分配权限页面
    @RequestMapping("/assignRole")
    public String assignRole(Integer id, Map map){
        //查询所有的角色
        List<Role> allListRole = userService.queryAllRole();
        //根据用户id查询用户拥有的角色的id
        List<Integer> roleIds = userService.queryRoleByUserId(id);
        //存储未分配角色
        List<Role> leftRoleList = new ArrayList<Role>();
        //存储已分配角色
        List<Role> rightRoleList = new ArrayList<Role>();

        //将所有角色添加到两个集合中
        for (Role role : allListRole) {
            if (roleIds.contains(role.getId())){
                //添加到已分配集合
                rightRoleList.add(role);
            } else {
                //添加到未分配集合
                leftRoleList.add(role);
            }
        }
        map.put("leftRoleList",leftRoleList);
        map.put("rightRoleList",rightRoleList);

        return "user/assignRole";
    }

    //分配角色
    @ResponseBody
    @RequestMapping("/doAddAssignRole")
    public Object doAddAssignRole(Integer userid, Data data){
        //用来封装ajax请求结果
        AjaxResult result = new AjaxResult();
        try {
            //调用业务层方法,返回一个影响数据库行数的int数值
            userService.addAssignRole(userid, data);
            result.setSuccess(true);
        } catch (Exception e) {
            result.setSuccess(false);
            result.setMessage("分配权限失败");
            e.printStackTrace();
        }
        return result;
    }


    //取消权限
    @ResponseBody
    @RequestMapping("/doDeleteAssignRole")
    public Object doDeleteAssignRole(Integer userid, Data data){
        //用来封装ajax请求结果
        AjaxResult result = new AjaxResult();
        try {
            //调用业务层方法,返回一个影响数据库行数的int数值
            userService.deleteAssignRole(userid, data);
            result.setSuccess(true);
        } catch (Exception e) {
            result.setSuccess(false);
            result.setMessage("取消权限失败");
            e.printStackTrace();
        }
        return result;
    }




}


















