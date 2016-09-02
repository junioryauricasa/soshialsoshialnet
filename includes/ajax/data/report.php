<?php
/**
 * ajax -> data -> report
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
$valid['do'] = array('report_user', 'report_page', 'report_group', 'report_post', 'unreport_post', 'report_comment', 'unreport_comment');
if(!in_array($_POST['do'], $valid['do'])) {
	_error(400);
}
/* check post id */
if(!isset($_POST['id']) || !is_numeric($_POST['id'])) {
	_error(400);
}

// report
try {

	// initialize the return array
	$return = array();

	switch ($_POST['do']) {

		case 'report_user':
			$user->report($_POST['id'], 'user');
			modal(SUCCESS, __("Thanks"), __("Your report has been submitted"));
			break;

		case 'report_page':
			$user->report($_POST['id'], 'page');
			modal(SUCCESS, __("Thanks"), __("Your report has been submitted"));
			break;

		case 'report_group':
			$user->report($_POST['id'], 'group');
			modal(SUCCESS, __("Thanks"), __("Your report has been submitted"));
			break;

		case 'report_post':
			$user->report($_POST['id'], 'post');
			break;

		case 'unreport_post':
			$user->unreport($_POST['id'], 'post');
			break;

		case 'report_comment':
			$user->report($_POST['id'], 'comment');
			break;

		case 'unreport_comment':
			$user->unreport($_POST['id'], 'comment');
			break;
	}

	// return & exit
	return_json($return);

}catch (Exception $e) {
	modal(ERROR, __("Error"), $e->getMessage());
}

?>