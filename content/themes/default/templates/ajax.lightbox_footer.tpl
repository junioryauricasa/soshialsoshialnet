<div class="post-footer">

	<!-- post stats -->
	<div class="post-stats {if {$photo['likes']} == 0}x-hidden{/if}">
		<!-- likes -->
		<span class="js_photo-likes {if {$photo['likes']} == 0}x-hidden{/if}">
			<i class="fa fa-thumbs-o-up"></i> <span class="text-link" data-toggle="modal" data-url="posts/who_likes.php?photo_id={$photo['photo_id']}"><span class="js_photo-likes-num">{$photo['likes']}</span> {__("people")}</span> {__("like this")}
		</span>
		<!-- likes -->
	</div>
	<!-- post stats -->

	<!-- comments -->
	{include file='__feeds_photo.comments.tpl'}
	<!-- comments -->
</div>