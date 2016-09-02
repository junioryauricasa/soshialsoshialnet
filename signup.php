<?php
/**
 * signup
 * 
 * @package Marsesweb v2+
 * @author Marwin Silva
 */

// fetch bootstrap
require('bootstrap.php');

// check user logged in
if($user->_logged_in) {
    header('Location: '.$system['system_url']);
}

// page header
page_header($system['system_title']." &rsaquo; ".__("Sign Up"));

// page footer
page_footer("signup");

?>