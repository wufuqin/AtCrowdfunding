$(document).ready(function() {
    $("#updateProjectForm").validate({
        errorElement : 'span',
        errorClass : 'help-block',
        rules : {
            name : "required",
            remark : "required",
            money : "required",
            day : "required",

        },
        messages : {
            name : "请输入项目名称",
            remark : "请输入项目简介",
            money : "请输入筹资金额",
            day : "请输入筹资天数",
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
            updateProject();
        }
    })
});


