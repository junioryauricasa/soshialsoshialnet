<li class="dropdown js_live-messages {if $user->_is_admin}is-admin{/if}">
    <a href="#" class="dropdown-toggle" data-toggle="dropdown">
        <i class="fa fa-comments-o fa-lg"></i>
        <span class="label {if $user->_data['user_live_messages_counter'] == 0}hidden{/if}">
            {$user->_data['user_live_messages_counter']}
        </span>
    </a>
    <div class="dropdown-menu dropdown-widget">
        <div class="dropdown-widget-header">
            {__("Messages")}
            <a class="pull-right flip flip flip text-link js_chat-start" href="{$system.system_url}/messages/new">{__("Send a New Message")}</a>
        </div>
        <div class="dropdown-widget-body">
            <div class="js_scroller">
                {if count($user->_data['conversations']) > 0}
                <ul>
                    {foreach $user->_data['conversations'] as $conversation}
                    {include file='__feeds_conversation.tpl'}
                    {/foreach}
                </ul>
                {else}
                <p class="text-center text-muted mt10">
                    {__("No messages")}
                </p>
                {/if}
            </div>
        </div>
        <a class="dropdown-widget-footer" href="{$system.system_url}/messages">{__("See All")}</a>
    </div>
</li>