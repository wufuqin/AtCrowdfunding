package com.atguigu.atcrowdfunding.util;

import java.io.Serializable;

/**
 * 封装ajax返回的结果对象
 */
public class AjaxResult implements Serializable {
    private Boolean success;  // 请求状态
    private String message;   // 错误信息
    private Page page;        // 分页数据对象

    private Object data ;     //封装许可树数据

    public String getMessage() {
        return message;
    }

    public void setMessage(String message) {
        this.message = message;
    }

    public Boolean getSuccess() {
        return success;
    }

    public void setSuccess(Boolean success) {
        this.success = success;
    }

    public Page getPage() {
        return page;
    }

    public void setPage(Page page) {
        this.page = page;
    }

    public Object getData() {
        return data;
    }

    public void setData(Object data) {
        this.data = data;
    }
}











