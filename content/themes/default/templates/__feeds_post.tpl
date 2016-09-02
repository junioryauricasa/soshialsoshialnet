{if !$single}<li>{/if}
    <!-- post -->
    <div class="post" data-id="{$post['post_id']}">

        <!-- post body -->
        <div class="post-body">
            <!-- post header -->
            <div class="post-header">
                <!-- post picture -->
                <div class="post-avatar">
                    <a class="post-avatar-picture" href="{$post['post_author_url']}" style="background-image:url({$post['post_picture']});">
                    </a>
                </div>
                <!-- post picture -->

                <!-- post meta -->
                <div class="post-meta">
                    <!-- post author name & menu -->
                    <div>
                        {if $user->_logged_in}
                            <!-- post menu -->
                            {if $post['user_type'] == "user"}
                                {if $post['user_id'] == $user->_data['user_id'] || ($post['in_group'] && $post['group_admin'] == $user->_data['user_id'])}
                                    <div class="pull-right flip">
                                        <button type="button" class="close js_delete-post"><span>&times;</span></button>
                                    </div>
                                {else}
                                    <div class="pull-right flip dropdown">
                                        <i class="fa fa-chevron-down dropdown-toggle" data-toggle="dropdown"></i>
                                        <ul class="dropdown-menu post-dropdown-menu">
                                            <li>
                                                <a href="#" class="js_hide-post">
                                                    <div class="action">
                                                        <i class="fa fa-eye-slash fa-fw"></i> {__("Hide this post")}
                                                    </div>
                                                    <div class="action-desc">{__("See fewer posts like this")}</div>
                                                </a>
                                            </li>
                                            <li>
                                                <a href="#" class="js_hide-author" data-author-id="{$post['user_id']}" data-author-name="{$post['post_author_name']}">
                                                    <div class="action">
                                                        <i class="fa fa-minus-circle fa-fw"></i> {__("Unfollow")} {get_firstname($post['user_fullname'])}
                                                    </div>
                                                    <div class="action-desc">{__("Stop seeing posts but stay friends")}</div>
                                                </a>
                                            </li>
                                            <li role="presentation" class="divider"></li>
                                            {if $user->_data['user_group'] < 3}
                                            <li>
                                                <a href="#" class="js_delete-post">
                                                    <div class="action no-icon">{__("Delete post")}</div>
                                                </a>
                                            </li>
                                            {else}
                                            <li>
                                                <a href="#" class="js_report-post">
                                                    <div class="action no-icon">{__("Report post")}</div>
                                                </a>
                                            </li>
                                            {/if}
                                        </ul>
                                    </div>
                                {/if}
                            {elseif $post['user_type'] == "page"}
                                {if $post['page_admin'] == $user->_data['user_id']}
                                    <div class="pull-right flip">
                                        <button type="button" class="close js_delete-post"><span>&times;</span></button>
                                    </div>
                                {else}
                                    <div class="pull-right flip dropdown">
                                        <i class="fa fa-chevron-down dropdown-toggle" data-toggle="dropdown"></i>
                                        <ul class="dropdown-menu post-dropdown-menu">
                                            <li>
                                                <a href="#" class="js_hide-post">
                                                    <div class="action">
                                                        <i class="fa fa-eye-slash fa-fw"></i> {__("Hide this post")}
                                                    </div>
                                                    <div class="action-desc">{__("See fewer posts like this")}</div>
                                                </a>
                                            </li>
                                            <li role="presentation" class="divider"></li>
                                            {if $user->_data['user_group'] < 3}
                                            <li>
                                                <a href="#" class="js_delete-post">
                                                    <div class="action no-icon">{__("Delete post")}</div>
                                                </a>
                                            </li>
                                            {else}
                                            <li>
                                                <a href="#" class="js_report-post">
                                                    <div class="action no-icon">{__("Report post")}</div>
                                                </a>
                                            </li>
                                            {/if}
                                        </ul>
                                    </div>
                                {/if}
                            {/if}
                            <!-- post menu -->
                        {/if}

                        <!-- post author name -->
                        <span class="js_user-popover" data-type="{$post['user_type']}" data-uid="{$post['user_id']}">
                            <a href="{$post['post_author_url']}">{$post['post_author_name']}</a>
                        </span>
                        {if $post['post_author_verified']}
                        <i data-toggle="tooltip" data-placement="top" title="{__("Verified profile")}" class="fa fa-check verified-badge"></i>
                        {/if}
                        <!-- post author name -->

                        <!-- post type meta -->
                        <span class="post-title">
                        {if $post['post_type'] == "shared"}
                            {__("shared")} 
                            <span class="js_user-popover" data-type="{$post['origin']['user_type']}" data-uid="{$post['origin']['user_id']}">
                                <a href="{$post['origin']['post_author_url']}">
                                    {$post['origin']['post_author_name']}
                                </a>{__("'s")}
                            </span> 
                            <a href="{$system['system_url']}/posts/{$post['origin']['post_id']}">
                            
                            {if $post['origin']['post_type'] == 'photos'}
                                {if $post['origin']['photos_num'] > 1}{__("photos")}{else}{__("photo")}{/if}
                            {elseif $post['origin']['post_type'] == 'media'}
                                {if $post['origin']['media']['media_type'] != "soundcloud"}
                                    {__("video")}
                                {else}
                                    {__("song")}
                                {/if}
                            {elseif $post['origin']['post_type'] == 'link'}
                                {__("link")}
                            {else}
                                {__("post")}
                            {/if}
                            </a>

                        {elseif $post['post_type'] == "link"}
                            {__("shared a link")}

                        {elseif $post['post_type'] == "photos"}
                            {if $post['photos_num'] == 1}
                                {__("added a photo")}
                            {else}
                                {__("added")} {$post['photos_num']} {__("photos")}
                            {/if}

                        {elseif $post['post_type'] == "video"}
                            {__("added a video")}

                        {elseif $post['post_type'] == "avatar"}
                            {if $post['user_gender'] == "M"}
                            {__("updated his profile picture")}
                            {else}
                            {__("updated her profile picture")}
                            {/if}

                        {elseif $post['post_type'] == "cover"}
                            {if $post['user_gender'] == "M"}
                            {__("updated his cover photo")}
                            {else}
                            {__("updated her cover photo")}
                            {/if}
                            
                        {/if}
                        </span>
                        <!-- post type meta -->
                    </div>
                    <!-- post author name & menu -->

                    <!-- post time & location & privacy -->
                    <div class="post-time">
                        <a href="{$system['system_url']}/posts/{$post['post_id']}" class="js_moment" data-time="{$post['time']}">{$post['time']}</a>

                        {if $post['location']}
                        ·
                        <i class="fa fa-map-marker"></i> <span>{$post['location']}</span>
                        {/if}

                        - 
                        {if $post['privacy'] == "friends"}
                            <i class="fa fa-users" data-toggle="tooltip" data-placement="top" title="{__("Shared with")}: {__("Friends")}"></i>
                        {else}
                            <i class="fa fa-globe" data-toggle="tooltip" data-placement="top" title="{__("Shared with")}: {__("Public")}"></i>
                        {/if}
                    </div>
                    <!-- post time & location & privacy -->
                </div>
                <!-- post meta -->
            </div>
            <!-- post header -->

            <!-- post text -->
            <div class="post-text">{$post['text']}</div>
            <!-- post text -->

            {if $post['post_type'] == "avatar"}
            <div class="pg_wrapper">
                <div class="pg_1x">
                    <a href="#" class="js_lightbox-nodata" data-image="{$post['user_picture']}">
                        <img src="{$system['system_uploads']}/{$post['user_picture']}">
                    </a>
                </div>
            </div>
            {elseif $post['post_type'] == "cover"}
            <div class="pg_wrapper">
                <div class="pg_1x">
                    <a href="#" class="js_lightbox-nodata" data-image="{$post['user_cover']}">
                        <img src="{$system['system_uploads']}/{$post['user_cover']}">
                    </a>
                </div>
            </div>
            {elseif $post['post_type'] == "photos" && $post['photos']}
            <div class="mt10 clearfix">
                <div class="pg_wrapper">
                {if $post['photos_num'] == 1}
                    <div class="pg_1x">
                        <a href="#" class="js_lightbox-nodata" data-image="{$post['photos'][0]['source']}">
                            <img src="{$system['system_uploads']}/{$post['photos'][0]['source']}">
                        </a>
                    </div>
                {elseif $post['photos_num'] == 2}
                    {foreach $post['photos'] as $photo}
                        <div class="pg_2x">
                            <a href="{$system['system_url']}/photos/{$photo['photo_id']}" class="js_lightbox" data-id="{$photo['photo_id']}" data-image="{$photo['source']}" style="background-image:url('{$system['system_uploads']}/{$photo['source']}');"></a>
                        </div>
                    {/foreach}
                {elseif $post['photos_num'] == 3}
                    <div class="pg_3x">
                        <div class="pg_2o3">
                            <div class="pg_2o3_in">
                                <a href="{$system['system_url']}/photos/{$post['photos'][0]['photo_id']}" class="js_lightbox" data-id="{$post['photos'][0]['photo_id']}" data-image="{$post['photos'][0]['source']}" style="background-image:url('{$system['system_uploads']}/{$post['photos'][0]['source']}');"></a>
                            </div>
                        </div>
                        <div class="pg_1o3">
                            <div class="pg_1o3_in">
                                <a href="{$system['system_url']}/photos/{$post['photos'][1]['photo_id']}" class="js_lightbox" data-id="{$post['photos'][1]['photo_id']}" data-image="{$post['photos'][1]['source']}" style="background-image:url('{$system['system_uploads']}/{$post['photos'][1]['source']}');"></a>
                            </div>
                            <div class="pg_1o3_in">
                                <a href="{$system['system_url']}/photos/{$post['photos'][2]['photo_id']}" class="js_lightbox" data-id="{$post['photos'][2]['photo_id']}" data-image="{$post['photos'][2]['source']}" style="background-image:url('{$system['system_uploads']}/{$post['photos'][2]['source']}');"></a>
                            </div>
                        </div>
                    </div>
                {else}
                    <div class="pg_4x">
                        <div class="pg_2o3">
                            <div class="pg_2o3_in">
                                <a href="{$system['system_url']}/photos/{$post['photos'][0]['photo_id']}" class="js_lightbox" data-id="{$post['photos'][0]['photo_id']}" data-image="{$post['photos'][0]['source']}" style="background-image:url('{$system['system_uploads']}/{$post['photos'][0]['source']}');"></a>
                            </div>
                        </div>
                        <div class="pg_1o3">
                            <div class="pg_1o3_in">
                                <a href="{$system['system_url']}/photos/{$post['photos'][1]['photo_id']}" class="js_lightbox" data-id="{$post['photos'][1]['photo_id']}" data-image="{$post['photos'][1]['source']}" style="background-image:url('{$system['system_uploads']}/{$post['photos'][1]['source']}');"></a>
                            </div>
                            <div class="pg_1o3_in">
                                <a href="{$system['system_url']}/photos/{$post['photos'][2]['photo_id']}" class="js_lightbox" data-id="{$post['photos'][2]['photo_id']}" data-image="{$post['photos'][2]['source']}" style="background-image:url('{$system['system_uploads']}/{$post['photos'][2]['source']}');"></a>
                            </div>
                            <div class="pg_1o3_in">
                                <a href="{$system['system_url']}/photos/{$post['photos'][3]['photo_id']}" class="js_lightbox" data-id="{$post['photos'][3]['photo_id']}" data-image="{$post['photos'][3]['source']}" style="background-image:url('{$system['system_uploads']}/{$post['photos'][3]['source']}');">
                                    {if $post['photos_num'] > 4}
                                    <span class="more">+{$post['photos_num']-4}</span>
                                    {/if}
                                </a>
                            </div>
                        </div>
                    </div>
                {/if}
                </div>
            </div>
            {elseif $post['post_type'] == "media" && $post['media']}
            <div class="mt10">
                {if $post['media']['media_type'] == "youtube"}
                    <div class="post-media">
                        <div class="embed-responsive embed-responsive-16by9">
                            <iframe class="embed-responsive-item" src="//www.youtube.com/embed/{$post['media']['source_uid']}" allowfullscreen=""></iframe>
                        </div>
                        <div class="post-media-meta">
                            <a class="title mb5" href="{$post['media']['source_url']}" target="_blank">{$post['media']['source_title']}</a>
                            <div class="text mb5">{$post['media']['source_text']}</div>
                            <div class="source">youtube.com</div>
                        </div>
                    </div>
                {elseif $post['media']['media_type'] == "vimeo"}
                    <div class="post-media">
                        <div class="embed-responsive embed-responsive-16by9">
                            <iframe class="embed-responsive-item" src="http://player.vimeo.com/video/{$post['media']['source_uid']}"></iframe>
                        </div>
                        <div class="post-media-meta">
                            <a class="title mb5" href="{$post['media']['source_url']}" target="_blank">{$post['media']['source_title']}</a>
                            <div class="text mb5">{$post['media']['source_text']}</div>
                            <div class="source">vimeo.com</div>
                        </div>
                    </div>
                {elseif $post['media']['media_type'] == "soundcloud"}
                    <div class="post-media">
                        <div class="embed-responsive embed-responsive-16by9">
                            <iframe height="450" src="https://w.soundcloud.com/player/?url=https%3A//api.soundcloud.com/tracks/{$post['media']['source_uid']}&amp;auto_play=false&amp;hide_related=false&amp;show_comments=true&amp;show_user=true&amp;show_reposts=false&amp;visual=true"></iframe>
                        </div>
                        <div class="post-media-meta">
                            <a class="title mb5" href="{$post['media']['source_url']}" target="_blank">{$post['media']['source_title']}</a>
                            <div class="text mb5">{$post['media']['source_text']}</div>
                            <div class="source">soundcloud.com</div>
                        </div>
                    </div>
                {/if}
            </div>
            {elseif $post['post_type'] == "link" && $post['link']}
            <div class="mt10">
                <div class="post-media">
                    {if $post['link']['source_thumbnail']}
                        <div class="post-media-image">
                            <div style="background-image:url('{$post['link']['source_thumbnail']}');"></div>
                        </div>
                    {/if}
                    <div class="post-media-meta">
                        <a class="title mb5" href="{$post['link']['source_url']}" target="_blank">{$post['link']['source_title']}</a>
                        <div class="text mb5">{$post['link']['source_text']}</div>
                        <div class="source">{$post['link']['source_host']|upper}</div>
                    </div>
                </div>
            </div>
            {elseif $post['post_type'] == "video" && $post['video']}
                <video controls>
                    <source src="{$system['system_uploads']}/{$post['video']['source']}" type="video/mp4">
                    {__("Your browser does not support HTML5 video")}
                </video>
            {elseif $post['post_type'] == "shared" && $post['origin']}
            {if $_snippet}
            <span class="text-link js_show-attachments">{__("Show Attachments")}</span>
            {/if}
            <div class="mt10 {if $_snippet}x-hidden{/if}">
                <div class="post-media">
                    <div class="post-media-meta">
                        {include file='__feeds_post_shared.tpl' origin=$post['origin']}
                    </div>
                </div>
            </div>
            {/if}

            <!-- post actions & stats -->
            <div class="post-actions">
                <!-- post actions -->
                {if $post['i_like']}
                    <span class="text-link js_unlike-post">{__("Unlike")}</span> - 
                {else}
                    <span class="text-link js_like-post">{__("Like")}</span> - 
                {/if}
                <span class="text-link js_comment">{__("Comment")}</span>
                {if $post['privacy'] == "public"}
                     - 
                    <span class="text-link js_share">{__("Share")}</span>
                {/if}
                <!-- post actions -->

                <!-- post stats -->
                <span class="post-stats-alt {if $post['likes']==0 && $post['comments']==0 && $post['shares']==0}x-hidden{/if}">
                    <i class="fa fa-thumbs-o-up"></i> <span class="js_post-likes-num">{$post['likes']}</span> 
                    <i class="fa fa-comments"></i> <span class="js_post-comments-num">{$post['comments']}</span> 
                    <i class="fa fa-share"></i> <span class="js_post-shares-num">{$post['shares']}</span>
                </span>
                <!-- post stats -->
            </div>
            <!-- post actions & stats -->
        </div>
        <!-- post body -->

        <!-- post footer -->
        <div class="post-footer {if $post['likes'] == 0 && $post['comments'] == 0 && $post['shares'] == 0}x-hidden{/if}">

            <!-- post stats (likes & shares) -->
            <div class="post-stats clearfix {if $post['likes'] == 0 && $post['shares'] == 0}x-hidden{/if}">
                <!-- shares -->
                <div class="pull-right flip js_post-shares {if $post['shares'] == 0}x-hidden{/if}">
                    <i class="fa fa-share"></i> 
                    <span class="text-link" data-toggle="modal" data-url="posts/who_shares.php?post_id={$post['post_id']}">
                        {$post['shares']}{__("shares")}
                    </span>
                </div>
                <!-- shares -->

                <!-- likes -->
                <span class="js_post-likes {if {$post['likes']} == 0}x-hidden{/if}">
                    <i class="fa fa-thumbs-o-up"></i> <span class="text-link" data-toggle="modal" data-url="posts/who_likes.php?post_id={$post['post_id']}"><span class="js_post-likes-num">{$post['likes']}</span> {__("people")}</span> {__("like this")}
                </span>
                <!-- likes -->
            </div>
            <!-- post stats (likes & shares) -->

            <!-- comments -->
            {include file='__feeds_post.comments.tpl'}
            <!-- comments -->
        </div>
        <!-- post footer -->

    </div>
    <!-- post -->
{if !$single}</li>{/if}