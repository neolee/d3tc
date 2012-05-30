$.ajaxSetup({
    beforeSend: function() {
        $('#spinner').show();
    },
    complete: function(){
        $('#spinner').hide();
    },
    success: function() {}
});

$.validator.setDefaults({
    errorClass: 'error',
    validClass: 'success',
    errorElement: 'span',
    highlight: function(element, errorClass, validClass) {
        var $obj;
        $obj = element.type === 'radio' ? this.findByName(element.name) : $(element);
        return $obj.parents('div.control-group').removeClass(validClass).addClass(errorClass);
    },
    unhighlight: function(element, errorClass, validClass) {
        var $obj;
        $obj = element.type === 'radio' ? this.findByName(element.name) : $(element);
        $obj.next('span.help-inline.' + errorClass).remove();
        return $obj.parents('div.control-group').removeClass(errorClass).addClass(validClass);
    },
    errorPlacement: function(error, element) {
        if (element.siblings().length > 0) {
            error.insertAfter(element.siblings(':last'));
        } else {
            error.insertAfter(element);
        }
    }
});

$.validator.messages = ({
    required: 'required',
    remote: 'error',
    email: 'not email',
    url: 'not URL',
    date: 'not date',
    dateISO: 'not date (ISO)',
    number: 'not number',
    digits: 'not digits',
    creditcard: 'not credit card number',
    equalTo: 'not same value again',
    accept: 'not with a valid extension',
    maxlength: jQuery.validator.format('more than {0} characters'),
    minlength: jQuery.validator.format('less than {0} characters'),
    rangelength: jQuery.validator.format('not between {0} and {1} characters'),
    range: jQuery.validator.format('not between {0} and {1}'),
    max: jQuery.validator.format('greater than {0}'),
    min: jQuery.validator.format('less than {0}')
});
