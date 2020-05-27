package com.atguigu.atcrowdfunding.bean;

/**
 * 抽签实体类
 */
public class Draw {
    private Integer id;          //主键
    private Integer draw;        //抽签号
    private String studentId;    //学号
    private String name;         //姓名
    private String createTime;   //抽签时间

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public Integer getDraw() {
        return draw;
    }

    public void setDraw(Integer draw) {
        this.draw = draw;
    }

    public String getStudentId() {
        return studentId;
    }

    public void setStudentId(String studentId) {
        this.studentId = studentId;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getCreateTime() {
        return createTime;
    }

    public void setCreateTime(String createTime) {
        this.createTime = createTime;
    }
}











