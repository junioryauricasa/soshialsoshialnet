<!-- post header -->
<div class="post-header">
    <!-- post picture -->
    <div class="post-avatar">
        <a class="post-avatar-picture" href="{$origin['post_author_url']}" style="background-image:url({$origin['post_picture']});">
        </a>
    </div>
    <!-- post picture -->

    <!-- post meta -->
    <div class="post-meta">
        <!-- post author name -->
        <div>
            <!-- post author name -->
            <span class="js_user-popover" data-type="{$origin['user_type']}" data-uid="{$origin['user_id']}">
                <a href="{$origin['post_author_url']}">{$origin['post_author_name']}</a>
            </span>
            <!-- post author name -->
        </div>
        <!-- post author name -->

        <!-- post time & location & privacy -->
        <div class="post-time">
            <a href="{$system['system_url']}/posts/{$origin['post_id']}" class="js_moment" data-time="{$origin['time']}">{$origin['time']}</a>

            {if $origin['location']}
            ·
            <i class="fa fa-map-marker"></i> <span>{$origin['location']}</span>
            {/if}

            - 
            {if $origin['privacy'] == "friends"}
            <i class="fa fa-users" data-toggle="tooltip" data-placement="top" title="{__("Compartido con")} {__("amigos")}"></i>
            {else}
            <i class="fa fa-globe" data-toggle="tooltip" data-placement="top" title="{__("Compartido en")} {__("público")}"></i>
            {/if}
        </div>
        <!-- post time & location & privacy -->
    </div>
    <!-- post meta -->
</div>
<!-- post header -->

<!-- post text -->
<div class="post-text text-muted">{$origin['text']}</div>
<!-- post text -->

