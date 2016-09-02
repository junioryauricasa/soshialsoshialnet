<?php
/**
 * ajax -> users -> settings
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
$valid['edit'] = array('username', 'email', 'password', 'basic', 'work', 'location', 'education', 'privacy', 'chat');
if(!in_array($_GET['edit'], $valid['edit'])) {
    _error(400);
}

// settings
try {

	if($_GET['edit'] == "username") {

		/* valid inputs */
		if(!isset($_POST['username'])) {
			_error(400);
		}
		$args = array();
		$args['edit'] = $_GET['edit'];
		$args['username'] = $_POST['username'];
		$user->settings($args);
		return_json( array('success' => true, 'message' => __("Done, Your username has been updated")) );

	} elseif ($_GET['edit'] == "email") {

		/* valid inputs */
		if(!isset($_POST['email'])) {
			_error(400);
		}
		$args = array();
		$args['edit'] = $_GET['edit'];
		$args['email'] = $_POST['email'];
		$user->settings($args);
		return_json( array('success' => true, 'message' => __("Done, Your email has been updated")) );

	} elseif ($_GET['edit'] == "password") {

		/* valid inputs */
		if(!isset($_POST['current']) || !isset($_POST['new']) || !isset($_POST['confirm']) ) {
			_error(400);
		}
		$args = array();
		$args['edit'] = $_GET['edit'];
		$args['current'] = $_POST['current'];
		$args['new'] = $_POST['new'];
		$args['confirm'] = $_POST['confirm'];
		$user->settings($args);
		return_json( array('success' => true, 'message' => __("Done, Your password has been updated")) );
		
	} elseif ($_GET['edit'] == "basic") {

		/* valid inputs */
		if(!isset($_POST['fullname']) || !isset($_POST['gender']) || !isset($_POST['birth_month']) || !isset($_POST['birth_day']) || !isset($_POST['birth_year']) ) {
			_error(400);
		}
		$args = array();
		$args['edit'] = $_GET['edit'];
		$args['fullname'] = $_POST['fullname'];
		$args['gender'] = $_POST['gender'];
		$args['birth_month'] = $_POST['birth_month'];
		$args['birth_day'] = $_POST['birth_day'];
		$args['birth_year'] = $_POST['birth_year'];
		$user->settings($args);
		return_json( array('success' => true, 'message' => __("Done, Your profile info has been updated")) );

	} elseif ($_GET['edit'] == "work") {

		/* valid inputs */
		if(!isset($_POST['work_title']) || !isset($_POST['work_place']) ) {
			_error(400);
		}
		$args = array();
		$args['edit'] = $_GET['edit'];
		$args['work_title'] = $_POST['work_title'];
		$args['work_place'] = $_POST['work_place'];
		$user->settings($args);
		return_json( array('success' => true, 'message' => __("Done, Your profile info has been updated")) );

	} elseif ($_GET['edit'] == "location") {

		/* valid inputs */
		if(!isset($_POST['city']) || !isset($_POST['hometown']) ) {
			_error(400);
		}
		$args = array();
		$args['edit'] = $_GET['edit'];
		$args['city'] = $_POST['city'];
		$args['hometown'] = $_POST['hometown'];
		$user->settings($args);
		return_json( array('success' => true, 'message' => __("Done, Your profile info has been updated")) );

	} elseif ($_GET['edit'] == "education") {

		/* valid inputs */
		if(!isset($_POST['edu_major']) || !isset($_POST['edu_school']) || !isset($_POST['edu_class'])) {
			_error(400);
		}
		$args = array();
		$args['edit'] = $_GET['edit'];
		$args['edu_major'] = $_POST['edu_major'];
		$args['edu_school'] = $_POST['edu_school'];
		$args['edu_class'] = $_POST['edu_class'];
		$user->settings($args);
		return_json( array('success' => true, 'message' => __("Done, Your profile info has been updated")) );

	} elseif ($_GET['edit'] == "privacy") {

		/* valid inputs */
		if(!isset($_POST['privacy_chat']) || !isset($_POST['privacy_birthdate']) || !isset($_POST['privacy_work']) || !isset($_POST['privacy_location']) || !isset($_POST['privacy_education'])) {
			_error(400);
		}
		$args = array();
		$args['edit'] = $_GET['edit'];
		$args['privacy_chat'] = $_POST['privacy_chat'];
		$args['privacy_birthdate'] = $_POST['privacy_birthdate'];
		$args['privacy_work'] = $_POST['privacy_work'];
		$args['privacy_location'] = $_POST['privacy_location'];
		$args['privacy_education'] = $_POST['privacy_education'];
		$args['privacy_friends'] = $_POST['privacy_friends'];
		$args['privacy_pages'] = $_POST['privacy_pages'];
		$args['privacy_groups'] = $_POST['privacy_groups'];
		$user->settings($args);
		return_json( array('success' => true, 'message' => __("Done, Your privacy settings have been updated")) );

	} elseif ($_GET['edit'] == "chat") {

		/* valid inputs */
		if(!isset($_POST['privacy_chat'])) {
			_error(400);
		}
		$args = array();
		$args['edit'] = $_GET['edit'];
		$args['privacy_chat'] = $_POST['privacy_chat'];
		$user->settings($args);
		return_json( array('success' => true, 'message' => __("Done, Your privacy settings have been updated")) );

	}

}catch (Exception $e) {
	return_json( array('error' => true, 'message' => $e->getMessage()) );
}

?>