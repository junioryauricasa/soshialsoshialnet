{if $_parent == "profile"}<li class="col-sm-12 col-md-6"><div class="box-container">{else}<li class="feeds-item">{/if}
    <div class="data-container">
        <a href="{$system['system_url']}/pages/{$_page['page_name']}">
            <img class="data-avatar" src="{$_page['page_picture']}" alt="{$_page['page_title']}">
        </a>
        <div class="data-content">
            <div class="pull-right flip">
                {if $_page['i_like']}
                <button type="button" class="btn btn-default js_unlike-page" data-id="{$_page['page_id']}">
                    <i class="fa fa-thumbs-o-up"></i>
                    {__("Unlike")}
                </button>
                {else}
                <button type="button" class="btn btn-primary js_like-page" data-id="{$_page['page_id']}">
                    <i class="fa fa-thumbs-o-up"></i>
                    {__("Like")}
                </button>
                {/if}
            </div>
            <div>
                <span class="name js_user-popover" data-uid="{$_page['page_id']}" data-type="page">
                    <a href="{$system['system_url']}/pages/{$_page['page_name']}">{$_page['page_title']}</a>
                </span>
                <div>{$_page['page_likes']} {__("Likes")}</div>
            </div>
        </div>
    </div>
{if $_parent == "profile"}</div></li>{else}</li>{/if}