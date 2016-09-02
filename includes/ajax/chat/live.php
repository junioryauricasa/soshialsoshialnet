<?php
/**
 * ajax -> chat -> live
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

// valid inputs
if(!isset($_POST['chat_enabled']) || !isset($_POST['chat_boxes_opened_client'])) {
	_error(400);
}
/* if chat_boxes_opened_client not array */
$_POST['chat_boxes_opened_client'] = json_decode($_POST['chat_boxes_opened_client'], true);
if(!is_array($_POST['chat_boxes_opened_client'])) {
	_error(400);
}
/* filter the client opened chat boxes */
$chat_boxes_opened_client = array();
foreach($_POST['chat_boxes_opened_client'] as $key => $value) {
	if(is_numeric($key) && is_numeric($value)) {
		$chat_boxes_opened_client[$key] = $value;
	}
}

/* if opened_thread isset */
if(isset($_POST['opened_thread'])) {
	$_POST['opened_thread'] = json_decode($_POST['opened_thread'], true);
	if(!is_array($_POST['opened_thread'])) {
		_error(400);
	}
	if(!is_numeric($_POST['opened_thread']['conversation_id']) || !is_numeric($_POST['opened_thread']['last_message_id'])) {
		_error(400);
	}
}

// get chat live updates
try {

	// initialize the return array
	$return = array();

	// [0] [update] master chat sidebar (users)	
	/* get online friends */
	$online_friends = $user->get_online_friends();
	/* get offline friends */
	$offline_friends = $user->get_offline_friends();
	/* get sidebar friends */
	$sidebar_friends = array_merge( $online_friends, $offline_friends );
	// assign variables
	$smarty->assign('online_friends', $online_friends);
	$smarty->assign('sidebar_friends', $sidebar_friends);
	/* return */
	$return['master']['head'] = $smarty->fetch("ajax.chat.master.head.tpl");
	$return['master']['sidebar'] = $smarty->fetch("ajax.chat.master.sidebar.tpl");

	// [1] [update] master chat widget (online users)
	/* check chat status on both (client side & server side) */
	if($user->_data['user_chat_enabled']) {
		// assign variables
		$smarty->assign('offline', false);
		/* return */
		$return['master']['chat_enabled'] = '1';
		$return['master']['content'] = $smarty->fetch("ajax.chat.master.content.tpl");
	} elseif (!$user->_data['user_chat_enabled'] && $_GET['chat_enabled']) {
		/* go offline */
		/* assign variables */
		$smarty->assign('offline', true);
		/* return */
		$return['master']['chat_enabled'] = '0';
		$return['master']['content'] = "";
	}

	// [2] & [3] & [4]
	if(!(empty($chat_boxes_opened_client) && empty($_SESSION['chat_boxes_opened']))) {

		// [2] [get] closed chat boxes
		$chat_boxes_closed = array_diff(array_keys($chat_boxes_opened_client), $_SESSION['chat_boxes_opened']);
		if(count($chat_boxes_closed) > 0) {
			$return['chat_boxes_closed'] = $chat_boxes_closed;
		}

		// [3] [get] opened chat boxes
		$chat_boxes_pre_opened = array_diff($_SESSION['chat_boxes_opened'], array_keys($chat_boxes_opened_client));
		foreach($chat_boxes_pre_opened as $opened_conversation_id) {
			/* get conversation */
			$conversation = $user->get_conversation($opened_conversation_id);
			if($conversation) {
				$chat_boxes_opened[] = $conversation;
			}
		}
		if(count($chat_boxes_opened) > 0) {
			$return['chat_boxes_opened'] = $chat_boxes_opened;
		}

		// [4] [get] updated chat boxes
		$chat_boxes_pre_updated = array_intersect($_SESSION['chat_boxes_opened'], array_keys($chat_boxes_opened_client));
		foreach($chat_boxes_pre_updated as $updated_conversation_id) {
			/* get conversation */
			$conversation = $user->get_conversation($updated_conversation_id);
			if($conversation) {
				$return_this = false;
				/* check single user's chat status (online|offline) */
				if(!$conversation['multiple_recipients']) {
					$return_this = true;
					/* update unary user's chat status */
					$conversation['user_online'] = ($user->user_online($conversation['ids']))? true: false;
				}
				/* check for a new messages for this chat box */
				if($conversation['last_message_id'] != $chat_boxes_opened_client[$conversation['conversation_id']]) {
					$return_this = true;
					/* get new messages */
					$messages = $user->get_conversation_messages($conversation['conversation_id'], 0, $chat_boxes_opened_client[$conversation['conversation_id']]);
					/* assign variables */
					$smarty->assign('messages', $messages);
					/* return */
					$last_message = end($messages);
					$conversation['is_me'] = ($last_message['user_id'] == $user->_data['user_id'])? true: false;
					$conversation['messages_count'] = count($messages);
					$conversation['messages'] = $smarty->fetch("ajax.chat.messages.tpl");
				}
				if($return_this) {
					$chat_boxes_updated[] = $conversation;
				}
			}
		}
	    if(count($chat_boxes_updated) > 0) {
	    	$return['chat_boxes_updated'] = $chat_boxes_updated;
	    }
	}

	// [5] [get] new chat boxes
	$chat_boxes_new = $user->get_conversations_new();
	if(count($chat_boxes_new) > 0) {
		$return['chat_boxes_new'] = $chat_boxes_new;
	}

	// [6] [get] updated thread
	if(isset($_POST['opened_thread'])) {
		/* get conversation */
		$conversation = $user->get_conversation($_POST['opened_thread']['conversation_id']);
		if($conversation) {
			/* check for a new messages for this converstaion */
			if($conversation['last_message_id'] != $_POST['opened_thread']['last_message_id']) {
				/* get new messages */
				$messages = $user->get_conversation_messages($conversation['conversation_id'], 0, $_POST['opened_thread']['last_message_id']);
				/* assign variables */
				$smarty->assign('messages', $messages);
				/* return */
				$conversation['messages'] = $smarty->fetch("ajax.chat.messages.tpl");
				$return['thread_updated'] = $conversation;
			}
		}
	}
    
	// return & exit
	return_json($return);

}catch (Exception $e) {
	modal(ERROR, __("Error"), $e->getMessage());
}


?>