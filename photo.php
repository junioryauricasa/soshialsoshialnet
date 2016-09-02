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
if(!isset($_GET['photo_id']) || !is_numeric($_GET['photo_id'])) {
	_error(403);
}

try {

	// get photo
	$photo = $user->get_photo($_GET['photo_id']);
	if(!$photo) {
		_error(404);
	}
	/* assign variables */
	$smarty->assign('photo', $photo);

	// get post
	$post = $user->get_post($photo['post_id'], false);
	if(!$post) {
		_error(404);
	}
	/* assign variables */
	$smarty->assign('post', $post);

	// page header
	page_header($post['post_author_name']);

	// get ads
	$ads = $user->ads('photo');
	/* assign variables */
	$smarty->assign('ads', $ads);

	// get widget
	$widget = $user->widget('photo');
	/* assign variables */
	$smarty->assign('widget', $widget);

} catch (Exception $e) {
	_error(__("Error"), $e->getMessage());
}

// page footer
page_footer("photo");

?>