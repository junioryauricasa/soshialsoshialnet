{include file='_head.tpl'}
{include file='_header.tpl'}

<!-- page content -->
<div class="container mt20">
    <div class="row">

        <div class="col-lg-8 col-md-8 col-sm-8">

            <!-- friend requests -->
            <div class="panel panel-default">
                {if $view != "sent"}
                    <div class="panel-heading light">
                        <div class="mt5">
                            <strong>{__("Respond to Your Friend Request")}</strong>
                        </div>
                        <div class="mb5">
                            <small><a href="{$system['system_url']}/friends/requests/sent">{__("View Sent Requests")}</a></small>
                        </div>
                    </div>
                    <div class="panel-body">
                        {if count($user->_data['friend_requests']) > 0}
                        <ul>
                            {foreach $user->_data['friend_requests'] as $_user}
                            {include file='__feeds_user.tpl' _connection="request"}
                            {/foreach}
                        </ul>
                        {else}
                        <p class="text-center text-muted">
                            {__("No new requests")}
                        </p>
                        {/if}

                        {if count($user->_data['friend_requests']) >= $system['max_results']}
                        <!-- see-more -->
                        <div class="alert alert-info see-more js_see-more" data-get="friend_requests">
                            <span>{__("See More")}</span>
                            <div class="loader loader_small x-hidden"></div>
                        </div>
                        <!-- see-more -->
                        {/if}
                    </div>
                {else}
                    <div class="panel-heading light">
                        <div class="mt5">
                            <strong>{__("Friend Requests Sent")}</strong>
                        </div>
                        <div class="mb5">
                            <small><a href="{$system['system_url']}/friends/requests">{__("View Received Requests")}</a></small>
                        </div>
                    </div>
                    <div class="panel-body">
                        {if count($user->_data['friend_requests_sent']) > 0}
                        <ul>
                            {foreach $user->_data['friend_requests_sent'] as $_user}
                            {include file='__feeds_user.tpl' _connection="cancel"}
                            {/foreach}
                        </ul>
                        {else}
                        <p class="text-center text-muted">
                            {__("No new requests")}
                        </p>
                        {/if}

                        {if count($user->_data['friend_requests_sent']) >= $system['max_results']}
                        <!-- see-more -->
                        <div class="alert alert-info see-more js_see-more" data-get="friend_requests_sent">
                            <span>{__("See More")}</span>
                            <div class="loader loader_small x-hidden"></div>
                        </div>
                        <!-- see-more -->
                        {/if}
                    </div>
                {/if}
            </div>
            <!-- friend requests -->

            <!-- people you may know -->
            <div class="panel panel-default">
                <div class="panel-heading light">
                    <div class="mt5">
                        <strong>{__("People You May Know")}</strong>
                    </div>
                </div>
                <div class="panel-body">
                    
                    {if count($user->_data['new_people']) > 0}
                    <ul>
                        {foreach $user->_data['new_people'] as $_user}
                        {include file='__feeds_user.tpl' _connection="add"}
                        {/foreach}
                    </ul>
                    {else}
                    <p class="text-center text-muted">
                        {__("No people available")}
                    </p>
                    {/if}

                    {if count($user->_data['new_people']) >= $system['min_results']}
                    <!-- see-more -->
                    <div class="alert alert-info see-more js_see-more" data-get="new_people">
                        <span>{__("See More")}</span>
                        <div class="loader loader_small x-hidden"></div>
                    </div>
                    <!-- see-more -->
                    {/if}

                </div>
            </div>
            <!-- people you may know -->
            
        </div>

        <div class="col-lg-4 col-md-4 col-sm-4">
            {include file='__ads.tpl'}
            {include file='__widget.tpl'}
        </div>

    </div>
</div>
<!-- page content -->

{include file='_footer.tpl'}