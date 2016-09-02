/**
 * core js
 * 
 * @package Marsesweb v2+
 * @author Marwin Silva
 */

// initialize API URLs
var api = [];
api['core/translator']  = ajax_path+"core/translator.php";

// initialize the plugins
function initialize() {
    // run bootstrap tooltip
    $('body').tooltip({
        selector: '[data-toggle="tooltip"]'
    });
    // run moment plugin
    $(".js_moment").each(function(){
        var _this = $(this);
        var time_utc = _this.attr('data-time');
        var offset = moment().utcOffset();
        var time = moment(time_utc).add({minutes:offset});
        _this.text(time.fromNow()).attr('title', time.format("dddd, MMMM D, YYYY h:m a"));
    });
    // run slimScroll plugin
    $('.js_scroller').each(function(){
        var _this = $(this);
        /* return if the plugin already running  */
        if(_this.parent('.slimScrollDiv').length > 0) {
            return;
        }
        /* run if not */
        _this.slimScroll({
            height: function(){
                var init = '280px';
                var height = _this.attr('data-slimScroll-height');
                if(height === undefined) {
                    return init;
                }
                return height;
            },
            distance: '2px'
        })
    });
}


// destroy slimScrol
function destroy_slimScrol(element) {
    if($(element).parent().hasClass('slimScrollDiv')) {
        $(element).parent().replaceWith($(element));
        $(element).removeAttr('style');
    }
}


// render template
function render_template(selector, options) {
    var template = $(selector).html();
    Mustache.parse(template);
    var rendered_template = Mustache.render(template, options);
    return rendered_template;
}


// modal
function modal() {
    if(arguments[0] == "#modal-login") {
        /* disable the backdrop (don't close modal when click outside) */
        if($('#modal').data('bs.modal')) {
            $('#modal').data('bs.modal').options = {backdrop: 'static', keyboard: false};
        } else {
            $('#modal').modal({backdrop: 'static', keyboard: false});
        }
    }
    /* check if the modal not visible, show it */
    if(!$('#modal').is(":visible")) $('#modal').modal('show');
    /* update the modal-content with the rendered template */
    $('.modal-content:last').html( render_template(arguments[0], arguments[1]) );
}


// modal update
function modal_update(selector) {
    /* update the template with the modal-content  */
    $(selector).html($('.modal-content:last').html());
}


// confirm
function confirm(title, message, callback) {
    modal('#modal-confirm', {'title': title, 'message': message});
    $("#modal-confirm-ok").click( function() {
        if(callback) callback();
    });
}


// is_empty
function is_empty(value) {
    if (value.match(/\S/) == null) {
        return true;
    } else  {
        return false;
    }
}


// photo grid
function photo_grid() {
    /* main photo */
    $('.pg_2o3_in').each(function() {
        if($(this).parents('.pg_3x').length > 0) {
            var width = height = $(this).parents('.pg_3x').width() * 0.667;
        }
        if($(this).parents('.pg_4x').length > 0) {
            var width = height = $(this).parents('.pg_4x').width() * 0.749;
        }
        $(this).width(width);
        $(this).height(height);
    });
    /* side photos */
    $('.pg_1o3_in').each(function() {
        if($(this).parents('.pg_3x').length > 0) {
            var width = $(this).parents('.pg_3x').width() * 0.332;
            var height = ($(this).parent('.pg_1o3').prev().height() - 1) / 2;
        }
        if($(this).parents('.pg_4x').length > 0) {
            var width = $(this).parents('.pg_4x').width() * 0.25;
            var height = ($(this).parent('.pg_1o3').prev().height() - 2) / 3;
        }
        $(this).width(width);
        $(this).height(height);
    });
}


$(function() {

    // run initialize() function after page load & after all ajax calls.
    initialize();
    $(document).ajaxComplete(function() {
        initialize();
    });

    // run fastlink
    FastClick.attach(document.body);

    // run photo grid
    $(window).bind("load", function() {
        photo_grid();
    });
    $(window).bind("resize", function() {
        setTimeout(photo_grid(), 200);
    });


    // run autogrow (expand textarea) plugin
    $('.js_autogrow').autogrow({'animate': false});

    //$('video').videoExtend();


    // run bootstrap modal
    $('body').on('click', '[data-toggle="modal"]', function(e) {
        e.preventDefault();
        var url = $(this).attr('data-url');
        if (url.indexOf('#') == 0) {
            /* open already loaded modal with #id */
            modal(url);
        } else {
            /* get & load modal from url */
            $.getJSON(ajax_path+url, function(response) {
                eval(response.callback);
            })
            .fail(function() {
                modal('#modal-message', {title: __['Error'], message: __['There is some thing went worng!']});
            });
        }
    });


    // bootsrap dropdown keep open (and for slimScrollBar)
    $('body').on('click', '.js_dropdown-keepopen, .slimScrollBar', function (e) {
        e.stopPropagation();
    });


    // run bootstrap btn-group
    $('body').on('click', '.btn-group a', function (e) {
        e.preventDefault();
        var parent = $(this).parents('.btn-group');
        /* change the value */
        parent.find('input[type="hidden"]').val($(this).attr('data-value'));
        /* copy text to btn-group-text */
        parent.find('.btn-group-text').text($(this).text());
        /* copy icon to btn-group-icon */
        parent.find('.btn-group-icon').attr("class", $(this).find('i.fa').attr("class")).addClass('btn-group-icon');
        /* copy title to tooltip */
        parent.attr('data-original-title', $(this).attr('data-title'));
        parent.attr('data-value', $(this).attr('data-value'));
        parent.tooltip();
    });


    // run ajax-forms
    $('body').on('submit', '.js_ajax-forms', function(e) {
        e.preventDefault();
        var _this = $(this);
        var url = _this.attr('data-url');
        var submit = _this.find('button[type="submit"]');
        var error = _this.find('.alert.alert-danger');
        var success = _this.find('.alert.alert-success');
        /* show any collapsed section if any */
        if(_this.find('.js_hidden-section').length > 0 && !_this.find('.js_hidden-section').is(':visible')) {
            _this.find('.js_hidden-section').slideDown();
            return false;
        }
        /* show loading */
        submit.data('text', submit.html());
        submit.prop('disabled', true);
        submit.html(__['Loading']);
        /* get ajax response */
        $.post(ajax_path+url, $(this).serialize(), function(response) {
            /* hide loading */
            submit.prop('disabled', false);
            submit.html(submit.data('text'));
            /* handle response */
            if(response.error) {
                if(success.is(":visible")) success.hide(); // hide previous alert
                error.html(response.message).slideDown();
            } else if(response.success) {
                if(error.is(":visible")) error.hide(); // hide previous alert
                success.html(response.message).slideDown();
            } else {
                eval(response.callback);
            }
        }, "json")
        .fail(function() {
            /* hide loading */
            submit.prop('disabled', false);
            submit.html(submit.data('text'));
            /* handle error */
            if(success.is(":visible")) success.hide(); // hide previous alert
            error.html(__['There is some thing went worng!']).slideDown();
        });
    });


    // run translator
    $('body').on('click', '.js_translator', function() {
        var language = $(this).attr('data-language');
        /* set language */
        $.post(api['core/translator'], {'language': language}, function(response) {
            /* check the response */
            if(!response) return;
            /* check if there is a callback */
            if(response.callback) {
                eval(response.callback);
            }
        }, 'json')
        .fail(function() {
            modal('#modal-message', {title: __['Error'], message: __['There is some thing went worng!']});
        });
    });

});