package com.atguigu.atcrowdfunding.manager.controller;

import com.atguigu.atcrowdfunding.bean.Permission;
import com.atguigu.atcrowdfunding.manager.service.PermissionService;
import com.atguigu.atcrowdfunding.util.AjaxResult;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * 许可维护的web控制器
 */
@Controller
@RequestMapping("/permission")
public class PermissionController {

    @Autowired
    private PermissionService permissionService;

    //去到许可维护主页面
    @RequestMapping("/index")
    public String index(){
        return "permission/index";
    }

	//加载许可树，用Map集合来查找父,来组合父子关系.减少循环的次数 ,提高性能.
	@ResponseBody
	@RequestMapping("/loadData")
	public Object loadData(){
		AjaxResult result = new AjaxResult();
		try {
			//存储父节点
			List<Permission> root = new ArrayList<Permission>();
			//存储子节点
			List<Permission> childredPermissons =  permissionService.queryAllPermission();
			Map<Integer,Permission> map = new HashMap<Integer,Permission>();

			for (Permission innerpermission : childredPermissons) {
				map.put(innerpermission.getId(), innerpermission);
			}
			for (Permission permission : childredPermissons) {
				//通过子查找父
				//子菜单
				Permission child = permission ; //假设为子菜单
				if(child.getPid() == null ){
					root.add(permission);
				}else{
					//父节点
					Permission parent = map.get(child.getPid());
					parent.getChildren().add(child);
				}
			}
			result.setSuccess(true);
			result.setData(root);
		} catch (Exception e) {
			result.setSuccess(false);
			result.setMessage("加载许可树数据失败!");
		}
		return result ;
	}

	//跳转到添加权限页面
	@RequestMapping("/toAdd")
	public String toAdd(){
		return "permission/add";
	}

	//添加权限方法
	@ResponseBody
	@RequestMapping("/doAdd")
	public Object doAdd(Permission permission){
		AjaxResult result = new AjaxResult();
		try {
			int count = permissionService.savePermission(permission);
			result.setSuccess(count == 1);
		}catch (Exception e){
			result.setSuccess(false);
			result.setMessage("保存失败");
		}
		return result;
	}

	//跳转到修改权限页面
	@RequestMapping("/toUpdate")
	public String toUpdate(Integer id, Map map){
        //根据id查询许可对应许可的信息并且返回页面进行表单数据回显
		Permission permission = permissionService.getPermissionById(id);
		map.put("permission",permission);
		return "permission/update";
	}

	//修改许可
	@ResponseBody
	@RequestMapping("/doUpdate")
	public Object doUpdate(Permission permission){
		AjaxResult result = new AjaxResult();
		try {
		    //调用service层的修改方法，返回一个影响数据库的行数
			int count = permissionService.updatePermission(permission);
			result.setSuccess(count == 1);
		}catch (Exception e){
			result.setSuccess(false);
			result.setMessage("保存失败");
		}
		return result;
	}

	//删除权限方法
	@ResponseBody
	@RequestMapping("/deletePermission")
	public Object deletePermission(Integer id){
		AjaxResult result = new AjaxResult();
		try {
            //调用service层的删除方法，返回一个影响数据库的行数
			int count = permissionService.deletePermission(id);
			result.setSuccess(count == 1);
		}catch (Exception e){
			result.setSuccess(false);
			result.setMessage("删除失败");
		}
		return result;
	}

}























