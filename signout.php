<?php
/**
 * signup
 * 
 * @package Marsesweb v2+
 * @author Marwin Silva
 */

// fetch bootstrap
require('bootstrap.php');

// check user logged in
if(!$user->_logged_in) {
	_redirect();
}

// sign out
$user->sign_out();
_redirect();

?>