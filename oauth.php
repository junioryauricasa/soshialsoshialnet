<?php
/**
 * signup
 * 
 * @package Marsesweb v2+
 * @author Marwin Silva
 */

// fetch bootstrap
require('bootstrap.php');

// fetch hybridauth
require_once( "includes/libs/hybridauth/Hybrid/Auth.php" );
require_once( "includes/libs/hybridauth/Hybrid/Endpoint.php" );

// process
try {

	Hybrid_Endpoint::process();

}catch (Exception $e) {
	_error('System Message', $e->getMessage());
}
