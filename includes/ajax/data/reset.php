<?php
/**
 * ajax -> data -> reset
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
$valid['reset'] = array('friend_requests', 'messages', 'notifications');
if(!isset($_POST['reset']) || !in_array($_POST['reset'], $valid['reset'])) {
	_error(400);
}

// reset live counters
try {

	$user->live_counters_reset($_POST['reset']);
	return_json();

}catch (Exception $e) {
	modal(ERROR, __("Error"), $e->getMessage());
}

?>