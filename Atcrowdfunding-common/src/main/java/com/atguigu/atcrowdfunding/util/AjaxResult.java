package com.atguigu.atcrowdfunding.util;

import java.io.Serializable;

/**
 * ��װ����ajax����ʱ�Ľ��
 */
public class AjaxResult implements Serializable {
    //����״̬
    private Boolean success;

    //����ʧ��ԭ��
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











