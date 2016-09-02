<?php
/**
 * signup
 * 
 * @package Marsesweb v2+
 * @author Marwin Silva
 */

// fetch bootstrap
require('bootstrap.php');

// check username
if(is_empty($_GET['username']) || !valid_username($_GET['username'])) {
	_error(404);
}

// valid inputs
$valid['view'] = array('', 'friends', 'followers', 'followings', 'likes', 'groups');
if(!in_array($_GET['view'], $valid['view'])) {
	_error(404);
}


// get profile info
$get_profile = $db->query(sprintf("SELECT * FROM users WHERE user_name = %s", secure($_GET['username']))) or _error(SQL_ERROR);
if($get_profile->num_rows == 0) {
	_error(404);
}
$profile = $get_profile->fetch_assoc();
/* check if blocked by the system */
if(in_array($profile['user_id'], $user->get_banned_ids())) {
	_error(404);
}
/* check if blocked by the viwer */
if($user->_logged_in && $user->blocked($profile['user_id'])) {
	_error(404);
}

$profile['user_picture'] = User::get_picture($profile['user_picture'], $profile['user_gender']);
/* check username case */
if(strtolower($_GET['username']) == strtolower($profile['user_name']) && $_GET['username'] != $profile['user_name']) {
	_redirect('/'.$profile['user_name']);
}
/* check if we friends & follow him */
if($user->_logged_in && $profile['user_id'] != $user->_data['user_id']) {
    $profile['we_friends'] = (in_array($profile['user_id'], $user->_data['friends_ids']))? true: false;
    $profile['he_request'] = (in_array($profile['user_id'], $user->_data['friend_requests_ids']))? true: false;
    $profile['i_request'] = (in_array($profile['user_id'], $user->_data['friend_requests_sent_ids']))? true: false;
    $profile['i_follow'] = (in_array($profile['user_id'], $user->_data['followings_ids']))? true: false;
}

// get profile friends
$profile['friends_count'] = count($user->get_friends_ids($profile['user_id']));
if($profile['friends_count'] > 0) {
	$profile['friends'] = $user->get_friends($profile['user_id']);
	/* get mutual friends count between the viewer and the target */
	if($user->_logged_in && $user->_data['user_id'] != $profile['user_id']) {
		$profile['mutual_friends_count'] = $user->get_mutual_friends_count($profile['user_id']);
		$profile['mutual_friends'] = $user->get_mutual_friends($profile['user_id']);
	}
}

// get followers count
$profile['followers_count'] = count($user->get_followers_ids($profile['user_id']));


try {
	// get profile user's pages
	$profile['pages'] = $user->get_pages( array('user_id' => $profile['user_id']) );
	// get profile user's groups
	$profile['groups'] = $user->get_groups( array('user_id' => $profile['user_id']) );
} catch (Exception $e) {
	_error(__("Error"), $e->getMessage());
}

// page header
page_header($profile['user_fullname']);

// content
if(is_empty($_GET['view'])) {

	try {
		// get posts
		$posts = $user->get_posts( array('user_id' => $profile['user_id']) );
		/* assign variables */
		$smarty->assign('posts', $posts);
	} catch (Exception $e) {
		_error(__("Error"), $e->getMessage());
	}

}elseif ($_GET['view'] == "followers") {

	try {
		if($profile['followers_count'] > 0) {
			$profile['followers'] = $user->get_followers($profile['user_id']);
		}
	} catch (Exception $e) {
		_error(__("Error"), $e->getMessage());
	}

}elseif ($_GET['view'] == "followings") {

	try {
		$profile['followings_count'] = count($user->get_followings_ids($profile['user_id']));
		if($profile['followings_count'] > 0) {
			$profile['followings'] = $user->get_followings($profile['user_id']);
		}
	} catch (Exception $e) {
		_error(__("Error"), $e->getMessage());
	}

}

// assign variables
$smarty->assign('profile', $profile);
$smarty->assign('view', $_GET['view']);

// page footer
page_footer("profile");

?>