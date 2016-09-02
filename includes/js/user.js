/**
 * user js
 * 
 * @package Marsesweb v2+
 * @author Marwin Silva
 */

// initialize API URLs
api['data/live']  = ajax_path+"data/live.php";
api['data/load']  = ajax_path+"data/load.php";
api['data/upload']  = ajax_path+"data/upload.php";
api['data/video']  = ajax_path+"data/video.php";
api['data/reset']  = ajax_path+"data/reset.php";
api['data/report']  = ajax_path+"data/report.php";
api['data/delete']  = ajax_path+"data/delete.php";
api['data/search']  = ajax_path+"data/search.php";

api['users/image']  = ajax_path+"users/image.php";
api['users/connect']  = ajax_path+"users/connect.php";
api['users/delete']  = ajax_path+"users/delete.php";
api['users/popover']   = ajax_path+"users/popover.php";
api['users/mention']  = ajax_path+"users/mention.php";
api['users/autocomplete']  = ajax_path+"users/autocomplete.php";


// data heartbeat
function data_heartbeat() {
    var last_request = $(".js_live-requests").find(".js_scroller li:first").attr('data-id') || 0;
    var last_message = $(".js_live-messages").find(".js_scroller li:first").attr('data-last-message') || 0;
    var last_notification = $(".js_live-notifications").find(".js_scroller li:first").attr('data-id') || 0;
    /* newsfeed check */
    var posts_stream =  $('.js_posts_stream');
    if(posts_stream.length > 0) {
        var last_post = posts_stream.find("li:first .post").attr('data-id') || 0;
        var get = posts_stream.attr('data-get');
        var id = posts_stream.attr('data-id');
    }
    $.post(api['data/live'], {'last_request': last_request, 'last_message': last_message, 'last_notification': last_notification, 'last_post': last_post, 'get': get, 'id': id}, function(response) {
        if(response.callback) {
            eval(response.callback);
        } else {
            if(response.requests) {
                if($(".js_live-requests").find(".js_scroller ul").length > 1) {
                    $(".js_live-requests").find(".js_scroller ul:first").prepend(response.requests);
                } else {
                    $(".js_live-requests").find(".js_scroller p:first").replaceWith("<ul>"+response.requests+"</ul>");
                }
                var requests = parseInt($(".js_live-requests").find("span.label").text()) + response.requests_count;
                $(".js_live-requests").find("span.label").text(requests).removeClass("hidden");
                $("#chat_audio")[0].play();
            }
            if(response.conversations) {
                $(".js_live-messages").find(".js_scroller").html("<ul>"+response.conversations+"</ul>");
                /* update live messages in messages page */
                if(window.location.pathname.indexOf("messages") != -1) {
                    if($(".js_live-messages-alt").find(".js_scroller ul").length > 0) {
                        $(".js_live-messages-alt").find(".js_scroller ul").html(response.conversations);
                    } else {
                        $(".js_live-messages-alt").find(".js_scroller").html("<ul>"+response.conversations+"</ul>");
                    }
                }
                if(response.conversations_count > 0) {
                    $(".js_live-messages").find("span.label").text(response.conversations_count).removeClass("hidden");
                    $("#chat_audio")[0].play();
                } else {
                    $(".js_live-messages").find("span.label").text(response.conversations_count);
                }
            }
            if(response.notifications) {
                if($(".js_live-notifications").find(".js_scroller ul").length > 0) {
                    $(".js_live-notifications").find(".js_scroller ul").prepend(response.notifications);
                } else {
                    $(".js_live-notifications").find(".js_scroller").html("<ul>"+response.notifications+"</ul>");
                }
                var notifications = parseInt($(".js_live-notifications").find("span.label").text()) + response.notifications_count;
                $(".js_live-notifications").find("span.label").text(notifications).removeClass("hidden");
                $("#chat_audio")[0].play();
            }
            if(response.posts) {
                posts_stream.prepend(response.posts);
                setTimeout(photo_grid(), 200);
            }
            setTimeout('data_heartbeat();',min_heartbeat);
        }
    }, 'json');
}

// see more
function see_more(element) {
    if(element.hasClass('done')) return;
    var _this = element;
    var offset = _this.attr('data-offset') || 1; /* we start from iteration 1 because 0 already loaded */
    var uid = _this.attr('data-uid') || null;
    var id = _this.attr('data-id') || null;
    var loading = _this.find('.loader');
    var text = _this.find('span');
    var get = _this.attr('data-get');
    var remove = _this.attr('data-remove') || false;
    var stream = _this.parent().find('ul:first');
    /* show loader & hide text */
    _this.addClass('loading');
    text.hide();
    loading.removeClass('x-hidden');
    /* get & load data */
    $.post(api['data/load'], {'get': get, 'offset': offset, 'uid': uid, 'id': id}, function(response) {
        _this.removeClass('loading');
        text.show();
        loading.addClass('x-hidden');
        /* check the response */
        if(response.callback) {
            eval(response.callback);
        } else {
            if(response.data) {
                offset++;
                if(response.append) {
                    stream.append(response.data);
                } else {
                    stream.prepend(response.data);
                }
                setTimeout(photo_grid(), 200);
            } else {
                if(remove) {
                    _this.remove();
                } else {
                    _this.addClass('done');
                    text.text(__['There is no more data to show']);
                }
            }
        }
        _this.attr('data-offset', offset);
    }, 'json')
    .fail(function() {
        _this.removeClass('loading');
        text.show();
        loading.addClass('x-hidden');
        modal('#modal-message', {title: __['Error'], message: __['There is some thing went worng!']});
    });
}


