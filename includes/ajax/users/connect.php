<?php
/**
 * ajax -> users -> connect
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
$valid['do'] = array('block', 'unblock', 'friend-accept', 'friend-decline', 'friend-add', 'friend-cancel', 'friend-remove', 'follow', 'unfollow', 'like', 'unlike', 'join', 'leave');
if(!in_array($_POST['do'], $valid['do'])) {
	_error(400);
}
/* check id */
if(!isset($_POST['id']) || !is_numeric($_POST['id'])) {
	_error(400);
}

// connect api
try {

	// connect user
	$user->connect($_POST['do'], $_POST['id']);

	// return & exit
	return_json();

}catch (Exception $e) {
	modal(ERROR, __("Error"), $e->getMessage());
}

?>