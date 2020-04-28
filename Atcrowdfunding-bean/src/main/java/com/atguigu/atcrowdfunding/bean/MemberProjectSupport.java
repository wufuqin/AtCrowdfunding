package com.atguigu.atcrowdfunding.bean;

/**
 * 用户支持项目的实体类对象
 */
public class MemberProjectSupport {

    Integer id;
    Integer memberid;
    Integer projectid;

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public Integer getMemberid() {
        return memberid;
    }

    public void setMemberid(Integer memberid) {
        this.memberid = memberid;
    }

    public Integer getProjectid() {
        return projectid;
    }

    public void setProjectid(Integer projectid) {
        this.projectid = projectid;
    }
}
