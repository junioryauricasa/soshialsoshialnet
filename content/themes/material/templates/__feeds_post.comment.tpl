<li>
    <div class="comment" data-id="{$comment['comment_id']}">
        <div class="comment-avatar">
            <a class="comment-avatar-picture" href="{$comment['comment_author_url']}" style="background-image:url({$comment['comment_picture']});">
            </a>
        </div>
        <div class="comment-data">
            {if $user->_logged_in}
                {if $comment['user_type'] == "user"}
                    {if $comment['user_id'] == $user->_data['user_id'] || $post['user_id'] == $user->_data['user_id'] || $photo['user_id'] == $user->_data['user_id'] || $comment['post']['user_id'] == $user->_data['user_id']}
                        <div class="comment-btn">
                            <button type="button" class="close js_delete-comment" data-toggle="tooltip" data-placement="top" title="{__("Delete")}">
                                <span aria-hidden="true">&times;</span>
                            </button>

                        </div>
                    {else}
                        <div class="comment-btn">
                            <button type="button" class="close js_report-comment" data-toggle="tooltip" data-placement="top" title="{__("Report")}">
                                <span aria-hidden="true">&times;</span>
                            </button>
                        </div>
                    {/if}
                {elseif $comment['user_type'] == "page"}
                    {if $post['page_admin'] == $user->_data['user_id'] || $photo['page_admin'] == $user->_data['user_id'] || $comment['post']['is_page_admin']}
                        <div class="comment-btn">
                            <button type="button" class="close js_delete-comment" data-toggle="tooltip" data-placement="top" title="{__("Delete")}">
                                <span aria-hidden="true">&times;</span>
                            </button>
                        </div>
                    {else}
                        <div class="comment-btn">
                            <button type="button" class="close js_report-comment" data-toggle="tooltip" data-placement="top" title="{__("Report")}">
                                <span aria-hidden="true">&times;</span>
                            </button>
                        </div>
                    {/if}
                {/if}
            {/if}
            <div class="mb5">
                <span class="text-semibold js_user-popover" data-type="{$comment['user_type']}" data-uid="{$comment['user_id']}">
                    <a href="{$comment['comment_author_url']}" >{$comment['comment_author_name']}</a>
                </span>
                {if $comment['comment_author_verified']}
                <i data-toggle="tooltip" data-placement="top" title="{__("Perfil verificado")}" class="fa fa-check verified-badge"></i>
                {/if}
                {$comment['text']}
                {if $comment['image'] != ""}
                    <span class="text-link js_lightbox-nodata" data-image="{$comment['image']}">
                        <img alt="" class="img-responsive" src="{$system['system_uploads']}/{$comment['image']}">
                    </span>
                {/if}
            </div>
            <div>
                <span class="text-muted js_moment" data-time="{$comment['time']}">{$comment['time']}</span>
                · 
                {if $comment['i_like']}
                <span class="text-link js_unlike-comment">{__("Unlike")}</span>
                {else}
                <span class="text-link js_like-comment">{__("Like")}</span>
                {/if}
                <span class="js_comment-likes {if {$comment['likes']} == 0}x-hidden{/if}">
                    · 
                    <span class="text-link" data-toggle="modal" data-url="posts/who_likes.php?comment_id={$comment['comment_id']}"><i class="fa fa-thumbs-o-up"></i> <span class="js_comment-likes-num">{$comment['likes']}</span></span>
                </span>
            </div>
        </div>
    </div>
</li>