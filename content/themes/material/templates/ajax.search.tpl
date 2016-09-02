<div class="js_scroller">
    <ul>
        {foreach $results as $result}
            {if $result['type'] == "user"}
                {include file='__feeds_user.tpl' _user=$result _connection=$result['connection']}
            
            {elseif $result['type'] == "page"}
                {include file='__feeds_page.tpl' _page=$result}
            
            {elseif $result['type'] == "group"}
                {include file='__feeds_group.tpl' _group=$result}

            {/if}
        {/foreach}
    </ul>
</div>