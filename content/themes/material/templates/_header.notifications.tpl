<li class="dropdown js_live-notifications {if $user->_is_admin}is-admin{/if}">
    <a href="#" class="dropdown-toggle" data-toggle="dropdown">
        <i class="material-icons">notifications</i>
        <span class="label {if $user->_data['user_live_notifications_counter'] == 0}hidden{/if}">
            {$user->_data['user_live_notifications_counter']}
        </span>
    </a>
    <div class="dropdown-menu dropdown-widget">
        <div class="dropdown-widget-header">
            {__("Notifications")}
        </div>
        <div class="dropdown-widget-body">
            <div class="js_scroller">
                {if count($user->_data['notifications']) > 0}
                <ul>
                    {foreach $user->_data['notifications'] as $notification}
                    {include file='__feeds_notification.tpl'}
                    {/foreach}
                </ul>
                {else}
                <p class="text-center text-muted mt10">
                    {__("No notifications")}
                </p>
                {/if}
            </div>
        </div>
        <a class="dropdown-widget-footer" href="{$system.system_url}/notifications">{__("See All")}</a>
    </div>
</li>