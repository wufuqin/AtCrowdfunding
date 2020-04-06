package com.atguigu.atcrowdfunding.util;

import java.util.List;

/**
 * 数据分页工具类
 */
public class Page<T> {

    private Integer pageno;    //当前页,要查询的页数
    private Integer pagesize;  //每页数据条数
    private List<T> datas;     //当前页的数据
    private Integer totalsize; //总数据条数
    private Integer totalno;   //总页数

    //只提供有参构造器，要求在查询数据的时候必须传递参数
    public Page(Integer pageno, Integer pagesize) {
        if (pageno <= 0) {
            this.pageno = 1;
        } else {
            this.pageno = pageno;
        }
        if (pagesize <= 0) {
            this.pagesize = 10;
        } else {
            this.pagesize = pagesize;
        }
    }

    public Integer getPageno() {
        return pageno;
    }

    public void setPageno(Integer pageno) {
        this.pageno = pageno;
    }

    public Integer getPagesize() {
        return pagesize;
    }

    public void setPagesize(Integer pagesize) {
        this.pagesize = pagesize;
    }

    public List getDatas() {
        return datas;
    }

    public void setDatas(List datas) {
        this.datas = datas;
    }

    public Integer getTotalsize() {
        return totalsize;
    }

    public void setTotalsize(Integer totalsize) {
        this.totalsize = totalsize;

    }

    public Integer getTotalno() {
        return totalno;
    }

    //计算总数据条数
    public void setTotalno(Integer totalsize) {
        this.totalno = (totalsize % pagesize) == 0 ? (totalsize / pagesize) : (totalsize / pagesize + 1);
    }

    //获取开始索引
    public Integer getStartIndex() {
        return (this.pageno - 1) * pagesize;
    }

    @Override
    public String toString() {
        return "Page{" +
                "pageno=" + pageno +
                ", pagesize=" + pagesize +
                ", datas=" + datas +
                ", totalsize=" + totalsize +
                ", totalno=" + totalno +
                '}';
    }
}
















