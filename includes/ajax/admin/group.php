<?php
/**
 * ajax -> admin -> group
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

// edit group
try {

	/* update */
	$db->query(sprintf("UPDATE groups SET group_title = %s, group_name = %s, group_description = %s WHERE group_id = %s", secure($_POST['group_title']), secure($_POST['group_name']), secure($_POST['group_description']), secure($_GET['id'], 'int') )) or _error(SQL_ERROR_THROWEN);
	/* return */
	return_json( array('success' => true, 'message' => __("Done, Group info have been updated")) );

} catch (Exception $e) {
	return_json( array('error' => true, 'message' => $e->getMessage()) );
}

?>