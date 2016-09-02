<?php
/**
 * ajax -> admin -> user
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

// valid inputs
if(!isset($_GET['id']) || !is_numeric($_GET['id'])) {
	_error(400);
}

// edit user
try {

	switch ($_GET['edit']) {
		case 'basic':
			/* prepare */
			$_POST['user_verified'] = (isset($_POST['user_verified']))? '1' : '0';
			$_POST['user_blocked'] = (isset($_POST['user_blocked']))? '1' : '0';
			$_POST['user_activated'] = (isset($_POST['user_activated']))? '1' : '0';
			$_POST['user_reseted'] = (isset($_POST['user_reseted']))? '1' : '0';
			/* check if changing #1 user's group */
			if($_GET['id'] == '1' && $_POST['user_group'] != '1') {
				throw new Exception(__("You can not change the group of this user"));
			}
			/* update */
			$db->query(sprintf("UPDATE users SET user_verified = %s, user_blocked = %s, user_activated = %s, user_reseted = %s, user_group = %s, user_ip = %s WHERE user_id = %s", secure($_POST['user_verified']), secure($_POST['user_blocked']), secure($_POST['user_activated']), secure($_POST['user_reseted']), secure($_POST['user_group'], 'int'), secure($_POST['user_ip']), secure($_GET['id'], 'int') )) or _error(SQL_ERROR_THROWEN);
			/* return */
			return_json( array('success' => true, 'message' => __("Done, User info have been updated")) );
			break;

		case 'profile':
			/* prepare */
			$_POST['user_gender'] = ($_POST['user_gender'] == "M")? "M" : "F";
			$_POST['user_birthdate'] = $_POST['birth_year'].'-'.$_POST['birth_month'].'-'.$_POST['birth_day'];
			/* update */
			$db->query(sprintf("UPDATE users SET user_fullname = %s, user_gender = %s, user_birthdate = %s, user_work_title = %s, user_work_place = %s, user_current_city = %s, user_hometown = %s, user_edu_major = %s, user_edu_school = %s, user_edu_class = %s WHERE user_id = %s", secure($_POST['user_fullname']), secure($_POST['user_gender']), secure($_POST['user_birthdate']), secure($_POST['user_work_title']), secure($_POST['user_work_place']), secure($_POST['user_current_city']), secure($_POST['user_hometown']), secure($_POST['user_edu_major']), secure($_POST['user_edu_school']), secure($_POST['user_edu_class']), secure($_GET['id'], 'int') )) or _error(SQL_ERROR_THROWEN);
			/* return */
			return_json( array('success' => true, 'message' => __("Done, User info have been updated")) );
			break;

		case 'username':
			if(strtolower($_POST['user_name']) != strtolower($_GET['username'])) {
				/* prepare */
				if(is_empty($_POST['user_name']) || !valid_username($_POST['user_name'])) {
					throw new Exception(__("Please enter a valid username (a-z0-9_.)"));
				}
				if($user->check_username($_POST['user_name'])) {
					throw new Exception(__("Sorry, it looks like")." <strong>".$_POST['user_name']."</strong> ".__("belongs to an existing account"));
				}
				/* update */
				$db->query(sprintf("UPDATE users SET user_name = %s WHERE user_id = %s", secure($_POST['user_name']), secure($_GET['id'], 'int') )) or _error(SQL_ERROR_THROWEN);
				/* return */
				return_json( array('success' => true, 'message' => __("Done, User info have been updated")) );
			}
			return_json();
			break;

		case 'email':
			if(strtolower($_POST['user_email']) != strtolower($_GET['email'])) {
				/* prepare */
				if(!valid_email($_POST['user_email'])) {
					throw new Exception(__("Please enter a valid email address"));
				}
				if($user->check_email($_POST['user_email'])) {
					throw new Exception(__("Sorry, it looks like")." <strong>".$_POST['user_email']."</strong> ".__("belongs to an existing account"));
				}
				/* update */
				$db->query(sprintf("UPDATE users SET user_email = %s WHERE user_id = %s", secure($_POST['user_email']), secure($_GET['id'], 'int') )) or _error(SQL_ERROR_THROWEN);
				/* return */
				return_json( array('success' => true, 'message' => __("Done, User info have been updated")) );
			}
			return_json();
			break;

		case 'password':
			/* prepare */
			if(strlen($_POST['user_password']) < 6) {
				throw new Exception(__("Your password must be at least 6 characters long. Please try another"));
			}
			/* update */
			$db->query(sprintf("UPDATE users SET user_password = %s WHERE user_id = %s", secure(md5($_POST['user_password'])), secure($_GET['id'], 'int') )) or _error(SQL_ERROR_THROWEN);
			/* return */
			return_json( array('success' => true, 'message' => __("Done, User info have been updated")) );
			break;

		case 'privacy':
			/* prepare */
			$_POST['user_privacy_chat'] = ($_POST['user_privacy_chat'] == 0)? 0 : 1;
			$_POST['user_privacy_birthdate'] = ($_POST['user_privacy_birthdate'] == "public")? "public" : "friends";
			$_POST['user_privacy_work'] = ($_POST['user_privacy_work'] == "public")? "public" : "friends";
			$_POST['user_privacy_location'] = ($_POST['user_privacy_location'] == "public")? "public" : "friends";
			$_POST['user_privacy_education'] = ($_POST['user_privacy_education'] == "public")? "public" : "friends";
			/* update */
			$db->query(sprintf("UPDATE users SET user_chat_enabled = %s, user_privacy_birthdate = %s, user_privacy_work = %s, user_privacy_location = %s, user_privacy_education = %s, user_privacy_friends = %s, user_privacy_pages = %s, user_privacy_groups = %s WHERE user_id = %s", secure($_POST['user_chat_enabled']), secure($_POST['user_privacy_birthdate']), secure($_POST['user_privacy_work']), secure($_POST['user_privacy_location']), secure($_POST['user_privacy_education']), secure($_POST['user_privacy_friends']), secure($_POST['user_privacy_pages']), secure($_POST['user_privacy_groups']), secure($_GET['id'], 'int') )) or _error(SQL_ERROR_THROWEN);
			/* return */
			return_json( array('success' => true, 'message' => __("Done, User info have been updated")) );
			break;
		
		default:
			_error(400);
			break;
	}

} catch (Exception $e) {
	return_json( array('error' => true, 'message' => $e->getMessage()) );
}

?>