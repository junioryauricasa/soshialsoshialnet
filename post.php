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
if(!isset($_GET['post_id']) || !is_numeric($_GET['post_id'])) {
	_error(404);
}

try {

	// get post
	$post = $user->get_post($_GET['post_id'], true, false);
	if(!$post)  {
		_error(404);
	}
	/* assign variables */
	$smarty->assign('post', $post);

	// page header
	page_header($post['post_author_name']);

	// get ads
	$ads = $user->ads('post');
	/* assign variables */
	$smarty->assign('ads', $ads);

	// get widget
	$widget = $user->widget('post');
	/* assign variables */
	$smarty->assign('widget', $widget);

} catch (Exception $e) {
	_error(__("Error"), $e->getMessage());
}

// page footer
page_footer("post");

?>