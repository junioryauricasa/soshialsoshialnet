<?php
/**
 * ajax -> users -> popover
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
$valid['type'] = array('user', 'page');
if(!in_array($_GET['type'], $valid['type'])) {
	_error(400);
}
/* check uid */
if(!isset($_GET['uid']) || !is_numeric($_GET['uid'])) {
	_error(400);
}

// get popover
try {

	// initialize the return array
	$return = array();

	// get (user|page) popover
	$profile = $user->popover($_GET['uid'], $_GET['type']);
	if($profile) {
		/* assign variables */
		$smarty->assign('type', $_GET['type']);
		$smarty->assign('profile', $profile);
		/* return */
		$return['popover'] = $smarty->fetch("ajax.popover.tpl");
	}

	// return & exit
	return_json($return);

}catch (Exception $e) {
	modal(ERROR, __("Error"), $e->getMessage());
}

?>