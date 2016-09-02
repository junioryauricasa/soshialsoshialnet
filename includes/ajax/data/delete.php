<?php
/**
 * ajax -> data -> delete
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
if(!isset($_POST['id']) || !is_numeric($_POST['id'])) {
	_error(400);
}

// delete
try {

	switch ($_POST['handle']) {
		case 'page':
			$user->delete_page($_POST['id']);
			break;

		case 'group':
			$user->delete_group($_POST['id']);
			break;

		default:
			_error(400);
			break;
	}

	// return
	return_json();

} catch (Exception $e) {
	return_json( array('error' => true, 'message' => $e->getMessage()) );
}

?>