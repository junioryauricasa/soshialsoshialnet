<?php
/**
 * ajax -> users -> activation email resend
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

// activation email resend
try {
	$user->activation_email_resend();
	modal(SUCCESS, __("Another activation email has been sent"), __("Please click on the link in that email to confirm your email address"));
}catch (Exception $e) {
	modal(ERROR, __("Error"), $e->getMessage());
}

?>