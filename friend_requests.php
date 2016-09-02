<?php
/**
 * signup
 * 
 * @package Marsesweb v2+
 * @author Marwin Silva
 */

// fetch bootstrap
require('bootstrap.php');

// user access
user_access();

// valid inputs
$valid['view'] = array('', 'sent');
if(!in_array($_GET['view'], $valid['view'])) {
	_error(404);
}

// page header
page_header(__("Friend Requests"));

try {

	// get ads
	$ads = $user->ads('requests');
	/* assign variables */
	$smarty->assign('ads', $ads);

	// get widget
	$widget = $user->widget('requests');
	/* assign variables */
	$smarty->assign('widget', $widget);
	
} catch (Exception $e) {
	_error(__("Error"), $e->getMessage());
}

// assign variables
$smarty->assign('view', $_GET['view']);

// page footer
page_footer("friend_requests");

?>