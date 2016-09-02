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

// revoke
switch ($_REQUEST['provider']) {
	case 'facebook':
		$social_id = "facebook_id";
		$social_connected = "facebook_connected";
		break;

	case 'twitter':
		$social_id = "twitter_id";
		$social_connected = "twitter_connected";
		break;

	case 'google':
		$social_id = "google_id";
		$social_connected = "google_connected";
		break;

	default:
		_error(404);
		break;
}
$db->query(sprintf("UPDATE users SET $social_connected = '0', $social_id = NULL WHERE user_id = %s", secure($user->_data['user_id'], 'int') )) or _error(SQL_ERROR_THROWEN);
_redirect('/settings/linked');

?>