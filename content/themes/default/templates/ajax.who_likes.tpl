<div class="modal-header">
    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
    <h5 class="modal-title">{__("People Who Like This")}</h5>
</div>
<div class="modal-body">
    <ul>
        {foreach $users as $_user}
        {include file='__feeds_user.tpl' _connection=$_user["connection"]}
        {/foreach}
    </ul>

    {if count($users) >= $system['max_results']}
    <!-- see-more -->
    <div class="alert alert-info see-more js_see-more" data-get="{$get}" data-id="{$id}">
        <span>{__("See More")}</span>
        <div class="loader loader_small x-hidden"></div>
    </div>
    <!-- see-more -->
    {/if}
    
</div>
