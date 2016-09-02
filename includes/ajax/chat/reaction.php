<?php
/**
 * ajax -> chat -> reaction
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
$valid['do'] = array('close', 'delete');
if(!in_array($_POST['do'], $valid['do'])) {
	_error(400);
}
/* check post id */
if(!isset($_POST['conversation_id']) || !is_numeric($_POST['conversation_id'])) {
	_error(400);
}

// reaction
try {

	// initialize the return array
	$return = array();

	switch ($_POST['do']) {
		
		case 'close':
			/* unset from opened chat boxes & return */
			if(($key = array_search($_POST['conversation_id'], $_SESSION['chat_boxes_opened'])) !== false) {
				unset($_SESSION['chat_boxes_opened'][$key]);
				/* reindex the array */
				$_SESSION['chat_boxes_opened'] = array_values($_SESSION['chat_boxes_opened']);
			}
			break;

		case 'delete':
			$user->delete_conversation($_POST['conversation_id']);
			/* unset from opened chat boxes & return */
			if(($key = array_search($_POST['conversation_id'], $_SESSION['chat_boxes_opened'])) !== false) {
				unset($_SESSION['chat_boxes_opened'][$key]);
				/* reindex the array */
				$_SESSION['chat_boxes_opened'] = array_values($_SESSION['chat_boxes_opened']);
			}
			$return['callback'] = 'window.location = "'.$system['system_url'].'/messages"';
			break;
		
	}

	// return & exit
	return_json($return);

}catch (Exception $e) {
	modal(ERROR, __("Error"), $e->getMessage());
}

?>