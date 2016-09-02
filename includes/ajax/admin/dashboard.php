<?php
/**
 * ajax -> admin -> dashboard
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


// dashboard
try {

	$data = [];
	$date_from = date('Y-m-d', strtotime('-1 week'));
	$date_to = date('Y-m-d', strtotime('+1 day'));

	$userCounter = [];

	$rows = $db->query("SELECT DATE_FORMAT(user_registered, '%Y-%m-%d') as user_registered, user_gender, COUNT(*) as user_count FROM users WHERE user_registered BETWEEN '" . $date_from . "' AND '" . $date_to . "' GROUP BY DATE_FORMAT( user_registered,  '%Y-%m-%d' ), user_gender") or _error(SQL_ERROR);

	if($rows->num_rows > 0) {
		
		$dates = get_dates_from_range( $date_from, $date_to );
		array_pop( $dates ); // Remove Last date
		
		foreach ( $dates as $date ) {
			$row = find_key($rows, array('user_registered' => $date));

			$userCounter[ $date ] = array(
				'M' => ($row !== false && $row['user_gender'] == 'M' ? $row['user_count'] : '0'),
				'F' => ($row !== false && $row['user_gender'] == 'F' ? $row['user_count'] : '0')
			);
		}

		asort($userCounter);
	}

	$data['userCounter'] = $userCounter;

    // -------------------------------------------------------------------------------------------
    // Status
    
    $data['userStatus'] = [];

    /* total users */
    $get_users = $db->query("SELECT * FROM users") or _error(SQL_ERROR);
    $data['userStatus']['users'] = $get_users->num_rows;
    
    /* males|females */
    $get_males = $db->query("SELECT * FROM users WHERE user_gender = 'M'");
    $data['userStatus']['males'] = $get_males->num_rows;

    $get_females = $db->query("SELECT * FROM users WHERE user_gender = 'F'");
    $data['userStatus']['females'] = $get_females->num_rows;

    /* banned */
    $get_banned = $db->query("SELECT * FROM users WHERE user_blocked = '1'") or _error(SQL_ERROR);
    $data['userStatus']['banned'] = $get_banned->num_rows;

    /* not activated */
    $get_not_activated = $db->query("SELECT * FROM users WHERE user_activated = '0'") or _error(SQL_ERROR);
    $data['userStatus']['not_activated'] = $get_not_activated->num_rows;

    /* online */
    $get_online = $db->query("SELECT * FROM users_online") or _error(SQL_ERROR);
    $data['userStatus']['online'] = $get_online->num_rows;

    /* posts */
    $get_posts = $db->query("SELECT * FROM posts") or _error(SQL_ERROR);
    $data['userStatus']['posts'] = $get_posts->num_rows;

    /* comments */
    $get_comments = $db->query("SELECT * FROM posts_comments") or _error(SQL_ERROR);
    $data['userStatus']['comments'] = $get_comments->num_rows;

    /* pages */
    $get_pages = $db->query("SELECT * FROM pages") or _error(SQL_ERROR);
    $data['userStatus']['pages'] = $get_pages->num_rows;

    /* groups */
    $get_groups = $db->query("SELECT * FROM groups") or _error(SQL_ERROR);
    $data['userStatus']['groups'] = $get_groups->num_rows;

    /* messages */
    $get_messages = $db->query("SELECT * FROM conversations_messages") or _error(SQL_ERROR);
    $data['userStatus']['messages'] = $get_messages->num_rows;

    /* notifications */
    $get_notifications = $db->query("SELECT * FROM notifications") or _error(SQL_ERROR);
    $data['userStatus']['notifications'] = $get_notifications->num_rows;

	
	return_json( array('success' => true, 'data' => $data ) );

} catch (Exception $e) {
	return_json( array('error' => true, 'message' => $e->getMessage()) );
}

?>