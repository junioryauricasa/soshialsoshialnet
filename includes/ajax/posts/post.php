<?php
/**
 * ajax -> posts -> post
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
$valid['handle'] = array('user', 'page', 'group');
if(!in_array($_POST['handle'], $valid['handle'])) {
	_error(400);
}
/* if both photos & link are exsist */
if(isset($_POST['photos']) && isset($_POST['link'])) {
	_error(400);
}
/* if both photos & video are exsist */
if(isset($_POST['photos']) && isset($_POST['video'])) {
	_error(400);
}
/* if both link & video are exsist */
if(isset($_POST['link']) && isset($_POST['video'])) {
	_error(400);
}
/* filter photos */
$photos = array();
if(isset($_POST['photos'])) {
	$_POST['photos'] = _json_decode($_POST['photos']);
	if(!is_object($_POST['photos'])) {
		_error(400);
	}
	/* filter the photos */
	foreach($_POST['photos'] as $photo) {
		if(valid_image($photo)) {
			$photos[] = $photo;
		}
	}
	if(count($photos) == 0) {
		_error(400);
	}
}
/* filter link */
if(isset($_POST['video'])) {
	$_POST['video'] = _json_decode($_POST['video']);
	if(!is_object($_POST['video'])) {
		_error(400);
	}
}
/* filter link */
if(isset($_POST['link'])) {
	$_POST['link'] = _json_decode($_POST['link']);
	if(!is_object($_POST['link'])) {
		_error(400);
	}
}


// publisher
try {

	// initialize the return array
	$return = $inputs = array();


	// publish the new post
	if($_POST['handle'] == 'page' || $_POST['handle'] == 'group') {
		if(!isset($_POST['id']) || !is_numeric($_POST['id'])) {
			_error(400);
		}
		$inputs['id'] = $_POST['id'];
		$inputs['privacy'] = 'public';
	} else {
		/* if privacy set and not valid */
		$valid['privacy'] = array('friends', 'public');
		if(!isset($_POST['privacy']) || !in_array($_POST['privacy'], $valid['privacy'])) {
			_error(400);
		}
		$inputs['privacy'] = $_POST['privacy'];

	}
	/* prepare inputs */
	$inputs['handle'] = $_POST['handle'];
	$inputs['message'] = $_POST['message'];
	$inputs['photos'] = $photos;
	$inputs['video'] = $_POST['video'];
	$inputs['link'] = $_POST['link'];
	$inputs['location'] = $_POST['location'];
	/* publish */
	$post = $user->publisher($inputs);
	/* assign variables */
	$smarty->assign('post', $post);
	/* return */
	$return['post'] = $smarty->fetch("__feeds_post.tpl");

	// return & exit
	return_json($return);
	
}catch (Exception $e) {
	modal(ERROR, __("Error"), $e->getMessage());
}

?>