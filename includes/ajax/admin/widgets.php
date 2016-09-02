<?php
/**
 * ajax -> admin -> widgets
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

// edit widgets
try {

	switch ($_GET['do']) {
		case 'edit':
			// valid inputs
			if(!isset($_GET['id']) || !is_numeric($_GET['id'])) {
				_error(400);
			}
			/* prepare */
			$_POST['default'] = (isset($_POST['default']))? '1' : '0';
			/* update */
			$db->query(sprintf("UPDATE widgets SET title = %s, place = %s, code = %s WHERE widget_id = %s", secure($_POST['title']), secure($_POST['place']), secure($_POST['code']), secure($_GET['id'], 'int') )) or _error(SQL_ERROR_THROWEN);
			/* return */
			return_json( array('success' => true, 'message' => __("Done, Widget info have been updated")) );
			break;

		case 'add':
			/* insert */
			$db->query(sprintf("INSERT INTO widgets (title, place, code) VALUES (%s, %s, %s)", secure($_POST['title']), secure($_POST['place']), secure($_POST['code']) )) or _error(SQL_ERROR_THROWEN);
			/* return */
			return_json( array('callback' => 'window.location = "'.$system['system_url'].'/admin/widgets";') );
			break;
		
		default:
			_error(400);
			break;
	}

} catch (Exception $e) {
	return_json( array('error' => true, 'message' => $e->getMessage()) );
}

?>