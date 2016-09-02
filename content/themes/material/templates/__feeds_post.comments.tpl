<div class="post-comments">

    <!-- previous comments -->
    {if $post['comments'] >= $system['max_results']}
    <div class="pb10 js_see-more" data-get="post_comments" data-id="{$post['post_id']}" data-remove="true">
        <span class="text-link">
            <i class="fa fa-comment-o"></i>
            {__("View previous comments")}
        </span>
        <div class="loader loader_small x-hidden"></div>
    </div>
    {/if}
    <!-- previous comments -->

    <!-- comments -->
    <ul>
        {if $post['comments'] > 0}
            {foreach $post['post_comments'] as $comment}
            {include file='__feeds_post.comment.tpl'}
            {/foreach}
        {/if}
    </ul>
    <!-- comments -->

    <!-- post a comment -->
    {include file='__feeds_post.comment_form.tpl' _handle='post' _id= $post['post_id']}
    <!-- post a comment -->
    
</div>