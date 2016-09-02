<?php
/**
 * static
 * 
 * @package Marsesweb v2+
 * @author Marwin Silva
 */

// fetch bootstrap
require('bootstrap.php');

// valid inputs
if(!isset($_GET['url'])) {
	_error(404);
}

// get static page
$get_static = $db->query(sprintf("SELECT * FROM static_pages WHERE page_url = %s", secure($_GET['url']) )) or _error(SQL_ERROR);
if($get_static->num_rows == 0) {
	_error(404);
}
$static = $get_static->fetch_assoc();
$static['page_text'] = html_entity_decode($static['page_text'], ENT_QUOTES);
/* assign variables */
$smarty->assign('static', $static);

// page header
page_header($static['page_title']);

// page footer
page_footer("static");

?>