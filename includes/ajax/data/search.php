<?php
/**
 * ajax -> data -> search
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
if(!isset($_POST['query'])) {
	_error(400);
}

// search
try {

	// initialize the return array
	$return = array();

	// get results
	$results = $user->search_quick($_POST['query']);
	if(count($results) > 0) {
		/* assign variables */
		$smarty->assign('results', $results);
		/* return */
		$return['results'] = $smarty->fetch("ajax.search.tpl");
	}
	
	// return & exit
	return_json($return);

}catch (Exception $e) {
	modal(ERROR, __("Error"), $e->getMessage());
}

?>