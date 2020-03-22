package com.atguigu.atcrowdfunding.potal.service.impl;

import com.atguigu.atcrowdfunding.bean.Member;
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

	//更新流程id和状态
    @Override
    public void updatePiidAndPstep(Ticket ticket) {
        ticketMapper.updatePiidAndPstep(ticket);
    }

    //根据任务查询流程实例(根据流程实例的id查询流程单,查询用户信息)
    @Override
    public Member getMemberByPiId(String processInstanceId) {
        return ticketMapper.getMemberByPiId(processInstanceId);
    }

    //更新审核进度
    @Override
    public void updateStatus(Member member) {
		ticketMapper.updateStatus(member);
    }
}
