<?php
/**
 * ajax -> chat -> get messages
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
/* if both (conversation_id & ids) not set */
if(!isset($_GET['conversation_id']) && !isset($_GET['ids'])) {
	_error(400);
}
/* if conversation_id set -> it must be numeric */
if(isset($_GET['conversation_id']) && !is_numeric($_GET['conversation_id'])) {
	_error(400);
}
/* if conversation_id not set -> ids must be numeric */
if(!isset($_GET['conversation_id']) && !is_numeric($_GET['ids'])) {
	_error(400);
}


// get conversation messages
try {

	// initialize the return array
	$return = array();

	// initialize the conversation
	$conversation = array();

	/* if conversation_id not set -> get conversation by ids  */
	if(!isset($_GET['conversation_id'])) {
		/* ids in this case will be just a single number */
		$mutual_conversation = $user->get_mutual_conversation((array)$_GET['ids']);
		if(!$mutual_conversation) {
			/* there is no conversation between the viewer and ids -> check & exit */
			/* check single user's chat status */
			$return['user_online'] = ($user->user_online($_GET['ids']))? true: false;
			/* return & exit */
			return_json($return);
		}
		/* set the conversation_id */
		$_GET['conversation_id'] = $mutual_conversation;
		/* return to set it as chat-box cid */
		$return['conversation_id'] = $mutual_conversation;
	}

	/* check single user's chat status */
	if(is_numeric($_GET['ids'])) {
		$return['user_online'] = ($user->user_online($_GET['ids']))? true: false;
	}

	/* set conversation id */
	$conversation['conversation_id'] = $_GET['conversation_id'];

	/* get conversation messages */
	$conversation['messages'] = $user->get_conversation_messages($conversation['conversation_id']);
	
	/* get total number of messages */
	$get_total_messages = $db->query(sprintf("SELECT * FROM conversations_messages WHERE conversation_id = %s", secure($conversation['conversation_id'], 'int'))) or _error(SQL_ERROR_THROWEN);
	$conversation['total_messages'] = $get_total_messages->num_rows;

	/* assign variables */
	$smarty->assign('conversation', $conversation);
	
	/* return */
	$return['messages'] = $smarty->fetch("ajax.chat.conversation.messages.tpl");

	/* add conversation to opened chat boxes session if not */
	if(!in_array($conversation['conversation_id'], $_SESSION['chat_boxes_opened'])) {
		$_SESSION['chat_boxes_opened'][] = $conversation['conversation_id'];
	}

	// return & exit
	return_json($return);

}catch (Exception $e) {
	modal(ERROR, __("Error"), $e->getMessage());
}

?>