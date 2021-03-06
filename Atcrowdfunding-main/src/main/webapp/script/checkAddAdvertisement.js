$(document).ready(function() {

    $("#addAdvertisementForm").validate({
        errorElement : 'span',
        errorClass : 'help-block',

        rules : {
            name : "required",
            advertPicture : "required"
        },

        messages : {
            name : "输入广告名称",
            advertPicture : "请选择广告图片"
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
            addAdvertisement();
        }

    })
});


