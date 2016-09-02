<?php
/**
 * ajax -> users -> signup
 * 
 * @package Marsesweb v2+
 * @author Marwin Silva
 */

// fetch bootstrap
require('../../../bootstrap.php');

// check AJAX Request
is_ajax();

// check user logged in
if($user->_logged_in) {
    return_json( array('callback' => 'window.location.reload();') );
}

// check if registration is open
if(!$system['users_can_register']) {
	return_json( array('error' => true, 'message' => __('Registration is closed right now')) );
}

// signup
try {
    $user->sign_up($_POST['full_name'], $_POST['username'], $_POST['email'], $_POST['password'], $_POST['gender'], $_POST['g-recaptcha-response']);
    return_json( array('callback' => 'window.location.reload();') );
}catch (Exception $e) {
	return_json( array('error' => true, 'message' => $e->getMessage()) );
}

?>