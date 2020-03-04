package com.atguigu.atcrowdfunding.util;

import java.io.Serializable;

/**
 * 封装处理ajax请求时的结果
 */
public class AjaxResult implements Serializable {
    //请求状态
    private Boolean success;

    //请求失败原因
    private String message;

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
}











