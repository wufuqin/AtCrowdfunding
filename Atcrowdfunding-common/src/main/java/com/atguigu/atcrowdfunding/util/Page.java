package com.atguigu.atcrowdfunding.util;

import org.apache.poi.ss.formula.functions.T;

import java.util.List;

/**
 * 数据分页工具类
 */
public class Page {

    private Integer pageno;    //当前页,要查询的页数
    private Integer pagesize;  //每页数据条数
    private List<T> datas;     //当前页的数据
    private Integer totalsize; //总数据条数
    private Integer totalno;   //总页数

    //只提供有参构造器，要求在查询数据的时候必须传递参数
    public Page(Integer pageno, Integer pagesize){
        if (pageno <= 1){
            this.pageno = 1;
        }else {
            this.pageno = pageno;
        }
        if (pagesize <= 0){
            this.pagesize = 1;
        }else {
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

    public List<T> getDatas() {
        return datas;
    }

    public void setDatas(List<T> datas) {
        this.datas = datas;
    }

    public Integer getTotalsize() {
        return totalsize;
    }

    public void setTotalsize(Integer totalsize) {
        this.totalsize = totalsize;
        //计算总记录数
        this.totalno = (totalsize % pagesize ) == 0 ? (totalsize/pagesize) : (totalsize/pagesize + 1);
    }

    private Integer getTotalno() {
        return totalno;
    }

    private void setTotalno(Integer totalno) {
        this.totalno = totalno;
    }

    //获取开始索引
    public Integer getStartIndex(){
        return (this.pageno - 1) * pagesize;
    }
}
















