package com.atguigu.atcrowdfunding.potal.service.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.atguigu.atcrowdfunding.bean.Ticket;
import com.atguigu.atcrowdfunding.potal.dao.TicketMapper;
import com.atguigu.atcrowdfunding.potal.service.TicketService;

/**
 * 实名审批流程service实现类
 */
@Service
public class TicketServiceImpl implements TicketService {

	@Autowired
	private TicketMapper ticketMapper ;

	//根据会员id查询流程审批单
	@Override
	public Ticket getTicketByMemberId(Integer memberid) {
		return ticketMapper.getTicketByMemberId(memberid);
	}

	//保存数据到流程审批单
	@Override
	public void saveTicket(Ticket ticket) {
		ticketMapper.saveTicket(ticket);
	}

	//更新流程审批单
	@Override
	public void updatePstep(Ticket ticket) {
		ticketMapper.updatePstep(ticket);
	}
}
