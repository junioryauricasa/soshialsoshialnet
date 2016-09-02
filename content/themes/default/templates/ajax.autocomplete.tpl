<ul>
    {foreach $users as $_user}
    <li>
        <div class="data-container clickable small js_tag-add" data-uid="{$_user['user_id']}" data-name="{$_user['user_fullname']}">
            <img class="data-avatar" src="{$_user['user_picture']}" alt="">
            <div class="data-content">
                <div><strong>{$_user['user_fullname']}</strong></div>
            </div>
        </div>
    </li>
    {/foreach}
</ul>