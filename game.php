<?php
/**
 * signup
 * 
 * @package Marsesweb v2+
 * @author Marwin Silva
 */

// fetch bootstrap
require('bootstrap.php');

// valid inputs
if(!isset($_GET['id']) || !is_numeric($_GET['id'])) {
	_error(404);
}

try {

	// games enabled
	if(!$system['games_enabled']) {
		_error(404);
	}

	// get game
	$game = $user->get_game($_GET['id']);
	if(!$game)  {
		_error(404);
	}
	/* assign variables */
	$smarty->assign('game', $game);

	// page header
	page_header($game['title']);

} catch (Exception $e) {
	_error(__("Error"), $e->getMessage());
}

// page footer
page_footer("game");

?>