$(document).ready(function() {

    $("#memberEmailForm").validate({
        errorElement : 'span',
        errorClass : 'help-block',

        rules : {
            email : {
                required : true,
                email : true
            }
        },

        messages : {
            email : {
                required : "请输入Email地址",
                email : "请输入正确的email地址"
            }
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
        submitHandler: function(form) {
            checkEmail();
        }

    })
});