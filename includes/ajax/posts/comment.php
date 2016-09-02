<?php
/**
 * ajax -> posts -> comment
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
$valid['handle'] = array('post', 'photo');
if(!in_array($_POST['handle'], $valid['handle'])) {
	_error(400);
}
/* if id is set & not numeric */
if(!isset($_POST['id']) || !is_numeric($_POST['id'])) {
	_error(400);
}
/* if message not set */
if(!isset($_POST['message'])) {
	_error(400);
}
/* filter comment photo */
if(isset($_POST['photo'])) {
	$_POST['photo'] = _json_decode($_POST['photo']);
	/* check if valid photo */
	if(!valid_image($_POST['photo'])) {
		_error(400);
	}
}


// comment
try {

	// initialize the return array
	$return = array();

	// publish the new comment
	$comment = $user->comment($_POST['handle'], $_POST['id'], $_POST['message'], $_POST['photo']);
	/* assign variables */
	$smarty->assign('comment', $comment);
	/* return */
	$return['comment'] = $smarty->fetch("__feeds_post.comment.tpl");

	// return & exit
	return_json($return);
	
}catch (Exception $e) {
	modal(ERROR, __("Error"), $e->getMessage());
}

?>