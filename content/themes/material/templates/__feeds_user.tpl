{if $_parent == "profile"}<li class="col-sm-12 col-md-6"><div class="box-container">{else}<li class="feeds-item" data-id="{$_user['id']}">{/if}
    <div class="data-container {if $_small}small{/if}">
        <a href="{$system['system_url']}/{$_user['user_name']}">
            <img class="data-avatar" src="{$_user['user_picture']}" alt="{$_user['user_fullname']}">
        </a>
        <div class="data-content">
            <div class="pull-right flip">
                {if $_connection == "request"}
                <div class="btn btn-primary js_friend-accept" data-uid="{$_user['user_id']}">{__("Confirm")}</div>
                <div class="btn btn-default js_friend-decline" data-uid="{$_user['user_id']}">{__("Delete Request")}</div>

                {elseif $_connection == "add"}
                <div class="btn btn-success btn-sm js_friend-add" data-uid="{$_user['user_id']}">
                    <i class="fa fa-check fa-user-plus"></i> {__("Add Friend")}
                </div>

                {elseif $_connection == "cancel"}
                <div class="btn btn-default btn-sm js_friend-cancel" data-uid="{$_user['user_id']}">
                    <i class="fa fa-check fa-user-plus"></i> {__("Friend Request Sent")}
                </div>
                
                {elseif $_connection == "remove"}
                <div class="btn btn-default btn-friends js_friend-remove" data-uid="{$_user['user_id']}">
                    <i class="fa fa-check fa-fw"></i> {__("Friends")}
                </div>

                {elseif $_connection == "follow"}
                <button type="button" class="btn btn-default js_follow" data-uid="{$_user['user_id']}">
                    <i class="fa fa-rss"></i>
                    {__("Follow")}
                </button>

                {elseif $_connection == "unfollow"}
                <button type="button" class="btn btn-default js_unfollow" data-uid="{$_user['user_id']}">
                    <i class="fa fa-check"></i>
                    {__("Following")}
                </button>

                {elseif $_connection == "blocked"}
                <div class="btn btn-danger js_unblock-user" data-uid="{$_user['user_id']}">
                    <i class="fa fa-trash fa-fw"></i> {__("Unblock")}
                </div>
                {/if}
            </div>
            <div>
                <span class="name js_user-popover" data-uid="{$_user['user_id']}">
                    <a href="{$system['system_url']}/{$_user['user_name']}">{$_user['user_fullname']}</a>
                </span>
            </div>
            {if $_connection != "me" && $_user['mutual_friends_count'] > 0}
            <div>
                <span class="text-underline" data-toggle="modal" data-url="users/mutual_friends.php?uid={$_user['user_id']}">{$_user['mutual_friends_count']} {__("mutual friends")}</span>
            </div>
            {/if}
        </div>
    </div>
{if $_parent == "profile"}</div></li>{else}</li>{/if}