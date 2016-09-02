<li class="feeds-item {if !$conversation['seen']}unread{/if}" data-last-message="{$conversation['last_message_id']}">
    {if $conversation['multiple_recipients']}
        <a class="data-container js_chat-start" data-uid="{$conversation['ids']}" data-name="{$conversation['name']}" data-picture="{$conversation['picture_left']}" data-multiple="true" data-cid="{$conversation['conversation_id']}"  data-name-list="{$conversation['name_list']}" href="{$system['system_url']}/messages/{$conversation['conversation_id']}">
            <div class="data-avatar">
                <div class="left-avatar" style="background-image: url('{$conversation['picture_left']}')"></div>
                <div class="right-avatar" style="background-image: url('{$conversation['picture_right']}')"></div>
            </div>
            <div class="data-content">
                {if $conversation['image'] != ''}
                    <div class="pull-right flip">
                        <img class="data-img" src="{$system['system_uploads']}/{$conversation['image']}" alt="">
                    </div>
                {/if}
                <div><span class="name">{$conversation['name']}</span></div>
                <div class="text">
                    {if $conversation['message'] != ''}
                        {$conversation['message']}
                    {else}
                        <i class="fa fa-picture-o"></i> {__('photo')}
                    {/if}
                </div>
                <div class="time js_moment" data-time="{$conversation['time']}">{$conversation['time']}</div>
            </div>
        </a>
    {else}
        <a class="data-container js_chat-start" data-uid="{$conversation['ids']}" data-name="{$conversation['name']}" data-picture="{$conversation['picture']}" data-multiple="false" data-cid="{$conversation['conversation_id']}" data-name-list="{$conversation['name_list']}"  href="{$system['system_url']}/messages/{$conversation['conversation_id']}">
            <img class="data-avatar" src="{$conversation['picture']}" alt="">
            <div class="data-content">
                {if $conversation['image'] != ''}
                    <div class="pull-right flip">
                        <img class="data-img" src="{$system['system_uploads']}/{$conversation['image']}" alt="">
                    </div>
                {/if}
                <div><span class="name">{$conversation['name']}</span></div>
                <div class="text">
                    {if $conversation['message'] != ''}
                        {$conversation['message']}
                    {else}
                        <i class="fa fa-picture-o"></i> {__('photo')}
                    {/if}
                </div>
                <div class="time js_moment" data-time="{$conversation['time']}">{$conversation['time']}</div>
            </div>
        </a>
    {/if}
</li>