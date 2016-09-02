{include file='_head.tpl'}
{include file='_header.tpl'}

<!-- page content -->
<div class="container mt20">
    <div class="row">

        <!-- threads -->
        <div class="col-lg-4 col-md-4 col-sm-4">
            <div class="panel panel-default panel-conversations">
                <div class="panel-heading">
                     {__("Inbox")}
                </div>
                <div class="panel-body js_live-messages-alt">
                    {if count($user->_data['conversations']) > 0}
                        <div class="js_scroller" data-slimScroll-height="100%">
                            <ul>
                                {foreach $user->_data['conversations'] as $_conversation}
                                {include file='__feeds_conversation.tpl' conversation=$_conversation}
                                {/foreach}
                            </ul>

                            {if count($user->_data['conversations']) >= $system['max_results']}
                            <!-- see-more -->
                            <div class="alert alert-post see-more small mlr5 js_see-more" data-get="conversations">
                                <span>{__("Load Older Threads")}</span>
                                <div class="loader loader_small x-hidden"></div>
                            </div>
                            <!-- see-more -->
                            {/if}
                        </div>
                    {/if}
                </div>
            </div>
        </div>
        <!-- threads -->

        <!-- conversation -->
        <div class="col-lg-8 col-md-8 col-sm-8 js_conversation-container">
            {if $conversation}
                {include file='ajax.chat.conversation.tpl'}
            {else}
                <div class="panel panel-default panel-messages">
                    <div class="panel-heading clearfix">
                        <div class="pull-right flip">
                            <button type="button" class="btn btn-default js_chat-start">
                                <i class="material-icons">chat_bubble_outline</i>
                                {__("New Message")}
                            </button>
                        </div>
                        <div class="mt5 text-muted">{__("No Selection")}</div>
                    </div>
                    <div class="panel-body empty">
                        <h4>{__("No Conversation Selected")}</h4>
                        <span class="text-link js_chat-start">{__("New Message")}</span>
                    </div>
                </div>
            {/if}
        </div>
        <!-- conversation -->

    </div>
</div>
<!-- page content -->

{include file='_footer.tpl'}