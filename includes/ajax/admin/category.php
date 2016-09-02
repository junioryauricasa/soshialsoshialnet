<?php
/**
 * ajax -> admin -> category
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

// edit category
try {

	switch ($_GET['do']) {
		case 'edit':
			// valid inputs
			if(!isset($_GET['id']) || !is_numeric($_GET['id'])) {
				_error(400);
			}
			/* update */
			$db->query(sprintf("UPDATE pages_categories SET category_name = %s WHERE category_id = %s", secure($_POST['category_name']), secure($_GET['id'], 'int') )) or _error(SQL_ERROR_THROWEN);
			/* return */
			return_json( array('success' => true, 'message' => __("Done, Category info have been updated")) );
			break;

		case 'add':
			/* insert */
			$db->query(sprintf("INSERT INTO pages_categories (category_name) VALUES (%s)", secure($_POST['category_name']) )) or _error(SQL_ERROR_THROWEN);
			/* return */
			return_json( array('callback' => 'window.location = "'.$system['system_url'].'/admin/categories";') );
			break;
		
		default:
			_error(400);
			break;
	}

} catch (Exception $e) {
	return_json( array('error' => true, 'message' => $e->getMessage()) );
}

?>