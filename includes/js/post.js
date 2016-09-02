/**
 * post js
 * 
 * @package Marsesweb v2+
 * @author Marwin Silva
 */

// initialize API URLs
api['posts/post']  = ajax_path+"posts/post.php";
api['posts/scraber']  = ajax_path+"posts/scraber.php";
api['posts/lightbox']  = ajax_path+"posts/lightbox.php";
api['posts/comment']  = ajax_path+"posts/comment.php";
api['posts/reaction']  = ajax_path+"posts/reaction.php";


$(function() {

    // run emoji
    /* toggle(close|open) emoji-menu */
    $('body').on('click', '.js_emoji-menu-toggle', function() {
        $(this).next('.emoji-menu').toggle();
    });
    /* close emoji-menu when clicked outside */
    $('body').on('click', function(e) {
        if($(e.target).hasClass('js_emoji-menu-toggle') || $(e.target).parents('.js_emoji-menu-toggle').length > 0 || $(e.target).hasClass('emoji-menu') || $(e.target).parents('.emoji-menu').length > 0) {
           return;
       }
       $('.emoji-menu').hide();
    });
    /* add an emoji */
    $('body').on('click', '.js_emoji', function() {
        var emoji = $(this).attr('data-emoji');
        var textarea = $(this).parents('.x-form').find('textarea');
        /* check if textarea value is empty || end with a space then no prefix space */
        var prefix = ( textarea.val() == "" || /\s+$/.test(textarea.val()) ) ? "": " ";
        textarea.val(textarea.val()+prefix+emoji+" ").focus();
    });


	// run lightbox
    /* open the lightbox */
    $('body').on('click', '.js_lightbox', function(e) {
        e.preventDefault();
        /* initialize vars */
        var id = $(this).attr('data-id');
        var image = $(this).attr('data-image');
        /* load lightbox */
        var lightbox = $(render_template("#lightbox", {'id': id, 'image': image}));
        var next = lightbox.find('.lightbox-next');
        var prev = lightbox.find('.lightbox-prev');
        /* get post header */
        var header = $(this).parents('.post').find('.post-header').html();
        /* change lightbox post header with the one from the post */
        lightbox.find('.post-header').html(header);
        /* remove the x menu from post header */
        lightbox.find('.post-meta .pull-right').remove();
        lightbox.find('.post-title').remove();
        $('body').addClass('lightbox-open').append(lightbox.fadeIn('fast'));
        /* get photo */
        $.post(api['posts/lightbox'], {'id': id}, function(response) {
            /* check the response */
            if(response.callback) {
                $('body').removeClass('lightbox-open');
                $('.lightbox').remove();
                eval(response.callback);
            } else {
                /* update next */
                if(response.next != null) {
                    next.show();
                    next.attr('data-id', response.next.photo_id);
                    next.attr('data-source', response.next.source);
                } else {
                    next.hide();
                    next.attr('data-id', '');
                    next.attr('data-source', '');
                }
                /* update prev */
                if(response.prev != null) {
                    prev.show();
                    prev.attr('data-id', response.prev.photo_id);
                    prev.attr('data-source', response.prev.source);
                } else {
                    prev.hide();
                    prev.attr('data-id', '');
                    prev.attr('data-source', '');
                }
                $('.lightbox').find('.post-actions').replaceWith(response.actions);
                $('.lightbox').find('.post-footer').replaceWith(response.footer);
            }
        }, 'json');
    });
    $('body').on('click', '.js_lightbox-slider', function(e) {
        /* initialize vars */
        var id = $(this).attr('data-id');
        var image = $(this).attr('data-source');
        /* load lightbox */
        var lightbox = $(this).parents('.lightbox');
        var next = lightbox.find('.lightbox-next');
        var prev = lightbox.find('.lightbox-prev');
        /* loading */
        next.hide();
        prev.hide();
        lightbox.find('.post-footer').html('<div class="loader mtb10"></div>');
        lightbox.find('.post-actions').html('');
        lightbox.find('.lightbox-preview img').attr('src', uploads_path + '/' + image);
        /* get photo */
        $.post(api['posts/lightbox'], {'id': id}, function(response) {
            /* check the response */
            if(response.callback) {
                $('body').removeClass('lightbox-open');
                lightbox.remove();
                eval(response.callback);
            } else {
                /* update lightbox-post id */
                lightbox.find('.lightbox-post').attr('data-id', id);
                /* update next */
                if(response.next != null) {
                    next.show();
                    next.attr('data-id', response.next.photo_id);
                    next.attr('data-source', response.next.source);
                } else {
                    next.hide();
                    next.attr('data-id', '');
                    next.attr('data-source', '');
                }
                /* update prev */
                if(response.prev != null) {
                    prev.show();
                    prev.attr('data-id', response.prev.photo_id);
                    prev.attr('data-source', response.prev.source);
                } else {
                    prev.hide();
                    prev.attr('data-id', '');
                    prev.attr('data-source', '');
                }
                lightbox.find('.post-actions').replaceWith(response.actions);
                lightbox.find('.post-footer').replaceWith(response.footer);
            }
        }, 'json');
    });
	/* open the lightbox with no data */
	$('body').on('click', '.js_lightbox-nodata', function(e) {
        e.preventDefault();
        /* initialize vars */
        var image = $(this).attr('data-image');
        /* load lightbox */
        var lightbox = $(render_template("#lightbox-nodata", {'image': image}));
        $('body').addClass('lightbox-open').append(lightbox.fadeIn('fast'));
    });
    /* close the lightbox (when click outside the lightbox content) */
    $('body').on('click', '.lightbox', function(e) {
        if($(e.target).is(".lightbox")) {
            $('body').removeClass('lightbox-open');
            $('.lightbox').remove();
        }
    });
    /* close the lightbox (when click the close button) */
    $('body').on('click', '.js_lightbox-close', function() {
        $('body').removeClass('lightbox-open');
        $('.lightbox').remove();
    });
    /* close the lightbox (when press Esc button) */
    $('body').on('keydown', function(e) {
        if(e.keyCode === 27 && $('.lightbox').length > 0) {
            destroy_slimScrol('.js_scroller-lightbox');
            $('body').removeClass('lightbox-open');
            $('.lightbox').remove();
        }
    });


	// run publisher
    /* toggle publisher-meta */
    $('body').on('click', '.js_publisher_meta', function() {
        $(this).toggleClass('active');
        $('.publisher-meta').slideToggle('fast');
        $('.publisher-meta').find('input').focus();
    });
    /* toggle activated publisher-meta */
    $('body').on('keyup', '.publisher-meta input', function() {
        if($(this).val() == '') {
            $('.js_publisher_meta').removeClass('activated');
        } else {
            $('.js_publisher_meta').addClass('activated');
        }
    });
    /* publisher scraber */
    $('body').on('keyup', '.js_publisher-scraber', function() {
        var publisher = $('.publisher');
        var uploader = $('.publisher-tools-attach');
        var loader = $('.publisher-loader');
        /* check if there is current (uploading|scrabing|video) process */
        if(publisher.data('uploading') || publisher.data('scrabing') || publisher.data('video')) {
        	return;
        }
        var raw_query = $(this).val().match(/(https?:\/\/[^\s]+)/gi);
        if(raw_query === null || raw_query.length == 0) {
        	return;
        }
        var query = raw_query[0];
        /* show the loader */
        loader.show();
        /* scrabe the link */
        $.post(api['posts/scraber'], {'query': query}, function(response) {
            if(response.callback) {
            	/* hide the loader */
            	loader.hide();
                eval(response.callback);
            } else if(response.link) {
            	/* hide the loader */
            	loader.hide();
            	/* add the link to publisher data */
            	publisher.data('scrabing', response.link);
            	/* hide the publisher uploader */
            	uploader.hide();
            	/* get the template */
            	if(response.link['media_type'] == "youtube") {
            		/* youtube */
            		var template = render_template('#scraber-youtube', {'uid': response.link['source_uid'], 'url': response.link['source_url'], 'title': response.link['source_title'], 'text': response.link['source_text'] });
            	} else if (response.link['media_type'] == "vimeo") {
            		/* vimeo */
            		var template = render_template('#scraber-vimeo', {'uid': response.link['source_uid'], 'url': response.link['source_url'], 'title': response.link['source_title'], 'text': response.link['source_text'] });
            	} else if (response.link['media_type'] == "soundcloud") {
            		/* soundcloud */
            		var template = render_template('#scraber-soundcloud', {'uid': response.link['source_uid'], 'url': response.link['source_url'], 'title': response.link['source_title'], 'text': response.link['source_text'] });
            	} else {
            		/* link */
            		var template = render_template('#scraber-link', {'thumbnail': response.link['source_thumbnail'], 'host': response.link['source_host'], 'url': response.link['source_url'], 'title': response.link['source_title'], 'text': response.link['source_text'] });
            	}
            	/* show the publisher scraber */
            	$('.publisher-scraber').html(template).fadeIn();
            }
        }, 'json');
    });
	/* publisher scraber remover */
	$('body').on('click', '.js_publisher-scraber-remover', function() {
		/* remove the link from publisher data */
		$('.publisher').removeData('scrabing');
		/* hide the publisher scraber */
		$('.publisher-scraber').html('').fadeOut();
		/* show the publisher uploader */
		$('.publisher-tools-attach').show();
    });
    /* publisher attachment remover */
    $('body').on('click', '.js_publisher-attachment-remover', function() {
    	var item = $(this).parents('li.item');
    	var src = item.attr('data-src');
        /* remove the attachment from publisher data */
        var files = $('.publisher').data('uploading');
        delete files[src];
        if(files.length > 0) {
        	$('.publisher').data('uploading', files);
        } else {
        	$('.publisher').removeData('uploading');
        	$('.publisher-attachments').hide();
        }
        /* remove the attachment item */
        item.remove();
    });
    /* publish the post */
    $('body').on('click', '.js_publisher', function() {
    	var _this = $(this);
        var publisher = _this.parents('.publisher');
        /* get handle */
        var handle = publisher.attr('data-handle');
        /* get (page|group) id */
        var id = publisher.attr('data-id');
        /* get text */
        var textarea = publisher.find('textarea');
        /* get location */
        var meta = publisher.find('.publisher-meta')
        var location = meta.find('input');
        /* get photos */
        var attachments = publisher.find('.publisher-attachments');
        var photos = publisher.data('uploading');
        /* get video */
        var attachments_video = publisher.find('.publisher-video');
        var video = publisher.data('video');
        /* get link */
        var link = publisher.data('scrabing');
        /* get privacy */
        var privacy = publisher.find('.btn-group').attr('data-value');
        /* return if no data to post */
        if(textarea.val() == "" && photos === undefined && video === undefined && link === undefined) {
            return;
        }
        _this.button('loading');
        $.post(api['posts/post'], {'handle': handle, 'id': id, 'message': textarea.val(), 'photos': JSON.stringify(photos), 'video': JSON.stringify(video), 'link': JSON.stringify(link), 'location':location.val(), 'privacy': privacy}, function(response) {
            if(response.callback) {
                _this.button('reset');
                eval(response.callback);
            } else {
            	_this.button('reset');
            	textarea.val('');
            	location.val('');
            	meta.hide();
            	$('.js_publisher_meta').removeClass('activated active');
            	attachments.hide();
            	attachments.find('li.item').remove();
            	publisher.removeData('uploading');
                attachments_video.hide();
                publisher.removeData('video');
            	$('.publisher-scraber').html('').fadeOut();
            	publisher.removeData('scrabing');
            	$('.publisher-tools-attach').show();
            	$('.js_posts_stream').prepend(response.post);
                photo_grid();
            }
        }, "json")
        .fail(function() {
            _this.button('reset');
            modal('#modal-message', {title: __['Error'], message: __['There is some thing went worng!']});
        });
    });

	
	// handle comment
	/* show comment form */
	$('body').on('click', '.js_comment', function () {
		var footer = $(this).parents('.post, .lightbox-post').find('.post-footer');
		footer.show();
		footer.find('textarea').focus();
	});
	/* comment attachment remover */
    $('body').on('click', '.js_comment-attachment-remover', function() {
    	var comment = $(this).parents('.comment');
    	var attachments = comment.find('.comment-attachments');
    	var item = $(this).parents('li.item');
    	/* remove the attachment from comment data */
        comment.removeData('uploading');
    	/* remove the attachment item */
        item.remove();
        /* hide attachments */
        attachments.hide();
        /* show comment form tools */
        comment.find('.x-form-tools-attach').show();
    });
	/* post comment */
	$('body').on('keydown', '.js_post-comment', function (event) {
		if(event.keyCode == 13 && event.shiftKey == 0) {
			event.preventDefault();
			var _this = $(this);
            var comment = _this.parents('.comment');
			var comments = _this.parents('.post-comments');
			var handle = comment.attr('data-handle');
			var id = comment.attr('data-id');
            var message = _this.val();
            var attachments = comment.find('.comment-attachments');
            /* get photo from comment data */
	        var photo = comment.data('uploading');
            /* check if message is empty */
            if(is_empty(message) && !photo) {
                return;
            }
            $.post(api['posts/comment'], {'handle': handle, 'id': id, 'message': message, 'photo': JSON.stringify(photo)}, function(response) {
                /* check if there is a callback */
                if(response.callback) {
                    eval(response.callback);
                } else {
                	_this.val('');
                	attachments.hide();
                	attachments.find('li.item').remove();
                	comment.removeData('uploading');
                	comment.find('.x-form-tools').show();
                	comments.find('ul').append(response.comment);
                }
            }, 'json')
            .fail(function() {
                modal('#modal-message', {title: __['Error'], message: __['There is some thing went worng!']});
            });
		}
	});
    /* delete comment */
    $('body').on('click', '.js_delete-comment', function () {
        var comment = $(this).parents('.comment');
        var id = comment.attr('data-id');
        confirm(__['Delete Comment'], __['Are you sure you want to delete this comment?'], function() {
            $.post(api['posts/reaction'], {'do': 'delete_comment', 'id': id}, function(response) {
                /* check the response */
                if(response.callback) {
                    eval(response.callback);
                } else {
                    comment.remove();
                    $('#modal').modal('hide');
                }
            }, 'json')
            .fail(function() {
                modal('#modal-message', {title: __['Error'], message: __['There is some thing went worng!']});
            });
        });
    });
    /* report comment */
    $('body').on('click', '.js_report-comment', function () {
        var comment = $(this).parents('.comment');
        var id = comment.attr('data-id');
        $.post(api['data/report'], {'do': 'report_comment', 'id': id}, function(response) {
            /* check the response */
            if(response.callback) {
                eval(response.callback);
            } else {
                comment.hide();
                comment.after(render_template("#reported-comment", {'id': id}));
            }
        }, 'json')
        .fail(function() {
            modal('#modal-message', {title: __['Error'], message: __['There is some thing went worng!']});
        });
    });
    /* unreport comment */
    $('body').on('click', '.js_unreport-comment', function () {
        var comment = $(this).parents('.comment');
        var id = comment.attr('data-id');
        $.post(api['data/report'], {'do': 'unreport_comment', 'id': id}, function(response) {
            /* check the response */
            if(response.callback) {
                eval(response.callback);
            } else {
                comment.prev().show();
                comment.remove();
            }
        }, 'json')
        .fail(function() {
            modal('#modal-message', {title: __['Error'], message: __['There is some thing went worng!']});
        });
    });
    /* like comment */
    $('body').on('click', '.js_like-comment', function () {
        var _this = $(this);
        var comment = _this.parents('.comment');
        var id = comment.attr('data-id');
        $.post(api['posts/reaction'], {'do': 'like_comment', 'id': id}, function(response) {
            /* check the response */
            if(response.callback) {
                eval(response.callback);
            } else {
                _this.removeClass('js_like-comment').addClass('js_unlike-comment').text(__['Unlike']);
                var likes_num = comment.find('.js_comment-likes-num');
                likes_num.text(parseInt(likes_num.text()) + 1);
                comment.find('.js_comment-likes').show();
            }
        }, 'json')
        .fail(function() {
            modal('#modal-message', {title: __['Error'], message: __['There is some thing went worng!']});
        });
    });
    /* unlike comment */
    $('body').on('click', '.js_unlike-comment', function () {
        var _this = $(this);
        var comment = _this.parents('.comment');
        var id = comment.attr('data-id');
        $.post(api['posts/reaction'], {'do': 'unlike_comment', 'id': id}, function(response) {
            /* check the response */
            if(response.callback) {
                eval(response.callback);
            } else {
                _this.removeClass('js_unlike-comment').addClass('js_like-comment').text(__['Like']);
                var likes_num = comment.find('.js_comment-likes-num');
                likes_num.text(parseInt(likes_num.text()) - 1);
                if(parseInt(likes_num.text()) < 1) {
                    comment.find('.js_comment-likes').hide();
                }
            }
        }, 'json')
        .fail(function() {
            modal('#modal-message', {title: __['Error'], message: __['There is some thing went worng!']});
        });
    });


    // handle post
    /* toggle post-footer */
    $('body').on('click', '.post-stats-alt', function () {
        $(this).parents('.post').find('.post-footer').toggle();
    });
    /* delete post */
    $('body').on('click', '.js_delete-post', function () {
        var post = $(this).parents('.post');
        var id = post.attr('data-id');
        confirm(__['Delete Post'], __['Are you sure you want to delete this post?'], function() {
            $.post(api['posts/reaction'], {'do': 'delete_post', 'id': id}, function(response) {
                /* check the response */
                if(response.callback) {
                    eval(response.callback);
                } else {
                    post.remove();
                    $('#modal').modal('hide');
                }
            }, 'json')
            .fail(function() {
                modal('#modal-message', {title: __['Error'], message: __['There is some thing went worng!']});
            });
        });
    });
    /* hide post */
    $('body').on('click', '.js_hide-post', function (e) {
        e.preventDefault();
        var post = $(this).parents('.post');
        var id = post.attr('data-id');
        $.post(api['posts/reaction'], {'do': 'hide_post', 'id': id}, function(response) {
            /* check the response */
            if(response.callback) {
                eval(response.callback);
            } else {
                post.hide();
                post.after(render_template("#hidden-post", {'id': id}));
            }
        }, 'json')
        .fail(function() {
            modal('#modal-message', {title: __['Error'], message: __['There is some thing went worng!']});
        });
    });
    /* unhide post */
    $('body').on('click', '.js_unhide-post', function (e) {
        e.preventDefault();
        var post = $(this).parents('.post');
        var id = post.attr('data-id');
        $.post(api['posts/reaction'], {'do': 'unhide_post', 'id': id}, function(response) {
            /* check the response */
            if(response.callback) {
                eval(response.callback);
            } else {
                post.prev().show();
                post.remove();
            }
        }, 'json')
        .fail(function() {
            modal('#modal-message', {title: __['Error'], message: __['There is some thing went worng!']});
        });
    });
    /* hide author */
    $('body').on('click', '.js_hide-author', function (e) {
        e.preventDefault();
        var post = $(this).parents('.post');
        var author_id = $(this).attr('data-author-id');
        var author_name = $(this).attr('data-author-name');
        var id = post.attr('data-id');
        $.post(api['users/connect'], {'do': 'unfollow', 'id': author_id} , function(response) {
            if(response.callback) {
                eval(response.callback);
            } else {
                post.hide();
                post.after(render_template("#hidden-author", {'id': id, 'name': author_name, 'uid': author_id}));
            }
        }, "json")
        .fail(function() {
            modal('#modal-message', {title: __['Error'], message: __['There is some thing went worng!']});
        });
    });
    /* unhide author */
    $('body').on('click', '.js_unhide-author', function (e) {
        e.preventDefault();
        var post = $(this).parents('.post');
        var author_id = $(this).attr('data-author-id');
        var author_name = $(this).attr('data-author-name');
        var id = post.attr('data-id');
        $.post(api['users/connect'], {'do': 'follow', 'id': author_id} , function(response) {
            if(response.callback) {
                eval(response.callback);
            } else {
                post.prev().show();
                post.remove();
            }
        }, "json")
        .fail(function() {
            modal('#modal-message', {title: __['Error'], message: __['There is some thing went worng!']});
        });
    });
    /* report post */
    $('body').on('click', '.js_report-post', function (e) {
        e.preventDefault();
        var post = $(this).parents('.post');
        var id = post.attr('data-id');
        $.post(api['data/report'], {'do': 'report_post', 'id': id}, function(response) {
            /* check the response */
            if(response.callback) {
                eval(response.callback);
            } else {
                post.hide();
                post.after(render_template("#reported-post", {'id': id}));
            }
        }, 'json')
        .fail(function() {
            modal('#modal-message', {title: __['Error'], message: __['There is some thing went worng!']});
        });
    });
    /* unreport post */
    $('body').on('click', '.js_unreport-post', function (e) {
        e.preventDefault();
        var post = $(this).parents('.post');
        var id = post.attr('data-id');
        $.post(api['data/report'], {'do': 'unreport_post', 'id': id}, function(response) {
            /* check the response */
            if(response.callback) {
                eval(response.callback);
            } else {
                post.prev().show();
                post.remove();
            }
        }, 'json')
        .fail(function() {
            modal('#modal-message', {title: __['Error'], message: __['There is some thing went worng!']});
        });
    });
    /* share post */
    $('body').on('click', '.js_share', function () {
        var post = $(this).parents('.post');
        var id = post.attr('data-id');
        confirm(__['Share Post'], __['Are you sure you want to share this post?'], function() {
            $.post(api['posts/reaction'], {'do': 'share', 'id': id}, function(response) {
                /* check the response */
                if(response.callback) {
                    eval(response.callback);
                } else {

                    modal('#modal-success', {title: __['Success'], message: __['This has been shared to your Timeline']});
                }
            }, 'json')
            .fail(function() {
                modal('#modal-message', {title: __['Error'], message: __['There is some thing went worng!']});
            });
        });
    });
	/* like post */
	$('body').on('click', '.js_like-post', function () {
        var _this = $(this);
        var post = _this.parents('.post');
        var id = post.attr('data-id');
        $.post(api['posts/reaction'], {'do': 'like_post', 'id': id}, function(response) {
            /* check the response */
            if(response.callback) {
                eval(response.callback);
            } else {
                _this.removeClass('js_like-post').addClass('js_unlike-post').text(__['Unlike']);
                post.find('.js_post-likes-num').each(function() {
                    $(this).text(parseInt($(this).text()) + 1);
                })
                post.find('.post-footer, .post-stats, .js_post-likes').show();
            }
        }, 'json')
        .fail(function() {
            modal('#modal-message', {title: __['Error'], message: __['There is some thing went worng!']});
        });
	});
    /* unlike post */
    $('body').on('click', '.js_unlike-post', function () {
        var _this = $(this);
        var post = _this.parents('.post');
        var id = post.attr('data-id');
        $.post(api['posts/reaction'], {'do': 'unlike_post', 'id': id}, function(response) {
            /* check the response */
            if(response.callback) {
                eval(response.callback);
            } else {
                _this.removeClass('js_unlike-post').addClass('js_like-post').text(__['Like']);
                post.find('.js_post-likes-num').each(function() {
                    $(this).text(parseInt($(this).text()) - 1);
                });
                if(parseInt(post.find('.js_post-likes-num:first').text()) == 0) {
                    post.find('.js_post-likes').hide();
                    if(post.find('.js_post-shares:hidden')) {
                        post.find('.post-stats').hide();
                    }
                }
            }
        }, 'json')
        .fail(function() {
            modal('#modal-message', {title: __['Error'], message: __['There is some thing went worng!']});
        });
    });
    /* like photo */
    $('body').on('click', '.js_like-photo', function () {
        var _this = $(this);
        var photo = _this.parents('.post, .lightbox-post');
        var id = photo.attr('data-id');
        $.post(api['posts/reaction'], {'do': 'like_photo', 'id': id}, function(response) {
            /* check the response */
            if(response.callback) {
                eval(response.callback);
            } else {
                _this.removeClass('js_like-photo').addClass('js_unlike-photo').text(__['Unlike']);
                photo.find('.js_photo-likes-num').each(function() {
                    $(this).text(parseInt($(this).text()) + 1);
                })
                photo.find('.post-footer, .post-stats, .js_photo-likes').show();
            }
        }, 'json')
        .fail(function() {
            modal('#modal-message', {title: __['Error'], message: __['There is some thing went worng!']});
        });
    });
    /* unlike photo */
    $('body').on('click', '.js_unlike-photo', function () {
        var _this = $(this);
        var photo = _this.parents('.post, .lightbox-post');
        var id = photo.attr('data-id');
        $.post(api['posts/reaction'], {'do': 'unlike_photo', 'id': id}, function(response) {
            /* check the response */
            if(response.callback) {
                eval(response.callback);
            } else {
                _this.removeClass('js_unlike-photo').addClass('js_like-photo').text(__['Like']);
                photo.find('.js_photo-likes-num').each(function() {
                    $(this).text(parseInt($(this).text()) - 1);
                });
                if(parseInt(photo.find('.js_photo-likes-num').text()) == 0) {
                    photo.find('.js_photo-likes').hide();
                    photo.find('.post-stats').hide();
                }
            }
        }, 'json')
        .fail(function() {
            modal('#modal-message', {title: __['Error'], message: __['There is some thing went worng!']});
        });
    });
    /* show shared post attachments */
    $('body').on('click', '.js_show-attachments', function () {
        $(this).next().toggle();
    });
    
});