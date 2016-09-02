{if $user->_logged_in}
<div class="comment" data-handle="{$_handle}" data-id="{$_id}">
    <div class="comment-avatar">
        <a class="comment-avatar-picture" href="{$system['system_url']}/{$user->_data['user_name']}" style="background-image:url({$user->_data['user_picture']});">
            </a>
    </div>
    <div class="comment-data">
        <div class="x-form comment-form">
            <textarea class="js_autogrow js_mention js_post-comment " placeholder="{__("Escribe un comentario...")}"></textarea>
            <div class="x-form-tools">
                <div class="x-form-tools-attach">
                    <i class="fa fa-camera js_x-uploader" data-handle="comment"></i>
                </div>
                <div class="x-form-tools-emoji js_emoji-menu-toggle">
                    <i class="fa fa-smile-o fa-lg"></i>
                </div>
                {include file='__emoji-menu.tpl'}
            </div>
        </div>
        <div class="comment-attachments attachments clearfix x-hidden">
            <ul>
                <li class="loading">
                    <div class="loader loader_small"></div>
                </li>
            </ul>
        </div>
    </div>
</div>
{/if}