package com.atguigu.atcrowdfunding.exception;

/**
 * 自定义异常
 */
public class LoginFailException extends RuntimeException {

	private static final long serialVersionUID = 1L;

	public LoginFailException(String message){
		super(message);
	}
	
}
