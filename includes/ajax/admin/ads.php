<?php
/**
 * ajax -> admin -> ads
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

// edit ads
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
			$db->query(sprintf("UPDATE ads SET title = %s, place = %s, code = %s WHERE ads_id = %s", secure($_POST['title']), secure($_POST['place']), secure($_POST['code']), secure($_GET['id'], 'int') )) or _error(SQL_ERROR_THROWEN);
			/* return */
			return_json( array('success' => true, 'message' => __("Done, Ads info have been updated")) );
			break;

		case 'add':
			/* insert */
			$db->query(sprintf("INSERT INTO ads (title, place, code, time) VALUES (%s, %s, %s, %s)", secure($_POST['title']), secure($_POST['place']), secure($_POST['code']), secure($date) )) or _error(SQL_ERROR_THROWEN);
			/* return */
			return_json( array('callback' => 'window.location = "'.$system['system_url'].'/admin/ads";') );
			break;
		
		default:
			_error(400);
			break;
	}

} catch (Exception $e) {
	return_json( array('error' => true, 'message' => $e->getMessage()) );
}

?>