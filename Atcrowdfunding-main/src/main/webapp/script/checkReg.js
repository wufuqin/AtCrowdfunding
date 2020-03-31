$(document).ready(function() {

    // 手机号码验证(登录账号)
    jQuery.validator.addMethod("reg_tel", function(value, element) {
        var length = value.length;
        return this.optional(element) || (length == 11 && /^(((13[0-9]{1})|(15[0-9]{1})|(18[0-9]{1}))+\d{8})$/.test(value));
    }, "请填写正确手机号");

    // 匹配密码，以字母开头，长度在6-12之间，必须包含数字和特殊字符。
    jQuery.validator.addMethod("password", function(value, element) {
        var str = value;
        if (str.length < 6 || str.length > 18)
            return false;
        if (!/^[a-zA-Z]/.test(str))
            return false;
        if (!/[0-9]/.test(str))
            return fasle;
        return this.optional(element) || /[^A-Za-z0-9]/.test(str);
    }, "字母开头,6-12位数之间,包含数字和特殊字符");


    $("#registerForm").validate({
        errorElement : 'span',
        errorClass : 'help-block',

        rules : {
            tel : {
                required : true,
                reg_tel : true
            },
            username : "required",
            userpswd : {
                required : true,
                password : true
            },
            email : {
                required : true,
                email : true
            },
            code : {
                required : true
            },

        },
        messages : {
            tel : {
                required : "请输入手机号"
            },
            username : "请输入用户名",
            userpswd : {
                required : "请输入密码"
            },
            email : {
                required : "请输入Email地址",
                email : "请输入正确的email地址"
            },
            code : "请输入验证码"

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