<ul>
    {foreach $online_friends as $_user}
    <li class="feeds-item">
        <div class="data-container clickable small js_chat-start" data-uid="{$_user['user_id']}" data-name="{$_user['user_fullname']}" data-picture="{$_user['user_picture']}">
            <img class="data-avatar" src="{$_user['user_picture']}" alt="{$_user['user_fullname']}">
            <div class="data-content">
                <div class="pull-right flip">
                    <i class="fa fa-circle"></i>
                </div>
                <div><strong>{$_user['user_fullname']}</strong></div>
            </div>
        </div>
    </li>
    {/foreach}
</ul>