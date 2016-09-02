<?php
/**
 * ajax -> admin -> settings
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
if(!isset($_GET['edit'])) {
	_error(400);
}

// admin settings
try {

	switch ($_GET['edit']) {
		case 'system':
			$_POST['system_live'] = (isset($_POST['system_live']))? '1' : '0';
			$_POST['videos_enabled'] = (isset($_POST['videos_enabled']))? '1' : '0';
			$_POST['games_enabled'] = (isset($_POST['games_enabled']))? '1' : '0';
			$db->query(sprintf("UPDATE system_options SET 
						system_live = %s, 
						system_message = %s, 
						system_logo = %s, 
						system_title = %s, 
						system_description = %s, 
						system_url = %s, 
						system_uploads_directory = %s, 
						system_domain = %s, 
						videos_enabled = %s, 
						games_enabled = %s ", secure($_POST['system_live']), secure($_POST['system_message']), secure($_POST['system_logo']), secure($_POST['system_title']), secure($_POST['system_description']), secure($_POST['system_url']), secure($_POST['system_uploads_directory']), secure($_POST['system_domain']), secure($_POST['videos_enabled']), secure($_POST['games_enabled']) )) or _error(SQL_ERROR_THROWEN);
			break;

		case 'registration':
			$_POST['users_can_register'] = (isset($_POST['users_can_register']))? '1' : '0';
			$_POST['email_send_activation'] = (isset($_POST['email_send_activation']))? '1' : '0';
			$_POST['social_login_enabled'] = (isset($_POST['social_login_enabled']))? '1' : '0';
			$_POST['facebook_login_enabled'] = (isset($_POST['facebook_login_enabled']))? '1' : '0';
			$_POST['twitter_login_enabled'] = (isset($_POST['twitter_login_enabled']))? '1' : '0';
			$_POST['google_login_enabled'] = (isset($_POST['google_login_enabled']))? '1' : '0';
			$db->query(sprintf("UPDATE system_options SET 
						users_can_register = %s, 
						email_send_activation = %s, 
						social_login_enabled = %s, 
						facebook_login_enabled = %s, 
						facebook_appid = %s, 
						facebook_secret = %s, 
						twitter_login_enabled = %s, 
						twitter_appid = %s, 
						twitter_secret = %s, 
						google_login_enabled = %s, 
						google_appid = %s, 
						google_secret = %s ", secure($_POST['users_can_register']), secure($_POST['email_send_activation']), secure($_POST['social_login_enabled']), secure($_POST['facebook_login_enabled']), secure($_POST['facebook_appid']), secure($_POST['facebook_secret']), secure($_POST['twitter_login_enabled']), secure($_POST['twitter_appid']), secure($_POST['twitter_secret']), secure($_POST['google_login_enabled']), secure($_POST['google_appid']), secure($_POST['google_secret']) )) or _error(SQL_ERROR_THROWEN);
			break;

		case 'emails':
			$_POST['email_smtp_enabled'] = (isset($_POST['email_smtp_enabled']))? '1' : '0';
			$_POST['email_smtp_authentication'] = (isset($_POST['email_smtp_authentication']))? '1' : '0';
			$db->query(sprintf("UPDATE system_options SET 
						email_smtp_enabled = %s, 
						email_smtp_authentication = %s, 
						email_smtp_server = %s, 
						email_smtp_port = %s, 
						email_smtp_username = %s, 
						email_smtp_password = %s ", secure($_POST['email_smtp_enabled']), secure($_POST['email_smtp_authentication']), secure($_POST['email_smtp_server']), secure($_POST['email_smtp_port']), secure($_POST['email_smtp_username']), secure($_POST['email_smtp_password']) )) or _error(SQL_ERROR_THROWEN);
			break;

		case 'security':
			$_POST['reCAPTCHA_enabled'] = (isset($_POST['reCAPTCHA_enabled']))? '1' : '0';
			$db->query(sprintf("UPDATE system_options SET 
						reCAPTCHA_enabled = %s, 
						reCAPTCHA_site_key = %s, 
						reCAPTCHA_secret_key = %s", secure($_POST['reCAPTCHA_enabled']), secure($_POST['reCAPTCHA_site_key']), secure($_POST['reCAPTCHA_secret_key']) )) or _error(SQL_ERROR_THROWEN);
			break;

		case 'limits':
			$db->query(sprintf("UPDATE system_options SET 
						max_avatar_size = %s, 
						max_cover_size = %s, 
						max_photo_size = %s, 
						max_video_size = %s, 
						min_results = %s, 
						min_results_even = %s, 
						max_results = %s ", secure($_POST['max_avatar_size']), secure($_POST['max_cover_size']), secure($_POST['max_photo_size']), secure($_POST['max_video_size']), secure($_POST['min_results']), secure($_POST['min_results_even']), secure($_POST['max_results']) )) or _error(SQL_ERROR_THROWEN);
			break;

		case 'analytics':
			$db->query(sprintf("UPDATE system_options SET 
						google_analytics = %s ", secure($_POST['google_analytics']) )) or _error(SQL_ERROR_THROWEN);
			break;

		default:
			_error(400);
			break;
	}
	return_json( array('callback' => 'window.location.reload();') );

}catch (Exception $e) {
	return_json( array('error' => true, 'message' => $e->getMessage()) );
}

?>