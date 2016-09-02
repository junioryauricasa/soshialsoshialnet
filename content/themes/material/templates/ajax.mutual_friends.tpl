<div class="modal-header">
    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
    <h5 class="modal-title">{__("Mutual Friends")}</h5>
</div>
<div class="modal-body">
    <ul>
        {foreach $mutual_friends as $_user}
        {include file='__feeds_user.tpl' _type="remove"}
        {/foreach}
    </ul>

    {if count($mutual_friends) >= $system['max_results']}
    <!-- see-more -->
    <div class="alert alert-info see-more js_see-more" data-get="mutual_friends" data-uid="{$uid}">
        <span>{__("See More")}</span>
        <div class="loader loader_small x-hidden"></div>
    </div>
    <!-- see-more -->
    {/if}
    
</div>
