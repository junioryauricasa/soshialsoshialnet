<?php
/**
 * ajax -> chat -> get conversation
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
/* if conversation_id not set -> ids must be numeric */
if(!isset($_GET['conversation_id']) && !is_numeric($_GET['ids'])) {
	_error(400);
}

// get conversation
try {

	// initialize the return array
	$return = array();

	/* get conversation */
	$conversation = $user->get_conversation($_GET['conversation_id']);
	if($conversation) {
		/* get conversation messages */
		$conversation['messages'] = $user->get_conversation_messages($conversation['conversation_id']);
		/* assign variables */
		$smarty->assign('conversation', $conversation);
		/* return */
		$return['conversation'] = $smarty->fetch("ajax.chat.conversation.tpl");
	}

	// return & exit
	return_json($return);

}catch (Exception $e) {
	modal(ERROR, __("Error"), $e->getMessage());
}

?>