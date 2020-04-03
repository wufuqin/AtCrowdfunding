$(document).ready(function() {

    // 手机号码验证
    jQuery.validator.addMethod("loginacct_tel", function(value, element) {
        var length = value.length;
        return this.optional(element) || (length == 11 && /^[1](([3][0-9])|([4][5-9])|([5][0-3,5-9])|([6][5,6])|([7][0-8])|([8][0-9])|([9][1,8,9]))[0-9]{8}$/.test(value));
    }, "请填写正确手机号");

    // 身份证号码验证
    jQuery.validator.addMethod("isIdCardNo", function(value, element) {
        return this.optional(element) || idCardNoUtil.checkIdCardNo(value);//调用验证的方法
    }, "请正确填写身份证号码");

    // 手机号码验证
    jQuery.validator.addMethod("tel_tel", function(value, element) {
        var length = value.length;
        return this.optional(element) || (length == 11 && /^(((13[0-9]{1})|(15[0-9]{1})|(18[0-9]{1}))+\d{8})$/.test(value));
    }, "请正确填写您的手机号码");

    $("#updateMemberForm").validate({
        errorElement : 'span',
        errorClass : 'help-block',
        onkeyup : function(element, event) {
            //输入无效空格，去除左侧空格
            var value = this.elementValue(element).replace(/^\s+/g, "");
            $(element).val(value);
        },

        rules : {
            loginacct : {
                    required : true,
                    loginacct_tel : true
            },
            userpswd : {
                required : true
            },
            username : "required",
            realname : "required",
            cardnum: "isIdCardNo",//添加验证方法

            tel : {
                required : true,
                tel_tel : true
    },

        },
        messages : {
            loginacct : {
                required : "请输入您的账号"
            },
            userpswd : {
                required : "请输入密码"
            },
            username : "请输入用户名",
            realname : "请输入用户名",
            cardnum: {
                required: "请填写身份证号码"
            },
            tel : {
                required : "请输入您的手机号"
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
            updateMember();
        }
    })
});


