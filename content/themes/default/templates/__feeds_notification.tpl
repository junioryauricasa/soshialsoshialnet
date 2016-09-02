<li class="feeds-item {if !$notification['seen']}unread{/if}" data-id="{$notification['notification_id']}">
    <a class="data-container" href="{$notification['url']}">
        <img class="data-avatar" src="{$notification['user_picture']}" alt="">
        <div class="data-content">
            <div><span class="name">{$notification['user_fullname']}</span></div>
            <div><i class="fa {$notification['icon']} pr5"></i> {$notification['message']}</div>
            <div class="time js_moment" data-time="{$notification['time']}">{$notification['time']}</div>
        </div>
    </a>
</li>