<?php
/**
 * ajax -> admin -> page
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

// edit page
try {

	/* prepare */
	$_POST['page_verified'] = (isset($_POST['page_verified']))? '1' : '0';
	/* update */
	$db->query(sprintf("UPDATE pages SET page_verified = %s, page_category = %s, page_title = %s, page_name = %s, page_description = %s WHERE page_id = %s", secure($_POST['page_verified']), secure($_POST['page_category'], 'int'), secure($_POST['page_title']), secure($_POST['page_name']), secure($_POST['page_description']), secure($_GET['id'], 'int') )) or _error(SQL_ERROR_THROWEN);
	/* return */
	return_json( array('success' => true, 'message' => __("Done, Page info have been updated")) );

} catch (Exception $e) {
	return_json( array('error' => true, 'message' => $e->getMessage()) );
}

?>