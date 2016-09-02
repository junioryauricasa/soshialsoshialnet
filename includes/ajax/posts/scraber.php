<?php
/**
 * ajax -> posts -> scraber
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
if(!isset($_POST['query']) || is_empty($_POST['query'])) {
	_error(403);
}

// scraber
try {

	// initialize the return array
	$return = array();

	$link = $user->scraper($_POST['query']);
	if($link) {
		$return['link'] = $link;
	}
	
	// return & exit
	return_json($return);

}catch (Exception $e) {
	modal(ERROR, __("Error"), $e->getMessage());
}

?>