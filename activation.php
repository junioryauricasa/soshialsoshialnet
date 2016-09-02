<?php
/**
 * signup
 * 
 * @package Marsesweb v2+
 * @author Marwin Silva
 */

// fetch bootstrap
require('bootstrap.php');

// valid inputs
/* if both (id & token) not set */
if(!isset($_GET['id']) && !isset($_GET['token'])) {
	_error(404);
}

// activation
try {

	$user->activation($_GET['id'], $_GET['token']);
	_redirect();

} catch (Exception $e) {
	_error(__("Error"), $e->getMessage());
}

?>