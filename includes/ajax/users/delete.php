<?php
/**
 * ajax -> users -> delete
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

// delete
try {

	// delete user
	$user->delete_user($user->_data['user_id']);

	// return & exit
	return_json();

}catch (Exception $e) {
	modal(ERROR, __("Error"), $e->getMessage());
}

?>