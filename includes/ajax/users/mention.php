<?php
/**
 * ajax -> data -> mention
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
if(!isset($_POST['query'])) {
	_error(400);
}

// mention
try {

	// initialize the return array
	$return = array();

	// get users
	$users = $user->get_users($_POST['query']);
	if(count($users) > 0) {
		/* assign variables */
		$smarty->assign('users', $users);
		/* return */
		$return['mention'] = $smarty->fetch("ajax.mention.tpl");
	}

	// return & exit
	return_json($return);

}catch (Exception $e) {
	modal(ERROR, __("Error"), $e->getMessage());
}


?>