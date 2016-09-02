<?php
/**
 * ajax -> admin -> theme
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

// edit language
try {

	switch ($_GET['do']) {
		case 'edit':
			// valid inputs
			if(!isset($_GET['id']) || !is_numeric($_GET['id'])) {
				_error(400);
			}
			/* prepare */
			$_POST['default'] = (isset($_POST['default']))? '1' : '0';
			/* if default is set -> set all languages as not default first */
			if($_POST['default']) {
				$db->query("UPDATE system_themes SET system_themes.default = '0'") or _error(SQL_ERROR_THROWEN);
			}
			/* update */
			$db->query(sprintf("UPDATE system_themes SET system_themes.default = %s, name = %s WHERE theme_id = %s", secure($_POST['default']), secure($_POST['name']), secure($_GET['id'], 'int') )) or _error(SQL_ERROR_THROWEN);
			/* return */
			return_json( array('success' => true, 'message' => __("Done, Theme info have been updated")) );
			break;

		case 'add':
			/* prepare */
			$_POST['default'] = (isset($_POST['default']))? '1' : '0';
			/* insert */
			$db->query(sprintf("INSERT INTO system_themes (system_themes.default, name) VALUES (%s, %s)", secure($_POST['default']), secure($_POST['name']) )) or _error(SQL_ERROR_THROWEN);
			/* return */
			return_json( array('callback' => 'window.location = "'.$system['system_url'].'/admin/themes";') );
			break;
		
		default:
			_error(400);
			break;
	}

} catch (Exception $e) {
	return_json( array('error' => true, 'message' => $e->getMessage()) );
}

?>