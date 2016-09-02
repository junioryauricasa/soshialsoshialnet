<?php
/**
 * ajax -> posts -> likes
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
/* if post_id & photo_id & comment_id not set */
if(!isset($_GET['post_id']) && !isset($_GET['photo_id']) && !isset($_GET['comment_id'])) {
	_error(400);
}
/* if post_id set but not numeric */
if(isset($_GET['post_id']) && !is_numeric($_GET['post_id'])) {
	_error(400);
}
/* if photo_id set but not numeric */
if(isset($_GET['photo_id']) && !is_numeric($_GET['photo_id'])) {
	_error(400);
}
/* if comment_id set but not numeric */
if(isset($_GET['comment_id']) && !is_numeric($_GET['comment_id'])) {
	_error(400);
}


// get likes
try {

	// initialize the return array
	$return = array();

	// get users who
	if(isset($_GET['post_id'])) {
		/* like this post */
		$users = $user->who_likes( array('post_id' => $_GET['post_id']) );
		$get = 'post_likes';
		$id = $_GET['post_id'];
	} elseif (isset($_GET['photo_id'])) {
		/* like this photo */
		$users = $user->who_likes( array('photo_id' => $_GET['photo_id']) );
		$get = 'photo_likes';
		$id = $_GET['photo_id'];
	} else {
		/* like this comment */
		$users = $user->who_likes( array('comment_id' => $_GET['comment_id']) );
		$get = 'comment_likes';
		$id = $_GET['comment_id'];
	}
	/* assign variables */
	$smarty->assign('users', $users);
	$smarty->assign('get', $get);
	$smarty->assign('id', $id);
	/* return */
	$return['template'] = $smarty->fetch("ajax.who_likes.tpl");
	$return['callback'] = "$('#modal').modal('show'); $('.modal-content:last').html(response.template);";

	// return & exit
	return_json($return);

}catch (Exception $e) {
	modal(ERROR, __("Error"), $e->getMessage());
}


?>