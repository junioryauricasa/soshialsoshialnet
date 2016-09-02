<?php
/**
 * ajax -> users -> activation email reset
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
if(!$system['email_send_activation'] || $user->_data['user_activated']) {
	modal(SUCCESS, __("Activated"), __("Your account already activated!"));
}

// activation email reset
try {
	$user->activation_email_reset($_POST['email']);
	modal(SUCCESS, __("Your email has been changed"), __("Please click on the link in that email to confirm your email address"));
}catch (Exception $e) {
	return_json( array('error' => true, 'message' => $e->getMessage()) );
}

?>