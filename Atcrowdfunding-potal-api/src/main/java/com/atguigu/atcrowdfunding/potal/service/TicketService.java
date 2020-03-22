package com.atguigu.atcrowdfunding.potal.service;

import com.atguigu.atcrowdfunding.bean.Member;
import com.atguigu.atcrowdfunding.bean.Ticket;

/**
 * 实名审批流程service接口
 */
public interface TicketService {

	//根据会员id查询流程审批单
	Ticket getTicketByMemberId(Integer memberid);

	//保存数据到流程审批单
	void saveTicket(Ticket ticket);

	//更新流程审批单
	void updatePstep(Ticket ticket);

	//更新流程id和状态
    void updatePiidAndPstep(Ticket ticket);

    //根据任务查询流程实例(根据流程实例的id查询流程单,查询用户信息)
    Member getMemberByPiId(String processInstanceId);

    //更新审核进度
	void updateStatus(Member member);
}
























