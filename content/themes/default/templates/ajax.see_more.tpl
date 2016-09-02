{if $get == 'newsfeed' || $get == 'posts_profile' || $get == 'posts_page' || $get == 'posts_group'}
{foreach $data as $post}
	{include file='__feeds_post.tpl'}
{/foreach}

{elseif $get == 'shares'}
{foreach $data as $post}
	{include file='__feeds_post.tpl' _snippet=true}
{/foreach}


{elseif $get == 'post_comments' || $get == 'photo_comments'}
{foreach $data as $comment}
	{include file='__feeds_post.comment.tpl'}
{/foreach}


{elseif $get == 'post_likes' || $get == 'photo_likes' || $get == 'comment_likes' || $get == 'blocks'}
{foreach $data as $_user}
	{include file='__feeds_user.tpl' _connection=$_user["connection"]}
{/foreach}


{elseif $get == 'pages'}
{foreach $data as $_page}
	{include file='__feeds_page.tpl'}
{/foreach}


{elseif $get == 'groups'}
{foreach $data as $_group}
	{include file='__feeds_group.tpl'}
{/foreach}


{elseif $get == 'profile_pages'}
{foreach $data as $_page}
	{include file='__feeds_page.tpl' _parent="profile"}
{/foreach}


{elseif $get == 'profile_groups'}
{foreach $data as $_group}
	{include file='__feeds_group.tpl' _parent="profile"}
{/foreach}


{elseif $get == 'friend_requests'}
{foreach $data as $_user}
	{include file='__feeds_user.tpl' _connection="request"}
{/foreach}


{elseif $get == 'friend_requests_sent'}
{foreach $data as $_user}
	{include file='__feeds_user.tpl' _connection="cancel"}
{/foreach}


{elseif $get == 'mutual_friends'}
{foreach $data as $_user}
	{include file='__feeds_user.tpl' _connection="remove"}
{/foreach}


{elseif $get == 'new_people'}
{foreach $data as $_user}
	{include file='__feeds_user.tpl' _connection="add"}
{/foreach}


{elseif $get == 'friends' || $get == 'followers' || $get == 'followings' || $get == 'members'}
{foreach $data as $_user}
	{include file='__feeds_user.tpl' _connection=$_user["connection"] _parent="profile"}
{/foreach}


{elseif $get == 'notifications'}
{foreach $data as $notification}
	{include file='__feeds_notification.tpl'}
{/foreach}


{elseif $get == 'conversations'}
{foreach $data as $conversation}
	{include file='__feeds_conversation.tpl'}
{/foreach}


{elseif $get == 'messages'}
{foreach $data as $message}
	{include file='__feeds_message.tpl'}
{/foreach}


{elseif $get == 'games'}
{foreach $data as $_game}
	{include file='__feeds_game.tpl'}
{/foreach}
{/if}