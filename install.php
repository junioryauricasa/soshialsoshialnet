<?php
/**
 * signup
 * 
 * @package Marsesweb v2+
 * @author Marwin Silva
 */

// enviroment settings
error_reporting(E_ALL ^ (E_NOTICE | E_WARNING));

// set base path
define('BASEPATH',dirname($_SERVER['PHP_SELF']));

// get functions
require('includes/functions.php');

/* the config file exist -> start the system */
if(file_exists('includes/config.php')) {
    _redirect();
}

// check requirements
_check_requirements();


// get system data
$system['system_url'] = _get_system_url();
$system['system_domain'] = $_SERVER['HTTP_HOST'];

// install
if(isset($_POST['submit'])) {
    
    // [1] connect to the db
    $db = new mysqli($_POST['db_host'], $_POST['db_username'], $_POST['db_password'], $_POST['db_name']);
    if(mysqli_connect_error()) {
        _error(DB_ERROR);
    }

    // [2] check admin data
    /* check email */
    if(is_empty($_POST['admin_email']) && !valid_email($_POST['admin_email'])) {
        _error("Error", "Por favor, introduzca un correo electrónico del administrador válido");
    }
    /* check username */
    if(is_empty($_POST['admin_username']) && !valid_username($_POST['admin_username'])) {
        _error("Error", "Por favor, introduzca un nombre de usuario del administrador válido");
    }
    /* check password */
    if(is_empty($_POST['admin_password']) && strlen($_POST['admin_password']) < 6) {
        _error("Error", "Por favor, introduzca una contraseña del administrador válida");
    }


    // [3] create the database
    $structure = "
-- --------------------------------------------------------

--
-- Table structure for table `ads`
--

CREATE TABLE IF NOT EXISTS `ads` (
  `ads_id` int(10) NOT NULL AUTO_INCREMENT,
  `title` varchar(255) NOT NULL,
  `place` varchar(255) NOT NULL,
  `code` text NOT NULL,
  `time` datetime NOT NULL,
  PRIMARY KEY (`ads_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `conversations`
--

CREATE TABLE IF NOT EXISTS `conversations` (
  `conversation_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `last_message_id` int(10) unsigned NOT NULL,
  PRIMARY KEY (`conversation_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `conversations_messages`
--

CREATE TABLE IF NOT EXISTS `conversations_messages` (
  `message_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `conversation_id` int(10) unsigned NOT NULL,
  `user_id` int(10) unsigned NOT NULL,
  `message` longtext NOT NULL,
  `image` varchar(255) NOT NULL,
  `time` datetime NOT NULL,
  PRIMARY KEY (`message_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `conversations_users`
--

CREATE TABLE IF NOT EXISTS `conversations_users` (
  `conversation_id` int(10) unsigned NOT NULL,
  `user_id` int(10) unsigned NOT NULL,
  `seen` enum('0','1') NOT NULL DEFAULT '0',
  `deleted` enum('0','1') NOT NULL DEFAULT '0',
  UNIQUE KEY `conversation_id_user_id` (`conversation_id`,`user_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 ROW_FORMAT=FIXED;

-- --------------------------------------------------------

--
-- Table structure for table `followings`
--

CREATE TABLE IF NOT EXISTS `followings` (
  `user_id` int(10) unsigned NOT NULL,
  `following_id` int(10) unsigned NOT NULL,
  UNIQUE KEY `user_id_following_id` (`user_id`,`following_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 ROW_FORMAT=FIXED;

-- --------------------------------------------------------

--
-- Table structure for table `friends`
--

CREATE TABLE IF NOT EXISTS `friends` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `user_one_id` int(10) unsigned NOT NULL,
  `user_two_id` int(10) unsigned NOT NULL,
  `status` tinyint(1) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `user_one_id_user_two_id` (`user_one_id`,`user_two_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `games`
--

CREATE TABLE IF NOT EXISTS `games` (
  `game_id` int(10) NOT NULL AUTO_INCREMENT,
  `title` varchar(255) CHARACTER SET latin1 NOT NULL,
  `description` text CHARACTER SET latin1 NOT NULL,
  `source` text CHARACTER SET latin1 NOT NULL,
  `thumbnail` varchar(255) CHARACTER SET latin1 NOT NULL,
  PRIMARY KEY (`game_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `groups`
--

CREATE TABLE IF NOT EXISTS `groups` (
  `group_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `group_admin` int(10) unsigned NOT NULL,
  `group_name` varchar(50) NOT NULL,
  `group_title` varchar(255) NOT NULL,
  `group_picture` varchar(255) NOT NULL,
  `group_cover` varchar(255) NOT NULL,
  `group_description` text NOT NULL,
  `group_members` int(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`group_id`),
  UNIQUE KEY `username` (`group_name`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `groups_members`
--

CREATE TABLE IF NOT EXISTS `groups_members` (
  `group_id` int(10) unsigned NOT NULL,
  `user_id` int(10) unsigned NOT NULL,
  UNIQUE KEY `group_id_user_id` (`group_id`,`user_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 ROW_FORMAT=FIXED;

-- --------------------------------------------------------

--
-- Table structure for table `notifications`
--

CREATE TABLE IF NOT EXISTS `notifications` (
  `notification_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `to_user_id` int(10) unsigned NOT NULL,
  `from_user_id` int(10) unsigned NOT NULL,
  `action` varchar(50) NOT NULL,
  `node_type` varchar(50) NOT NULL,
  `node_url` varchar(255) NOT NULL,
  `time` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `seen` enum('0','1') NOT NULL DEFAULT '0',
  PRIMARY KEY (`notification_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `pages`
--

CREATE TABLE IF NOT EXISTS `pages` (
  `page_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `page_admin` int(10) unsigned NOT NULL,
  `page_category` int(10) unsigned NOT NULL,
  `page_name` varchar(50) NOT NULL,
  `page_title` varchar(255) NOT NULL,
  `page_picture` varchar(255) NOT NULL,
  `page_cover` varchar(255) NOT NULL,
  `page_description` text NOT NULL,
  `page_verified` enum('0','1') NOT NULL DEFAULT '0',
  `page_likes` int(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`page_id`),
  UNIQUE KEY `username` (`page_name`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `pages_categories`
--

CREATE TABLE IF NOT EXISTS `pages_categories` (
  `category_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `category_name` varchar(255) NOT NULL,
  PRIMARY KEY (`category_id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=8 ;

--
-- Dumping data for table `pages_categories`
--

INSERT INTO `pages_categories` (`category_id`, `category_name`) VALUES
(1, 'Servicio'),
(2, 'Músico/Banda'),
(3, 'Marca o Producto'),
(4, 'Compañía, Organización o Institución'),
(5, 'Artista, grupo musical o figura pública'),
(6, 'Entretenimiento'),
(7, 'Causa o Comunidad'),
(8, 'Lugar o Negocio local');

-- --------------------------------------------------------

--
-- Table structure for table `pages_likes`
--

CREATE TABLE IF NOT EXISTS `pages_likes` (
  `page_id` int(10) unsigned NOT NULL,
  `user_id` int(10) unsigned NOT NULL,
  UNIQUE KEY `page_id_user_id` (`page_id`,`user_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 ROW_FORMAT=FIXED;

-- --------------------------------------------------------

--
-- Table structure for table `posts`
--

CREATE TABLE IF NOT EXISTS `posts` (
  `post_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int(10) unsigned NOT NULL,
  `user_type` enum('user','page') NOT NULL,
  `in_group` enum('0','1') NOT NULL DEFAULT '0',
  `group_id` int(10) unsigned DEFAULT NULL,
  `post_type` varchar(50) NOT NULL,
  `origin_id` int(10) unsigned DEFAULT NULL,
  `time` datetime NOT NULL,
  `location` varchar(50) NOT NULL,
  `privacy` enum('friends','public') NOT NULL,
  `text` longtext NOT NULL,
  `likes` int(10) unsigned NOT NULL DEFAULT '0',
  `comments` int(10) unsigned NOT NULL DEFAULT '0',
  `shares` int(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`post_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `posts_comments`
--

CREATE TABLE IF NOT EXISTS `posts_comments` (
  `comment_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `node_id` int(10) unsigned NOT NULL,
  `node_type` enum('post','photo') NOT NULL,
  `user_id` int(10) unsigned NOT NULL,
  `user_type` enum('user','page') NOT NULL,
  `text` longtext NOT NULL,
  `image` varchar(255) DEFAULT NULL,
  `time` datetime NOT NULL,
  `likes` int(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`comment_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `posts_comments_likes`
--

CREATE TABLE IF NOT EXISTS `posts_comments_likes` (
  `user_id` int(10) unsigned NOT NULL,
  `comment_id` int(10) unsigned NOT NULL,
  UNIQUE KEY `comment_id_user_id` (`comment_id`,`user_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;

-- --------------------------------------------------------

--
-- Table structure for table `posts_hidden`
--

CREATE TABLE IF NOT EXISTS `posts_hidden` (
  `user_id` int(10) unsigned NOT NULL,
  `post_id` int(10) unsigned NOT NULL,
  UNIQUE KEY `post_id_user_id` (`post_id`,`user_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;

-- --------------------------------------------------------

--
-- Table structure for table `posts_likes`
--

CREATE TABLE IF NOT EXISTS `posts_likes` (
  `user_id` int(10) unsigned NOT NULL,
  `post_id` int(10) unsigned NOT NULL,
  UNIQUE KEY `post_id_user_id` (`post_id`,`user_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `posts_links`
--

CREATE TABLE IF NOT EXISTS `posts_links` (
  `link_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `post_id` int(10) unsigned NOT NULL,
  `source_url` tinytext NOT NULL,
  `source_host` varchar(255) NOT NULL,
  `source_title` varchar(255) NOT NULL,
  `source_text` text NOT NULL,
  `source_thumbnail` varchar(255) NOT NULL,
  PRIMARY KEY (`link_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `posts_media`
--

CREATE TABLE IF NOT EXISTS `posts_media` (
  `media_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `post_id` int(10) NOT NULL,
  `media_type` enum('youtube','vimeo','soundcloud') NOT NULL,
  `source_uid` varchar(255) NOT NULL,
  `source_url` text NOT NULL,
  `source_title` varchar(255) DEFAULT NULL,
  `source_text` text,
  PRIMARY KEY (`media_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `posts_photos`
--

CREATE TABLE IF NOT EXISTS `posts_photos` (
  `photo_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `post_id` int(10) unsigned NOT NULL,
  `source` varchar(255) NOT NULL,
  `likes` int(10) unsigned NOT NULL DEFAULT '0',
  `comments` int(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`photo_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `posts_photos_likes`
--

CREATE TABLE IF NOT EXISTS `posts_photos_likes` (
  `user_id` int(10) unsigned NOT NULL,
  `photo_id` int(10) unsigned NOT NULL,
  UNIQUE KEY `user_id_photo_id` (`user_id`,`photo_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 ROW_FORMAT=FIXED;

-- --------------------------------------------------------

--
-- Table structure for table `posts_videos`
--

CREATE TABLE IF NOT EXISTS `posts_videos` (
  `video_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `post_id` int(10) unsigned NOT NULL,
  `source` varchar(255) NOT NULL,
  PRIMARY KEY (`video_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `reports`
--

CREATE TABLE IF NOT EXISTS `reports` (
  `report_id` int(10) NOT NULL AUTO_INCREMENT,
  `user_id` int(10) NOT NULL,
  `node_id` int(10) NOT NULL,
  `node_type` varchar(50) NOT NULL,
  `time` datetime NOT NULL,
  PRIMARY KEY (`report_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `static_pages`
--

CREATE TABLE IF NOT EXISTS `static_pages` (
  `page_id` int(10) NOT NULL AUTO_INCREMENT,
  `page_url` varchar(50) NOT NULL,
  `page_title` varchar(255) NOT NULL,
  `page_text` text NOT NULL,
  PRIMARY KEY (`page_id`),
  UNIQUE KEY `page_url` (`page_url`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=4 ;

--
-- Dumping data for table `static_pages`
--

INSERT INTO `static_pages` (`page_id`, `page_url`, `page_title`, `page_text`) VALUES
(1, 'about', 'Acerca de', '&lt;p&gt;\r\n                Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.\r\n            &lt;/p&gt;\r\n            &lt;h3 class=&quot;text-info&quot;&gt;\r\n                Big Title\r\n            &lt;/h3&gt;\r\n            &lt;p&gt;\r\n                Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.\r\n            &lt;/p&gt;\r\n            &lt;h3 class=&quot;text-info&quot;&gt;\r\n                Big Title\r\n            &lt;/h3&gt;\r\n            &lt;p&gt;\r\n               Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.\r\n            &lt;/p&gt;'),
(2, 'terms', 'Términos y Condiciones', '&lt;p&gt;\r\n                Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.\r\n            &lt;/p&gt;\r\n            &lt;h3 class=&quot;text-info&quot;&gt;\r\n                Big Title\r\n            &lt;/h3&gt;\r\n            &lt;p&gt;\r\n                Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.\r\n            &lt;/p&gt;\r\n            &lt;h3 class=&quot;text-info&quot;&gt;\r\n                Big Title\r\n            &lt;/h3&gt;\r\n            &lt;p&gt;\r\n               Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.\r\n            &lt;/p&gt;'),
(3, 'privacy', 'Privacidad', '&lt;p&gt;\r\n                Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.\r\n            &lt;/p&gt;\r\n            &lt;h3 class=&quot;text-info&quot;&gt;\r\n                Big Title\r\n            &lt;/h3&gt;\r\n            &lt;p&gt;\r\n                Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.\r\n            &lt;/p&gt;\r\n            &lt;h3 class=&quot;text-info&quot;&gt;\r\n                Big Title\r\n            &lt;/h3&gt;\r\n            &lt;p&gt;\r\n               Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.\r\n            &lt;/p&gt;');

-- --------------------------------------------------------

--
-- Table structure for table `system_languages`
--

CREATE TABLE IF NOT EXISTS `system_languages` (
  `language_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `code` varchar(50) NOT NULL,
  `title` varchar(255) NOT NULL,
  `flag_icon` varchar(50) NOT NULL,
  `dir` enum('LTR','RTL') NOT NULL,
  `default` enum('0','1') NOT NULL,
  `enabled` enum('0','1') NOT NULL DEFAULT '1',
  PRIMARY KEY (`language_id`),
  UNIQUE KEY `code` (`code`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=11 ;

--
-- Dumping data for table `system_languages`
--

INSERT INTO `system_languages` (`language_id`, `code`, `title`, `flag_icon`, `dir`, `default`, `enabled`) VALUES
(1, 'en_US', 'English', 'us', 'LTR', '0', '1'),
(2, 'ar_EG', 'Arabic', 'sa', 'RTL', '0', '1'),
(3, 'fr_FR', 'Fran&ccedil;ais', 'fr', 'LTR', '0', '1'),
(4, 'es_ES', 'Espa&ntilde;ol', 'es', 'LTR', '1', '1'),
(5, 'pt_PT', 'Portugu&ecirc;s', 'pt', 'LTR', '0', '1'),
(6, 'de_DE', 'Deutsch', 'de', 'LTR', '0', '1'),
(7, 'tr_TR', 'T&uuml;rk&ccedil;e', 'tr', 'LTR', '0', '1'),
(8, 'nl_NL', 'Dutch', 'nl', 'LTR', '0', '1'),
(9, 'it_IT', 'Italiano', 'it', 'LTR', '0', '1'),
(10, 'ru_RU', 'Russian', 'ru', 'LTR', '0', '1');

-- --------------------------------------------------------

--
-- Table structure for table `system_options`
--

CREATE TABLE IF NOT EXISTS `system_options` (
  `ID` int(10) NOT NULL AUTO_INCREMENT,
  `system_live` enum('1','0') NOT NULL DEFAULT '1',
  `system_message` text NOT NULL,
  `system_title` varchar(255) NOT NULL DEFAULT 'Marsesweb',
  `system_description` text NOT NULL,
  `system_url` varchar(255) NOT NULL,
  `system_uploads_directory` varchar(255) NOT NULL,
  `system_domain` varchar(255) NOT NULL,
  `system_logo` varchar(255) DEFAULT 'logo.png',
  `users_can_register` enum('1','0') NOT NULL DEFAULT '1',
  `social_login_enabled` enum('1','0') NOT NULL DEFAULT '0',
  `facebook_login_enabled` enum('1','0') NOT NULL DEFAULT '0',
  `facebook_appid` varchar(255) DEFAULT NULL,
  `facebook_secret` varchar(255) DEFAULT NULL,
  `twitter_login_enabled` enum('1','0') NOT NULL DEFAULT '0',
  `twitter_appid` varchar(255) DEFAULT NULL,
  `twitter_secret` varchar(255) DEFAULT NULL,
  `google_login_enabled` enum('1','0') NOT NULL DEFAULT '0',
  `google_appid` varchar(255) DEFAULT NULL,
  `google_secret` varchar(255) DEFAULT NULL,
  `google_analytics` text,
  `reCAPTCHA_enabled` enum('1','0') NOT NULL DEFAULT '0',
  `reCAPTCHA_site_key` varchar(255) NOT NULL,
  `reCAPTCHA_secret_key` varchar(255) NOT NULL,
  `email_send_activation` enum('1','0') NOT NULL DEFAULT '1',
  `email_smtp_enabled` enum('1','0') NOT NULL DEFAULT '0',
  `email_smtp_authentication` enum('1','0') NOT NULL DEFAULT '1',
  `email_smtp_server` varchar(255) NOT NULL,
  `email_smtp_port` varchar(255) NOT NULL,
  `email_smtp_username` varchar(255) NOT NULL,
  `email_smtp_password` varchar(255) NOT NULL,
  `min_results` int(10) NOT NULL DEFAULT '5',
  `min_results_even` int(10) NOT NULL DEFAULT '6',
  `max_results` int(10) NOT NULL DEFAULT '10',
  `max_avatar_size` int(10) NOT NULL DEFAULT '5120',
  `max_cover_size` int(10) NOT NULL DEFAULT '5120',
  `max_photo_size` int(10) NOT NULL DEFAULT '5120',
  `max_video_size` int(10) NOT NULL DEFAULT '5120',
  `videos_enabled` enum('1','0') NOT NULL DEFAULT '0',
  `games_enabled` enum('1','0') NOT NULL DEFAULT '0',
  PRIMARY KEY (`ID`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=2 ;

--
-- Dumping data for table `system_options`
--

INSERT INTO `system_options` (`ID`, `system_live`, `system_message`, `system_title`, `system_description`, `system_url`, `system_uploads_directory`, `system_domain`, `system_logo`, `users_can_register`, `social_login_enabled`, `facebook_login_enabled`, `facebook_appid`, `facebook_secret`, `twitter_login_enabled`, `twitter_appid`, `twitter_secret`, `google_login_enabled`, `google_appid`, `google_secret`, `google_analytics`, `reCAPTCHA_enabled`, `reCAPTCHA_site_key`, `reCAPTCHA_secret_key`, `email_send_activation`, `email_smtp_enabled`, `email_smtp_authentication`, `email_smtp_server`, `email_smtp_port`, `email_smtp_username`, `email_smtp_password`, `min_results`, `min_results_even`, `max_results`, `max_avatar_size`, `max_cover_size`, `max_photo_size`, `max_video_size`, `videos_enabled`, `games_enabled`) VALUES
(1, '1', 'Estamos actualizando el sistema, por favor ingresa más tarde!', 'Marsesweb', 'Descripción de su sitio web', '', 'content/uploads', '', '', '1', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', 5, 6, 10, 5120, 5120, 5120, 5120, '', '');

-- --------------------------------------------------------

--
-- Table structure for table `system_themes`
--

CREATE TABLE IF NOT EXISTS `system_themes` (
  `theme_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL,
  `default` enum('0','1') NOT NULL,
  PRIMARY KEY (`theme_id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC AUTO_INCREMENT=3 ;

--
-- Dumping data for table `system_themes`
--

INSERT INTO `system_themes` (`theme_id`, `name`, `default`) VALUES
(1, 'default', '0'),
(2, 'material', '1');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE IF NOT EXISTS `users` (
  `user_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `user_group` tinyint(1) unsigned NOT NULL DEFAULT '3',
  `user_name` varchar(64) NOT NULL,
  `user_email` varchar(100) NOT NULL,
  `user_token` varchar(64) NOT NULL,
  `user_password` varchar(64) NOT NULL,
  `user_fullname` varchar(255) NOT NULL,
  `user_gender` enum('M','F') NOT NULL,
  `user_picture` varchar(255) NOT NULL,
  `user_cover` varchar(255) NOT NULL,
  `user_work_title` varchar(50) NOT NULL,
  `user_work_place` varchar(50) NOT NULL,
  `user_current_city` varchar(50) NOT NULL,
  `user_hometown` varchar(50) NOT NULL,
  `user_edu_major` varchar(50) DEFAULT NULL,
  `user_edu_school` varchar(50) NOT NULL,
  `user_edu_class` varchar(50) NOT NULL,
  `user_birthdate` date DEFAULT NULL,
  `user_registered` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `user_last_login` datetime NOT NULL,
  `user_privacy_birthdate` enum('friends','public') NOT NULL DEFAULT 'public',
  `user_privacy_work` enum('friends','public') NOT NULL DEFAULT 'public',
  `user_privacy_location` enum('friends','public') NOT NULL DEFAULT 'public',
  `user_privacy_education` enum('friends','public') NOT NULL DEFAULT 'public',
  `user_privacy_friends` enum('me','friends','public') NOT NULL DEFAULT 'public',
  `user_privacy_pages` enum('me','friends','public') NOT NULL DEFAULT 'public',
  `user_privacy_groups` enum('me','friends','public') NOT NULL DEFAULT 'public',
  `user_activation_key` varchar(64) NOT NULL,
  `user_activated` enum('0','1') NOT NULL DEFAULT '0',
  `user_verified` enum('0','1') NOT NULL DEFAULT '0',
  `user_reseted` enum('0','1') NOT NULL DEFAULT '0',
  `user_reset_key` varchar(64) NOT NULL,
  `user_blocked` enum('0','1') NOT NULL DEFAULT '0',
  `user_ip` varchar(64) NOT NULL,
  `user_chat_enabled` enum('0','1') NOT NULL DEFAULT '1',
  `user_live_requests_counter` int(10) NOT NULL DEFAULT '0',
  `user_live_requests_lastid` int(10) NOT NULL DEFAULT '0',
  `user_live_messages_counter` int(10) NOT NULL DEFAULT '0',
  `user_live_messages_lastid` int(10) NOT NULL DEFAULT '0',
  `user_live_notifications_counter` int(10) NOT NULL DEFAULT '0',
  `user_live_notifications_lastid` int(10) NOT NULL DEFAULT '0',
  `facebook_connected` enum('0','1') NOT NULL DEFAULT '0',
  `facebook_id` varchar(255) DEFAULT NULL,
  `twitter_connected` enum('0','1') NOT NULL DEFAULT '0',
  `twitter_id` varchar(255) DEFAULT NULL,
  `google_connected` enum('0','1') NOT NULL DEFAULT '0',
  `google_id` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`user_id`),
  UNIQUE KEY `username` (`user_name`),
  UNIQUE KEY `user_email` (`user_email`),
  UNIQUE KEY `user_token` (`user_token`),
  UNIQUE KEY `facebook_id` (`facebook_id`),
  UNIQUE KEY `twitter_id` (`twitter_id`),
  UNIQUE KEY `google_id` (`google_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `users_blocks`
--

CREATE TABLE IF NOT EXISTS `users_blocks` (
  `user_id` int(10) unsigned NOT NULL,
  `blocked_id` int(10) unsigned NOT NULL,
  UNIQUE KEY `user_id_blocked_id` (`user_id`,`blocked_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 ROW_FORMAT=FIXED;

-- --------------------------------------------------------

--
-- Table structure for table `users_online`
--

CREATE TABLE IF NOT EXISTS `users_online` (
  `user_id` int(10) unsigned NOT NULL,
  `last_seen` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  UNIQUE KEY `UserID` (`user_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- --------------------------------------------------------

--
-- Table structure for table `widgets`
--

CREATE TABLE IF NOT EXISTS `widgets` (
  `widget_id` int(10) NOT NULL AUTO_INCREMENT,
  `title` varchar(255) NOT NULL,
  `place` varchar(255) NOT NULL,
  `code` text NOT NULL,
  PRIMARY KEY (`widget_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC AUTO_INCREMENT=1 ;";
    

    $db->multi_query($structure) or _error("Error", $db->error);
    // flush multi_queries
    do{} while(mysqli_more_results($db) && mysqli_next_result($db));


    // [4] update system settings
    $db->query(sprintf("UPDATE system_options SET system_url = %s, system_domain = %s", secure($system['system_url']), secure($system['system_domain']))) or _error("Error #101", $db->error);

    // [5] Add the admin
    /* generate user token */
    $token = md5(time()*rand(1, 9999));
    /* insert */
    $db->query(sprintf("INSERT INTO users (user_group, user_email, user_name, user_token, user_fullname, user_password, user_gender, user_activated, user_verified, user_registered, user_ip) VALUES ('1', %s, %s, %s, %s, %s, 'M', '1', '1', %s, %s)", secure($_POST['admin_email']), secure($_POST['admin_username']), secure($token), secure($_POST['admin_username']), secure(md5($_POST['admin_password'])), secure(gmdate('Y-m-d H:i:s')), secure($_SERVER[REMOTE_ADDR]) )) or _error("Error #102", $db->error);


    // [6] create config file
    $config_string = '<?php  
    define("DB_NAME", "'. $_POST["db_name"]. '");
    define("DB_USER", "'. $_POST["db_username"]. '");
    define("DB_PASSWORD", "'. $_POST["db_password"]. '");
    define("DB_HOST", "'. $_POST["db_host"]. '");
    define("DEBUGGING", false);
    define("DEFAULT_LOCALE", "en_US");
    
    ?>';
    
    $config_file = 'includes/config.php';
    $handle = fopen($config_file, 'w') or _error("Error del sistema", "No se puede crear el archivo de configuración");
    
    fwrite($handle, $config_string);
    fclose($handle);
    
    _redirect();
}

?>

<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8" />
        <meta http-equiv="X-UA-Compatible" content="IE=edge"> 
        <meta name="viewport" content="width=device-width, initial-scale=1"> 
        
        <title>Marsesweb v2+ &rsaquo; Instalador</title>
        <link rel="icon" type="image/png" sizes="32x32" href="content/themes/material/images/favicon.png">
        <link rel="stylesheet" type="text/css" href="content/themes/default/css/installer.css" />
        <script src="includes/js/installer/modernizr.custom.js"></script>
    </head>

    <body>
        
        <div class="container">

            <div class="fs-form-wrap" id="fs-form-wrap">
                
<div class="fs-title">
      <h1>Marsesweb v2+ Instalador</h1>
                </div>
                
                <form id="myform" class="fs-form fs-form-full" autocomplete="off" action="install.php" method="post">
                    <ol class="fs-fields">

                        <li>
                            <p class="fs-field-label fs-anim-upper">
                                <br>
                                Bienvenido al proceso de instalación de Marsesweb! Apenas completes la información de abajo, crearas tu propio sitio web social o comunidad en línea.
                            </p>
                        </li>
                        
                        <li>
                            <label class="fs-field-label fs-anim-upper" for="db_name" data-info="El nombre de la base de datos que desea ejecutar en Marsesweb">
¿Nombre de la base de datos?</label>
                            <input class="fs-anim-lower" id="db_name" name="db_name" type="text" placeholder="marsesweb" required/>
                        </li>

                        <li>
                            <label class="fs-field-label fs-anim-upper" for="db_username" data-info="
Su nombre de usuario de su servidor MySQL">
¿Nombre de usuario de la base de datos?</label>
                            <input class="fs-anim-lower" id="db_username" name="db_username" type="text" placeholder="Usuario de Mysql" required/>
                        </li>

                        <li>
                            <label class="fs-field-label fs-anim-upper" for="db_password" data-info="
Su contraseña de sus servidor MySQL">
¿Contraseña de la base de datos?</label>
                            <input class="fs-anim-lower" id="db_password" name="db_password" type="text" placeholder="Contraseña"/>
                        </li>

                        <li>
                            <label class="fs-field-label fs-anim-upper" for="db_host" data-info="
Usted debe obtener esta información de su proveedor de alojamiento web">
¿Servidor de la base de datos?</label>
                            <input class="fs-anim-lower" id="db_host" name="db_host" type="text" placeholder="localhost" required/>
                        </li>
                        
                        <li>
                            <label class="fs-field-label fs-anim-upper" for="admin_email" data-info="Compruebe la dirección de correo electrónico antes de continuar.">Tu correo electrónico</label>
                            <input class="fs-anim-lower" id="admin_email" name="admin_email" type="email" placeholder="correoelectrónico@mail.com" required/>
                        </li>

                        <li>
                            <label class="fs-field-label fs-anim-upper" for="admin_username" data-info="
Los nombres de usuario pueden tener sólo caracteres alfanuméricos, espacios, guiones, puntos y el símbolo @.">Usuario</label>
                            <input class="fs-anim-lower" id="admin_username" name="admin_username" type="text" placeholder="Usuario" required/>
                        </li>

                        <li>
                            <label class="fs-field-label fs-anim-upper" for="admin_password" data-info=' La contraseña debe ser de al menos siete caracteres. Para hacerla más fuerte, use letras mayúsculas y minúsculas, números y símbolos como ! " ? $ % ^ & ).'>Contraseña</label>
                            <input class="fs-anim-lower" id="admin_password" name="admin_password" type="text" placeholder="Contraseña" required/>
                        </li>

                    </ol>
                    <button class="fs-submit" name="submit" type="submit">Instalar</button>
                </form>

            </div>

        </div>
        
        <script src="includes/js/installer/classie.js"></script>
        <script src="includes/js/installer/fullscreenForm.js"></script>
        <script>
            (function() {
                var formWrap = document.getElementById( 'fs-form-wrap' );
                new FForm( formWrap, {
                    onReview : function() {
                        classie.add( document.body, 'overview' );
                    }
                } );
            })();
        </script>

    </body>
</html>