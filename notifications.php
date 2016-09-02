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

// page header
page_header(__("Notifications"));


// notifications
try {

	// reset live counters
	$user->live_counters_reset('notifications');

	// get ads
	$ads = $user->ads('notifications');
	/* assign variables */
	$smarty->assign('ads', $ads);

	// get widget
	$widget = $user->widget('notifications');
	/* assign variables */
	$smarty->assign('widget', $widget);


}catch (Exception $e) {
	_error(__("Error"), $e->getMessage());
}

// page footer
page_footer("notifications");

?>