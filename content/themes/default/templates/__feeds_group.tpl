{if $_parent == "profile"}<li class="col-sm-12 col-md-6"><div class="box-container">{else}<li class="feeds-item">{/if}
    <div class="data-container">
        <a href="{$system['system_url']}/groups/{$_group['group_name']}">
            <img class="data-avatar" src="{$_group['group_picture']}" alt="{$_group['group_title']}">
        </a>
        <div class="data-content">
            <div class="pull-right flip">
                {if $_group['i_joined']}
                <button type="button" class="btn btn-default btn-friends js_leave-group" data-id="{$_group['group_id']}">
                    <i class="fa fa-check"></i>
                    {__("Joined")}
                </button>
                {else}
                <button type="button" class="btn btn-success js_join-group" data-id="{$_group['group_id']}">
                    <i class="fa fa-user-plus"></i>
                    {__("Join Group")}
                </button>
                {/if}
            </div>
            <div>
                <span class="name">
                    <a href="{$system['system_url']}/groups/{$_group['group_name']}">{$_group['group_title']}</a>
                </span>
                <div>{$_group['group_members']} {__("Members")}</div>
            </div>
        </div>
    </div>
{if $_parent == "profile"}</div></li>{else}</li>{/if}