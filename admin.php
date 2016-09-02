<?php
/**
 * signup
 * 
 * @package Marsesweb v2+
 * @author Marwin Silva
 */

// set override_shutdown
$override_shutdown = true;

// fetch bootstrap
require('bootstrap.php');

// user access
user_access();

// check admin logged in
if(!$user->_is_admin) {
    _error(__('System Message'), "<p class='text-center'>".__("You don't have the right permission to access this")."</p>");
}

// page content
switch ($_GET['view']) {
	case '':
		// page header
		page_header(__("Admin Panel"));

		// get insights
		/* total users */
		$get_users = $db->query("SELECT * FROM users") or _error(SQL_ERROR);
    	$insights['users'] = $get_users->num_rows;
    	/* males|females */
    	$get_males = $db->query("SELECT * FROM users WHERE user_gender = 'M'");
	    $insights['users_males'] = $get_males->num_rows;
	    $get_females = $db->query("SELECT * FROM users WHERE user_gender = 'F'");
	    $insights['users_females'] = $get_females->num_rows;
	    $insights['users_males_percent'] = round(($insights['users_males']/$insights['users'])*100, 2);
	    $insights['users_females_percent'] = round(100 - $insights['users_males_percent']);
	    /* banned */
	    $get_banned = $db->query("SELECT * FROM users WHERE user_blocked = '1'") or _error(SQL_ERROR);
    	$insights['banned'] = $get_banned->num_rows;
	    /* not activated */
	    $get_not_activated = $db->query("SELECT * FROM users WHERE user_activated = '0'") or _error(SQL_ERROR);
    	$insights['not_activated'] = $get_not_activated->num_rows;
    	/* online */
	    $get_online = $db->query("SELECT * FROM users_online") or _error(SQL_ERROR);
    	$insights['online'] = $get_online->num_rows;
    	/* posts */
	    $get_posts = $db->query("SELECT * FROM posts") or _error(SQL_ERROR);
    	$insights['posts'] = $get_posts->num_rows;
    	/* comments */
	    $get_comments = $db->query("SELECT * FROM posts_comments") or _error(SQL_ERROR);
    	$insights['comments'] = $get_comments->num_rows;
    	/* pages */
	    $get_pages = $db->query("SELECT * FROM pages") or _error(SQL_ERROR);
    	$insights['pages'] = $get_pages->num_rows;
    	/* groups */
	    $get_groups = $db->query("SELECT * FROM groups") or _error(SQL_ERROR);
    	$insights['groups'] = $get_groups->num_rows;
    	/* messages */
	    $get_messages = $db->query("SELECT * FROM conversations_messages") or _error(SQL_ERROR);
    	$insights['messages'] = $get_messages->num_rows;
    	/* notifications */
	    $get_notifications = $db->query("SELECT * FROM notifications") or _error(SQL_ERROR);
    	$insights['notifications'] = $get_notifications->num_rows;

    	// assign variables
		$smarty->assign('insights', $insights);
		break;

	case 'settings':
		// page header
		page_header(__("Admin")." &rsaquo; ".__("Settings"));
		break;

	case 'users':
		// get content
		switch ($_GET['sub_view']) {
			case '':
				// page header
				page_header(__("Admin")." &rsaquo; ".__("Users"));
				
				// get data
				$get_rows = $db->query("SELECT * FROM users") or _error(SQL_ERROR);
				if($get_rows->num_rows > 0) {
					while($row = $get_rows->fetch_assoc()) {
						$row['user_picture'] = User::get_picture($row['user_picture'], $row['user_gender']);
						$rows[] = $row;
					}
				}
				
				// assign variables
				$smarty->assign('rows', $rows);
				break;
			
			case 'admins':
				// page header
				page_header(__("Admin")." &rsaquo; ".__("Users")." &rsaquo; ".__("Admins"));
				
				// get data
				$get_rows = $db->query("SELECT * FROM users WHERE user_group = '1'") or _error(SQL_ERROR);
				if($get_rows->num_rows > 0) {
					while($row = $get_rows->fetch_assoc()) {
						$row['user_picture'] = User::get_picture($row['user_picture'], $row['user_gender']);
						$rows[] = $row;
					}
				}
				
				// assign variables
				$smarty->assign('rows', $rows);
				break;

			case 'moderators':
				// page header
				page_header(__("Admin")." &rsaquo; ".__("Users")." &rsaquo; ".__("Moderators"));
				
				// get data
				$get_rows = $db->query("SELECT * FROM users WHERE user_group = '2'") or _error(SQL_ERROR);
				if($get_rows->num_rows > 0) {
					while($row = $get_rows->fetch_assoc()) {
						$row['user_picture'] = User::get_picture($row['user_picture'], $row['user_gender']);
						$rows[] = $row;
					}
				}
				
				// assign variables
				$smarty->assign('rows', $rows);
				break;

			case 'online':
				// page header
				page_header(__("Admin")." &rsaquo; ".__("Users")." &rsaquo; ".__("Online"));
				
				// get data
				$get_rows = $db->query("SELECT users.* FROM users_online INNER JOIN users ON users_online.user_id = users.user_id") or _error(SQL_ERROR);
				if($get_rows->num_rows > 0) {
					while($row = $get_rows->fetch_assoc()) {
						$row['user_picture'] = User::get_picture($row['user_picture'], $row['user_gender']);
						$rows[] = $row;
					}
				}
				
				// assign variables
				$smarty->assign('rows', $rows);
				break;

			case 'banned':
				// page header
				page_header(__("Admin")." &rsaquo; ".__("Users")." &rsaquo; ".__("Banned"));
				
				// get data
				$get_rows = $db->query("SELECT * FROM users WHERE user_blocked = '1'") or _error(SQL_ERROR);
				if($get_rows->num_rows > 0) {
					while($row = $get_rows->fetch_assoc()) {
						$row['user_picture'] = User::get_picture($row['user_picture'], $row['user_gender']);
						$rows[] = $row;
					}
				}
				
				// assign variables
				$smarty->assign('rows', $rows);
				break;

			case 'edit':
				// valid inputs
				if(!isset($_GET['id']) || !is_numeric($_GET['id'])) {
					_error(404);
				}
				
				// get data
				$get_data = $db->query(sprintf("SELECT * FROM users WHERE user_id = %s", secure($_GET['id'], 'int') )) or _error(SQL_ERROR);
				if($get_data->num_rows == 0) {
					_error(404);
				}
				$data = $get_data->fetch_assoc();
				$data['user_picture'] = User::get_picture($data['user_picture'], $data['user_gender']);
				/* get user's friends */
				$data['friends'] = count($user->get_friends_ids($data['user_id']));
				$data['followings'] = count($user->get_followings_ids($data['user_id']));
				$data['followers'] = count($user->get_followers_ids($data['user_id']));
				/* parse birthdate */
				$data['user_birthdate_parsed'] = date_parse($data['user_birthdate']);
				
				// assign variables
				$smarty->assign('data', $data);
				
				// page header
				page_header(__("Admin")." &rsaquo; ".__("Users")." &rsaquo; ".$data['user_fullname']);
				break;

			default:
				_error(404);
				break;
		}
		break;

	case 'pages':
		// get content
		switch ($_GET['sub_view']) {
			case '':
				// page header
				page_header(__("Admin")." &rsaquo; ".__("Pages"));
				
				// get data
				$get_rows = $db->query("SELECT * FROM pages") or _error(SQL_ERROR);
				if($get_rows->num_rows > 0) {
					while($row = $get_rows->fetch_assoc()) {
						$row['page_picture'] = User::get_picture($row['page_picture'], 'page');
						$rows[] = $row;
					}
				}
				
				// assign variables
				$smarty->assign('rows', $rows);
				break;

			case 'edit':
				// valid inputs
				if(!isset($_GET['id']) || !is_numeric($_GET['id'])) {
					_error(404);
				}
				
				// get data
				$get_data = $db->query(sprintf("SELECT * FROM pages WHERE page_id = %s", secure($_GET['id'], 'int') )) or _error(SQL_ERROR);
				if($get_data->num_rows == 0) {
					_error(404);
				}
				$data = $get_data->fetch_assoc();
				$data['page_picture'] = User::get_picture($data['page_picture'], 'page');
				/* get categories */
				$data['categories'] = $user->get_pages_categories();
				
				// assign variables
				$smarty->assign('data', $data);
				
				// page header
				page_header(__("Admin")." &rsaquo; ".__("Pages")." &rsaquo; ".$data['page_title']);
				break;

			default:
				_error(404);
				break;
		}
		break;

	case 'categories':
		// get content
		switch ($_GET['sub_view']) {
			case '':
				// page header
				page_header(__("Admin")." &rsaquo; ".__("Categories"));
				
				// get data
				$rows = $user->get_pages_categories();
				
				// assign variables
				$smarty->assign('rows', $rows);
				break;

			case 'edit':
				// valid inputs
				if(!isset($_GET['id']) || !is_numeric($_GET['id'])) {
					_error(404);
				}
				
				// get data
				$get_data = $db->query(sprintf("SELECT * FROM pages_categories WHERE category_id = %s", secure($_GET['id'], 'int') )) or _error(SQL_ERROR);
				if($get_data->num_rows == 0) {
					_error(404);
				}
				$data = $get_data->fetch_assoc();
				
				// assign variables
				$smarty->assign('data', $data);
				
				// page header
				page_header(__("Admin")." &rsaquo; ".__("Categories")." &rsaquo; ".$data['category_name']);
				break;

			case 'add':
				// page header
				page_header(__("Admin")." &rsaquo; ".__("Categories")." &rsaquo; ".__("Add New"));
				break;

			default:
				_error(404);
				break;
		}
		break;

	case 'groups':
		// get content
		switch ($_GET['sub_view']) {
			case '':
				// page header
				page_header(__("Admin")." &rsaquo; ".__("Groups"));
				
				// get data
				$get_rows = $db->query("SELECT * FROM groups") or _error(SQL_ERROR);
				if($get_rows->num_rows > 0) {
					while($row = $get_rows->fetch_assoc()) {
						$row['group_picture'] = User::get_picture($row['group_picture'], 'group');
						$rows[] = $row;
					}
				}
				
				// assign variables
				$smarty->assign('rows', $rows);
				break;

			case 'edit':
				// valid inputs
				if(!isset($_GET['id']) || !is_numeric($_GET['id'])) {
					_error(404);
				}
				
				// get data
				$get_data = $db->query(sprintf("SELECT * FROM groups WHERE group_id = %s", secure($_GET['id'], 'int') )) or _error(SQL_ERROR);
				if($get_data->num_rows == 0) {
					_error(404);
				}
				$data = $get_data->fetch_assoc();
				$data['group_picture'] = User::get_picture($data['group_picture'], 'page');
				
				// assign variables
				$smarty->assign('data', $data);
				
				// page header
				page_header(__("Admin")." &rsaquo; ".__("Groups")." &rsaquo; ".$data['group_title']);
				break;

			default:
				_error(404);
				break;
		}
		break;

	case 'verified':
		// get content
		switch ($_GET['sub_view']) {
			case 'users':
				// page header
				page_header(__("Admin")." &rsaquo; ".__("Verified")." &rsaquo; ".__("Users"));
				
				// get data
				$get_rows = $db->query("SELECT * FROM users WHERE user_verified = '1'") or _error(SQL_ERROR);
				if($get_rows->num_rows > 0) {
					while($row = $get_rows->fetch_assoc()) {
						$row['user_picture'] = User::get_picture($row['user_picture'], $row['user_gender']);
						$rows[] = $row;
					}
				}

				// assign variables
				$smarty->assign('rows', $rows);
				break;

			case 'pages':
				// page header
				page_header(__("Admin")." &rsaquo; ".__("Verified")." &rsaquo; ".__("Pages"));
				
				// get data
				$get_rows = $db->query("SELECT * FROM pages WHERE page_verified = '1'") or _error(SQL_ERROR);
				if($get_rows->num_rows > 0) {
					while($row = $get_rows->fetch_assoc()) {
						$row['page_picture'] = User::get_picture($row['page_picture'], 'page');
						$rows[] = $row;
					}
				}
				
				// assign variables
				$smarty->assign('rows', $rows);
				break;
			
			default:
				_error(404);
				break;
		}
		break;
	
	case 'reports':
		// page header
		page_header(__("Admin")." &rsaquo; ".__("Reports"));

		// get data
		$get_rows = $db->query("SELECT reports.*, users.user_name, users.user_fullname, users.user_picture, users.user_gender FROM reports INNER JOIN users ON reports.user_id = users.user_id") or _error(SQL_ERROR);
		if($get_rows->num_rows > 0) {
			while($row = $get_rows->fetch_assoc()) {
				$row['user_picture'] = User::get_picture($row['user_picture'], $row['user_gender']);
				/* get comment node */
				if($row['node_type'] == 'comment') {
					$get_comment = $db->query(sprintf("SELECT * FROM posts_comments WHERE comment_id = %s", secure($row['node_id'], 'int') )) or _error(SQL_ERROR);
					$comment = $get_comment->fetch_assoc();
					$row['url'] = ($comment['node_type'] == "photo")? $system['system_url'].'/photos/'.$comment['node_id'] : $system['system_url'].'/posts/'.$comment['node_id'];
				}
				$rows[] = $row;
			}
		}
		
		// assign variables
		$smarty->assign('rows', $rows);
		break;

	case 'static':
		// get content
		switch ($_GET['sub_view']) {
			case '':
				// page header
				page_header(__("Admin")." &rsaquo; ".__("Static Pages"));

				// get data
				$get_rows = $db->query("SELECT * FROM static_pages") or _error(SQL_ERROR);
				if($get_rows->num_rows > 0) {
					while($row = $get_rows->fetch_assoc()) {
						$rows[] = $row;
					}
				}
				
				// assign variables
				$smarty->assign('rows', $rows);
				break;

			case 'edit':
				// valid inputs
				if(!isset($_GET['id']) || !is_numeric($_GET['id'])) {
					_error(404);
				}
				
				// get data
				$get_data = $db->query(sprintf("SELECT * FROM static_pages WHERE page_id = %s", secure($_GET['id'], 'int') )) or _error(SQL_ERROR);
				if($get_data->num_rows == 0) {
					_error(404);
				}
				$data = $get_data->fetch_assoc();
				
				// assign variables
				$smarty->assign('data', $data);
				
				// page header
				page_header(__("Admin")." &rsaquo; ".__("Static Pages")." &rsaquo; ".$data['page_title']);
				break;

			case 'add':
				// page header
				page_header(__("Admin")." &rsaquo; ".__("Static Pages")." &rsaquo; ".__("Add New"));
				break;
			
			default:
				_error(404);
				break;
		}
		break;

	case 'ads':
		// get content
		switch ($_GET['sub_view']) {
			case '':
				// page header
				page_header(__("Admin")." &rsaquo; ".__("Ads"));

				// get data
				$get_rows = $db->query("SELECT * FROM ads") or _error(SQL_ERROR);
				if($get_rows->num_rows > 0) {
					while($row = $get_rows->fetch_assoc()) {
						$rows[] = $row;
					}
				}
				
				// assign variables
				$smarty->assign('rows', $rows);
				break;

			case 'edit':
				// valid inputs
				if(!isset($_GET['id']) || !is_numeric($_GET['id'])) {
					_error(404);
				}
				
				// get data
				$get_data = $db->query(sprintf("SELECT * FROM ads WHERE ads_id = %s", secure($_GET['id'], 'int') )) or _error(SQL_ERROR);
				if($get_data->num_rows == 0) {
					_error(404);
				}
				$data = $get_data->fetch_assoc();
				
				// assign variables
				$smarty->assign('data', $data);
				
				// page header
				page_header(__("Admin")." &rsaquo; ".__("Ads")." &rsaquo; ".$data['title']);
				break;

			case 'add':
				// page header
				page_header(__("Admin")." &rsaquo; ".__("Ads")." &rsaquo; ".__("Add New"));
				break;
			
			default:
				_error(404);
				break;
		}
		break;

	case 'languages':
		// get content
		switch ($_GET['sub_view']) {
			case '':
				// page header
				page_header(__("Admin")." &rsaquo; ".__("Languages"));

				// get data
				$get_rows = $db->query("SELECT * FROM system_languages") or _error(SQL_ERROR);
				if($get_rows->num_rows > 0) {
					while($row = $get_rows->fetch_assoc()) {
						$rows[] = $row;
					}
				}
				
				// assign variables
				$smarty->assign('rows', $rows);
				break;

			case 'edit':
				// valid inputs
				if(!isset($_GET['id']) || !is_numeric($_GET['id'])) {
					_error(404);
				}
				
				// get data
				$get_data = $db->query(sprintf("SELECT * FROM system_languages WHERE language_id = %s", secure($_GET['id'], 'int') )) or _error(SQL_ERROR);
				if($get_data->num_rows == 0) {
					_error(404);
				}
				$data = $get_data->fetch_assoc();
				
				// assign variables
				$smarty->assign('data', $data);
				
				// page header
				page_header(__("Admin")." &rsaquo; ".__("Languages")." &rsaquo; ".$data['title']);
				break;

			case 'add':
				// page header
				page_header(__("Admin")." &rsaquo; ".__("Languages")." &rsaquo; ".__("Add New"));
				break;
			
			default:
				_error(404);
				break;
		}
		break;

	case 'themes':
		// get content
		switch ($_GET['sub_view']) {
			case '':
				// page header
				page_header(__("Admin")." &rsaquo; ".__("Themes"));

				// get data
				$get_rows = $db->query("SELECT * FROM system_themes") or _error(SQL_ERROR);
				if($get_rows->num_rows > 0) {
					while($row = $get_rows->fetch_assoc()) {
						$rows[] = $row;
					}
				}
				
				// assign variables
				$smarty->assign('rows', $rows);
				break;

			case 'edit':
				// valid inputs
				if(!isset($_GET['id']) || !is_numeric($_GET['id'])) {
					_error(404);
				}
				
				// get data
				$get_data = $db->query(sprintf("SELECT * FROM system_themes WHERE theme_id = %s", secure($_GET['id'], 'int') )) or _error(SQL_ERROR);
				if($get_data->num_rows == 0) {
					_error(404);
				}
				$data = $get_data->fetch_assoc();
				
				// assign variables
				$smarty->assign('data', $data);
				
				// page header
				page_header(__("Admin")." &rsaquo; ".__("Themes")." &rsaquo; ".$data['name']);
				break;

			case 'add':
				// page header
				page_header(__("Admin")." &rsaquo; ".__("Themes")." &rsaquo; ".__("Add New"));
				break;
			
			default:
				_error(404);
				break;
		}
		break;

	case 'widgets':
		// get content
		switch ($_GET['sub_view']) {
			case '':
				// page header
				page_header(__("Admin")." &rsaquo; ".__("Widgets"));

				// get data
				$get_rows = $db->query("SELECT * FROM widgets") or _error(SQL_ERROR);
				if($get_rows->num_rows > 0) {
					while($row = $get_rows->fetch_assoc()) {
						$rows[] = $row;
					}
				}
				
				// assign variables
				$smarty->assign('rows', $rows);
				break;

			case 'edit':
				// valid inputs
				if(!isset($_GET['id']) || !is_numeric($_GET['id'])) {
					_error(404);
				}
				
				// get data
				$get_data = $db->query(sprintf("SELECT * FROM widgets WHERE widget_id = %s", secure($_GET['id'], 'int') )) or _error(SQL_ERROR);
				if($get_data->num_rows == 0) {
					_error(404);
				}
				$data = $get_data->fetch_assoc();
				
				// assign variables
				$smarty->assign('data', $data);
				
				// page header
				page_header(__("Admin")." &rsaquo; ".__("Widgets")." &rsaquo; ".$data['title']);
				break;

			case 'add':
				// page header
				page_header(__("Admin")." &rsaquo; ".__("Widgets")." &rsaquo; ".__("Add New"));
				break;
			
			default:
				_error(404);
				break;
		}
		break;

	case 'games':
		// get content
		switch ($_GET['sub_view']) {
			case '':
				// page header
				page_header(__("Admin")." &rsaquo; ".__("Games"));

				// get data
				$get_rows = $db->query("SELECT * FROM games") or _error(SQL_ERROR);
				if($get_rows->num_rows > 0) {
					while($row = $get_rows->fetch_assoc()) {
						$row['thumbnail'] = $user->get_picture($row['thumbnail'], 'game');
						$rows[] = $row;
					}
				}
				
				// assign variables
				$smarty->assign('rows', $rows);
				break;

			case 'edit':
				// valid inputs
				if(!isset($_GET['id']) || !is_numeric($_GET['id'])) {
					_error(404);
				}
				
				// get data
				$get_data = $db->query(sprintf("SELECT * FROM games WHERE game_id = %s", secure($_GET['id'], 'int') )) or _error(SQL_ERROR);
				if($get_data->num_rows == 0) {
					_error(404);
				}
				$data = $get_data->fetch_assoc();
				
				// assign variables
				$smarty->assign('data', $data);
				
				// page header
				page_header(__("Admin")." &rsaquo; ".__("Games")." &rsaquo; ".$data['title']);
				break;

			case 'add':
				// page header
				page_header(__("Admin")." &rsaquo; ".__("Games")." &rsaquo; ".__("Add New"));
				break;
			
			default:
				_error(404);
				break;
		}
		break;

	default:
		_error(404);
}

// assign variables
$smarty->assign('view', $_GET['view']);
$smarty->assign('sub_view', $_GET['sub_view']);

// page footer
page_footer("admin");

?>