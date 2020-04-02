$(document).ready(function() {
    $("#uploadCertForm").validate({
        errorElement : 'span',
        errorClass : 'help-block',

        rules : {
            "certimgs[0].fileImg" : "required",
            "certimgs[1].fileImg" : "required",
            "certimgs[2].fileImg" : "required",
            "certimgs[3].fileImg" : "required",
            "certimgs[4].fileImg" : "required",
            "certimgs[5].fileImg" : "required",
            "certimgs[6].fileImg" : "required"
        },

        messages : {
            "certimgs[0].fileImg" : "请选择资质文件",
            "certimgs[1].fileImg" : "请选择资质文件",
            "certimgs[2].fileImg" : "请选择资质文件",
            "certimgs[3].fileImg" : "请选择资质文件",
            "certimgs[4].fileImg" : "请选择资质文件",
            "certimgs[5].fileImg" : "请选择资质文件",
            "certimgs[6].fileImg" : "请选择资质文件"
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
            uploadCert();
        }

    })
});


