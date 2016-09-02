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
$valid['view'] = array('', 'profile', 'privacy', 'linked', 'blocking', 'delete');
if(!in_array($_GET['view'], $valid['view'])) {
    _error(404);
}

switch ($_GET['view']) {
	case 'profile':
		// page header
		page_header(__("Settings")." &rsaquo; ".__("Edit Profile"));
		// parse birthdate
		$user->_data['user_birthdate_parsed'] = date_parse($user->_data['user_birthdate']);
		break;

	case 'privacy':
		// page header
		page_header(__("Settings")." &rsaquo; ".__("Privacy Settings"));
		break;

	case 'linked':
		// page header
		page_header(__("Settings")." &rsaquo; ".__("Linked Accounts"));
		break;

	case 'blocking':
		// page header
		page_header(__("Settings")." &rsaquo; ".__("Blocking"));

		// get blocks
		$blocks = $user->get_blocked();
		// assign variables
		$smarty->assign('blocks', $blocks);
		break;

	case 'delete':
		// page header
		page_header(__("Settings")." &rsaquo; ".__("Delete Account"));
		break;
	
	default:
		// page header
		page_header(__("Settings")." &rsaquo; ".__("Account Settings"));
		break;
}

// assign variables
$smarty->assign('view', $_GET['view']);

// page footer
page_footer("settings");

?>