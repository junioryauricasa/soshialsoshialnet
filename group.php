<?php
/**
 * signup
 * 
 * @package Marsesweb v2+
 * @author Marwin Silva
 */

// fetch bootstrap
require('bootstrap.php');

// check username
if(is_empty($_GET['username']) || !valid_username($_GET['username'])) {
	_error(404);
}

// get group info
$get_group = $db->query(sprintf("SELECT * FROM groups WHERE group_name = %s", secure($_GET['username']))) or _error(SQL_ERROR);
if($get_group->num_rows == 0) {
	_error(404);
}
$group = $get_group->fetch_assoc();
$group['group_picture'] = User::get_picture($group['group_picture'], 'group');
/* check username case */
if(strtolower($_GET['username']) == strtolower($group['group_name']) && $_GET['username'] != $group['group_name']) {
	_redirect('/groups/'.$group['group_name']);
}
/* check if the viewer joined the page */
$group['i_joined'] = false;
if($user->_logged_in) {
	$check_membership = $db->query(sprintf("SELECT * FROM groups_members WHERE group_id = %s AND user_id = %s", secure($group['group_id'], 'int'), secure($user->_data['user_id'], 'int') )) or _error(SQL_ERROR);
	if($check_membership->num_rows > 0) {
		$group['i_joined'] = true;
	}
}

// page header
page_header($group['group_title']);

// content
if(is_empty($_GET['view'])) {

	try {
		// get posts
		$posts = $user->get_posts( array('group_id' => $group['group_id']) );
		/* assign variables */
		$smarty->assign('posts', $posts);
	} catch (Exception $e) {
		_error(__("Error"), $e->getMessage());
	}

}elseif ($_GET['view'] == "members") {

	try {
		// get group members
		if($group['group_members'] > 0) {
			$group['members'] = $user->get_members($group['group_id']);
		}
	} catch (Exception $e) {
		_error(__("Error"), $e->getMessage());
	}

} elseif ($_GET['view'] == "settings") {

	/* check if the user is the page admin */
	if($user->_data['user_id'] != $group['group_admin']) {
		_error(404);
	}

}else {	
	_error(404);
}

// assign variables
$smarty->assign('group', $group);
$smarty->assign('view', $_GET['view']);

// page footer
page_footer("group");

?>