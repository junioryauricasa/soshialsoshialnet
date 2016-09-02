<?php
/**
 * ajax -> admin -> delete
 * 
 * @package Marsesweb v2+
 * @author Marwin Silva
 */

// fetch bootstrap
require('../../../bootstrap.php');

// check AJAX Request
is_ajax();


// check admin logged in
if(!$user->_logged_in || !$user->_is_admin) {
	modal(MESSAGE, __("System Message"), __("You don't have the right permission to access this"));
}


// valid inputs
if(!isset($_POST['id']) || !is_numeric($_POST['id'])) {
	_error(400);
}

// delete
try {

	switch ($_POST['handle']) {

		case 'user':
			$user->delete_user($_POST['id']);
			break;

		case 'language':
			$db->query(sprintf("DELETE FROM system_languages WHERE language_id = %s", secure($_POST['id'], 'int') )) or _error(SQL_ERROR_THROWEN);
			break;

		case 'theme':
			$db->query(sprintf("DELETE FROM system_themes WHERE theme_id = %s", secure($_POST['id'], 'int') )) or _error(SQL_ERROR_THROWEN);
			break;

		case 'page':
			$user->delete_page($_POST['id']);
			break;

		case 'group':
			$user->delete_group($_POST['id']);
			break;

		case 'category':
			$db->query(sprintf("DELETE FROM pages_categories WHERE category_id = %s", secure($_POST['id'], 'int') )) or _error(SQL_ERROR_THROWEN);
			break;

		case 'report':
			$db->query(sprintf("DELETE FROM reports WHERE report_id = %s", secure($_POST['id'], 'int') )) or _error(SQL_ERROR_THROWEN);
			break;

		case 'post':
			// valid inputs
			if(!isset($_POST['node']) || !is_numeric($_POST['node'])) {
				_error(400);
			}
			/* delete post */
			$user->delete_post($_POST['node']);
			/* delete report */
			$db->query(sprintf("DELETE FROM reports WHERE report_id = %s", secure($_POST['id'], 'int') )) or _error(SQL_ERROR_THROWEN);
			break;

		case 'comment':
			// valid inputs
			if(!isset($_POST['node']) || !is_numeric($_POST['node'])) {
				_error(400);
			}
			/* delete comment */
			$user->delete_comment($_POST['node']);
			/* delete report */
			$db->query(sprintf("DELETE FROM reports WHERE report_id = %s", secure($_POST['id'], 'int') )) or _error(SQL_ERROR_THROWEN);
			break;

		case 'static':
			$db->query(sprintf("DELETE FROM static_pages WHERE page_id = %s", secure($_POST['id'], 'int') )) or _error(SQL_ERROR_THROWEN);
			break;

		case 'ads':
			$db->query(sprintf("DELETE FROM ads WHERE ads_id = %s", secure($_POST['id'], 'int') )) or _error(SQL_ERROR_THROWEN);
			break;

		case 'widget':
			$db->query(sprintf("DELETE FROM widgets WHERE widget_id = %s", secure($_POST['id'], 'int') )) or _error(SQL_ERROR_THROWEN);
			break;

		case 'game':
			$db->query(sprintf("DELETE FROM games WHERE game_id = %s", secure($_POST['id'], 'int') )) or _error(SQL_ERROR_THROWEN);
			break;

		default:
			_error(400);
			break;
	}

	// return
	return_json();

} catch (Exception $e) {
	modal(ERROR, __("Error"), $e->getMessage());
}

?>