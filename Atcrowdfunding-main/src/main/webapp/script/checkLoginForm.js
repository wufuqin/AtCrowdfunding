$(document).ready(function() {

    // 手机号码验证(登录账号)
    jQuery.validator.addMethod("reg_loginacct", function(value, element) {
        var length = value.length;
        return this.optional(element) || (length == 11 && /^[1](([3][0-9])|([4][5-9])|([5][0-3,5-9])|([6][5,6])|([7][0-8])|([8][0-9])|([9][1,8,9]))[0-9]{8}$/.test(value));
    }, "请填写正确手机号");

    // 匹配密码，以字母开头，长度在6-12之间，必须包含数字和特殊字符。
    jQuery.validator.addMethod("password", function(value, element) {
        var str = value;
        if (str.length < 6 || str.length > 18)
            return false;
        if (!/^[a-zA-Z]/.test(str))
            return false;
        if (!/[0-9]/.test(str))
            return false;
        return this.optional(element) || /[^A-Za-z0-9]/.test(str);
    }, "字母开头,6-12位数之间,包含数字和特殊字符");

    $("#loginForm").validate({
        errorElement : 'span',
        errorClass : 'help-block',

        rules : {
            loginacct : {
                required : true,
                reg_loginacct : true
            },
            userpswd : {
                required : true,
                password : true
            },
            checkCode : {
                required : true
            },

        },
        messages : {
            loginacct : {
                required : "请输入账号"
            },
            userpswd : {
                required : "请输入密码"
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
        submitHandler: function() {
            doLogin();
        }
    })
});