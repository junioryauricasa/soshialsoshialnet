<?php
/**
 * ajax -> data -> load
 * 
 * @package Marsesweb v2+
 * @author Marwin Silva
 */

// fetch bootstrap
require('../../../bootstrap.php');

// check AJAX Request
is_ajax();

// check user logged in
if(!$user->_logged_in) {
    modal(LOGIN);
}

// check user activated
if($system['email_send_activation'] && !$user->_data['user_activated']) {
	modal(MESSAGE, __("Not Activated"), __("Before you can interact with other users, you need to confirm your email address"));
}

// valid inputs
$valid['get'] = array('newsfeed', 'posts_profile', 'posts_page', 'posts_group', 'post_comments', 'photo_comments', 'pages', 'groups', 'profile_pages', 'profile_groups', 'post_likes', 'photo_likes', 'comment_likes', 'shares', 'friend_requests', 'friend_requests_sent', 'mutual_friends', 'new_people', 'friends', 'followers', 'followings', 'notifications', 'conversations', 'messages', 'members', 'blocks', 'games');
if(!in_array($_POST['get'], $valid['get'])) {
	_error(400);
}
/* if offset not set & not numeric */
if(!isset($_POST['offset']) || !is_numeric($_POST['offset'])) {
	_error(400);
}

// load more data
try {

	// initialize the return array
	$return = array();

	// initialize the attach type
	$append = true;

	// get data
	/* get newsfeed posts */
	if($_POST['get'] == "newsfeed") {
		$data = $user->get_posts( array('offset' => $_POST['offset']) );


	/* get profile posts */
	} elseif ($_POST['get'] == "posts_profile") {
		/* check id */
		if(!isset($_POST['id']) || !is_numeric($_POST['id'])) {
			_error(400);
		}
		$data = $user->get_posts( array('user_id' => $_POST['id'], 'offset' => $_POST['offset']) );


	/* get page posts */
	} elseif ($_POST['get'] == "posts_page") {
		/* check id */
		if(!isset($_POST['id']) || !is_numeric($_POST['id'])) {
			_error(400);
		}
		$data = $user->get_posts( array('page_id' => $_POST['id'], 'offset' => $_POST['offset']) );


	/* get group posts */
	} elseif ($_POST['get'] == "posts_group") {
		/* check id */
		if(!isset($_POST['id']) || !is_numeric($_POST['id'])) {
			_error(400);
		}
		$data = $user->get_posts( array('group_id' => $_POST['id'], 'offset' => $_POST['offset']) );


	/* get post comments */
	} elseif ($_POST['get'] == "post_comments") {
		/* check id */
		if(!isset($_POST['id']) || !is_numeric($_POST['id'])) {
			_error(400);
		}
		$append = false;
		$data = $user->get_comments($_POST['id'], $_POST['offset'], true, false);


	/* get photo comments */
	} elseif ($_POST['get'] == "photo_comments") {
		/* check id */
		if(!isset($_POST['id']) || !is_numeric($_POST['id'])) {
			_error(400);
		}
		$append = false;
		$data = $user->get_comments($_POST['id'], $_POST['offset'], false, false);


	/* get who likes the post */
	} elseif ($_POST['get'] == "post_likes") {
		/* check id */
		if(!isset($_POST['id']) || !is_numeric($_POST['id'])) {
			_error(400);
		}
		$data = $user->who_likes( array('post_id' => $_POST['id'], 'offset' => $_POST['offset']) );


	/* get who likes the photo */
	} elseif ($_POST['get'] == "photo_likes") {
		/* check id */
		if(!isset($_POST['id']) || !is_numeric($_POST['id'])) {
			_error(400);
		}
		$data = $user->who_likes( array('photo_id' => $_POST['id'], 'offset' => $_POST['offset']) );


	/* get who likes the comment */
	} elseif ($_POST['get'] == "comment_likes") {
		/* check uid */
		if(!isset($_POST['id']) || !is_numeric($_POST['id'])) {
			_error(400);
		}
		$data = $user->who_likes( array('comment_id' => $_POST['id'], 'offset' => $_POST['offset']) );


	/* get who shares the post */
	} elseif ($_POST['get'] == "shares") {
		/* check id */
		if(!isset($_POST['id']) || !is_numeric($_POST['id'])) {
			_error(400);
		}
		$data = $user->who_shares($_POST['id'], $_POST['offset']);


	/* get viewer pages */
	} elseif ($_POST['get'] == "pages") {
		$data = $user->get_pages( array('offset' => $_POST['offset']) );


	/* get viewer groups */
	} elseif ($_POST['get'] == "groups") {
		$data = $user->get_groups( array('offset' => $_POST['offset']) );


	/* get profile pages */
	} elseif ($_POST['get'] == "profile_pages") {
		/* check uid */
		if(!isset($_POST['uid']) || !is_numeric($_POST['uid'])) {
			_error(400);
		}
		$data = $user->get_pages( array('user_id' => $_POST['uid'], 'offset' => $_POST['offset']) );


	/* get profile groups */
	} elseif ($_POST['get'] == "profile_groups") {
		/* check uid */
		if(!isset($_POST['uid']) || !is_numeric($_POST['uid'])) {
			_error(400);
		}
		$data = $user->get_groups( array('user_id' => $_POST['uid'], 'offset' => $_POST['offset']) );


	/* get friend requests */
	} elseif ($_POST['get'] == "friend_requests") {
		$data = $user->get_friend_requests($_POST['offset']);


	/* get mutual friends */
	} elseif ($_POST['get'] == "friend_requests_sent") {
		$data = $user->get_friend_requests_sent($_POST['offset']);


	/* get mutual friends */
	} elseif ($_POST['get'] == "mutual_friends") {
		/* check uid */
		if(!isset($_POST['uid']) || !is_numeric($_POST['uid'])) {
			_error(400);
		}
		$data = $user->get_mutual_friends($_POST['uid'], $_POST['offset']);


	/* get new people */
	} elseif ($_POST['get'] == "new_people") {
		$data = $user->get_new_people($_POST['offset']);
	

	/* get friends */
	} elseif ($_POST['get'] == "friends") {
		/* check uid */
		if(!isset($_POST['uid']) || !is_numeric($_POST['uid'])) {
			_error(400);
		}
		$data = $user->get_friends($_POST['uid'], $_POST['offset']);
	

	/* get followers */
	} elseif ($_POST['get'] == "followers") {
		/* check uid */
		if(!isset($_POST['uid']) || !is_numeric($_POST['uid'])) {
			_error(400);
		}
		$data = $user->get_followers($_POST['uid'], $_POST['offset']);
	

	/* get followings */
	} elseif ($_POST['get'] == "followings") {
		/* check uid */
		if(!isset($_POST['uid']) || !is_numeric($_POST['uid'])) {
			_error(400);
		}
		$data = $user->get_followings($_POST['uid'], $_POST['offset']);
	

	/* get notifications */
	} elseif ($_POST['get'] == "notifications") {
		$data = $user->get_notifications($_POST['offset']);
	

	/* get conversations */
	} elseif ($_POST['get'] == "conversations") {
		$data = $user->get_conversations($_POST['offset']);
	

	/* get messages */
	} elseif ($_POST['get'] == "messages") {
		/* check id */
		if(!isset($_POST['id']) || !is_numeric($_POST['id'])) {
			_error(400);
		}
		$append = false;
		$data = $user->get_conversation_messages($_POST['id'], $_POST['offset']);
	

	/* get members */
	} elseif ($_POST['get'] == "members") {
		/* check uid */
		if(!isset($_POST['id']) || !is_numeric($_POST['id'])) {
			_error(400);
		}
		$data = $user->get_members($_POST['id'], $_POST['offset']);

	/* get blocks */
	} elseif ($_POST['get'] == "blocks") {
		$data = $user->get_blocked($_POST['offset']);

	/* get games */
	} elseif ($_POST['get'] == "games") {
		$data = $user->get_games($_POST['offset']);

	}


	// handle data
	if(count($data) > 0) {
		/* assign variables */
		$smarty->assign('get', $_POST['get']);
		$smarty->assign('data', $data);
		/* return */
		$return['append'] = $append;
		$return['data'] = $smarty->fetch("ajax.see_more.tpl");
	}

	// return & exit
	return_json($return);

}catch (Exception $e) {
	modal(ERROR, __("Error"), $e->getMessage());
}


?>