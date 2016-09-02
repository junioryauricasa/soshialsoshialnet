<?php
/**
 * ajax -> chat -> initialize
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

// initialize opened chat boxes session if not
if(!isset($_SESSION['chat_boxes_opened'])) {
    $_SESSION['chat_boxes_opened'] = array();
}

// get opened chat boxes session
try {

	// get opened chat boxes
	$conversations = array();
	if(!empty($_SESSION['chat_boxes_opened'])) {
		foreach($_SESSION['chat_boxes_opened'] as $opened_conversation_id) {
			$conversation = $user->get_conversation($opened_conversation_id);
			if($conversation) {
				$conversations[] = $conversation;
			}
		}
	}
	return_json($conversations);

}catch (Exception $e) {
	modal(ERROR, __("Error"), $e->getMessage());
}

?>