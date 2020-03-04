package com.atguigu.atcrowdfunding.controller;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpSession;

import com.atguigu.atcrowdfunding.exception.LoginFailException;
import com.atguigu.atcrowdfunding.util.AjaxResult;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.atguigu.atcrowdfunding.bean.User;
import com.atguigu.atcrowdfunding.manager.service.UserService;
import com.atguigu.atcrowdfunding.util.Const;
import org.springframework.web.bind.annotation.ResponseBody;

/**
 * ��web������
 */
@Controller
public class DispatcherController {

	//�û���ҵ�����󣬰��Զ�����ע��
	@Autowired
	private UserService userService ;

	/**
	 * ȥ����ҳ��
	 */
	@RequestMapping("/index")
	public String index(){		
		return "index";
	}

	/**
	 * ȥ����¼ҳ��
	 */
	@RequestMapping("/login")
	public String login(){		
		return "login";
	}

	/**
	 * ȥ��ע��ҳ��
	 */
	@RequestMapping("/reg")
	public String reg(){
		return "reg";
	}

	/**
	 * ȥ����̨��ҳ��
	 */
	@RequestMapping("/main")
	public String main(){		
		return "main";
	}

	//��¼ͬ������ʽ
	/**
	 * �����¼����
	 * @param loginacct  �����û�����ĵ�¼��
	 * @param userpswd   �����û�����ĵ�¼����
	 * @param type		  �����û�������û�����
	 * @param session	  �����û��������֤�룬���û�������뵽session����
	 */
	/*@RequestMapping("/doLogin")
	public String doLogin(String loginacct,String userpswd, String checkCode, String type,HttpSession session){
		Map<String,Object> paramMap = new HashMap<String,Object>();
		paramMap.put("loginacct", loginacct);
		paramMap.put("userpswd", userpswd);
		paramMap.put("type", type);

		//��session���л�ȡ�������ɵ���֤��
		String checkCode_server = (String) session.getAttribute("CHECKCODE_SERVER");
		//������֤�룬ȷ����֤��һ����
		session.removeAttribute("CHECKCODE_SERVER");
		//�ж��û��������֤���ʵ�����ɵ���֤���Ƿ�һ�£������ִ�Сд
		if(!checkCode_server.equalsIgnoreCase(checkCode)){
			//��֤�벻��ȷ(�׳��쳣��Ϣ)
			throw new LoginFailException("��֤�����");
		}

		//����ѯ�����û����ݷ�װ��map������
		User user = userService.queryUserLogin(paramMap);
		session.setAttribute(Const.LOGIN_USER, user);
		//ʹ���ض���ʹ������ת�������Ա���ҳ��ˢ��ʱ�ظ���������
		return "redirect:/main.htm";
	}*/

	//��¼�첽����ʽ
	/**
     * �����¼����
	 * @ResponseBody ���Jackson���, �����ؽ��ת��Ϊ�ַ���.
     * ��JSON����������ʽ���ظ��ͻ���.
     *      �������ݸ�ʽ�� {"success":false,"message":"��¼ʧ��!"}
     *
     */
	@ResponseBody
	@RequestMapping("/doLogin")
	public Object doLogin(String loginacct,String userpswd, String checkCode, String type,HttpSession session){

	    //��������װ����
        AjaxResult result = new AjaxResult();

        try {
            //ʹ��map���϶��û��������Ϣ���з�װ
            Map<String,Object> paramMap = new HashMap<String,Object>();
            paramMap.put("loginacct", loginacct);
            paramMap.put("userpswd", userpswd);
            paramMap.put("type", type);

            //��session���л�ȡ�������ɵ���֤��
            String checkCode_server = (String) session.getAttribute("CHECKCODE_SERVER");
            //������֤�룬ȷ����֤��һ����
            session.removeAttribute("CHECKCODE_SERVER");
            //�ж��û��������֤���ʵ�����ɵ���֤���Ƿ�һ�£������ִ�Сд
            if(!checkCode_server.equalsIgnoreCase(checkCode)){
                //��֤�벻��ȷ(�׳��쳣��Ϣ)
                result.setMessage("��֤�����");
                result.setSuccess(false);
                return result;
            }

            //����ѯ�����û����ݷ�װ��map������
            User user = userService.queryUserLogin(paramMap);
            session.setAttribute(Const.LOGIN_USER, user);
            result.setSuccess(true);
        } catch (Exception e) {
            e.printStackTrace();
            result.setMessage("��¼ʧ��");
            result.setSuccess(false);
        }
        return result;
	}
}
