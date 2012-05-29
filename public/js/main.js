$("#character").validate({
    rules: {
        strength: {
            required: true,
            number: true,
        },
        dexterity: {
            required: true,
            number: true,
        },
        intelligence: {
            required: true,
            number: true,
        },
        vitality: {
            required: true,
            number: true,
        },
        armor: {
            required: true,
            number: true,
        },
    }
});

$('#calc').click(function(event) {
    if($('#character').valid() == false) return false;
    
    $('#alert').removeClass('alert-success alert-error').addClass('alert-info');
    $('#alert').show().text('Calculating...');

    $.ajax({
        type: $('#character').attr('method'),
        url: $('#character').attr('action'),
        data: $('#character').serialize(),
        success: function(data) {
            errorMsg = 'Done.'
            
            $('#result').html(data);
            $('#alert').removeClass('alert-info').addClass('alert-success');
            $('#alert').text(errorMsg).fadeOut('slow');
        },
        error: function(data) {
            switch(data.status)
            {
                case 400:
                errorMsg = 'Cannot save changes [Error: ' + data.responseText + '].'
                break;
                default:
                errorMsg = 'Failed [Error code: ' + data.status + '].'
            }

            $('#alert').removeClass('alert-info').addClass('alert-error');
            $('#alert').text(errorMsg);
        },
    });

    return false;
});
