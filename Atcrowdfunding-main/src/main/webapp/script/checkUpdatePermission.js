$(document).ready(function() {
    // 手机号码验证(登录账号)
    jQuery.validator.addMethod("loginacct_tel", function(value, element) {
        var length = value.length;
        return this.optional(element) || (length == 11 && /^[1](([3][0-9])|([4][5-9])|([5][0-3,5-9])|([6][5,6])|([7][0-8])|([8][0-9])|([9][1,8,9]))[0-9]{8}$/.test(value));
    }, "请填写正确手机号");

    $("#updatePermissionForm").validate({
        errorElement : 'span',
        errorClass : 'help-block',

        rules : {
            name : {
                required : true
            },
            url : {
                required : true
            }
        },

        messages : {
            name : "请输入许可名",
            url : "请正确输入许可url"
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
            updatePermission();
        }

    })
});


