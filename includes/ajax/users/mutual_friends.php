<?php
/**
 * ajax -> users -> mutual friends
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
if(!isset($_GET['uid']) || !is_numeric($_GET['uid'])) {
	_error(400);
}

// get mutual friends
try {

	// initialize the return array
	$return = array();

	// get mutual friends
	$mutual_friends = $user->get_mutual_friends($_GET['uid']);
	/* assign variables */
	$smarty->assign('uid', $_GET['uid']);
	$smarty->assign('mutual_friends', $mutual_friends);
	/* return */
	$return['mutual_friends'] = $smarty->fetch("ajax.mutual_friends.tpl");
	$return['callback'] = "$('#modal').modal('show'); $('.modal-content:last').html(response.mutual_friends);";

	// return & exit
	return_json($return);

}catch (Exception $e) {
	modal(ERROR, __("Error"), $e->getMessage());
}


?>