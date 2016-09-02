<?php
/**
 * signup
 * 
 * @package Marsesweb v2+
 * @author Marwin Silva
 */

// fetch bootstrap
require('bootstrap.php');

// user access
user_access();

// page header
page_header(__("Messages"));


// check cid
if(!isset($_GET['cid'])) {
	if(count($user->_data['conversations']) > 0) {
		$conversation = $user->_data['conversations'][0];
		try {
			$conversation['messages'] = $user->get_conversation_messages($conversation['conversation_id']);
		} catch (Exception $e) {
			_error(__("Error"), $e->getMessage());
		}
	}
} else {
	/* check cid is valid */
	if(is_empty($_GET['cid']) || !is_numeric($_GET['cid'])) {
		_error(404);
	}
	try {
		$conversation = $user->get_conversation($_GET['cid']);
		$conversation['messages'] = $user->get_conversation_messages($conversation['conversation_id']);
    } catch (Exception $e) {
        _error(__("Error"), $e->getMessage());
    }
	
}


// assign variables
$smarty->assign('conversation', $conversation);

// page footer
page_footer("messages");

?>