$(function() {

    // start live heartbeat
    data_heartbeat();


    // run data reseter
    $('body').on('click', '.js_live-requests, .js_live-messages, .js_live-notifications', function () {
        var _this = $(this);
        var counter = parseInt(_this.find("span.label").text()) || 0;
        if(!$(this).hasClass('open') && counter > 0) {
            /* reset the client counter & hide it */
            _this.find("span.label").addClass('hidden').text('0');
            /* get the reset target */
            if(_this.hasClass('js_live-requests')) {
                var data = {'reset': 'friend_requests'};
            } else if (_this.hasClass('js_live-messages')) {
                var data = {'reset': 'messages'};
            } else if(_this.hasClass('js_live-notifications')) {
                var data = {'reset': 'notifications'};
            }
            /* reset the server counter */
            $.post(api['data/reset'], data, function(response) {
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
        }
    });


    // run x-uploader
    /* initialize the uplodaer */
    $('.js_x-uploader').each(function() {
        /* check the multiple */
        var multiple = ($(this).attr('data-multiple') !== undefined)? true : false;
        $(this).wrap(render_template("#x-uploader", {'url': api['data/upload'], 'secret': secret, 'multiple': multiple}));
    });
    $(document).ajaxComplete(function() {
        $('.js_x-uploader').each(function(index) {
            /* return if the plugin already running  */
            if($(this).parent('form.x-uploader').length > 0) {
                return;
            }
            $(this).wrap(render_template("#x-uploader", {'url': api['data/upload'], 'secret': secret}));
        });
    });
    /* initialize uploading */
    $('body').on('change', '.x-uploader input[type="file"]', function() {
        $(this).parent('.x-uploader').submit();
    });
    /* uploading */
    $('body').on('submit', '.x-uploader', function(e) {
        e.preventDefault;
        /* initialize AJAX options */
        var options = {
            dataType: "json",
            uploadProgress: _handle_progress,
            success: _handle_success,
            error: _handle_error,
            resetForm: true
        };
        /* get uploader input */
        var uploader = $(this).find('input[type="file"]');
        /* check the multiple */
        var multiple = ($(this).find('.js_x-uploader').attr('data-multiple') !== undefined)? true : false;
        /* check the handle */
        var handle = $(this).find('.js_x-uploader').attr('data-handle');
        if(handle !== undefined) {
            /* update the query string */
            var id = $(this).find('.js_x-uploader').attr('data-id');
            if(id !== undefined) {
                options['data'] = {'handle': handle, 'multiple': multiple, 'id': id}
            } else {
                options['data'] = {'handle': handle, 'multiple': multiple}
            }
            /* show upload loader */
            if(handle == "cover-user" || handle == "cover-page" || handle == "cover-group") {
                var loader = $('.profile-cover-change-loader');
                loader.show();

            } else if(handle == "picture-user" || handle == "picture-page" || handle == "picture-group") {
                var loader = $('.profile-avatar-change-loader');
                loader.show();

            } else if(handle == "publisher") {
                var publisher = $('.publisher');
                var files_num = uploader.get(0).files.length;
                /* check if there is current (uploading|scrabing|video) process */
                if(publisher.data('scrabing') || publisher.data('video')) {
                    return false;
                }
                /* check if there is already uploading process */
                if(!publisher.data('uploading')) {
                    publisher.data('uploading', {});
                }
                var attachments = $('.publisher-attachments');
                var loader = $('<ul></ul>').appendTo(attachments);
                attachments.show();
                for (var i = 0; i < files_num; ++i) {
                    $('<li class="loading"><div class="loader loader_small"></div></li>').appendTo(loader).show();
                }

            } else if(handle == "comment") {
                var comment = $(this).parents('.comment');
                /* check if there is already uploading process */
                if(comment.data('uploading')) {
                    return false;
                }
                var attachments = comment.find('.comment-attachments');
                var loader = attachments.find('li.loading');
                attachments.show();
                loader.show();

            } else if(handle == "chat") {
                var chat_widget = $(this).parents('.chat-widget, .panel-messages');
                /* check if there is already uploading process */
                if(chat_widget.data('uploading')) {
                    return false;
                }
                var attachments = chat_widget.find('.chat-attachments');
                var loader = attachments.find('li.loading');
                attachments.show();
                loader.show();

            } else if(handle == "x-image") {
                var parent = $(this).parents('.x-image');
                var loader = parent.find('.loader');
                loader.show();
            }
        }
        /* handle progress */
        function _handle_progress() {
            /* disable uploader input during uploading */
            uploader.prop('disabled', true);
        }
        /* handle success */
        function _handle_success(response) {
            /* enable uploader input */
            uploader.prop('disabled', false);
            /* hide upload loader */
            if(loader) loader.hide();
            /* handle the response */
            if(response.callback) {
                eval(response.callback);
            } else {
                /* check the handle */
                if(handle !== undefined) {
                    if(handle == "cover-user" || handle == "cover-page" || handle == "cover-group") {
                        /* update (user|page|group) cover */
                        var image_path = uploads_path+'/'+response.file;
                        $('.profile-cover-wrapper').css("background-image", 'url('+image_path+')').removeClass('no-cover');

                    } else if(handle == "picture-user" || handle == "picture-page" || handle == "picture-group") {
                        /* update (user|page|group) picture */
                        var image_path = uploads_path+'/'+response.file;
                        $('.profile-avatar-wrapper img').attr("src", image_path);

                    } else if(handle == "publisher") {
                        /* remove upload loader */
                        if(loader) loader.remove();
                        /* add the attachment to publisher data */
                        var files = publisher.data('uploading');
                        for(var i in response.files) {
                            files[response.files[i]] = response.files[i];
                            /* add publisher-attachments */
                            var image_path = uploads_path+'/'+response.files[i];
                            attachments.find('ul').append(render_template("#publisher-attachments-item", {'src':response.files[i], 'image_path':image_path}));
                        }
                        publisher.data('uploading', files);

                    } else if(handle == "comment") {
                        /* add the attachment to comment data */
                        comment.data('uploading', response.file);
                        /* hide comment x-form-tools */
                        comment.find('.x-form-tools-attach').hide();
                        /* add comment-attachments */
                        var image_path = uploads_path+'/'+response.file;
                        attachments.find('ul').append(render_template("#comment-attachments-item", {'src':response.file, 'image_path':image_path}));

                    } else if(handle == "chat") {
                        /* add the attachment to comment data */
                        chat_widget.data('uploading', response.file);
                        /* hide comment x-form-tools */
                        chat_widget.find('.x-form-tools-attach').hide();
                        /* add comment-attachments */
                        var image_path = uploads_path+'/'+response.file;
                        attachments.find('ul').append(render_template("#chat-attachments-item", {'src':response.file, 'image_path':image_path}));

                    } else if(handle == "x-image") {
                        /* update x-image picture */
                        var image_path = uploads_path+'/'+response.file;
                        parent.css("background-image", 'url('+image_path+')');
                        /* add the image to input */
                        parent.find('.js_x-image-input').val(response.file);
                        /* show the remover */
                        parent.find('button').show();
                    }
                }
            }
        }
        /* handle error */
        function _handle_error() {
            /* hide upload loader */
            if(loader) loader.hide();
            /* check the handle */
            if(handle !== undefined) {
                if(handle == "publisher") {
                    /* hide the attachment from publisher data */
                    if(publisher.data('uploading')) {
                        attachments.hide();
                    }
                    /* remove upload loader */
                    if(loader) loader.remove();
                }
            }
            modal('#modal-message', {title: __['Error'], message: __['There is some thing went worng!']});
        }
        /* submit the form */
        $(this).ajaxSubmit(options);
        return false;
    });


    // run x-uploader-video
    /* initialize the uplodaer */
    $('.js_x-uploader-video').each(function() {
        $(this).wrap(render_template("#x-uploader-video", {'url': api['data/video'], 'secret': secret}));
    });
    $(document).ajaxComplete(function() {
        $('.js_x-uploader-video').each(function(index) {
            /* return if the plugin already running  */
            if($(this).parent('form.x-uploader-video').length > 0) {
                return;
            }
            $(this).wrap(render_template("#x-uploader-video", {'url': api['data/video'], 'secret': secret}));
        });
    });
    /* initialize uploading */
    $('body').on('change', '.x-uploader-video input[type="file"]', function() {
        $(this).parent('.x-uploader-video').submit();
    });
    /* uploading */
    $('body').on('submit', '.x-uploader-video', function(e) {
        e.preventDefault;
        /* initialize AJAX options */
        var options = {
            dataType: "json",
            uploadProgress: _handle_progress,
            success: _handle_success,
            error: _handle_error,
            resetForm: true
        };
        /* get uploader input */
        var uploader = $(this).find('input[type="file"]');
        /* show upload loader */
        var publisher = $('.publisher');
        /* check if there is current (uploading|scrabing|video) process */
        if(publisher.data('uploading') || publisher.data('scrabing') || publisher.data('video')) {
            return;
        }
        /* check if there is already video process */
        if(!publisher.data('video')) {
            publisher.data('video', {});
        }
        var attachments = $('.publisher-attachments');
        var loader = $('<ul></ul>').appendTo(attachments);
        attachments.show();
        $('<li class="loading"><div class="loader loader_small"></div></li>').appendTo(loader).show();
        
        /* handle progress */
        function _handle_progress() {
            /* disable uploader input during uploading */
            uploader.prop('disabled', true);
        }
        /* handle success */
        function _handle_success(response) {
            /* enable uploader input */
            uploader.prop('disabled', false);
            /* hide upload loader */
            if(loader) loader.hide();
            /* handle the response */
            if(response.callback) {
                /* hide the attachment from publisher data */
                attachments.hide();
                /* remove upload loader */
                loader.remove();
                /* remove the video from publisher data */
                $('.publisher').removeData('video');
                eval(response.callback);
            } else {
                /* hide the attachment from publisher data */
                attachments.hide();
                /* remove upload loader */
                if(loader) loader.remove();
                /* show video uploaded message */
                $('.publisher-video').show();
                /* add the attachment to publisher data */
                var video = publisher.data('video');
                video['source'] = response.file;
                /* add publisher-attachments */
                publisher.data('video', video);
            }
        }
        /* handle error */
        function _handle_error() {
            /* hide the attachment from publisher data */
            attachments.hide();
            /* remove upload loader */
            loader.remove();
            modal('#modal-message', {title: __['Error'], message: __['There is some thing went worng!']});
        }
        /* submit the form */
        $(this).ajaxSubmit(options);
        return false;
    });


    // run profile (cover|picture) remover
    $('body').on('click', '.js_delete-cover, .js_delete-picture', function () {
        var remove = ($(this).hasClass('js_delete-cover'))? 'cover' : 'picture';
        var id = $(this).attr('data-id');
        var handle = $(this).attr('data-handle');
        if(remove == 'cover') {
            var wrapper = $('.profile-cover-wrapper');
            if(wrapper.hasClass('no-cover')) return;
            var _title = __['Delete Cover'];
            var _message = __['Are you sure you want to remove your cover photo?'];
        } else {
            var wrapper = $('.profile-avatar-wrapper');
            var _title = __['Delete Picture'];
            var _message = __['Are you sure you want to remove your profile picture?'];
        }
        confirm(_title, _message, function() {
            $.post(api['users/image'], {'handle': handle, 'id': id}, function(response) {
                /* check the response */
                if(response.callback) {
                    eval(response.callback);
                } else {
                    if(remove == 'cover') {
                        /* remove (user|page|group) cover */
                        wrapper.addClass('no-cover').attr('style', '');
                    } else {
                        /* update (user|page|group) picture with default picture */
                        $('.profile-avatar-wrapper img').attr("src", response.file);
                    }
                    $('#modal').modal('hide');
                }
            }, 'json')
            .fail(function() {
                modal('#modal-message', {title: __['Error'], message: __['There is some thing went worng!']});
            });
        });
    });


    // run x-image remover
    $('body').on('click', '.js_x-image-remover', function() {
        var _this = $(this);
        var parent = _this.parents('.x-image');
        confirm(__['Delete'], __['Are you sure you want to delete this?'], function() {
            /* remove x-image image */
            parent.attr('style', '');
            /* add the image to input */
            parent.find('.js_x-image-input').val('');
            /* hide the remover */
            _this.hide();
            /* hide the confimation */
            $('#modal').modal('hide');
        });
    });

    
    // run see-more
    $('body').on('click', '.js_see-more', function () {
        see_more($(this));
    });
    $('.js_see-more-infinite').bind('inview', function (event, visible) {
        if(visible == true) {
            see_more($(this));
        }
    });
    $('body').on('click', '.js_see-more-text', function () {
        $(this).next('span').show();
        $(this).remove();
    });


    // run user-popover
    $('body').on('mouseenter', '.js_user-popover', function() {
        /* do not run if window size < 768px */
        if($(window).width() < 751) {
            return;
        }
        var _this = $(this);
        var uid = _this.attr('data-uid');
        var type = _this.attr('data-type') || 'user';
        var _timeout = setTimeout(function() {
            var offset = _this.offset();
            var posY = (offset.top - $(window).scrollTop()) + _this.height();
            var posX = offset.left - $(window).scrollLeft();
            if($('html').attr('dir') == "RTL") {
                var available =  posX + _this.width();
                if(available < 400) {
                    $('body').append('<div class="user-popover-wrapper tl" style="position: fixed; top: '+posY+'px; left:'+posX+'px"><div class="user-popover-content ptb10 plr10"><div class="loader loader_small"></div></div></div>');
                } else {
                    var right = $(window).width() - available;
                    $('body').append('<div class="user-popover-wrapper tr" style="position: fixed; top: '+posY+'px; right:'+right+'px"><div class="user-popover-content ptb10 plr10"><div class="loader loader_small"></div></div></div>');
                }
            } else {
                var available = $(window).width() - posX;
                if(available < 400) {
                    var right = available - _this.width();
                    $('body').append('<div class="user-popover-wrapper tl" style="position: fixed; top: '+posY+'px; right:'+right+'px"><div class="user-popover-content ptb10 plr10"><div class="loader loader_small"></div></div></div>');
                } else {
                    $('body').append('<div class="user-popover-wrapper tr" style="position: fixed; top: '+posY+'px; left:'+posX+'px"><div class="user-popover-content ptb10 plr10"><div class="loader loader_small"></div></div></div>');
                }
            }
            $.getJSON(api['users/popover'], {'type': type, 'uid': uid} , function(response) {
                if(response.callback) {
                    eval(response.callback);
                } else {
                    if(response.popover) {
                        $('.user-popover-wrapper').html(response.popover);
                    }
                }
            });
        }, 1000);
        _this.data('timeout', _timeout);
    });
    $('body').on('mouseleave', '.js_user-popover', function(e) {
        var to = e.toElement || e.relatedTarget;
        if(!$(to).is(".user-popover-wrapper")) {
            clearTimeout($(this).data('timeout'));
            $('.user-popover-wrapper').remove();
        }
    });
    $('body').on('mouseleave', '.user-popover-wrapper', function() {
        $('.user-popover-wrapper').remove();
    });


    // run autocomplete
    /* focus the input */
    $('body').on('click', '.js_autocomplete', function() {
        var input = $(this).find('input').focus();
    });
    /* show and get the results if any */
    $('body').on('keyup', '.js_autocomplete input', function() {
        var _this = $(this);
        var query = _this.val();
        var parent = _this.parents('.js_autocomplete');
        /* change the width of typehead input */
        prev_length = _this.data('length') || 0;
        new_length = query.length;
        if(new_length > prev_length && _this.width() < 250) {
            _this.width(_this.width()+6);
        } else if(new_length < prev_length) {
            _this.width(_this.width()-6);
        }
        _this.data('length', query.length);
        /* check maximum number of tags */
        if(parent.find('ul.tags li').length > 9) {
            return;
        }
        /* check the query string */
        if(query != '') {
            /* check if results dropdown-menu not exist */
            if(_this.next('.dropdown-menu').length == 0) {
                /* construct a new one */
                var offset = _this.offset();
                var posX = offset.left - $(window).scrollLeft();
                if($(window).width() - posX < 180) {
                    _this.after('<div class="dropdown-menu auto-complete tl"></div>');
                } else {
                    _this.after('<div class="dropdown-menu auto-complete"></div>');
                }
            }
            /* get skipped ids */
            var skipped_ids = [];
            $.each(parent.find('ul.tags li'), function(i,tag) {
                skipped_ids.push($(tag).attr('data-uid'));
            });
            $.post(api['users/autocomplete'], {'query': query, 'skipped_ids': JSON.stringify(skipped_ids)}, function(response) {
                if(response.callback) {
                    eval(response.callback);
                } else if(response.autocomplete) {
                    _this.next('.dropdown-menu').show().html(response.autocomplete);
                }
            }, 'json');
        } else {
            /* check if results dropdown-menu already exist */
            if(_this.next('.dropdown-menu').length > 0) {
                _this.next('.dropdown-menu').hide();
            }
        }
    });
    /* show previous results dropdown-menu when the input is clicked */
    $('body').on('click focus', '.js_autocomplete input', function() {
        /* check maximum number of tags */
        if($(this).parents('.js_autocomplete').find('ul.tags li').length > 9) {
            return;
        }
        /* only show again if the input & dropdown-menu are not empty */
        if($(this).val() != '' && $(this).next('.dropdown-menu').find('li').length > 0) {
            $(this).next('.dropdown-menu').show();
        }
    });
    /* hide the results dropdown-menu when clicked outside the input */
    $('body').on('click', function(e) {
        if(!$(e.target).is(".js_autocomplete")) {
            $('.js_autocomplete .dropdown-menu').hide();
        }
    });
    /* add a tag */
    $('body').on('click', '.js_tag-add', function() {
        var uid = $(this).attr('data-uid');
        var name = $(this).attr('data-name');
        var parent = $(this).parents('.js_autocomplete');
        var tag = '<li data-uid="'+uid+'">'+name+'<button type="button" class="close js_tag-remove" title="'+__['Remove']+'"><span>&times;</span></button></li>'
        parent.find('.tags').append(tag);
        parent.find('input').val('').focus();
        /* check if there is chat-form next to js_autocomplete */
        if(parent.siblings('.chat-form').length > 0) {
            if(parent.find('ul.tags li').length == 0) {
                if(!parent.siblings('.chat-form').hasClass('x-visible')) {
                    parent.siblings('.chat-form').addClass('x-visible');
                }
            } else {
                parent.siblings('.chat-form').removeClass('x-visible');
            }
        }
    });
    /* remove a tag */
    $('body').on('click', '.js_tag-remove', function() {
        var tag = $(this).parents('li');
        var parent = $(this).parents('.js_autocomplete');
        tag.remove();
        /* check if there is chat-form next to js_autocomplete */
        if(parent.siblings('.chat-form').length > 0) {
            if(parent.find('ul.tags li').length == 0) {
                if(!parent.siblings('.chat-form').hasClass('x-visible')) {
                    parent.siblings('.chat-form').addClass('x-visible');
                }
            } else {
                parent.siblings('.chat-form').removeClass('x-visible');
            }
        }
        return false;
    });


    // run @mention
    $('body').on('keyup', '.js_mention', function() {
        var _this = $(this);
        var raw_query = _this.val().match(/@(\w+)/ig);
        if(raw_query !== null && raw_query.length > 0) {
            var query = raw_query[0].replace("@", "");
            /* check if results dropdown-menu already exist */
            if(_this.next('.dropdown-menu').length == 0) {
                /* construct a new one */
                var offset = _this.offset();
                var posX = offset.left - $(window).scrollLeft();
                if($(window).width() - posX < 180) {
                    _this.after('<div class="dropdown-menu auto-complete tl"><div class="loader loader_small ptb10"></div></div>');
                } else {
                    _this.after('<div class="dropdown-menu auto-complete"><div class="loader loader_small ptb10"></div></div>');
                }
            }
            $.post(api['users/mention'], {'query': query}, function(response) {
                if(response.callback) {
                    eval(response.callback);
                } else if(response.mention) {
                    _this.next('.dropdown-menu').show().html(response.mention);
                }
            }, 'json');
        } else {
            /* check if results dropdown-menu already exist */
            if(_this.next('.dropdown-menu').length > 0) {
                _this.next('.dropdown-menu').hide();
            }
        }
    });
    /* show previous results dropdown-menu when the input is clicked */
    $('body').on('click focus', '.js_mention', function() {
        var query = $(this).val().match(/@(\w+)/ig);
        if(query !== null && query.length > 0) {
            $(this).next('.dropdown-menu').show();
        }
    });
    /* hide the results dropdown-menu when clicked outside the input */
    $('body').on('click', function(e) {
        if(!$(e.target).is(".js_mention")) {
            $('.js_mention').next('.dropdown-menu').hide();
        }
    });
    /* add a mention */
    $('body').on('click', '.js_mention-add', function() {
        var textarea = $(this).parents('.dropdown-menu').prev('textarea.js_mention');
        var username = $(this).attr('data-username');
        textarea.val(textarea.val().replace(/@(\w+)/ig,"")+'['+username+'] ').focus();
    });


    // run connect
    /* friend-request */
    $('body').on('click', '.js_friend-accept, .js_friend-decline', function () {
        var id = $(this).attr('data-uid');
        var parent = $(this).parent();
        var accept = parent.find('.js_friend-accept');
        var decline = parent.find('.js_friend-decline');
        var _do = ($(this).hasClass('js_friend-accept'))? 'friend-accept' : 'friend-decline';
        /* hide buttons & show loader */
        accept.hide();
        decline.hide();
        parent.append('<div class="loader loader_medium pr10"></div>');
        /* post the request */
        $.post(api['users/connect'], {'do': _do, 'id': id} , function(response) {
            if(response.callback) {
                parent.find('.loader').remove();
                accept.show();
                decline.show();
                eval(response.callback);
            } else {
                parent.find('.loader').remove();
                accept.remove();
                decline.remove();
                if(_do == 'friend-accept') {
                    parent.append('<div class="btn btn-default btn-friends js_friend-remove" data-uid="'+id+'"><i class="fa fa-check"></i> '+__["Friends"]+'</div>');
                }
            }
        }, "json")
        .fail(function() {
            parent.find('.loader').remove();
            accept.show();
            decline.show();
            modal('#modal-message', {title: __['Error'], message: __['There is some thing went worng!']});
        });
    });
    /* friend & unfriend */
    $('body').on('click', '.js_friend-add, .js_friend-cancel, .js_friend-remove', function () {
        var _this = $(this);
        var id = _this.attr('data-uid');
        if(_this.hasClass('js_friend-add')) {
            var _do = 'friend-add';
        } else if (_this.hasClass('js_friend-cancel')) {
            var _do = 'friend-cancel';
        } else {
            var _do = 'friend-remove';
        }
        /* hide button & show loader || loading state */
        if(_this.parents('.data-content').length > 0) {
            _this.hide();
            _this.after('<div class="loader loader_medium pr10"></div>');
        } else {
            _this.button('loading');
        }
        /* post the request */
        $.post(api['users/connect'], {'do': _do, 'id': id} , function(response) {
            if(response.callback) {
                _this.next('.loader').remove();
                _this.show();
                _this.button('reset');
                eval(response.callback);
            } else {
                _this.next('.loader').remove();
                if(_do == 'friend-add') {
                    _this.after('<div class="btn btn-default js_friend-cancel" data-uid="'+id+'"><i class="fa fa-user-plus"></i> '+__["Friend Request Sent"]+'</div>');
                } else {
                    _this.after('<div class="btn btn-success js_friend-add" data-uid="'+id+'"><i class="fa fa-user-plus"></i> '+__["Add Friend"]+'</div>');
                }
                _this.remove();
            }
        }, "json")
        .fail(function() {
            _this.next('.loader').remove();
            _this.show();
            _this.button('reset');
            modal('#modal-message', {title: __['Error'], message: __['There is some thing went worng!']});
        });
    });
    /* follow & unfollow */
    $('body').on('click', '.js_follow, .js_unfollow', function () {
        var _this = $(this);
        var id = _this.attr('data-uid');
        var _do = (_this.hasClass('js_follow'))? 'follow' : 'unfollow';
        /* show loading */
        _this.button('loading');
        /* post the request */
        $.post(api['users/connect'], {'do': _do, 'id': id} , function(response) {
            if(response.callback) {
                _this.button('reset');
                eval(response.callback);
            } else {
                if(_do == 'follow') {
                    _this.replaceWith('<button type="button" class="btn btn-default js_unfollow" data-uid="'+id+'"><i class="fa fa-check"></i> '+__['Following']+'</button>');
                } else {
                    _this.replaceWith('<button type="button" class="btn btn-default js_follow" data-uid="'+id+'"><i class="fa fa-rss"></i> '+__['Follow']+'</button>');
                }
            }
        }, "json")
        .fail(function() {
            _this.button('reset');
            modal('#modal-message', {title: __['Error'], message: __['There is some thing went worng!']});
        });
    });
    /* block user */
    $('body').on('click', '.js_block-user', function (e) {
        e.preventDefault();
        var id = $(this).attr('data-uid');
        confirm(__['Block User'], __['Are you sure you want to block this user?'], function() {
            $.post(api['users/connect'], {'do': 'block', 'id': id} , function(response) {
                /* check the response */
                if(response.callback) {
                    eval(response.callback);
                } else {
                    window.location = site_path;
                }
            }, 'json')
            .fail(function() {
                modal('#modal-message', {title: __['Error'], message: __['There is some thing went worng!']});
            });
        });
    });
    /* unblock user */
    $('body').on('click', '.js_unblock-user', function (e) {
        e.preventDefault();
        var id = $(this).attr('data-uid');
        confirm(__['Unblock User'], __['Are you sure you want to unblock this user?'], function() {
            $.post(api['users/connect'], {'do': 'unblock', 'id': id} , function(response) {
                /* check the response */
                if(response.callback) {
                    eval(response.callback);
                } else {
                    window.location.reload();
                }
            }, 'json')
            .fail(function() {
                modal('#modal-message', {title: __['Error'], message: __['There is some thing went worng!']});
            });
        });
    });
    /* report user */
    $('body').on('click', '.js_report-user', function (e) {
        e.preventDefault();
        var id = $(this).attr('data-uid');
        confirm(__['Report User'], __['Are you sure you want to report this user?'], function() {
            $.post(api['data/report'], {'do': 'report_user', 'id': id}, function(response) {
                /* check the response */
                if(response.callback) {
                    eval(response.callback);
                }
            }, 'json')
            .fail(function() {
                modal('#modal-message', {title: __['Error'], message: __['There is some thing went worng!']});
            });
        });
    });
    /* delete user */
    $('body').on('click', '.js_delete-user', function (e) {
        e.preventDefault();
        var id = $(this).attr('data-uid');
        confirm(__['Delete'], __['Are you sure you want to delete your account?'], function() {
            $.post(api['users/delete'], {'do': 'block', 'id': id} , function(response) {
                /* check the response */
                if(response.callback) {
                    eval(response.callback);
                } else {
                    window.location = site_path;
                }
            }, 'json')
            .fail(function() {
                modal('#modal-message', {title: __['Error'], message: __['There is some thing went worng!']});
            });
        });
    });
    /* like & unlike page */
    $('body').on('click', '.js_like-page, .js_unlike-page', function () {
        var _this = $(this);
        var id = _this.attr('data-id');
        var _do = (_this.hasClass('js_like-page'))? 'like' : 'unlike';
        /* show loading */
        _this.button('loading');
        /* post the request */
        $.post(api['users/connect'], {'do': _do, 'id': id} , function(response) {
            if(response.callback) {
                _this.button('reset');
                eval(response.callback);
            } else {
                if(_do == 'like') {
                    _this.replaceWith('<button type="button" class="btn btn-default js_unlike-page" data-id="'+id+'"><i class="fa fa-thumbs-o-up"></i> '+__['Unlike']+'</button>');
                } else {
                    _this.replaceWith('<button type="button" class="btn btn-primary js_like-page" data-id="'+id+'"><i class="fa fa-thumbs-o-up"></i> '+__['Like']+'</button>');
                }
            }
        }, "json")
        .fail(function() {
            _this.button('reset');
            modal('#modal-message', {title: __['Error'], message: __['There is some thing went worng!']});
        });
    });
    /* delete page & delete group */
    $('body').on('click', '.js_delete-page, .js_delete-group', function (e) {
        e.preventDefault();
        var id = $(this).attr('data-id');
        var handle = ($(this).hasClass('js_delete-page'))? 'page' : 'group';
        confirm(__['Delete'], __['Are you sure you want to delete this?'], function() {
            $.post(api['data/delete'], {'handle': handle, 'id': id} , function(response) {
                /* check the response */
                if(response.callback) {
                    eval(response.callback);
                } else {
                    window.location = site_path;
                }
            }, 'json')
            .fail(function() {
                modal('#modal-message', {title: __['Error'], message: __['There is some thing went worng!']});
            });
        });
    });
    /* join & leave page */
    $('body').on('click', '.js_join-group, .js_leave-group', function () {
        var _this = $(this);
        var id = _this.attr('data-id');
        var _do = (_this.hasClass('js_join-group'))? 'join' : 'leave';
        /* show loading */
        _this.button('loading');
        /* post the request */
        $.post(api['users/connect'], {'do': _do, 'id': id} , function(response) {
            if(response.callback) {
                _this.button('reset');
                eval(response.callback);
            } else {
                if(_do == 'join') {
                    _this.replaceWith('<button type="button" class="btn btn-default btn-friends js_leave-group" data-id="'+id+'"><i class="fa fa-check"></i> '+__['Joined']+'</button>');
                } else {
                    _this.replaceWith('<button type="button" class="btn btn-success js_join-group" data-id="'+id+'"><i class="fa fa-user-plus"></i> '+__['Join Group']+'</button>');
                }
            }
        }, "json")
        .fail(function() {
            _this.button('reset');
            modal('#modal-message', {title: __['Error'], message: __['There is some thing went worng!']});
        });
    });
    
    
    
    // run search
    /* show and get the search results */
    $('body').on('keyup', '#search-input', function() {
        var query = $(this).val();
        if(!is_empty(query)) {
            $('#search-results').show();
            var hashtags = query.match(/#(\w+)/ig);
            if(hashtags !== null && hashtags.length > 0) {
                var query = hashtags[0].replace("#", "");
                $('#search-results .dropdown-widget-header').hide();
                $('#search-results-all').hide();
                $('#search-results .dropdown-widget-body').html(render_template('#search-for', {'query': query, 'hashtag': true}));
            } else {
                $.post(api['data/search'], {'query': query}, function(response) {
                    if(response.callback) {
                        eval(response.callback);
                    } else if(response.results) {
                        $('#search-results .dropdown-widget-header').show();
                        $('#search-results-all').show();
                        $('#search-results .dropdown-widget-body').html(response.results);
                        $('#search-results-all').attr('href', site_path+'/search/'+query);
                    } else {
                        $('#search-results .dropdown-widget-header').hide();
                        $('#search-results-all').hide();
                        $('#search-results .dropdown-widget-body').html(render_template('#search-for', {'query': query}));
                    }
                }, 'json');
            }
        }
    });
    /* submit search form */
    $('body').on('keydown', '#search-input', function(event) {
        if(event.keyCode == 13) {
            event.preventDefault;
            var query = $(this).val();
            if(!is_empty(query)) {
                var hashtags = query.match(/#(\w+)/ig);
                if(hashtags !== null && hashtags.length > 0) {
                    var query = hashtags[0].replace("#", "");
                    window.location = site_path+'/search/hashtag/'+query
                } else {
                    window.location = site_path+'/search/'+query
                }
            }
            return false;
        }
    });
    /* show previous search-results when the search-input is clicked */
    $('body').on('click', '#search-input', function() {
        if($(this).val() != '') {
            $('#search-results').show();
        }
    });
    /* hide the search-results when clicked outside search-input */
    $('body').on('click', function(e) {
        if(!$(e.target).is("#search-input")) {
            $('#search-results').hide();
        }
    });
    /* submit search form */
    $('body').on('submit', '.js_search-form', function(e) {
        e.preventDefault;
        var query = this.query.value;
        if(!is_empty(query)) {
            var hashtags = query.match(/#(\w+)/ig);
            if(hashtags !== null && hashtags.length > 0) {
                var query = hashtags[0].replace("#", "");
                window.location = site_path+'/search/hashtag/'+query
            } else {
                window.location = site_path+'/search/'+query
            }
        }
        return false;
    });
    
});