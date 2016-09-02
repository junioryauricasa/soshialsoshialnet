<li class="feeds-item">
    <div class="data-container">
        <a href="{$system['system_url']}/games/{$_game['game_id']}">
            <img class="data-avatar" src="{$_game['thumbnail']}" alt="{$_game['title']}">
        </a>
        <div class="data-content">
            <div class="pull-right flip">
                <a class="btn btn-primary" href="{$system['system_url']}/games/{$_game['game_id']}">{__("Play")}</a>
            </div>
            <div>
                <span class="name">
                    <a href="{$system['system_url']}/games/{$_game['game_id']}">{$_game['title']}</a>
                </span>
            </div>
        </div>
    </div>
</li>