{if $origin['post_type'] == "avatar"}
    <div class="pg_wrapper">
        <div class="pg_1x">
            <a href="#" class="js_lightbox-nodata" data-image="{$origin['user_picture']}">
                <img src="{$system['system_uploads']}/{$origin['user_picture']}">
            </a>
        </div>
    </div>
{elseif $origin['post_type'] == "cover"}
    <div class="pg_wrapper">
        <div class="pg_1x">
            <a href="#" class="js_lightbox-nodata" data-image="{$origin['user_cover']}">
                <img src="{$system['system_uploads']}/{$origin['user_cover']}">
            </a>
        </div>
    </div>
{elseif $origin['post_type'] == "photos" && $origin['photos']}
    <div class="mt10 clearfix">
        <div class="pg_wrapper">
            {if $origin['photos_num'] == 1}
            <div class="pg_1x">
                <a href="#" class="js_lightbox-nodata" data-image="{$origin['photos'][0]['source']}">
                    <img src="{$system['system_uploads']}/{$origin['photos'][0]['source']}">
                </a>
            </div>
            {elseif $origin['photos_num'] == 2}
            {foreach $origin['photos'] as $photo}
            <div class="pg_2x">
                <a href="{$system['system_url']}/photos/{$photo['photo_id']}" class="js_lightbox" data-id="{$photo['photo_id']}" data-image="{$photo['source']}" style="background-image:url('{$system['system_uploads']}/{$photo['source']}');"></a>
            </div>
            {/foreach}
            {elseif $origin['photos_num'] == 3}
            <div class="pg_3x">
                <div class="pg_2o3">
                    <div class="pg_2o3_in">
                        <a href="{$system['system_url']}/photos/{$origin['photos'][0]['photo_id']}" class="js_lightbox" data-id="{$origin['photos'][0]['photo_id']}" data-image="{$origin['photos'][0]['source']}" style="background-image:url('{$system['system_uploads']}/{$origin['photos'][0]['source']}');"></a>
                    </div>
                </div>
                <div class="pg_1o3">
                    <div class="pg_1o3_in">
                        <a href="{$system['system_url']}/photos/{$origin['photos'][1]['photo_id']}" class="js_lightbox" data-id="{$origin['photos'][1]['photo_id']}" data-image="{$origin['photos'][1]['source']}" style="background-image:url('{$system['system_uploads']}/{$origin['photos'][1]['source']}');"></a>
                    </div>
                    <div class="pg_1o3_in">
                        <a href="{$system['system_url']}/photos/{$origin['photos'][2]['photo_id']}" class="js_lightbox" data-id="{$origin['photos'][2]['photo_id']}" data-image="{$origin['photos'][2]['source']}" style="background-image:url('{$system['system_uploads']}/{$origin['photos'][2]['source']}');"></a>
                    </div>
                </div>
            </div>
            {else}
            <div class="pg_4x">
                <div class="pg_2o3">
                    <div class="pg_2o3_in">
                        <a href="{$system['system_url']}/photos/{$origin['photos'][0]['photo_id']}" class="js_lightbox" data-id="{$origin['photos'][0]['photo_id']}" data-image="{$origin['photos'][0]['source']}" style="background-image:url('{$system['system_uploads']}/{$origin['photos'][0]['source']}');"></a>
                    </div>
                </div>
                <div class="pg_1o3">
                    <div class="pg_1o3_in">
                        <a href="{$system['system_url']}/photos/{$origin['photos'][1]['photo_id']}" class="js_lightbox" data-id="{$origin['photos'][1]['photo_id']}" data-image="{$origin['photos'][1]['source']}" style="background-image:url('{$system['system_uploads']}/{$origin['photos'][1]['source']}');"></a>
                    </div>
                    <div class="pg_1o3_in">
                        <a href="{$system['system_url']}/photos/{$origin['photos'][2]['photo_id']}" class="js_lightbox" data-id="{$origin['photos'][2]['photo_id']}" data-image="{$origin['photos'][2]['source']}" style="background-image:url('{$system['system_uploads']}/{$origin['photos'][2]['source']}');"></a>
                    </div>
                    <div class="pg_1o3_in">
                        <a href="{$system['system_url']}/photos/{$origin['photos'][3]['photo_id']}" class="js_lightbox" data-id="{$origin['photos'][3]['photo_id']}" data-image="{$origin['photos'][3]['source']}" style="background-image:url('{$system['system_uploads']}/{$origin['photos'][3]['source']}');">
                            {if $origin['photos_num'] > 4}
                            <span class="more">+{$origin['photos_num']-4}</span>
                            {/if}
                        </a>
                    </div>
                </div>
            </div>
            {/if}
        </div>
    </div>
{elseif $origin['post_type'] == "media"}
    <div class="mt10">
        {if $origin['media']['media_type'] == "youtube"}
        <div class="post-media">
            <div class="embed-responsive embed-responsive-16by9">
                <iframe class="embed-responsive-item" src="//www.youtube.com/embed/{$origin['media']['source_uid']}" allowfullscreen=""></iframe>
            </div>
            <div class="post-media-meta">
                <a class="title mb5" href="{$origin['media']['source_url']}" target="_blank">{$origin['media']['soucre_title']}</a>
                <div class="text mb5">{$origin['media']['source_text']}</div>
                <div class="source">youtube.com</div>
            </div>
        </div>
        {elseif $origin['media']['media_type'] == "vimeo"}
        <div class="post-media">
            <div class="embed-responsive embed-responsive-16by9">
                <iframe class="embed-responsive-item" src="http://player.vimeo.com/video/{$origin['media']['source_uid']}"></iframe>
            </div>
            <div class="post-media-meta">
                <a class="title mb5" href="{$origin['media']['source_url']}" target="_blank">{$origin['media']['soucre_title']}</a>
                <div class="text mb5">{$origin['media']['source_text']}</div>
                <div class="source">vimeo.com</div>
            </div>
        </div>
        {elseif $origin['media']['media_type'] == "soundcloud"}
        <div class="post-media">
            <div class="embed-responsive embed-responsive-16by9">
                <iframe height="450" src="https://w.soundcloud.com/player/?url=https%3A//api.soundcloud.com/tracks/{$origin['media']['source_uid']}&amp;auto_play=false&amp;hide_related=false&amp;show_comments=true&amp;show_user=true&amp;show_reposts=false&amp;visual=true"></iframe>
            </div>
            <div class="post-media-meta">
                <a class="title mb5" href="{$origin['media']['source_url']}" target="_blank">{$origin['media']['soucre_title']}</a>
                <div class="text mb5">{$origin['media']['source_text']}</div>
                <div class="source">soundcloud.com</div>
            </div>
        </div>
        {/if}
    </div>
{elseif $origin['post_type'] == "link"}
    {if $origin['link']['link_title'] || $origin['link']['link_text'] || $origin['link']['link_host']}
    <div class="mt10">
        <div class="post-media">
            {if $origin['link']['link_thumbnail']}
            <div class="post-media-image">
                <div style="background-image:url('{$origin['link']['link_thumbnail']}');"></div>
            </div>
            {/if}
            <div class="post-media-meta">
                <a class="title mb5" href="{$origin['link']['link_url']}" target="_blank">{$origin['link']['link_title']}</a>
                <div class="text mb5">{$origin['link']['link_text']}</div>
                <div class="source">{$origin['link']['link_host']|upper}</div>
            </div>
        </div>
    </div>
    {/if}
{elseif $origin['post_type'] == "video" && $origin['video']}
    <video controls>
        <source src="{$system['system_uploads']}/{$origin['video']['source']}" type="video/mp4">
        {__("Your browser does not support HTML5 video")}
    </video>
{/if}