<?php 
/**
 * signup
 * 
 * @package Marsesweb v2+
 * @author Marwin Silva
 */

// set absolut & base path
define('ABSPATH',dirname(__FILE__).'/');
define('BASEPATH',dirname($_SERVER['PHP_SELF']));

if(!file_exists(ABSPATH.'includes/config.php')) {

    // get functions
    require(ABSPATH.'includes/functions.php');
    
    /* the config file doesn't exist -> start the installer */
    _redirect('/install');
    
}else {
    
    /* the config file exist -> start the system */
    
    // get system configurations
    require(ABSPATH.'includes/config.php');

    // enviroment settings
    if(DEBUGGING) {
        ini_set("display_errors", true);
        error_reporting(E_ALL ^ E_NOTICE);
    }else {
        ini_set("display_errors", false);
        error_reporting(0);
    }


    // start session
    session_start();
    /* set session secret */
    if(!isset($_SESSION['secret'])) {
        $_SESSION['secret'] = md5(time()*rand(1, 9999));
    }
    

    // i18n config
    require(ABSPATH.'includes/libs/gettext/gettext.inc');
    T_setlocale(LC_MESSAGES, DEFAULT_LOCALE);
    $domain = 'messages';
    T_bindtextdomain($domain, ABSPATH .'content/languages/locale');
    T_bind_textdomain_codeset($domain, 'UTF-8');
    T_textdomain($domain);


    // get functions
    require(ABSPATH.'includes/functions.php');


    // connect to the database
    $db = new mysqli(DB_HOST, DB_USER, DB_PASSWORD, DB_NAME);
    $db->set_charset('utf8');
    if(mysqli_connect_error()) {
        _error(DB_ERROR);
    }


    // get system options
    $get_options = $db->query("SELECT * FROM system_options") or _error(SQL_ERROR);
    $system = $get_options->fetch_assoc();
    /* set system uploads */
    $system['system_uploads'] = $system['system_url'].'/'.$system['system_uploads_directory'];
    /* get system languages */
    $get_languages = $db->query("SELECT * FROM system_languages WHERE enabled = '1'") or _error(SQL_ERROR);
    while($language = $get_languages->fetch_assoc()) {
        /* set system langauge */
        if(isset($_COOKIE['s_lang'])) {
            if($_COOKIE['s_lang'] == $language['code']) {
                $system['language'] = $language;
                T_setlocale(LC_MESSAGES, $system['language']['code']);
            }
        } else {
            if(($language['default'])) {
                $system['language'] = $language;
                T_setlocale(LC_MESSAGES, $system['language']['code']);
            }
        }
        $system['languages'][] = $language;
    }
    /* get system theme */
    $get_theme = $db->query("SELECT * FROM system_themes WHERE system_themes.default = '1'") or _error(SQL_ERROR);
    $theme = $get_theme->fetch_assoc();
    $system['theme'] = $theme['name'];
    /* get system version */
    require(ABSPATH.'includes/version.php');
    $system['version'] = $marsesweb_version;
    /* check system URL */
    _check_system_url($system['system_url']);



    // static pages
    $static_pages = array();
    $get_static = $db->query("SELECT * FROM static_pages") or _error(SQL_ERROR);
    if($get_static->num_rows > 0) {
        while($static_page = $get_static->fetch_assoc()) {
            $static_pages[] = $static_page;
        }
    }


    // time config
    date_default_timezone_set( 'UTC' );
    $time = time();
    $minutes_to_add = 0;
    $DateTime = new DateTime();
    $DateTime->add(new DateInterval('PT' . $minutes_to_add . 'M'));
    $date = $DateTime->format('Y-m-d H:i:s');


    // smarty config
    require(ABSPATH.'includes/libs/smarty/Smarty.class.php');
    $smarty = new Smarty;
    $smarty->template_dir = ABSPATH.'content/themes/'.$system['theme'].'/templates';
    $smarty->compile_dir = ABSPATH.'content/themes/'.$system['theme'].'/templates_compiled';


    // get user & online friends if chat enabled
    require(ABSPATH.'includes/class-user.php');
    try {
        $user = new User();
        if($user->_logged_in && $user->_data['user_chat_enabled']) {
            /* get online friends */
            $online_friends = $user->get_online_friends();
            /* assign online friends */
            $smarty->assign('online_friends', $online_friends);
        }
    } catch (Exception $e) {
        _error(SQL_ERROR);
    }


    // assign system varibles
    $smarty->assign('secret', $_SESSION['secret']);
    $smarty->assign('__', __);
    $smarty->assign('system', $system);
    $smarty->assign('static_pages', $static_pages);
    $smarty->assign('user', $user);


    // check if system is live
    if(!$system['system_live'] && ( (!$user->_logged_in && !isset($override_shutdown)) || ($user->_logged_in && $user->_data['user_group'] != 1)) ) {
        _error(__('System Message'), "<p class='text-center'>".$system['system_message']."</p>");
    }

    // check if the viewer is banned
    if($user->_logged_in && $user->_data['user_group'] != '1' && $user->_data['user_blocked']) {
        _error(__("System Message"), __("Your account has been blocked"));
    }
}

?>