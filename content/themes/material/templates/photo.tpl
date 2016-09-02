{include file='_head.tpl'}
{include file='_header.tpl'}

<!-- page content -->
<div class="container mt20">
	<div class="row">

		<!-- left panel -->
		<div class="col-sm-8">

			<!-- post -->
    		<div class="post" data-id="{$photo['photo_id']}">

    			<!-- post body -->
    			<div class="post-body">

    				<!-- post header -->
    				<div class="post-header">
    					<!-- post picture -->
    					<div class="post-avatar">
    						<a class="post-avatar-picture" href="{$post['post_author_url']}" style="background-image:url({$post['post_picture']});">
                            </a>
    					</div>
    					<!-- post picture -->

    					<!-- post meta -->
    					<div class="post-meta">
    						<!-- post author name & menu -->
    						<div>
    							<!-- post author name -->
    							<span class="js_user-popover" data-type="{$post['user_type']}" data-uid="{$post['user_id']}">
    								<a href="{$post['post_author_url']}">{$post['post_author_name']}</a>
    							</span>
    							<!-- post author name -->
    						</div>
    						<!-- post author name & menu -->

    						<!-- post time & location & privacy -->
    						<div class="post-time">
    							<a href="{$system['system_url']}/posts/{$post['post_id']}" class="js_moment" data-time="{$post['time']}">{$post['time']}</a>

    							{if $post['location']}
    							·
    							<i class="fa fa-map-marker"></i> <span>{$post['location']}</span>
    							{/if}

    							- 
    							{if $post['privacy'] == "friends"}
    							<i class="fa fa-users" data-toggle="tooltip" data-placement="top" title="{__("Shared with")}: {__("Friends")}"></i>
    							{else}
    							<i class="fa fa-globe" data-toggle="tooltip" data-placement="top" title="{__("Shared with")}: {__("Public")}"></i>
    							{/if}
    						</div>
    						<!-- post time & location & privacy -->
    					</div>
    					<!-- post meta -->
    				</div>
    				<!-- post header -->

                    <!-- photo -->
    				<div class="post-photo-preview">
						<img alt="" class="img-responsive" src="{$system['system_uploads']}/{$photo['source']}">
					</div>
                    <!-- photo -->

                    <!-- post actions -->
                    {include file='ajax.lightbox_actions.tpl'}
                    <!-- post actions -->

    			</div>

				<!-- post footer -->
				{include file='ajax.lightbox_footer.tpl'}
				<!-- post footer -->

			</div>
		</div>
		<!-- left panel -->

		<!-- right panel -->
		<div class="col-sm-4">
        {include file='__ads.tpl'}
        {include file='__widget.tpl'}
		</div>
		<!-- right panel -->

	</div>
</div>
<!-- page content -->

{include file='_footer.tpl'}