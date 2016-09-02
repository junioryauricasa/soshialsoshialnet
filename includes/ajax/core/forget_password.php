<?php
/**
 * ajax -> users -> forget password
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

// forget password
try {
	$user->forget_password($_POST['email'], $_POST['g-recaptcha-response']);
	modal("#forget-password-confirm", "{email: '".$_POST['email']."'}");
}catch (Exception $e) {
	return_json( array('error' => true, 'message' => $e->getMessage()) );
}

?>