<?php
/**
 * ajax -> chat -> post
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
/* if message not set */
if(!isset($_POST['message'])) {
	_error(400);
}
/* if both (conversation_id & recipients) not set */
if(!isset($_POST['conversation_id']) && !isset($_POST['recipients'])) {
	_error(400);
}
/* if conversation_id set but not numeric */
if(isset($_POST['conversation_id']) && !is_numeric($_POST['conversation_id'])) {
	_error(400);
}
/* if recipients not array */
if(isset($_POST['recipients'])) {
	$_POST['recipients'] = _json_decode($_POST['recipients']);
	if(!is_array($_POST['recipients'])) {
		_error(400);
	}
	/* recipients must contain numeric values only */
	$_POST['recipients'] = array_filter($_POST['recipients'], 'is_numeric');
	/* check blocking */
	foreach($_POST['recipients'] as $recipient) {
		if($user->blocked($recipient)) {
			_error(403);
		}
	}
}
/* filter message photo */
if(isset($_POST['photo'])) {
	$_POST['photo'] = _json_decode($_POST['photo']);
	/* check if valid photo */
	if(!valid_image($_POST['photo'])) {
		_error(400);
	}
}


// post message
try {

	$conversation = $user->post_conversation_message($_POST['message'], $_POST['photo'], $_POST['conversation_id'], $_POST['recipients']);	
	return_json($conversation);
	
}catch (Exception $e) {
	modal(ERROR, __("Error"), $e->getMessage());
}

?>