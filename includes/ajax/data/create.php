<?php
/**
 * ajax -> data -> create|edit <-> page|group
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
$valid['type'] = array('page', 'group');
if(!in_array($_GET['type'], $valid['type'])) {
	_error(400);
}
$valid['do'] = array('create', 'edit');
if(!in_array($_GET['do'], $valid['do'])) {
	_error(400);
}

// (create|edit) (page|group)
try {

	// initialize the return array
	$return = array();
	$return['callback'] = 'window.location.replace(response.path);';

	// page (create|edit)
	if($_GET['type'] == "page") {

		// page create
		if($_GET['do'] == "create") {
			$user->page_create($_POST['category'], $_POST['title'], $_POST['username'], $_POST['description']);
			$return['path'] = $system['system_url'].'/pages/'.$_POST['username'];

		// page edit
		} elseif($_GET['do'] == "edit") {
			/* check id */
			if(!isset($_GET['id']) || !is_numeric($_GET['id'])) {
				_error(400);
			}
			/* check if the user is the page admin */
			$check = $db->query(sprintf("SELECT * FROM pages WHERE page_id = %s AND page_admin = %s", secure($_GET['id'], 'int'), secure($user->_data['user_id'], 'int') )) or _error(SQL_ERROR_THROWEN);
			if($check->num_rows == 0) {
				_error(403);
			}
			$spage = $check->fetch_assoc();
			/* edit page */
			$user->page_edit($_GET['id'], $_POST['category'], $_POST['title'], $_POST['username'], $spage['page_name'], $_POST['description']);
			$return['path'] = $system['system_url'].'/pages/'.$_POST['username'];
		}

	// group (create|edit)
	} elseif ($_GET['type'] == "group") {

		// group create
		if($_GET['do'] == "create") {
			$user->group_create($_POST['title'], $_POST['username'], $_POST['description']);
			$return['path'] = $system['system_url'].'/groups/'.$_POST['username'];

		// group edit
		} elseif($_GET['do'] == "edit") {
			/* check id */
			if(!isset($_GET['id']) || !is_numeric($_GET['id'])) {
				_error(400);
			}
			/* check if the user is the group admin */
			$check = $db->query(sprintf("SELECT * FROM groups WHERE group_id = %s AND group_admin = %s", secure($_GET['id'], 'int'), secure($user->_data['user_id'], 'int') )) or _error(SQL_ERROR_THROWEN);
			if($check->num_rows == 0) {
				_error(403);
			}
			$group = $check->fetch_assoc();
			/* edit group */
			$user->group_edit($_GET['id'], $_POST['title'], $_POST['username'], $group['group_name'], $_POST['description']);
			$return['path'] = $system['system_url'].'/groups/'.$_POST['username'];
		}

	}

	// return & exit
	return_json($return);
	
}catch (Exception $e) {
	return_json( array('error' => true, 'message' => $e->getMessage()) );
}

?>