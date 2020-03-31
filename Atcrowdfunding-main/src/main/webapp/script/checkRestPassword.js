$(document).ready(function() {

    // 手机号码验证(登录账号)
    jQuery.validator.addMethod("loginacct_tel", function(value, element) {
        var length = value.length;
        return this.optional(element) || (length == 11 && /^(((13[0-9]{1})|(15[0-9]{1})|(18[0-9]{1}))+\d{8})$/.test(value));
    }, "请填写正确手机号");

    // 匹配密码，以字母开头，长度在6-12之间，必须包含数字和特殊字符。
    jQuery.validator.addMethod("isPwd", function(value, element) {
        var str = value;
        if (str.length < 6 || str.length > 18)
            return false;
        if (!/^[a-zA-Z]/.test(str))
            return false;
        if (!/[0-9]/.test(str))
            return fasle;
        return this.optional(element) || /[^A-Za-z0-9]/.test(str);
    }, "以字母开头，长度在6-12之间，必须包含数字和特殊字符。");

    $("#restPasswordForm").validate({
        errorElement : 'span',
        errorClass : 'help-block',

        rules : {
            loginacct : {
                required : true,
                loginacct_tel : true
            },
            userpswd : {
                required : true,
                isPwd : true
            },
            confirm_password : {
                required : true,
                isPwd : true,
                equalTo : "#userpswd"
            },
            checkCode : {
                required : true
            },

        },
        messages : {
            loginacct : {
                required : "请输入手机号"
            },
            userpswd : {
                required : "请输入密码",
                minlength : jQuery.format("密码不能小于{0}个字 符")
            },
            confirm_password : {
                required : "请输入确认密码",
                minlength : "确认密码不能小于6个字符",
                equalTo : "两次输入密码不一致"
            },
            checkCode : "请输入验证码"

        },

        errorPlacement : function(error, element) {
            element.next().remove();
            element.after('<span class="glyphicon glyphicon-remove form-control-feedback" aria-hidden="true"></span>');
            element.closest('.form-group').append(error);
        },

        highlight : function(element) {
            $(element).closest('.form-group').addClass('has-error has-feedback');
        },

        success : function(label) {
            var el=label.closest('.form-group').find("input");
            el.next().remove();
            el.after('<span class="glyphicon glyphicon-ok form-control-feedback" aria-hidden="true"></span>');
            label.closest('.form-group').removeClass('has-error').addClass("has-feedback has-success");
            label.remove();
        },
    })
});