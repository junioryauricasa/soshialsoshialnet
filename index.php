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
if(!$user->_logged_in) {

    // page header
	page_header(__("Welcome to").' '.$system['system_title']);

} else {

	// valid inputs
	$valid['view'] = array('', 'search', 'pages', 'groups', 'create_page', 'create_group', 'games');
	if(!in_array($_GET['view'], $valid['view'])) {
		_error(404);
	}

	try {

		// get my pages
		$pages = $user->get_pages();
		/* assign variables */
		$smarty->assign('pages', $pages);

		// get my groups
		$groups = $user->get_groups();
		/* assign variables */
		$smarty->assign('groups', $groups);

		// get new people
		$new_people = $user->get_new_people(0, true);
		/* assign variables */
		$smarty->assign('new_people', $new_people);

		// get new pages
		$new_pages = $user->get_pages( array('suggested' => true));
		/* assign variables */
		$smarty->assign('new_pages', $new_pages);

		// get new groups
		$new_groups = $user->get_groups( array('suggested' => true));
		/* assign variables */
		$smarty->assign('new_groups', $new_groups);

		// get ads
		$ads = $user->ads('home');
		/* assign variables */
		$smarty->assign('ads', $ads);

		// get widget
		$widget = $user->widget('home');
		/* assign variables */
		$smarty->assign('widget', $widget);


		// get content
		switch ($_GET['view']) {
			case '':
				// page header
				page_header($system['system_title']);

				// get posts (newsfeed)
				$posts = $user->get_posts();
				/* assign variables */
				$smarty->assign('posts', $posts);
				break;

			case 'search':
				// page header
				page_header(__("Search"));

				// search
				if(isset($_GET['query'])) {
					/* get results */
					$results = $user->search($_GET['query']);
					/* assign variables */
					$smarty->assign('query', $_GET['query']);
					$smarty->assign('results', $results);
					$smarty->assign('results_num', count($results));
				}
				break;

			case 'pages':
				// page header
				page_header(__("Pages"));
				break;

			case 'groups':
				// page header
				page_header(__("Groups"));
				break;

			case 'create_page':
				// page header
				page_header($system['system_title']." &rsaquo; ".__("Create Page"));

				// get pages categories
				$categories = $user->get_pages_categories();
				/* assign variables */
				$smarty->assign('categories', $categories);
				break;

			case 'create_group':
				// page header
				page_header($system['system_title']." &rsaquo; ".__("Create Group"));
				break;

			case 'games':
				// games enabled
				if(!$system['games_enabled']) {
					_error(404);
				}

				// page header
				page_header($system['system_title']." &rsaquo; ".__("Games"));

				// get games
				$games = $user->get_games();
				/* assign variables */
				$smarty->assign('games', $games);
				break;

			default:
				_error(404);
				break;
		}

    } catch (Exception $e) {
        _error(__("Error"), $e->getMessage());
    }

	// assign variables
	$smarty->assign('view', $_GET['view']);
}

// page footer
page_footer("index");

?>