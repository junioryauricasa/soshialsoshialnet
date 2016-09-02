<?php
/**
 * signup
 * 
 * @package Marsesweb v2+
 * @author Marwin Silva
 */

// fetch bootstrap
require('bootstrap.php');


// check if social login enabled & valid
if(!$system['social_login_enabled']) {
	_error(404);
}
switch ($_REQUEST['provider']) {
	case 'facebook':
		if(!$system['facebook_login_enabled']) {
			_error(404);
		}
		break;
	
	case 'twitter':
		if(!$system['twitter_login_enabled']) {
			_error(404);
		}
		break;

	case 'google':
		if(!$system['google_login_enabled']) {
			_error(404);
		}
		break;

	default:
		_error(404);
		break;
}


// set provider
$provider = $_REQUEST["provider"];

// config hybridauth
$config = array(
	"base_url" => $system['system_url']."/oauth.php", 
	"providers" => array ( 
		"Google" => array ( 
			"enabled" => true,
			"keys"    => array ( "id" => $system['google_appid'], "secret" => $system['google_secret'] ),
			"scope"   => "https://www.googleapis.com/auth/userinfo.profile ".
						 "https://www.googleapis.com/auth/userinfo.email"   ,
			"access_type"     => "offline"
			),
		"Facebook" => array ( 
			"enabled" => true,
			"keys"    => array ( "id" => $system['facebook_appid'], "secret" => $system['facebook_secret'] ),
			"scope"   => "email, public_profile, user_friends",
			"trustForwarded" => false
			),
		"Twitter" => array ( 
			"enabled" => true,
			"keys"    => array ( "key" => $system['twitter_appid'], "secret" => $system['twitter_secret'] ),
			"includeEmail" => true
			)
		),
		// If you want to enable logging, set 'debug_mode' to true.
		// You can also set it to
		// - "error" To log only error messages. Useful in production
		// - "info" To log info and error messages (ignore debug messages)
		"debug_mode" => false,
		// Path to file writable by the web server. Required if 'debug_mode' is not false
		"debug_file" => ""
);

// fetch hybridauth
require("includes/libs/hybridauth/Hybrid/Auth.php");

// connect
try{
    
    // initialize Hybrid_Auth with a given file
    $hybridauth = new Hybrid_Auth( $config );
    
    // try to authenticate with the selected provider
    $adapter = $hybridauth->authenticate( $provider );
    
    // then grab the user profile
    $user_profile = $adapter->getUserProfile();
    
    // then grap access tokens
    //$access_tokens = $adapter->getAccessToken();

    // socail login
    $user->socail_login($provider, $user_profile);
    
}catch( Exception $e ){
    _error('System Message', $e->getMessage());
}

?>