package com.atguigu.atcrowdfunding.potal.listener;

import org.activiti.engine.delegate.DelegateExecution;
import org.activiti.engine.delegate.ExecutionListener;

//实名认证审核拒绝需要执行的操作
public class RefuseListener implements ExecutionListener {

	@Override
	public void notify(DelegateExecution execution) throws Exception {
		System.out.println("RefuseListener");

	}

}
