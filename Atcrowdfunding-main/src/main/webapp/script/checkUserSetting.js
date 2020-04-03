$(document).ready(function() {

    // 手机号码验证(登录账号)
    jQuery.validator.addMethod("loginacct_tel", function(value, element) {
        var length = value.length;
        return this.optional(element) || (length == 11 && /^[1](([3][0-9])|([4][5-9])|([5][0-3,5-9])|([6][5,6])|([7][0-8])|([8][0-9])|([9][1,8,9]))[0-9]{8}$/.test(value));
    }, "请填写正确手机号");

    $("#userSettingForm").validate({
        errorElement : 'span',
        errorClass : 'help-block',

        rules : {
            loginacct : {
                required : true,
                loginacct_tel : true
            },
            username : "required",
            userpswd : {
                required : true
            },
            email : {
                required : true,
                email : true
            },
        },
        messages : {
            loginacct : {
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
            updateSetting();
    }
    })
});