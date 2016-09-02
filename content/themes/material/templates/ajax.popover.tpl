{if $type == "user"}
    <!-- user popover -->
    <div class="user-popover-content">
        <div class="user-card">
            {if $profile['user_cover']}
                <div class="user-card-cover" style="background-image:url('{$system['system_uploads']}/{$profile['user_cover']}');"></div>
            {else}
                <div class="user-card-cover no-cover"></div>
            {/if}
            <div class="user-card-avatar">
                <img src="{$profile['user_picture']}" alt="{$profile['user_fullname']}">
            </div>
            <div class="user-card-info">
                <a class="name" href="{$system['system_url']}/{$profile['user_name']}">{$profile['user_fullname']}</a>
                {if $profile['user_verified']}
                <i data-toggle="tooltip" data-placement="top" title="{__("Perfil verificado")}" class="fa fa-check verified-badge"></i>
                {/if}
                <div class="info">
                    <a href="{$system['system_url']}/{$profile['user_name']}/followers">{$profile['followers_count']} {__("followers")}</a>
                </div>
            </div>
        </div>
        <div class="user-card-meta">
            <!-- mutual friends -->
            {if $profile['mutual_friends_count'] && $profile['mutual_friends_count'] > 0}
                <div class="mb10">
                    <i class="fa fa-users fa-fw pr5"></i>
                    <span class="text-underline" data-toggle="modal" data-url="users/mutual_friends.php?uid={$profile['user_id']}">{$profile['mutual_friends_count']} {__("mutual friends")}</span>
                </div>
            {/if}
            <!-- mutual friends -->
            <!-- work -->
            {if !is_empty($profile['user_work_title'])}
                {if $profile['user_id'] == $user->_data['user_id'] || $profile['user_privacy_work'] == "public" || $profile['we_friends']}
                    <div class="mb10">
                        <i class="fa fa-briefcase fa-fw pr5"></i>
                        {$profile['user_work_title']} {__("at")} <span class="text-link">{$profile['user_work_place']}</span>
                    </div>
                {/if}
            {/if}
            <!-- work -->
            <!-- hometown -->
            {if !is_empty($profile['user_hometown'])}
                {if $profile['user_id'] == $user->_data['user_id'] || $profile['user_privacy_location'] == "public" || $profile['we_friends']}
                    <div class="mb10">
                        <i class="fa fa-map-marker fa-fw pr5"></i>
                        {__("From")} <span class="text-link">{$profile['user_hometown']}</span>
                    </div>
                {/if}
            {/if}
            <!-- hometown -->
        </div>
        <div class="footer">
            {if $user->_data['user_id'] != $profile['user_id']}
                {if $profile['we_friends']}
                    <div class="btn btn-default btn-friends js_friend-remove" data-uid="{$profile['user_id']}">
                        <i class="fa fa-check fa-fw"></i> {__("Friends")}
                    </div>
                {elseif $profile['he_request']}
                    <div class="btn btn-primary js_friend-accept" data-uid="{$profile['user_id']}">{__("Confirm")}</div>
                    <div class="btn btn-default js_friend-decline" data-uid="{$profile['user_id']}">{__("Delete Request")}</div>
                {elseif $profile['i_request']}
                    <div class="btn btn-default btn-sm js_friend-cancel" data-uid="{$profile['user_id']}">
                        <i class="fa fa-check fa-user-plus"></i> {__("Friend Request Sent")}
                    </div>
                {else}
                    <div class="btn btn-success btn-sm js_friend-add" data-uid="{$profile['user_id']}">
                        <i class="fa fa-check fa-user-plus"></i> {__("Add Friend")}
                    </div>
                {/if}

                <div class="btn-group">
                    {if $profile['i_follow']}
                        <button type="button" class="btn btn-default js_unfollow" data-uid="{$profile['user_id']}">
                            <i class="fa fa-check"></i>
                            {__("Following")}
                        </button>
                    {else}
                        <button type="button" class="btn btn-default js_follow" data-uid="{$profile['user_id']}">
                            <i class="fa fa-rss"></i>
                            {__("Follow")}
                        </button>
                    {/if}
                    <button type="button" class="btn btn-default js_chat-start" data-uid="{$profile['user_id']}" data-name="{$profile['user_fullname']}" data-picture="{$profile['user_picture']}">{__("Message")}</button>
                </div>
            {else}
                <a href="{$system.system_url}/settings/profile" class="btn btn-default">
                    <i class="fa fa-pencil"></i> {__("Update Info")}
                </a>
            {/if}
        </div>
    </div>
    <!-- user popover -->
{else}
    <!-- page popover -->
    <div class="user-popover-content">
        <div class="user-card">
            {if $profile['page_cover']}
                <div class="user-card-cover" style="background-image:url('{$system['system_uploads']}/{$profile['page_cover']}');"></div>
            {else}
                <div class="user-card-cover no-cover"></div>
            {/if}
            <div class="user-card-avatar">
                <img class="img-responsive" src="{$profile['page_picture']}" alt="{$profile['page_title']}">
            </div>
            <div class="user-card-info">
                <a class="name" href="{$system['system_url']}/pages/{$profile['page_name']}">{$profile['page_title']}</a>
                {if $profile['page_verified']}
                <i data-toggle="tooltip" data-placement="top" title="{__("Verified profile")}" class="fa fa-check verified-badge"></i>
                {/if}
                <div class="info">{$profile['page_likes']} {__("Likes")}</div>
            </div>
        </div>
        <div class="footer">
            {if $profile['i_like']}
                <button type="button" class="btn btn-default js_unlike-page" data-id="{$profile['page_id']}">
                    <i class="fa fa-thumbs-o-up"></i>
                    {__("Unlike")}
                </button>
            {else}
                <button type="button" class="btn btn-primary js_like-page" data-id="{$profile['page_id']}">
                    <i class="fa fa-thumbs-o-up"></i>
                    {__("Like")}
                </button>
            {/if}
        </div>
    </div>
    <!-- page popover -->
{/if}