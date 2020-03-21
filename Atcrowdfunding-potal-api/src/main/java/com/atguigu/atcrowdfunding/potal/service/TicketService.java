package com.atguigu.atcrowdfunding.potal.service;

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
}
























