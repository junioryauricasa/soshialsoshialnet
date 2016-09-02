<?php
/**
 * ajax -> posts -> lightbox
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

// valid inputs
if(!isset($_POST['id']) || !is_numeric($_POST['id'])) {
	_error(400);
}

// lightbox
try {

	// initialize the return array
	$return = array();

	// get photo
	$photo = $user->get_photo($_POST['id']);
	if(!$photo)  {
		_error(400);
	}
	/* assign variables */
	$smarty->assign('photo', $photo);
	/* return */
	$return['next'] = $photo['next'];
	$return['prev'] = $photo['prev'];
	$return['actions'] = $smarty->fetch("ajax.lightbox_actions.tpl");
	$return['footer'] = $smarty->fetch("ajax.lightbox_footer.tpl");

	// return & exit
	return_json($return);

}catch (Exception $e) {
	modal(ERROR, __("Error"), $e->getMessage());
}


?>