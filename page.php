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

// get page info
$get_page = $db->query(sprintf("SELECT pages.*, pages_categories.category_name FROM pages LEFT JOIN pages_categories ON pages.page_category = pages_categories.category_id WHERE page_name = %s", secure($_GET['username']))) or _error(SQL_ERROR);
if($get_page->num_rows == 0) {
	_error(404);
}
$spage = $get_page->fetch_assoc();
$spage['category_name'] = (!$spage['category_name'])? __('N/A'): $spage['category_name'];
$spage['page_picture'] = User::get_picture($spage['page_picture'], 'page');
/* check username case */
if(strtolower($_GET['username']) == strtolower($spage['page_name']) && $_GET['username'] != $spage['page_name']) {
	_redirect('/pages/'.$spage['page_name']);
}
/* check if the viewer liked the page */
$spage['i_like'] = false;
if($user->_logged_in) {
	$get_likes = $db->query(sprintf("SELECT * FROM pages_likes WHERE page_id = %s AND user_id = %s", secure($spage['page_id'], 'int'), secure($user->_data['user_id'], 'int') )) or _error(SQL_ERROR);
	if($get_likes->num_rows > 0) {
		$spage['i_like'] = true;
	}
}

// page header
page_header($spage['page_title']);

// check the view
if(is_empty($_GET['view'])) {
		
	try {
		// get posts
		$posts = $user->get_posts( array('page_id' => $spage['page_id']) );
		/* assign variables */
		$smarty->assign('posts', $posts);
	} catch (Exception $e) {
		_error(__("Error"), $e->getMessage());
	}

} elseif ($_GET['view'] == "settings") {

	/* check if the user is the page admin */
	if($user->_data['user_id'] != $spage['page_admin']) {
		_error(404);
	}

	try {
		// check the tab
		if(is_empty($_GET['tab'])) {
			// get pages categories
			$categories = $user->get_pages_categories();
			/* assign variables */
			$smarty->assign('categories', $categories);
		}
	} catch (Exception $e) {
		_error(__("Error"), $e->getMessage());
	}

}else {	
	_error(404);
}

// assign variables
$smarty->assign('spage', $spage);
$smarty->assign('view', $_GET['view']);
$smarty->assign('tab', $_GET['tab']);

// page footer
page_footer("page");

?>