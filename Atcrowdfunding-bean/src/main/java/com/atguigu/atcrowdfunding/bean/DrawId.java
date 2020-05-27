package com.atguigu.atcrowdfunding.bean;

/**
 * 抽签号实体类
 */
public class DrawId {
    private Integer id;     //主键
    private Integer draw;   //抽签号

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
}
